Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9BBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39ECE20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbfCYLWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:22:01 -0400
Received: from www62.your-server.de ([213.133.104.62]:37704 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730472AbfCYLWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:22:00 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8Nfv-0000gr-QK; Mon, 25 Mar 2019 12:21:55 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8Nfv-0007I5-Jm; Mon, 25 Mar 2019 12:21:55 +0100
Subject: Re: KASAN: use-after-free Read in path_lookupat
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000006946d2057bbd0eef@google.com>
 <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk>
 <717eaff9-1f49-28f3-bbb6-c8f14ebbe03b@iogearbox.net>
 <20190325111123.GM2217@ZenIV.linux.org.uk>
 <20190325111756.GN2217@ZenIV.linux.org.uk>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7404881b-efe4-0854-567a-01ff77a93c73@iogearbox.net>
Date:   Mon, 25 Mar 2019 12:21:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190325111756.GN2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25399/Mon Mar 25 08:46:48 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/2019 12:17 PM, Al Viro wrote:
> On Mon, Mar 25, 2019 at 11:11:23AM +0000, Al Viro wrote:
>> On Mon, Mar 25, 2019 at 10:15:40AM +0100, Daniel Borkmann wrote:
>>>> So we have 5 broken cases, all with the same kind of fix: move freeing
>>>> into the RCU-delayed part of ->destroy_inode(); for debugfs and bpf
>>>> that requires adding ->alloc_inode()/->destroy_inode(), rather than
>>>> relying upon the defaults from fs/inode.c
>>>
>>> I believe I copied that logic from one of the other fs'es back then, sigh.
>>> Thanks for the analysis and hints for fixing. Would the below (only compile
>>> tested for now) look reasonable to you? I believe there is no other way
>>> around than to add our own inode cache, but so be it. The freeing of the
>>> i_link is then RCU-deferred in bpf_destroy_inode_deferred():
>>
>> It looks like it would suffice, but it's way too much boilerplate for my
>> taste ;-/
>>
>> Most of your headache here comes from messing with slab setup and the
>> only reason for that is being unable to free stuff into inode_cachep.
>> So grep for inode_cachep would be a good idea, and it digs up the
>> following sucker:
>> void free_inode_nonrcu(struct inode *inode)  
>> {
>>         kmem_cache_free(inode_cachep, inode);
>> }
>> EXPORT_SYMBOL(free_inode_nonrcu);
>>
>> IOW, you need nothing on ->alloc_inode() side and for ->destroy_inode()
>> just do call_rcu() of a callback, that would kfree(inode->link) if
>> it was a symlink, then call free_inode_nonrcu(inode).
>>
>> Considerably smaller patch that way...
> 
> AFAICS, it boils down to just this (also only compile-tested):

Ah yep, much better, agree. Want to cook proper patch for bpf, or want
me to take care of it?

Thanks,
Daniel

> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 2ada5e21dfa6..9437f88b6acf 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -80,6 +80,20 @@ static const struct inode_operations bpf_dir_iops;
>  static const struct inode_operations bpf_prog_iops = { };
>  static const struct inode_operations bpf_map_iops  = { };
>  
> +static void bpf_destroy_inode_deferred(struct rcu_head *head)
> +{
> +	struct inode *inode = container_of(head, struct inode, i_rcu);
> +
> +	if (S_ISLNK(inode->i_mode))
> +		kfree(inode->i_link);
> +	free_inode_nonrcu(inode);
> +}
> +
> +static void bpf_destroy_inode(struct inode *inode)
> +{
> +	call_rcu(&inode->i_rcu, bpf_destroy_inode_deferred);
> +}
> +
>  static struct inode *bpf_get_inode(struct super_block *sb,
>  				   const struct inode *dir,
>  				   umode_t mode)
> @@ -561,8 +575,6 @@ static void bpf_evict_inode(struct inode *inode)
>  	truncate_inode_pages_final(&inode->i_data);
>  	clear_inode(inode);
>  
> -	if (S_ISLNK(inode->i_mode))
> -		kfree(inode->i_link);
>  	if (!bpf_inode_type(inode, &type))
>  		bpf_any_put(inode->i_private, type);
>  }
> @@ -584,6 +596,7 @@ static const struct super_operations bpf_super_ops = {
>  	.drop_inode	= generic_delete_inode,
>  	.show_options	= bpf_show_options,
>  	.evict_inode	= bpf_evict_inode,
> +	.destroy_inode	= bpf_destroy_inode,
>  };
>  
>  enum {
> 
