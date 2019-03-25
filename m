Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D322080F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfCYWlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:41:44 -0400
Received: from www62.your-server.de ([213.133.104.62]:56828 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfCYWlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:41:44 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8YHk-0005G9-DR; Mon, 25 Mar 2019 23:41:40 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8YHk-000BIL-65; Mon, 25 Mar 2019 23:41:40 +0100
Subject: Re: KASAN: use-after-free Read in path_lookupat
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000006946d2057bbd0eef@google.com>
 <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk>
 <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <CAHk-=whJ4M5FegOLvnjUtJ0+pHv4L8UNFt+9jJDhox3Ada8kwA@mail.gmail.com>
 <20190325211405.GP2217@ZenIV.linux.org.uk>
 <CAHk-=wj+-e=X9cvvNwc5+QuvBOyYT7OtZTBzy-Wg8zGrUwxSbw@mail.gmail.com>
 <f4eccb87-1ea2-c0d5-19db-d638f2c5aa57@iogearbox.net>
 <CAHk-=wjD-A_VsYC_OKcn30_ZsrLEE1CN7mnwZ803cvaFTdTTfA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <79dfc903-cf0d-0091-ef96-76c2749abb9c@iogearbox.net>
Date:   Mon, 25 Mar 2019 23:41:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjD-A_VsYC_OKcn30_ZsrLEE1CN7mnwZ803cvaFTdTTfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25399/Mon Mar 25 08:46:48 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/2019 11:13 PM, Linus Torvalds wrote:
> On Mon, Mar 25, 2019 at 3:04 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> I'm fine either way, I think the rcu_destroy_inode would indeed simplify
>> it nicely. In any case fwiw, here's what I'd have ready for standby on bpf
>> side and tested as well. Decided to get rid of bpf_evict_inode() entirely
>> since the only callback we'd really need is on final inode destruction:
> 
> Yes, this looks correct to me.
> 
> I think this is worth doing regardless. Even if we then make the vfs
> layer add that rcu_destroy_inode(), that will fit very well with this
> patch, and getting rid of the special bpf_evict_inode() logic and just
> letting the normal vfs inode cleanup happen looks like the right
> thing.
> 
> So ack from me on your
> 
>> Subject: [PATCH bpf] bpf: fix use after free in bpf_evict_inode
> 
> patch regardless of what else we might end up doing in this area to
> clean things up.

Ok, thanks a lot. In that case, I just pushed this one to bpf tree, and
it will come your way the usual route via David.

Thanks,
Daniel
