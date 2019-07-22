Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90912C76196
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770B521BE6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfGVFWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:22:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfGVFWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:22:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 911E9335CF;
        Mon, 22 Jul 2019 05:22:16 +0000 (UTC)
Received: from [10.72.12.30] (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B99D65DA2E;
        Mon, 22 Jul 2019 05:22:03 +0000 (UTC)
Subject: Re: WARNING in __mmdrop
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        syzbot <syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com>
Cc:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jglisse@redhat.com,
        keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <75c43998-3a1c-676f-99ff-3d04663c3fcc@redhat.com>
Date:   Mon, 22 Jul 2019 13:21:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190721044615-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 22 Jul 2019 05:22:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/21 下午6:02, Michael S. Tsirkin wrote:
> On Sat, Jul 20, 2019 at 03:08:00AM -0700, syzbot wrote:
>> syzbot has bisected this bug to:
>>
>> commit 7f466032dc9e5a61217f22ea34b2df932786bbfc
>> Author: Jason Wang <jasowang@redhat.com>
>> Date:   Fri May 24 08:12:18 2019 +0000
>>
>>      vhost: access vq metadata through kernel virtual address
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149a8a20600000
>> start commit:   6d21a41b Add linux-next specific files for 20190718
>> git tree:       linux-next
>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=169a8a20600000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=129a8a20600000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
>> dashboard link: https://syzkaller.appspot.com/bug?extid=e58112d71f77113ddb7b
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10139e68600000
>>
>> Reported-by: syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com
>> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual
>> address")
>>
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> OK I poked at this for a bit, I see several things that
> we need to fix, though I'm not yet sure it's the reason for
> the failures:
>
>
> 1. mmu_notifier_register shouldn't be called from vhost_vring_set_num_addr
>     That's just a bad hack,


This is used to avoid holding lock when checking whether the addresses 
are overlapped. Otherwise we need to take spinlock for each invalidation 
request even if it was the va range that is not interested for us. This 
will be very slow e.g during guest boot.


>   in particular I don't think device
>     mutex is taken and so poking at two VQs will corrupt
>     memory.


The caller vhost_net_ioctl() (or scsi and vsock) will hold device mutex 
before calling us.


>     So what to do? How about a per vq notifier?
>     Of course we also have synchronize_rcu
>     in the notifier which is slow and is now going to be called twice.
>     I think call_rcu would be more appropriate here.
>     We then need rcu_barrier on module unload.


So this seems unnecessary.


>     OTOH if we make pages linear with map then we are good
>     with kfree_rcu which is even nicer.


It could be an optimization on top.


>
> 2. Doesn't map leak after vhost_map_unprefetch?
>     And why does it poke at contents of the map?
>     No one should use it right?


Yes, it's not hard to fix just kfree map in this function.


>
> 3. notifier unregister happens last in vhost_dev_cleanup,
>     but register happens first. This looks wrong to me.


I'm not sure I get the the exact issue here.


>
> 4. OK so we use the invalidate count to try and detect that
>     some invalidate is in progress.
>     I am not 100% sure why do we care.
>     Assuming we do, uaddr can change between start and end
>     and then the counter can get negative, or generally
>     out of sync.


Yes, so the fix is as simple as zero the invalidate_count after 
unregister  the mmu notifier in vhost_set_vring_num_addr().


>
> So what to do about all this?
> I am inclined to say let's just drop the uaddr optimization
> for now. E.g. kvm invalidates unconditionally.
> 3 should be fixed independently.


Maybe it's better to try to fix with the exist uaddr optimization first.

I did spot two other issues:

1) we don't check the return value mmu_register in vhost_set_vring_num()

2) we try to setup vq address even if set_vring_addr() fail


For the bug it self, it looks to me that the mm refcount was messed up 
since we try to register and unregister MMU notifier. But I haven't 
figured out why, will do more investigation.

Thanks


>
>
