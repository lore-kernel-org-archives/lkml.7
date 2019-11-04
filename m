Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDCECA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474C421D81
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfKDLyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:54:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfKDLyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:54:03 -0500
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 750FE83F40
        for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2019 11:54:03 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id y3so3416729wrm.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 03:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K9ShbQwUl3JT1wY9fwM0LVfIdQxr/5VaXCx33ZJ5yec=;
        b=WW9xjnd02e0P02Gpbgb3sDcq6+RK6x3fMBJKWlT7mR00NNub6hndt+d+6Cu+v5mVuk
         bb5IYlzww1s8IiKAmTx/32mhi1z4zS4w75Skeg9oQXwElT9xT5InWqU7wZupZ/AC7DNd
         Hvv4pekuUqvI1DgkS8PqPFGr6GwZ+BBH8p89v3Y66n1ZIj0TGo18kWlHX7gLT3TvAq/x
         /gnwTscS8p9wbw946Ba7WCZg1SKd+3gLwq3H2lwIDCCZBrrF47EghRHpBlSFAGV+1C5L
         4r6FD2O+6A3oN1PVDXZyYq/WAWQgd1bW6RWJIr0RGCb/tqoAOQhFHQN6HZ+nxK+OTXd0
         GMrA==
X-Gm-Message-State: APjAAAU2qgRai9IYV3IDmm3wzUgF9CDRpask/sbiueHT8Nshc+avN+Fp
        0tNTNflJE2fgQSJwyrcAuPC9tA68L7fK74FXFJsBEzEhWDyOvIMwEhCTsKB92FlcGmyV7ElK9lH
        hx9F8sB9RrOo5NUufnLElfXEB
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr24119467wrn.143.1572868442060;
        Mon, 04 Nov 2019 03:54:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqxFiK0uysITL0qyqhqzQe9IaQU3kN4T5tUMeyIETkHAy9fg1Ec1DQbcA/YXPxCfHYIp7okHUA==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr24119450wrn.143.1572868441791;
        Mon, 04 Nov 2019 03:54:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4051:461:136e:3f74? ([2001:b07:6468:f312:4051:461:136e:3f74])
        by smtp.gmail.com with ESMTPSA id i71sm22623611wri.68.2019.11.04.03.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 03:54:01 -0800 (PST)
Subject: Re: [PATCH 2/4] kvm: svm: Enable UMIP feature on AMD
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "jmattson@google.com" <jmattson@google.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <157262960837.2838.17520432516398899751.stgit@naples-babu.amd.com>
 <157262962352.2838.15656190309312238595.stgit@naples-babu.amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <37c61050-e315-fc84-9699-bb92e5afacda@redhat.com>
Date:   Mon, 4 Nov 2019 12:54:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <157262962352.2838.15656190309312238595.stgit@naples-babu.amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/19 18:33, Moger, Babu wrote:
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 4153ca8cddb7..79abbdeca148 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -2533,6 +2533,11 @@ static void svm_decache_cr4_guest_bits(struct kvm_vcpu *vcpu)
>  {
>  }
>  
> +static bool svm_umip_emulated(void)
> +{
> +	return boot_cpu_has(X86_FEATURE_UMIP);
> +}

For hardware that supports UMIP, this is only needed because of your
patch 1.  Without it, X86_FEATURE_UMIP should already be enabled on
processors that natively support UMIP.

If you want UMIP *emulation* instead, this should become "return true".

>  static void update_cr0_intercept(struct vcpu_svm *svm)
>  {
>  	ulong gcr0 = svm->vcpu.arch.cr0;
> @@ -4438,6 +4443,13 @@ static int interrupt_window_interception(struct vcpu_svm *svm)
>  	return 1;
>  }
>  
> +static int umip_interception(struct vcpu_svm *svm)
> +{
> +	struct kvm_vcpu *vcpu = &svm->vcpu;
> +
> +	return kvm_emulate_instruction(vcpu, 0);
> +}
> +
>  static int pause_interception(struct vcpu_svm *svm)
>  {
>  	struct kvm_vcpu *vcpu = &svm->vcpu;
> @@ -4775,6 +4787,10 @@ static int (*const svm_exit_handlers[])(struct vcpu_svm *svm) = {
>  	[SVM_EXIT_SMI]				= nop_on_interception,
>  	[SVM_EXIT_INIT]				= nop_on_interception,
>  	[SVM_EXIT_VINTR]			= interrupt_window_interception,
> +	[SVM_EXIT_IDTR_READ]			= umip_interception,
> +	[SVM_EXIT_GDTR_READ]			= umip_interception,
> +	[SVM_EXIT_LDTR_READ]			= umip_interception,
> +	[SVM_EXIT_TR_READ]			= umip_interception,

This is missing enabling the intercepts.  Also, this can be just
emulate_on_interception instead of a new function.

Paolo

>  	[SVM_EXIT_RDPMC]			= rdpmc_interception,
>  	[SVM_EXIT_CPUID]			= cpuid_interception,
>  	[SVM_EXIT_IRET]                         = iret_interception,
> @@ -5976,11 +5992,6 @@ static bool svm_xsaves_supported(void)
>  	return boot_cpu_has(X86_FEATURE_XSAVES);
>  }
>  
> -static bool svm_umip_emulated(void)
> -{
> -	return false;
> -}
> -
>  static bool svm_pt_supported(void)
>  {
>  	return false;
> 

