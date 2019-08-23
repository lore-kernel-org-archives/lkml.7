Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C2CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870E921726
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbfHWJcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:32:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731592AbfHWJck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:32:40 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6552711A12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 09:32:40 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id m7so4541659wrw.22
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 02:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4hIvhiErI/PBhr2czomH4NGnSK+5wiyAYFcemIBDRQY=;
        b=WSenrebHBZD6iZwpkoMGDCX1klrqPx4o3UBMjvwrR8VdVgTiXxC36Eg2XZhLIGTS5X
         qB+3/B4B3DQEtPlRJTEXM+26yoGbLfcrlaA3j8Azf1M3lbzefof5LxsxkxwfB6jEKFJU
         W2kPAvltmJ/8pFeUXGHVj6O5fJwqA68Sead9uHfV5EP4wvpIQPcJ0ZNFUoRroud0OX0P
         2kWRw+nv+eVUlibeYFLaXW5RrY8KZRQ4l8U0Eu1uB4XCNpgIHpyntvFySiQUQqEfxTxT
         yfxqIOmpHgdKgWBLaMrKj7Uuci9N04p3+lv1H0cUwLf3q+1MREBObWzemU2m1/7pk3Eo
         /aHg==
X-Gm-Message-State: APjAAAVVDd+EKl64mMwTINLUP5dTFDIWqzvpdp7FmvwUjRYhXUOI1Hea
        nMBv9uf8Il/DdFsjiSPkUpEUJZwuWOGjDkJwxio2ZY34neWyxmx/b7kTWlOKkocu7A2FXgF7TD8
        5zgOcThm1NVNmt2lLs46MkmQD
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr3974285wrq.208.1566552758933;
        Fri, 23 Aug 2019 02:32:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzI0cggr5dizpontsicJgMUuB+7sraGqAJ4myMllcNT75XrYBz/buafUoaEFCRsYeGnIuTzBw==
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr3974248wrq.208.1566552758650;
        Fri, 23 Aug 2019 02:32:38 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v124sm4374779wmf.23.2019.08.23.02.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 02:32:38 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [RESEND PATCH 03/13] KVM: x86: Refactor kvm_vcpu_do_singlestep() to remove out param
In-Reply-To: <20190823010709.24879-4-sean.j.christopherson@intel.com>
References: <20190823010709.24879-1-sean.j.christopherson@intel.com> <20190823010709.24879-4-sean.j.christopherson@intel.com>
Date:   Fri, 23 Aug 2019 11:32:37 +0200
Message-ID: <877e74p6q2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Return the single-step emulation result directly instead of via an out
> param.  Presumably at some point in the past kvm_vcpu_do_singlestep()
> could be called with *r==EMULATE_USER_EXIT, but that is no longer the
> case, i.e. all callers are happy to overwrite their own return variable.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/x86.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c6de5bc4fa5e..fe847f8eb947 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6377,7 +6377,7 @@ static int kvm_vcpu_check_hw_bp(unsigned long addr, u32 type, u32 dr7,
>  	return dr6;
>  }
>  
> -static void kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu, int *r)
> +static int kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_run *kvm_run = vcpu->run;
>  
> @@ -6386,10 +6386,10 @@ static void kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu, int *r)
>  		kvm_run->debug.arch.pc = vcpu->arch.singlestep_rip;
>  		kvm_run->debug.arch.exception = DB_VECTOR;
>  		kvm_run->exit_reason = KVM_EXIT_DEBUG;
> -		*r = EMULATE_USER_EXIT;
> -	} else {
> -		kvm_queue_exception_p(vcpu, DB_VECTOR, DR6_BS);
> +		return EMULATE_USER_EXIT;
>  	}
> +	kvm_queue_exception_p(vcpu, DB_VECTOR, DR6_BS);
> +	return EMULATE_DONE;
>  }
>  
>  int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
> @@ -6410,7 +6410,7 @@ int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
>  	 * that sets the TF flag".
>  	 */
>  	if (unlikely(rflags & X86_EFLAGS_TF))
> -		kvm_vcpu_do_singlestep(vcpu, &r);
> +		r = kvm_vcpu_do_singlestep(vcpu);
>  	return r == EMULATE_DONE;
>  }
>  EXPORT_SYMBOL_GPL(kvm_skip_emulated_instruction);
> @@ -6613,7 +6613,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
>  		vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
>  		kvm_rip_write(vcpu, ctxt->eip);
>  		if (r == EMULATE_DONE && ctxt->tf)
> -			kvm_vcpu_do_singlestep(vcpu, &r);
> +			r = kvm_vcpu_do_singlestep(vcpu);
>  		if (!ctxt->have_exception ||
>  		    exception_type(ctxt->exception.vector) == EXCPT_TRAP)
>  			__kvm_set_rflags(vcpu, ctxt->eflags);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
