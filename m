Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B19FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074ED20673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407223AbfIWJcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:32:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407176AbfIWJcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:32:02 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DDF361D25
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:32:02 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id k9so6395289wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 02:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fIlK0Gqa2EqqMHp7X2xV9H/eOYI2l6FvewEZP+gEe0w=;
        b=qDaBRjFG0LaJ4LqZkHqRFTm6nn5V3wdahp92HAobRakmlq8K2jJucQlwUuUvGIJFA8
         ampCLrZAWrafXph7p/k6AMhH3OuLwaML35eel3sR1Oe8xNpMo+kqQAPfbRO3fSu3JIRh
         TMGvseU3G9Ty6XdNQOJGNk/2XkyH4LWO4H39GGerK5xj3wP8ziEK/37FVYeOVT+ZH3As
         nRKyWFq2El10127vwBfcS9d5u04o6A/xRtggyzB8/M/C0+BCuSRXdYPoVjY0h2wCtePm
         y7REm36IwHPlUcWq1IJH/SN513l0nGfcDY5VcndDyr8X9MIHSKHRXfAnT9NBD4etfd3U
         xeRg==
X-Gm-Message-State: APjAAAVDOlJ7/VYrKpG0zxGJPX1q2eOuRTCKUyZsMHmBbg4MxZiJvQXW
        kBc/Iiwawxb16n3IPQwAUooT8c9yZwcGMFf8un1pWjlN8EChc8nEekhEsID9LHCDXCUJsd3S10Z
        LFIxg7T1Ku6dBNMjgtknVvezm
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr20552624wrs.146.1569231120672;
        Mon, 23 Sep 2019 02:32:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzSooD5cgGEoyLBTWPsXxrIrfqpCoWXBwb0C/X63O8YHe+RdRAExbsbPZ1BRXwFPWpIKgMBhQ==
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr20552599wrs.146.1569231120397;
        Mon, 23 Sep 2019 02:32:00 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x5sm19529043wrg.69.2019.09.23.02.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 02:31:59 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/17] KVM: retpolines: x86: eliminate retpoline from vmx.c exit handlers
In-Reply-To: <20190920212509.2578-16-aarcange@redhat.com>
References: <20190920212509.2578-1-aarcange@redhat.com> <20190920212509.2578-16-aarcange@redhat.com>
Date:   Mon, 23 Sep 2019 11:31:58 +0200
Message-ID: <87o8zb8ik1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <aarcange@redhat.com> writes:

> It's enough to check the exit value and issue a direct call to avoid
> the retpoline for all the common vmexit reasons.
>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index a6e597025011..9aa73e216df2 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5866,9 +5866,29 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu)
>  	}
>  
>  	if (exit_reason < kvm_vmx_max_exit_handlers
> -	    && kvm_vmx_exit_handlers[exit_reason])
> +	    && kvm_vmx_exit_handlers[exit_reason]) {
> +#ifdef CONFIG_RETPOLINE
> +		if (exit_reason == EXIT_REASON_MSR_WRITE)
> +			return handle_wrmsr(vcpu);
> +		else if (exit_reason == EXIT_REASON_PREEMPTION_TIMER)
> +			return handle_preemption_timer(vcpu);
> +		else if (exit_reason == EXIT_REASON_PENDING_INTERRUPT)
> +			return handle_interrupt_window(vcpu);
> +		else if (exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT)
> +			return handle_external_interrupt(vcpu);
> +		else if (exit_reason == EXIT_REASON_HLT)
> +			return handle_halt(vcpu);
> +		else if (exit_reason == EXIT_REASON_PAUSE_INSTRUCTION)
> +			return handle_pause(vcpu);
> +		else if (exit_reason == EXIT_REASON_MSR_READ)
> +			return handle_rdmsr(vcpu);
> +		else if (exit_reason == EXIT_REASON_CPUID)
> +			return handle_cpuid(vcpu);
> +		else if (exit_reason == EXIT_REASON_EPT_MISCONFIG)
> +			return handle_ept_misconfig(vcpu);
> +#endif
>  		return kvm_vmx_exit_handlers[exit_reason](vcpu);

I agree with the identified set of most common vmexits, however, this
still looks a bit random. Would it be too much if we get rid of
kvm_vmx_exit_handlers completely replacing this code with one switch()?

> -	else {
> +	} else {
>  		vcpu_unimpl(vcpu, "vmx: unexpected exit reason 0x%x\n",
>  				exit_reason);
>  		dump_vmcs();

-- 
Vitaly
