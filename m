Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2126DC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1E2207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLndBXFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfLDKF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:05:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55707 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727502AbfLDKF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575453953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3bzkOfkSPb6+yZQ19D8wPgL9epYwdepj3FzmNzcMCF4=;
        b=JLndBXFhsEDzVoYAgiJXRSZ3DpCgJGatFWp26fBx9AVCyW11QWQ3QVxI0JRySR09bTAWjt
        YWw9zwkTNxVC5S3Nb1WRXxa9E1VCjXfJ87X3wTUIfJm+ofG5kDne7eVzePzvqHY0RVqBJC
        GHzF5R148b8+jrueZD1Je4ey3wPUxRo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-73BQKKcqNS-C3gTDf6i_6w-1; Wed, 04 Dec 2019 05:05:50 -0500
Received: by mail-wr1-f72.google.com with SMTP id w6so3375030wrm.16
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 02:05:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3bzkOfkSPb6+yZQ19D8wPgL9epYwdepj3FzmNzcMCF4=;
        b=cfRH3JX7r3mik3DRykXhLXHL1RDKeyC6X0ajk3tCqzpR7pLmiMlmi+wj6sAeRihOOx
         t/2phmMov+WGIaECFVSoqh+FDMJ8kWue/+ZAKDxG6Q6pHGDAxtxfZSxlyRHOapYbHlKc
         w8HgokQZ3hfeRSphPGn0F0DDsdqF294uCxluM+vsSB8mUZHKCHhpfYf4xc1rChD22uIZ
         s4oXpOcQZvID93O/ARSJEF4ViWywV6u7rvHBncDrLDB24gBrpyh+HpupXVxlM/A/dRxV
         mndO3W8h4Tajynbn+wPAw1JBDxmYuk2C/0KW5Al02z/6yOg2zAtvdBxeILyD446oKSxp
         k6MA==
X-Gm-Message-State: APjAAAXyu7+iIuDlYTBcezSHU9uRomY8RknuiTR3ZI5IrC8V2PFi9lNy
        ozWPwOE2xq7KdQMs32McO1En+A/2osuovHMS4kVJYeYm3NCKnpbv1bmWpZJLG7JJ9OcdW9MowGx
        r0raeI/tkkhl11j4pLtzRM/aZ
X-Received: by 2002:a1c:6389:: with SMTP id x131mr24167544wmb.174.1575453949342;
        Wed, 04 Dec 2019 02:05:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqzAiISuDcUWRbEN4GA4CkChNhzcGczIBRYMip+8ZZRMkK0DKzpZdJ6CixN1sArGDUdLUzH2jQ==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr24167500wmb.174.1575453948930;
        Wed, 04 Dec 2019 02:05:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a? ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
        by smtp.gmail.com with ESMTPSA id k4sm6458033wmk.26.2019.12.04.02.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 02:05:48 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <20191202201036.GJ4063@linux.intel.com> <20191202211640.GF31681@xz-x1>
 <20191202215049.GB8120@linux.intel.com>
 <fd882b9f-e510-ff0d-db43-eced75427fc6@redhat.com>
 <20191203184600.GB19877@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <374f18f1-0592-9b70-adbb-0a72cc77d426@redhat.com>
Date:   Wed, 4 Dec 2019 11:05:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191203184600.GB19877@linux.intel.com>
Content-Language: en-US
X-MC-Unique: 73BQKKcqNS-C3gTDf6i_6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/19 19:46, Sean Christopherson wrote:
> On Tue, Dec 03, 2019 at 02:48:10PM +0100, Paolo Bonzini wrote:
>> On 02/12/19 22:50, Sean Christopherson wrote:
>>>>
>>>> I discussed this with Paolo, but I think Paolo preferred the per-vm
>>>> ring because there's no good reason to choose vcpu0 as what (1)
>>>> suggested.  While if to choose (2) we probably need to lock even for
>>>> per-cpu ring, so could be a bit slower.
>>> Ya, per-vm is definitely better than dumping on vcpu0.  I'm hoping we can
>>> find a third option that provides comparable performance without using any
>>> per-vcpu rings.
>>>
>>
>> The advantage of per-vCPU rings is that it naturally: 1) parallelizes
>> the processing of dirty pages; 2) makes userspace vCPU thread do more
>> work on vCPUs that dirty more pages.
>>
>> I agree that on the producer side we could reserve multiple entries in
>> the case of PML (and without PML only one entry should be added at a
>> time).  But I'm afraid that things get ugly when the ring is full,
>> because you'd have to wait for all vCPUs to finish publishing the
>> entries they have reserved.
> 
> Ah, I take it the intended model is that userspace will only start pulling
> entries off the ring when KVM explicitly signals that the ring is "full"?

No, it's not.  But perhaps in the asynchronous case you can delay
pushing the reserved entries to the consumer until a moment where no
CPUs have left empty slots in the ring buffer (somebody must have done
multi-producer ring buffers before).  In the ring-full case that is
harder because it requires synchronization.

> Rather than reserve entries, what if vCPUs reserved an entire ring?  Create
> a pool of N=nr_vcpus rings that are shared by all vCPUs.  To mark pages
> dirty, a vCPU claims a ring, pushes the pages into the ring, and then
> returns the ring to the pool.  If pushing pages hits the soft limit, a
> request is made to drain the ring and the ring is not returned to the pool
> until it is drained.
> 
> Except for acquiring a ring, which likely can be heavily optimized, that'd
> allow parallel processing (#1), and would provide a facsimile of #2 as
> pushing more pages onto a ring would naturally increase the likelihood of
> triggering a drain.  And it might be interesting to see the effect of using
> different methods of ring selection, e.g. pure round robin, LRU, last used
> on the current vCPU, etc...

If you are creating nr_vcpus rings, and draining is done on the vCPU
thread that has filled the ring, why not create nr_vcpus+1?  The current
code then is exactly the same as pre-claiming a ring per vCPU and never
releasing it, and using a spinlock to claim the per-VM ring.

However, we could build on top of my other suggestion to add
slot->as_id, and wrap kvm_get_running_vcpu() with a nice API, mimicking
exactly what you've suggested.  Maybe even add a scary comment around
kvm_get_running_vcpu() suggesting that users only do so to avoid locking
and wrap it with a nice API.  Similar to what get_cpu/put_cpu do with
smp_processor_id.

1) Add a pointer from struct kvm_dirty_ring to struct
kvm_dirty_ring_indexes:

vcpu->dirty_ring->data = &vcpu->run->vcpu_ring_indexes;
kvm->vm_dirty_ring->data = *kvm->vm_run->vm_ring_indexes;

2) push the ring choice and locking to two new functions

struct kvm_ring *kvm_get_dirty_ring(struct kvm *kvm)
{
	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();

	if (vcpu && !WARN_ON_ONCE(vcpu->kvm != kvm)) {
		return &vcpu->dirty_ring;
	} else {
		/*
		 * Put onto per vm ring because no vcpu context.
		 * We'll kick vcpu0 if ring is full.
		 */
		spin_lock(&kvm->vm_dirty_ring->lock);
		return &kvm->vm_dirty_ring;
	}
}

void kvm_put_dirty_ring(struct kvm *kvm,
			struct kvm_dirty_ring *ring)
{
	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
	bool full = kvm_dirty_ring_used(ring) >= ring->soft_limit;

	if (ring == &kvm->vm_dirty_ring) {
		if (vcpu == NULL)
			vcpu = kvm->vcpus[0];
		spin_unlock(&kvm->vm_dirty_ring->lock);
	}

	if (full)
		kvm_make_request(KVM_REQ_DIRTY_RING_FULL, vcpu);
}

3) simplify kvm_dirty_ring_push to

void kvm_dirty_ring_push(struct kvm_dirty_ring *ring,
			 u32 slot, u64 offset)
{
	/* left as an exercise to the reader */
}

and mark_page_dirty_in_ring to

static void mark_page_dirty_in_ring(struct kvm *kvm,
				    struct kvm_memory_slot *slot,
				    gfn_t gfn)
{
	struct kvm_dirty_ring *ring;

	if (!kvm->dirty_ring_size)
		return;

	ring = kvm_get_dirty_ring(kvm);
	kvm_dirty_ring_push(ring, (slot->as_id << 16) | slot->id,
			    gfn - slot->base_gfn);
	kvm_put_dirty_ring(kvm, ring);
}

Paolo

>> It's ugly that we _also_ need a per-VM ring, but unfortunately some
>> operations do not really have a vCPU that they can refer to.
> 

