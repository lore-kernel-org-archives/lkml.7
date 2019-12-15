Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B55C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 17:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAC424679
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 17:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzxlV34n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfLORdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 12:33:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37279 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbfLORdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 12:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576431187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J6eLuoIH1PYARRdiL90lhVsYJtyjHYLmUjrrQQDPe7E=;
        b=CzxlV34np9k3UEhMnNHvlZ/abfc3QqqDSifgUvK84Mn9hB/RVtKSzsFYU5B1Eoa7ygsHXv
        xIJUGztF5l0ZtXtd1D8clVzr3L2Px6oqzPqqcGEb7H8G1JDrAajvJIAI90QYlUH1VrF/zH
        hEJNyt8Bf3dBnek98SZAtoO+Nk4Y5F8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-UXQBTVKqM0O4UaBotsSrfQ-1; Sun, 15 Dec 2019 12:33:05 -0500
X-MC-Unique: UXQBTVKqM0O4UaBotsSrfQ-1
Received: by mail-qv1-f72.google.com with SMTP id ec1so3752597qvb.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 09:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J6eLuoIH1PYARRdiL90lhVsYJtyjHYLmUjrrQQDPe7E=;
        b=lungjJtzZQHNF3R1jxr4q2+LlMCcPBU5kg8gh6wCXGKD3YkUUOWIozblUjIe2dM59J
         49GBbqUXN9pGdJ6xYMaoiWoWoAV9RV1ZVJIeH8aizzr4FxlEBD8qyfGwrXdJddes58PQ
         HfA6iUdFmFQSRMXA+eRvX3w0O27hcoRgTLvHyk1Usy0zw/yEGyeKC53obhkAOc6hi69b
         YQnrRosnHMYOXY84IRTgfkhQxLtHmj2ECnYq798U8c4gfJpcn+nSS1zzqAgNdAUJNR4L
         3UgjUE+jp9f8b4PyQO/gMNf1Sojgj+YfTBXS4Pi6KBEoqu1P8/4OY8k3tZhF5rZjdWwg
         /5xQ==
X-Gm-Message-State: APjAAAWpZTT5z6uDy6yrCHgxiNYyn5KpajK1GJd4EktsWEdsk+6E03O2
        UAuPB6G1RfAPh0nA/rN3i5RU7M7gl1TAnY0WVw05s1W7rlNW3NnIjQInjDDGP0JqI+dM05Cmyeu
        YCcqt3ow3vJ1CU1PXabQ7wMD6
X-Received: by 2002:a0c:c250:: with SMTP id w16mr22513196qvh.24.1576431184771;
        Sun, 15 Dec 2019 09:33:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxo9sJEBR+EsX1bmgGKr8ThSL07V3VdYoGvHnp9UXySXWBJwJocU2y448wh+xjezZzZwrACMw==
X-Received: by 2002:a0c:c250:: with SMTP id w16mr22513173qvh.24.1576431184495;
        Sun, 15 Dec 2019 09:33:04 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:3f::2])
        by smtp.gmail.com with ESMTPSA id p126sm5093766qke.108.2019.12.15.09.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 09:33:03 -0800 (PST)
Date:   Sun, 15 Dec 2019 12:33:02 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191215173302.GB83861@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <20191211063830-mutt-send-email-mst@kernel.org>
 <20191211205952.GA5091@xz-x1>
 <20191211172713-mutt-send-email-mst@kernel.org>
 <46ceb88c-0ddd-0d9a-7128-3aa5a7d9d233@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46ceb88c-0ddd-0d9a-7128-3aa5a7d9d233@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 01:08:14AM +0100, Paolo Bonzini wrote:
> >>> What depends on what here? Looks suspicious ...
> >>
> >> Hmm, I think maybe it can be removed because the entry pointer
> >> reference below should be an ordering constraint already?
> 
> entry->xxx depends on ring->reset_index.

Yes that's true, but...

        entry = &ring->dirty_gfns[ring->reset_index & (ring->size - 1)];
        /* barrier? */
        next_slot = READ_ONCE(entry->slot);
        next_offset = READ_ONCE(entry->offset);

... I think entry->xxx depends on entry first, then entry depends on
reset_index.  So it seems fine because all things have a dependency?

> 
> >>> what's the story around locking here? Why is it safe
> >>> not to take the lock sometimes?
> >>
> >> kvm_dirty_ring_push() will be with lock==true only when the per-vm
> >> ring is used.  For per-vcpu ring, because that will only happen with
> >> the vcpu context, then we don't need locks (so kvm_dirty_ring_push()
> >> is called with lock==false).
> 
> FWIW this will be done much more nicely in v2.
> 
> >>>> +	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> >>>> +	if (!page) {
> >>>> +		r = -ENOMEM;
> >>>> +		goto out_err_alloc_page;
> >>>> +	}
> >>>> +	kvm->vm_run = page_address(page);
> >>>
> >>> So 4K with just 8 bytes used. Not as bad as 1/2Mbyte for the ring but
> >>> still. What is wrong with just a pointer and calling put_user?
> >>
> >> I want to make it the start point for sharing fields between
> >> user/kernel per-vm.  Just like kvm_run for per-vcpu.
> 
> This page is actually not needed at all.  Userspace can just map at
> KVM_DIRTY_LOG_PAGE_OFFSET, the indices reside there.  You can drop
> kvm_vm_run completely.

I changed it because otherwise we use one entry of the padding, and
all the rest of paddings are a waste of memory because we can never
really use the padding as new fields only for the 1st entry which
overlaps with the indices.  IMHO that could even waste more than 4k.

(for now we only "waste" 4K for per-vm, kvm_run is already mapped so
 no waste there, not to say potentially I still think we can use the
 kvm_vm_run in the future)

> 
> >>>> +	} else {
> >>>> +		/*
> >>>> +		 * Put onto per vm ring because no vcpu context.  Kick
> >>>> +		 * vcpu0 if ring is full.
> >>>
> >>> What about tasks on vcpu 0? Do guests realize it's a bad idea to put
> >>> critical tasks there, they will be penalized disproportionally?
> >>
> >> Reasonable question.  So far we can't avoid it because vcpu exit is
> >> the event mechanism to say "hey please collect dirty bits".  Maybe
> >> someway is better than this, but I'll need to rethink all these
> >> over...
> > 
> > Maybe signal an eventfd, and let userspace worry about deciding what to
> > do.
> 
> This has to be done synchronously.  But the vm ring should be used very
> rarely (it's for things like kvmclock updates that write to guest memory
> outside a vCPU), possibly a handful of times in the whole run of the VM.

I've summarized a list of callers who might dirty guest memory in the
other thread, it seems to me that even the kvm clock is using per-vcpu
contexts.

> 
> >>> KVM_DIRTY_RING_MAX_ENTRIES is not part of UAPI.
> >>> So how does userspace know what's legal?
> >>> Do you expect it to just try?
> >>
> >> Yep that's what I thought. :)
> 
> We should return it for KVM_CHECK_EXTENSION.

OK.  I'll drop the versioning.

-- 
Peter Xu

