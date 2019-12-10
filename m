Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AA0C2D0C5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897E82073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAuSgPlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfLJKHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:07:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23100 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727242AbfLJKHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575972454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CMYeQ7tZmLdKNEh9TlqLYvgk+bkQDsij/88OR5a5q7A=;
        b=PAuSgPlBzYyQzdxfASObE7ixrEzXK1NOOVgZ8hXCFJ40pddQxjMWUTQvPl+Tss4Xzikiq5
        fp0ozpyWG/qwTBxztbrFhO9mygxZqqwtsQOWX6OTg+erIRKOmh88xyo2JU42LM52XTNdVP
        TCpWUWEo9BLNZGQtwzONN1APWJwJzjw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-HY5R-pzdOjuqK2IHM923VQ-1; Tue, 10 Dec 2019 05:07:33 -0500
Received: by mail-wm1-f72.google.com with SMTP id o135so453104wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 02:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CMYeQ7tZmLdKNEh9TlqLYvgk+bkQDsij/88OR5a5q7A=;
        b=hZHYGXlorgEvwt+wr0lsT/jMLNk5MHor3BIfrrRe7p4ADmOEzwOzgzeHvbUfE82cvI
         IRoLtp7WX/YNJjrhEG5y07BASirMAcLlXmVpGj8XS9OpZ0i4WF46ibvKksEpXvrlotG9
         Lcxjy7tr1yfObtD8Z5Z6zqhWdPrat2MA+3T6VAjv7xewAEn62BbZiG+rVWMsYK6PXX+H
         gST1glAKcYWvyabtkjEz09whaizNtYO6kbGwTIktAjSBPpkkg5llS7oMTD0PGufF74gj
         CiBhOk923e8PHFoOr+tPI4miBBz/USaMuKUert5g+UL93oT6di/7/1/zPBY95IdGk3rW
         hEhg==
X-Gm-Message-State: APjAAAVysvGNLOcJtESmSfvW7XFURB0pScVmXvCwl4Q2sNDALqDzcg2q
        mIAZb4IfqZc8ocuJjrudr/xZnh2DfitFl2lJ1eIwRsLxjkMmB4+0CE52gn34FbbNO49kThMb2Kf
        LRlb3Q/Wd+0ejqMn8U5Pv98D6
X-Received: by 2002:a7b:c386:: with SMTP id s6mr4078407wmj.105.1575972452037;
        Tue, 10 Dec 2019 02:07:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwDWTW63Gujp9+L863ffP+D4hw6Kj/ugNEcyaKGSK7Mi7Dt/48LeqIK/LCRgrmnlbxtw4hVEQ==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr4078380wmj.105.1575972451765;
        Tue, 10 Dec 2019 02:07:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id m187sm2534576wmm.16.2019.12.10.02.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 02:07:31 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     Peter Xu <peterx@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <20191202201036.GJ4063@linux.intel.com> <20191202211640.GF31681@xz-x1>
 <20191202215049.GB8120@linux.intel.com>
 <fd882b9f-e510-ff0d-db43-eced75427fc6@redhat.com>
 <20191203184600.GB19877@linux.intel.com>
 <374f18f1-0592-9b70-adbb-0a72cc77d426@redhat.com>
 <20191209215400.GA3352@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <affd9d84-1b84-0c25-c431-a075c58c33dc@redhat.com>
Date:   Tue, 10 Dec 2019 11:07:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191209215400.GA3352@xz-x1>
Content-Language: en-US
X-MC-Unique: HY5R-pzdOjuqK2IHM923VQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/19 22:54, Peter Xu wrote:
> Just until recently I noticed that actually kvm_get_running_vcpu() has
> a real benefit in that it gives a very solid result on whether we're
> with the vcpu context, even more accurate than when we pass vcpu
> pointers around (because sometimes we just passed the kvm pointer
> along the stack even if we're with a vcpu context, just like what we
> did with mark_page_dirty_in_slot).

Right, that's the point.

> I'm thinking whether I can start
> to use this information in the next post on solving an issue I
> encountered with the waitqueue.
> 
> Current waitqueue is still problematic in that it could wait even with
> the mmu lock held when with vcpu context.

I think the idea of the soft limit is that the waiting just cannot
happen.  That is, the number of dirtied pages _outside_ the guest (guest
accesses are taken care of by PML, and are subtracted from the soft
limit) cannot exceed hard_limit - (soft_limit + pml_size).

> The issue is KVM_RESET_DIRTY_RINGS needs the mmu lock to manipulate
> the write bits, while it's the only interface to also wake up the
> dirty ring sleepers.  They could dead lock like this:
> 
>       main thread                            vcpu thread
>       ===========                            ===========
>                                              kvm page fault
>                                                mark_page_dirty_in_slot
>                                                mmu lock taken
>                                                mark dirty, ring full
>                                                queue on waitqueue
>                                                (with mmu lock)
>       KVM_RESET_DIRTY_RINGS
>         take mmu lock               <------------ deadlock here
>         reset ring gfns
>         wakeup dirty ring sleepers
> 
> And if we see if the mark_page_dirty_in_slot() is not with a vcpu
> context (e.g. kvm_mmu_page_fault) but with an ioctl context (those
> cases we'll use per-vm dirty ring) then it's probably fine.
> 
> My planned solution:
> 
> - When kvm_get_running_vcpu() != NULL, we postpone the waitqueue waits
>   until we finished handling this page fault, probably in somewhere
>   around vcpu_enter_guest, so that we can do wait_event() after the
>   mmu lock released

I think this can cause a race:

	vCPU 1			vCPU 2		host
	---------------------------------------------------------------
	mark page dirty
				write to page
						treat page as not dirty
	add page to ring

where vCPU 2 skips the clean-page slow path entirely.

Paolo

