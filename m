Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88548C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A94E2253E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbfGWImc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:42:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfGWImb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:42:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A801B59455;
        Tue, 23 Jul 2019 08:42:30 +0000 (UTC)
Received: from [10.72.12.26] (ovpn-12-26.pek2.redhat.com [10.72.12.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA57B608A5;
        Tue, 23 Jul 2019 08:42:18 +0000 (UTC)
Subject: Re: WARNING in __mmdrop
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     syzbot <syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
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
 <75c43998-3a1c-676f-99ff-3d04663c3fcc@redhat.com>
 <20190722035657-mutt-send-email-mst@kernel.org>
 <cfcd330d-5f4a-835a-69f7-c342d5d0d52d@redhat.com>
 <20190723010156-mutt-send-email-mst@kernel.org>
 <124be1a2-1c53-8e65-0f06-ee2294710822@redhat.com>
 <20190723032800-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e2e01a05-63d8-4388-2bcd-b2be3c865486@redhat.com>
Date:   Tue, 23 Jul 2019 16:42:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723032800-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 23 Jul 2019 08:42:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/23 下午3:56, Michael S. Tsirkin wrote:
> On Tue, Jul 23, 2019 at 01:48:52PM +0800, Jason Wang wrote:
>> On 2019/7/23 下午1:02, Michael S. Tsirkin wrote:
>>> On Tue, Jul 23, 2019 at 11:55:28AM +0800, Jason Wang wrote:
>>>> On 2019/7/22 下午4:02, Michael S. Tsirkin wrote:
>>>>> On Mon, Jul 22, 2019 at 01:21:59PM +0800, Jason Wang wrote:
>>>>>> On 2019/7/21 下午6:02, Michael S. Tsirkin wrote:
>>>>>>> On Sat, Jul 20, 2019 at 03:08:00AM -0700, syzbot wrote:
>>>>>>>> syzbot has bisected this bug to:
>>>>>>>>
>>>>>>>> commit 7f466032dc9e5a61217f22ea34b2df932786bbfc
>>>>>>>> Author: Jason Wang <jasowang@redhat.com>
>>>>>>>> Date:   Fri May 24 08:12:18 2019 +0000
>>>>>>>>
>>>>>>>>         vhost: access vq metadata through kernel virtual address
>>>>>>>>
>>>>>>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149a8a20600000
>>>>>>>> start commit:   6d21a41b Add linux-next specific files for 20190718
>>>>>>>> git tree:       linux-next
>>>>>>>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=169a8a20600000
>>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=129a8a20600000
>>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
>>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=e58112d71f77113ddb7b
>>>>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10139e68600000
>>>>>>>>
>>>>>>>> Reported-by: syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com
>>>>>>>> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual
>>>>>>>> address")
>>>>>>>>
>>>>>>>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>>>>>>> OK I poked at this for a bit, I see several things that
>>>>>>> we need to fix, though I'm not yet sure it's the reason for
>>>>>>> the failures:
>>>>>>>
>>>>>>>
>>>>>>> 1. mmu_notifier_register shouldn't be called from vhost_vring_set_num_addr
>>>>>>>        That's just a bad hack,
>>>>>> This is used to avoid holding lock when checking whether the addresses are
>>>>>> overlapped. Otherwise we need to take spinlock for each invalidation request
>>>>>> even if it was the va range that is not interested for us. This will be very
>>>>>> slow e.g during guest boot.
>>>>> KVM seems to do exactly that.
>>>>> I tried and guest does not seem to boot any slower.
>>>>> Do you observe any slowdown?
>>>> Yes I do.
>>>>
>>>>
>>>>> Now I took a hard look at the uaddr hackery it really makes
>>>>> me nervious. So I think for this release we want something
>>>>> safe, and optimizations on top. As an alternative revert the
>>>>> optimization and try again for next merge window.
>>>> Will post a series of fixes, let me know if you're ok with that.
>>>>
>>>> Thanks
>>> I'd prefer you to take a hard look at the patch I posted
>>> which makes code cleaner,
>>
>> I did. But it looks to me a series that is only about 60 lines of code can
>> fix all the issues we found without reverting the uaddr optimization.
> Another thing I like about the patch I posted is that
> it removes 60 lines of code, instead of adding more :)
> Mostly because of unifying everything into
> a single cleanup function and using kfree_rcu.


Yes.


>
> So how about this: do exactly what you propose but as a 2 patch series:
> start with the slow safe patch, and add then return uaddr optimizations
> on top. We can then more easily reason about whether they are safe.


If you stick, I can do this.


> Basically you are saying this:
> 	- notifiers are only needed to invalidate maps
> 	- we make sure any uaddr change invalidates maps anyway
> 	- thus it's ok not to have notifiers since we do
> 	  not have maps
>
> All this looks ok but the question is why do we
> bother unregistering them. And the answer seems to
> be that this is so we can start with a balanced
> counter: otherwise we can be between _start and
> _end calls.


Yes, since there could be multiple co-current invalidation requests. We 
need count them to make sure we don't pin wrong pages.


>
> I also wonder about ordering. kvm has this:
>         /*
>           * Used to check for invalidations in progress, of the pfn that is
>           * returned by pfn_to_pfn_prot below.
>           */
>          mmu_seq = kvm->mmu_notifier_seq;
>          /*
>           * Ensure the read of mmu_notifier_seq isn't reordered with PTE reads in
>           * gfn_to_pfn_prot() (which calls get_user_pages()), so that we don't
>           * risk the page we get a reference to getting unmapped before we have a
>           * chance to grab the mmu_lock without mmu_notifier_retry() noticing.
>           *
>           * This smp_rmb() pairs with the effective smp_wmb() of the combination
>           * of the pte_unmap_unlock() after the PTE is zapped, and the
>           * spin_lock() in kvm_mmu_notifier_invalidate_<page|range_end>() before
>           * mmu_notifier_seq is incremented.
>           */
>          smp_rmb();
>
> does this apply to us? Can't we use a seqlock instead so we do
> not need to worry?


I'm not familiar with kvm MMU internals, but we do everything under of 
mmu_lock.

Thanks


