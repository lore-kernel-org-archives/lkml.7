Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81F3C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26E920835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407455AbfIWJ6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:58:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405009AbfIWJ6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:58:01 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E278C054C52
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:58:01 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id k67so4754464wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 02:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wzehYQ/q/Unr9ua1VQFlkvwitkghryuoSUrqvQKWtys=;
        b=Z7jh5nhCPEqXNqawRi3YIeViNSknyx5HB9l4ucf93zhMJ2dnMcLFRKyLVFGF4lFFr3
         JM5DfIo34DcJ44L1nZpU4QsUKs6KLbAh9TFRe9nUfe+/XwyWxmG3fQ4X4SHFLUjU04Yy
         sg6llhpE2n3OdO9PBv/53mJoE/5unz7GAGSBXdYBXt0Wn3g6FTSNxaEGsFcCQ5KxSISf
         0pIRHDOQSDq6OSsrbWxayaGejAa7BYeA2njfg1Qq5fzf3gGuIyaSs274Bj/kfxhT6eD5
         kjaFX1XNz64wEvwM8Y7ye7NG/t4shCXJFwbY7AEuO1jd//0AuhS069TLNVXhPj2y+srn
         SYvg==
X-Gm-Message-State: APjAAAWRhT0SVNuFgv3H1081gXsDcWgkb/k1vY8jSEcDMCWxaEgMOkZf
        kI5Ec4Fb7K+NQmYu7L8eSUoG6T4GVf2ERaSiltsiJZ1EKgZwZ/b/jqs8gbvYnPWdWo8zQt+c6zz
        WddATK5Rgj2XdQAASy4mv6Ycv
X-Received: by 2002:adf:f9c9:: with SMTP id w9mr19828665wrr.172.1569232679351;
        Mon, 23 Sep 2019 02:57:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+R47KLkJmnU7l8Zxf4zZxqnGS/qkxsg/JQjqPn/GlshVIlfYKQ2eupxBkl7MdJyTJq5f6zQ==
X-Received: by 2002:adf:f9c9:: with SMTP id w9mr19828652wrr.172.1569232679116;
        Mon, 23 Sep 2019 02:57:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id c1sm8310783wmk.20.2019.09.23.02.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 02:57:58 -0700 (PDT)
Subject: Re: [PATCH 15/17] KVM: retpolines: x86: eliminate retpoline from
 vmx.c exit handlers
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-16-aarcange@redhat.com>
 <87o8zb8ik1.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7329012d-0b3b-ce86-f58d-3d2d5dc5a790@redhat.com>
Date:   Mon, 23 Sep 2019 11:57:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87o8zb8ik1.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/19 11:31, Vitaly Kuznetsov wrote:
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

Most of these, while frequent, are already part of slow paths.

I would keep only EXIT_REASON_MSR_WRITE, EXIT_REASON_PREEMPTION_TIMER,
EXIT_REASON_EPT_MISCONFIG and add EXIT_REASON_IO_INSTRUCTION.

If you make kvm_vmx_exit_handlers const, can the compiler substitute for
instance kvm_vmx_exit_handlers[EXIT_REASON_MSR_WRITE] with handle_wrmsr?
 Just thinking out loud, not sure if it's an improvement code-wise.

Paolo

Paolo
