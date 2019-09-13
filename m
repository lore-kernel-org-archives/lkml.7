Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC32C4CEC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FF620717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbfIMJKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 05:10:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387702AbfIMJKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:10:37 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D0C750F4D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 09:10:36 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id n6so13375210wrm.20
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 02:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lfR7hCR3n1vMNF7VisZxsxqzSWEAbbNmpmDv0NMLiRM=;
        b=lPN17sH1E5o5oRIwWZTbtwtPr/ai0CigK3ee+CMX0LnxNXxzoIfGzrpkoX9cfxsWFV
         XA17SESxDXVB2W2XyBcrPbLD+J4trL3O5FadPDBPq4cRY+yLhabx3sVWm5V79keUnuNl
         EP3M8YMMWot2K2vPSfV854ebF6JSEOlxQZXCLN9jQWdvv+lacOVslhPy1J09KSGu++CY
         0y9Hu2Tmg97a2vmf0ypNaQxSlIsjKbFRiNwSGy18J+uRE/1EYB6UUWiECrDY3W/B2QoJ
         Majbqj/pNnNMJjoBjOSa3oH4oM1vN/AU/T7/kBOsCz4eQiDLB6bzockJUQvx3fSg883d
         PWpw==
X-Gm-Message-State: APjAAAXgrHhqjP37/IPHL84T1rhTrY01ztkjnhdxe1K+EhPi05rPTzAa
        RvtHhGZEZL4ydGpnGIrIHYtqaisic2RXCbBF13QhYvHjvw7eQ9ugaorOEzP/dfY9ePRhW4zaw9z
        4aUzYYOkn3a63VrvD9k2YjXsf
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr2815655wrx.163.1568365834524;
        Fri, 13 Sep 2019 02:10:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzXc1bL5xFrSnBSo98QxqZe1gFpSVLipO6h3XpfBIdBwq42ngDjAhZicWU9t26AJiy3BJD+Fw==
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr2815637wrx.163.1568365834261;
        Fri, 13 Sep 2019 02:10:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3166:d768:e1a7:aab8? ([2001:b07:6468:f312:3166:d768:e1a7:aab8])
        by smtp.gmail.com with ESMTPSA id h125sm3380157wmf.31.2019.09.13.02.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 02:10:32 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: x86: Handle unexpected MMIO accesses using master
 abort semantics
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
References: <20190913015623.19869-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b924ac35-d69a-be11-a037-7ff09be89125@redhat.com>
Date:   Fri, 13 Sep 2019 11:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913015623.19869-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/19 03:56, Sean Christopherson wrote:
> Use master abort semantics, i.e. reads return all ones and writes are
> dropped, to handle unexpected MMIO accesses when reading guest memory
> instead of returning X86EMUL_IO_NEEDED, which in turn gets interpreted
> as a guest page fault.
> 
> Emulation of certain instructions, notably VMX instructions, involves
> reading or writing guest memory without going through the emulator.
> These emulation flows are not equipped to handle MMIO accesses as no
> sane and properly functioning guest kernel will target MMIO with such
> instructions, and so simply inject a page fault in response to
> X86EMUL_IO_NEEDED.
> 
> While not 100% correct, using master abort semantics is at least
> sometimes correct, e.g. non-existent MMIO accesses do actually master
> abort, whereas injecting a page fault is always wrong, i.e. the issue
> lies in the physical address domain, not in the virtual to physical
> translation.
> 
> Apply the logic to kvm_write_guest_virt_system() in addition to
> replacing existing #PF logic in kvm_read_guest_virt(), as VMPTRST uses
> the former, i.e. can also leak a host stack address.
> 
> Reported-by: Fuqian Huang <huangfq.daxian@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

For 5.5, I'll look into doing proper emulation in
vmxon/vmclear/vmptrld/vmptrst emulation.

Paolo

> ---
> 
> v2: Fix the comment for kvm_read_guest_virt_helper().
> 
>  arch/x86/kvm/x86.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b4cfd786d0b6..3da57f137470 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5234,16 +5234,24 @@ int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
>  			       struct x86_exception *exception)
>  {
>  	u32 access = (kvm_x86_ops->get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0;
> +	int r;
> +
> +	r = kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access,
> +				       exception);
>  
>  	/*
> -	 * FIXME: this should call handle_emulation_failure if X86EMUL_IO_NEEDED
> -	 * is returned, but our callers are not ready for that and they blindly
> -	 * call kvm_inject_page_fault.  Ensure that they at least do not leak
> -	 * uninitialized kernel stack memory into cr2 and error code.
> +	 * FIXME: this should technically call out to userspace to handle the
> +	 * MMIO access, but our callers are not ready for that, so emulate
> +	 * master abort behavior instead, i.e. reads return all ones.
>  	 */
> -	memset(exception, 0, sizeof(*exception));
> -	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access,
> -					  exception);
> +	if (r == X86EMUL_IO_NEEDED) {
> +		memset(val, 0xff, bytes);
> +		return 0;
> +	}
> +	if (r == X86EMUL_PROPAGATE_FAULT)
> +		return -EFAULT;
> +	WARN_ON_ONCE(r);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(kvm_read_guest_virt);
>  
> @@ -5317,11 +5325,25 @@ static int emulator_write_std(struct x86_emulate_ctxt *ctxt, gva_t addr, void *v
>  int kvm_write_guest_virt_system(struct kvm_vcpu *vcpu, gva_t addr, void *val,
>  				unsigned int bytes, struct x86_exception *exception)
>  {
> +	int r;
> +
>  	/* kvm_write_guest_virt_system can pull in tons of pages. */
>  	vcpu->arch.l1tf_flush_l1d = true;
>  
> -	return kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
> -					   PFERR_WRITE_MASK, exception);
> +	r = kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
> +					PFERR_WRITE_MASK, exception);
> +
> +	/*
> +	 * FIXME: this should technically call out to userspace to handle the
> +	 * MMIO access, but our callers are not ready for that, so emulate
> +	 * master abort behavior instead, i.e. writes are dropped.
> +	 */
> +	if (r == X86EMUL_IO_NEEDED)
> +		return 0;
> +	if (r == X86EMUL_PROPAGATE_FAULT)
> +		return -EFAULT;
> +	WARN_ON_ONCE(r);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(kvm_write_guest_virt_system);
>  
> 

