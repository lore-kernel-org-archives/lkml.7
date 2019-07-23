Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56575C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F3322543
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732822AbfGWNej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:34:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfGWNei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:34:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9D3785365;
        Tue, 23 Jul 2019 13:34:37 +0000 (UTC)
Received: from [10.72.12.26] (ovpn-12-26.pek2.redhat.com [10.72.12.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DB5A1001B29;
        Tue, 23 Jul 2019 13:34:24 +0000 (UTC)
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
 <e2e01a05-63d8-4388-2bcd-b2be3c865486@redhat.com>
 <20190723062221-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9baa4214-67fd-7ad2-cbad-aadf90bbfc20@redhat.com>
Date:   Tue, 23 Jul 2019 21:34:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723062221-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 23 Jul 2019 13:34:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/23 下午6:27, Michael S. Tsirkin wrote:
>> Yes, since there could be multiple co-current invalidation requests. We need
>> count them to make sure we don't pin wrong pages.
>>
>>
>>> I also wonder about ordering. kvm has this:
>>>          /*
>>>            * Used to check for invalidations in progress, of the pfn that is
>>>            * returned by pfn_to_pfn_prot below.
>>>            */
>>>           mmu_seq = kvm->mmu_notifier_seq;
>>>           /*
>>>            * Ensure the read of mmu_notifier_seq isn't reordered with PTE reads in
>>>            * gfn_to_pfn_prot() (which calls get_user_pages()), so that we don't
>>>            * risk the page we get a reference to getting unmapped before we have a
>>>            * chance to grab the mmu_lock without mmu_notifier_retry() noticing.
>>>            *
>>>            * This smp_rmb() pairs with the effective smp_wmb() of the combination
>>>            * of the pte_unmap_unlock() after the PTE is zapped, and the
>>>            * spin_lock() in kvm_mmu_notifier_invalidate_<page|range_end>() before
>>>            * mmu_notifier_seq is incremented.
>>>            */
>>>           smp_rmb();
>>>
>>> does this apply to us? Can't we use a seqlock instead so we do
>>> not need to worry?
>> I'm not familiar with kvm MMU internals, but we do everything under of
>> mmu_lock.
>>
>> Thanks
> I don't think this helps at all.
>
> There's no lock between checking the invalidate counter and
> get user pages fast within vhost_map_prefetch. So it's possible
> that get user pages fast reads PTEs speculatively before
> invalidate is read.
>
> -- 


In vhost_map_prefetch() we do:

         spin_lock(&vq->mmu_lock);

         ...

         err = -EFAULT;
         if (vq->invalidate_count)
                 goto err;

         ...

         npinned = __get_user_pages_fast(uaddr->uaddr, npages,
                                         uaddr->write, pages);

         ...

         spin_unlock(&vq->mmu_lock);

Is this not sufficient?

Thanks

