Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC96C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949C5227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+plSqR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfLRQSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:18:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44123 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726984AbfLRQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576685879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P88rx9cd9kQKZ8dguxvhOHW4MjtfLZb0Tzz3Us5jasg=;
        b=D+plSqR5iL61gM2ZqOB8i8fqjoBYI0v+QRPtwx7uUCUrKJnLVWJjE3wrriYbyx8laUmTZJ
        Y7FBUdcaLcMydtqagZifGXaZDK/FE5gvBlWbjtE99Oo0cO02KGT3FtSKYXRlnCGAhm7AB3
        3K3Om7SqjuWSasC7a/f4HBCmmpXNjNU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-7IJMjEueOJyM_Waj6Z0Rdg-1; Wed, 18 Dec 2019 11:17:58 -0500
X-MC-Unique: 7IJMjEueOJyM_Waj6Z0Rdg-1
Received: by mail-qk1-f199.google.com with SMTP id a200so1630211qkc.18
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 08:17:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P88rx9cd9kQKZ8dguxvhOHW4MjtfLZb0Tzz3Us5jasg=;
        b=EU7FaAWUfwWSktMfjkY0MmbBfk6rjognGeVM4/Bbt60eZfz5u8Dh/tgLdoIN5nCITM
         3k7651VZJF9DMyXDc/Bay3WIsg9tI7NoYO5BK5/C8u4DoqfnYYRL0xgfJC7o/W++F2Sd
         N7Kne+HJgjwVwtqonukqfdQRPy/Kv+mq4nP+S8Wn9H84n7KrMFfxhsn5iNaE/Y8FLEaT
         hLryWSoVo7YOQ3bB/D2L2KyYiZZ5L2YKVAgJj38pOQJOShSw1L7nuDGL1ROet8xlgX4l
         wOGN/E3E+/fQAPp1dQmBbUJf6eqXoAd0eeUd5nLNCnT7ThC6zAjJdfYARgi1whP+/HW8
         IZaQ==
X-Gm-Message-State: APjAAAUCrN8rZaes28nkaZpaMR67yNv9ZJ5mqNgH9k24yHXJJWGrqxR7
        1HT3BhUQBL/8f6Lo7FfBTUJqCfn0zgl7/MqJv8CLFZUSGH530WDgE0JEEYqRG4o08vVW2yvb2Wu
        KTDe/kTF9TByb+kPNWBb1/Ztp
X-Received: by 2002:ac8:7a70:: with SMTP id w16mr2877840qtt.154.1576685877633;
        Wed, 18 Dec 2019 08:17:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4qHGhFCQSr/jP29aEubtfbaj7wEV9G/hOTID6lKw6YyGvv0dEeZDPR8BH6CrL2bXiQvdTHQ==
X-Received: by 2002:ac8:7a70:: with SMTP id w16mr2877791qtt.154.1576685877330;
        Wed, 18 Dec 2019 08:17:57 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id o16sm769610qkj.91.2019.12.18.08.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 08:17:56 -0800 (PST)
Date:   Wed, 18 Dec 2019 11:17:55 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Cornelia Huck <cohuck@redhat.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvmarm@lists.cs.columbia.edu, Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v4 07/19] KVM: Explicitly free allocated-but-unused dirty
 bitmap
Message-ID: <20191218161755.GB26669@xz-x1>
References: <20191217204041.10815-1-sean.j.christopherson@intel.com>
 <20191217204041.10815-8-sean.j.christopherson@intel.com>
 <20191217222446.GK7258@xz-x1>
 <20191217225118.GF11771@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217225118.GF11771@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 02:51:18PM -0800, Sean Christopherson wrote:
> On Tue, Dec 17, 2019 at 05:24:46PM -0500, Peter Xu wrote:
> > On Tue, Dec 17, 2019 at 12:40:29PM -0800, Sean Christopherson wrote:
> > > Explicitly free an allocated-but-unused dirty bitmap instead of relying
> > > on kvm_free_memslot() if an error occurs in __kvm_set_memory_region().
> > > There is no longer a need to abuse kvm_free_memslot() to free arch
> > > specific resources as arch specific code is now called only after the
> > > common flow is guaranteed to succeed.  Arch code can still fail, but
> > > it's responsible for its own cleanup in that case.
> > > 
> > > Eliminating the error path's abuse of kvm_free_memslot() paves the way
> > > for simplifying kvm_free_memslot(), i.e. dropping its @dont param.
> > > 
> > > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > > ---
> > >  virt/kvm/kvm_main.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index d403e93e3028..6b2261a9e139 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> > > @@ -1096,7 +1096,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
> > >  
> > >  	slots = kvzalloc(sizeof(struct kvm_memslots), GFP_KERNEL_ACCOUNT);
> > >  	if (!slots)
> > > -		goto out_free;
> > > +		goto out_bitmap;
> > >  	memcpy(slots, __kvm_memslots(kvm, as_id), sizeof(struct kvm_memslots));
> > >  
> > >  	if ((change == KVM_MR_DELETE) || (change == KVM_MR_MOVE)) {
> > > @@ -1144,8 +1144,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
> > >  	if (change == KVM_MR_DELETE || change == KVM_MR_MOVE)
> > >  		slots = install_new_memslots(kvm, as_id, slots);
> > >  	kvfree(slots);
> > > -out_free:
> > > -	kvm_free_memslot(kvm, &new, &old);
> > > +out_bitmap:
> > > +	if (new.dirty_bitmap && !old.dirty_bitmap)
> > > +		kvm_destroy_dirty_bitmap(&new);
> > 
> > What if both the old and new have KVM_MEM_LOG_DIRTY_PAGES set?
> > kvm_free_memslot() did cover that but I see that you explicitly
> > dropped it.  Could I ask why?  Thanks,
> 
> In that case, old.dirty_bitmap == new.dirty_bitmap, i.e. shouldn't be freed
> by this error path since doing so would result in a use-after-free via the
> old memslot.
> 
> The kvm_free_memslot() logic is the same, albeit in a very twisted way.

Yes it is. :)

> 
> In __kvm_set_memory_region(), @old and @new start with the same dirty_bitmap.
> 
> 	new = old = *slot;
> 
> And @new is modified based on KVM_MEM_LOG_DIRTY_PAGES.  If LOG_DIRTY_PAGES
> is set in both @new and @old, then both the "if" and "else if" evaluate
> false, i.e. new.dirty_bitmap == old.dirty_bitmap.
> 
> 	/* Allocate/free page dirty bitmap as needed */
> 	if (!(new.flags & KVM_MEM_LOG_DIRTY_PAGES))
> 		new.dirty_bitmap = NULL;
> 	else if (!new.dirty_bitmap) {
> 		r = kvm_create_dirty_bitmap(&new);
> 		if (r)
> 			return r;
> 	}
> 
> Subbing "@free <= @new" and "@dont <= @old" in kvm_free_memslot()
> 
>   static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
> 			       struct kvm_memory_slot *dont)
>   {
> 	if (!dont || free->dirty_bitmap != dont->dirty_bitmap)
> 		kvm_destroy_dirty_bitmap(free);
> 
> 
> yeids this, since @old is obviously non-NULL
> 
> 	if (new.dirty_bitmap != old.dirty_bitmap)
> 		kvm_destroy_dirty_bitmap(&new);
> 
> The dirty_bitmap allocation logic guarantees that new.dirty_bitmap is
>   a) NULL (the "if" case")
>   b) != old.dirty_bitmap iff old.dirty_bitmap == NULL (the "else if" case)
>   c) == old.dirty_bitmap (the implicit "else" case).
> 
> kvm_free_memslot() frees @new.dirty_bitmap iff its != @old.dirty_bitmap,
> thus the explicit destroy only needs to check for (b).

Thanks for explaining with such a detail.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

