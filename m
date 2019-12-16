Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B661C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660EF20665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haRxTYcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfLPJrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:47:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32752 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726977AbfLPJrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576489666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x4F0S6F+puErRf/9qNGD3qSr4YnaGP1lnAVzdVRgZvU=;
        b=haRxTYcb+pPrHZlwLDOkXthIEeYXVmZXQAZh8YDqeXjnDxJ+5AyX0HT6mdoVVFUtBrsG3k
        V/oq40QpgvLlnE4pLdoGdbxa4RkjcXKqVOxF9f2t5wTaGVEERBSKKXkoXQMwZRbLoxgfhv
        E7HQ4+0Rb4sGWBmmUWm7nLxsM6pan+c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-bPoOpwa_MnulqnxHRIoEoA-1; Mon, 16 Dec 2019 04:47:43 -0500
X-MC-Unique: bPoOpwa_MnulqnxHRIoEoA-1
Received: by mail-qk1-f197.google.com with SMTP id c202so4322495qkg.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 01:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x4F0S6F+puErRf/9qNGD3qSr4YnaGP1lnAVzdVRgZvU=;
        b=MMcj/0XyR68dqQeK+hIGIIbV94MmuFcdJYeu6/md8Swp5TFlOW+YGF79crjU7oJEQy
         Rn1rraiihDGODr6r1dsNJIklkROZB9CJ8hPOfCC0GUMD7mk/tY4t8p51A4ovyHr3E6xB
         ytqt0WmofToDDfWluTRugSNAx49nGr33swLuJ04YRe2MWejKGR/vNeHwAkyRTj263bPs
         5MpBk+iob01ZNO3CueNPKaa2KPrI8oK+8pQSYFbizsPAlK+E18CJiR4/EvYKQT4ednOg
         roTtAJHDUt+QhKY/WNpfRKqSoBMueO9IMHNmJgcXfZCv+zuwuU9Yp8uEhctbSiF4MY7w
         PPfQ==
X-Gm-Message-State: APjAAAUjzK3f5Pu2WNwl3uWTpHuB+eWeT5Pk2ic2qVdebuBeKjbxyRPZ
        1n9Dmy4gTXg3SwQhgOCgpgavm6TDG9bH4r1BLvRpm1OSz9F7YeOURwQqdwDlrkTTFmbIKz2FJdj
        U5REt+81VktboYDybDx3nCeX/
X-Received: by 2002:aed:256f:: with SMTP id w44mr7069754qtc.331.1576489663040;
        Mon, 16 Dec 2019 01:47:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxIZNYdabqmI0CG0aOJ0NQEhESVmckgU7vVqS63tN6mOzzA5VFGb+hnjE+Zgtxy3Azad9N/Jw==
X-Received: by 2002:aed:256f:: with SMTP id w44mr7069748qtc.331.1576489662780;
        Mon, 16 Dec 2019 01:47:42 -0800 (PST)
Received: from redhat.com (bzq-111-168-31-5.red.bezeqint.net. [31.168.111.5])
        by smtp.gmail.com with ESMTPSA id r10sm5762779qkm.23.2019.12.16.01.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 01:47:41 -0800 (PST)
Date:   Mon, 16 Dec 2019 04:47:36 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191216044619-mutt-send-email-mst@kernel.org>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <20191211063830-mutt-send-email-mst@kernel.org>
 <20191211205952.GA5091@xz-x1>
 <20191211172713-mutt-send-email-mst@kernel.org>
 <46ceb88c-0ddd-0d9a-7128-3aa5a7d9d233@redhat.com>
 <20191215173302.GB83861@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215173302.GB83861@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 12:33:02PM -0500, Peter Xu wrote:
> On Thu, Dec 12, 2019 at 01:08:14AM +0100, Paolo Bonzini wrote:
> > >>> What depends on what here? Looks suspicious ...
> > >>
> > >> Hmm, I think maybe it can be removed because the entry pointer
> > >> reference below should be an ordering constraint already?
> > 
> > entry->xxx depends on ring->reset_index.
> 
> Yes that's true, but...
> 
>         entry = &ring->dirty_gfns[ring->reset_index & (ring->size - 1)];
>         /* barrier? */
>         next_slot = READ_ONCE(entry->slot);
>         next_offset = READ_ONCE(entry->offset);
> 
> ... I think entry->xxx depends on entry first, then entry depends on
> reset_index.  So it seems fine because all things have a dependency?

Is reset_index changed from another thread then?
If yes then you want to read reset_index with READ_ONCE.
That includes a dependency barrier.

> > 
> > >>> what's the story around locking here? Why is it safe
> > >>> not to take the lock sometimes?
> > >>
> > >> kvm_dirty_ring_push() will be with lock==true only when the per-vm
> > >> ring is used.  For per-vcpu ring, because that will only happen with
> > >> the vcpu context, then we don't need locks (so kvm_dirty_ring_push()
> > >> is called with lock==false).
> > 
> > FWIW this will be done much more nicely in v2.
> > 
> > >>>> +	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> > >>>> +	if (!page) {
> > >>>> +		r = -ENOMEM;
> > >>>> +		goto out_err_alloc_page;
> > >>>> +	}
> > >>>> +	kvm->vm_run = page_address(page);
> > >>>
> > >>> So 4K with just 8 bytes used. Not as bad as 1/2Mbyte for the ring but
> > >>> still. What is wrong with just a pointer and calling put_user?
> > >>
> > >> I want to make it the start point for sharing fields between
> > >> user/kernel per-vm.  Just like kvm_run for per-vcpu.
> > 
> > This page is actually not needed at all.  Userspace can just map at
> > KVM_DIRTY_LOG_PAGE_OFFSET, the indices reside there.  You can drop
> > kvm_vm_run completely.
> 
> I changed it because otherwise we use one entry of the padding, and
> all the rest of paddings are a waste of memory because we can never
> really use the padding as new fields only for the 1st entry which
> overlaps with the indices.  IMHO that could even waste more than 4k.
> 
> (for now we only "waste" 4K for per-vm, kvm_run is already mapped so
>  no waste there, not to say potentially I still think we can use the
>  kvm_vm_run in the future)
> 
> > 
> > >>>> +	} else {
> > >>>> +		/*
> > >>>> +		 * Put onto per vm ring because no vcpu context.  Kick
> > >>>> +		 * vcpu0 if ring is full.
> > >>>
> > >>> What about tasks on vcpu 0? Do guests realize it's a bad idea to put
> > >>> critical tasks there, they will be penalized disproportionally?
> > >>
> > >> Reasonable question.  So far we can't avoid it because vcpu exit is
> > >> the event mechanism to say "hey please collect dirty bits".  Maybe
> > >> someway is better than this, but I'll need to rethink all these
> > >> over...
> > > 
> > > Maybe signal an eventfd, and let userspace worry about deciding what to
> > > do.
> > 
> > This has to be done synchronously.  But the vm ring should be used very
> > rarely (it's for things like kvmclock updates that write to guest memory
> > outside a vCPU), possibly a handful of times in the whole run of the VM.
> 
> I've summarized a list of callers who might dirty guest memory in the
> other thread, it seems to me that even the kvm clock is using per-vcpu
> contexts.
> 
> > 
> > >>> KVM_DIRTY_RING_MAX_ENTRIES is not part of UAPI.
> > >>> So how does userspace know what's legal?
> > >>> Do you expect it to just try?
> > >>
> > >> Yep that's what I thought. :)
> > 
> > We should return it for KVM_CHECK_EXTENSION.
> 
> OK.  I'll drop the versioning.
> 
> -- 
> Peter Xu

