Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3073BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051C321726
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbfHWJYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:24:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730984AbfHWJYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:24:00 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62F39C08C325
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 09:24:00 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id o5so4527746wrg.15
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 02:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hcVR7FpzlOfLuA+3zYp3tlZljPrqrhIJeuvuUSrYtwk=;
        b=lmLlGPJP5gmOzBRh0DPTtANbNALxu59y+UtH3s1IqQVjYqagHET99uSxuMVA17mK9z
         EUY+Z/5JS9On59ITzRxxVlOlCvMdMoPKd6n3OKLePyYDOOqNAYitxn7BhIMFI/mQKgKb
         MlggFqJEbc8SwivTj032bLV83/G54A/G4LCgu9LzszjAVM2Bno+qvCR4gSgy8i3p+k/n
         6EMQlQMntmUVyMUj18cV910S/LA6LOd8YGthX32X9Of+ga5+AvSo0rlZdcu6iGkMwueJ
         E7mygZqmK8XAFw8ls/HuCnD5a6v5a1m79rAD9GNRgjvkOKMlFBBikrPC/l9uytZlS74m
         Fu2w==
X-Gm-Message-State: APjAAAXNmpIdeLkJqi3S79Nwihxe6kk/I0BbPFhN2LddKsUBdM2It4qf
        INQeSDHz2zLlHkL9faOAuSN8FN1dOKznw21oyYQ8qaOU8JGlDSYX2i+FcrbrrEs7r3bvTMY5YX2
        4dBWjVYVGlnfi/w93qrm8SDpe
X-Received: by 2002:adf:ea51:: with SMTP id j17mr4247436wrn.184.1566552238965;
        Fri, 23 Aug 2019 02:23:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYqf4b3JLBFjXbtwI1PAc24WOpxRJRamvN7DOCq4zItdjMSIuewcjlLL1CC26yfkJwXCe8mA==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr4247414wrn.184.1566552238757;
        Fri, 23 Aug 2019 02:23:58 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f17sm2173101wmj.27.2019.08.23.02.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 02:23:58 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [RESEND PATCH 02/13] KVM: x86: Clean up handle_emulation_failure()
In-Reply-To: <20190823010709.24879-3-sean.j.christopherson@intel.com>
References: <20190823010709.24879-1-sean.j.christopherson@intel.com> <20190823010709.24879-3-sean.j.christopherson@intel.com>
Date:   Fri, 23 Aug 2019 11:23:57 +0200
Message-ID: <87a7c0p74i.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> When handling emulation failure, return the emulation result directly
> instead of capturing it in a local variable.  Future patches will move
> additional cases into handle_emulation_failure(), clean up the cruft
> before so there isn't an ugly mix of setting a local variable and
> returning directly.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/x86.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index cd425f54096a..c6de5bc4fa5e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6207,24 +6207,22 @@ EXPORT_SYMBOL_GPL(kvm_inject_realmode_interrupt);
>  
>  static int handle_emulation_failure(struct kvm_vcpu *vcpu, int emulation_type)
>  {
> -	int r = EMULATE_DONE;
> -
>  	++vcpu->stat.insn_emulation_fail;
>  	trace_kvm_emulate_insn_failed(vcpu);
>  
>  	if (emulation_type & EMULTYPE_NO_UD_ON_FAIL)
>  		return EMULATE_FAIL;
>  
> +	kvm_queue_exception(vcpu, UD_VECTOR);
> +
>  	if (!is_guest_mode(vcpu) && kvm_x86_ops->get_cpl(vcpu) == 0) {
>  		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
>  		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
>  		vcpu->run->internal.ndata = 0;
> -		r = EMULATE_USER_EXIT;
> +		return EMULATE_USER_EXIT;
>  	}
>  
> -	kvm_queue_exception(vcpu, UD_VECTOR);
> -
> -	return r;
> +	return EMULATE_DONE;
>  }
>  
>  static bool reexecute_instruction(struct kvm_vcpu *vcpu, gva_t cr2,

No functional change,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Just for self-education, what sane userspace is supposed to do when it
sees KVM_EXIT_INTERNAL_ERROR other than kill the guest? Why does it make
sense to still prepare to inject '#UD'?

-- 
Vitaly
