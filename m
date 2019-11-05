Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150ECC010A3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E543C206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbfKEKXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:23:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388517AbfKEKXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:23:21 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2265C81F01
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 10:23:21 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id l184so7483520wmf.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 02:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L2DCL6AJUoTx12g/nBt+5+g+jRrLNYmCpns9Ml6NzII=;
        b=CvlJf/bJHRl2YxmuWVlIBUXLESAfJsbVJyur16nvMgskJOh+dPa6nD9fUzy/Dv9Qmm
         tno1U33gRaivlwpWaG42xnqoRkOujWUxdtBAY+BzpcWOvWtItm1VhY3WeFs7bMzmjpYV
         TsyTNPvY4hbAtT6ZkRCgO2EdUdDM/wDxn/jiHFLxUAvitXu8o1rlngpyv1AgcylrZusE
         TcOHbgk9wHsQnQ/F6Euee5J1R0QW1CJaEOmnXsxmdrHinZRZgMGgAJRMJIoWCL7cZqKW
         YiTqCzGRUt+bsmIbL2lrwX9Z9FCLPZpNVzQGZQ+RaJZSXiC8lm/zujfkWz/Uli/yiz1h
         tiNg==
X-Gm-Message-State: APjAAAUAJWuKpGT5tJkJ74QKd81zKqrJho07Wr8wavHQoctsQbnqUeYQ
        30mlakYCCw3ycOYeyEjs6lKTpsaAMQymstfpEull6NxQUAgydmivsXuYzsTa/GCCCZCqa7IZvdc
        vfiEFuWkQjIUnlnhnmtP3/2yO
X-Received: by 2002:a05:600c:214b:: with SMTP id v11mr3615910wml.149.1572949399789;
        Tue, 05 Nov 2019 02:23:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqzBZkub82r+YaidAWnAVsPcUzN7WWqgOtKY4bu/OLSPh9FFpp+MoOYAmoKCvjjxybqwhQOC/A==
X-Received: by 2002:a05:600c:214b:: with SMTP id v11mr3615883wml.149.1572949399478;
        Tue, 05 Nov 2019 02:23:19 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id w9sm21506531wrt.85.2019.11.05.02.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 02:23:18 -0800 (PST)
Subject: Re: [PATCH 13/13] x86: retpolines: eliminate retpoline from msr event
 handlers
To:     Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20191104230001.27774-1-aarcange@redhat.com>
 <20191104230001.27774-14-aarcange@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <306784c2-25b0-9f25-c9e0-c23aaee11e4f@redhat.com>
Date:   Tue, 5 Nov 2019 11:21:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191104230001.27774-14-aarcange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/19 00:00, Andrea Arcangeli wrote:
> It's enough to check the value and issue the direct call.
> 
> After this commit is applied, here the most common retpolines executed
> under a high resolution timer workload in the guest on a VMX host:
> 
> [..]
> @[
>     trace_retpoline+1
>     __trace_retpoline+30
>     __x86_indirect_thunk_rax+33
>     do_syscall_64+89
>     entry_SYSCALL_64_after_hwframe+68
> ]: 267
> @[]: 2256
> @[
>     trace_retpoline+1
>     __trace_retpoline+30
>     __x86_indirect_thunk_rax+33
>     __kvm_wait_lapic_expire+284
>     vmx_vcpu_run.part.97+1091
>     vcpu_enter_guest+377
>     kvm_arch_vcpu_ioctl_run+261
>     kvm_vcpu_ioctl+559
>     do_vfs_ioctl+164
>     ksys_ioctl+96
>     __x64_sys_ioctl+22
>     do_syscall_64+89
>     entry_SYSCALL_64_after_hwframe+68
> ]: 2390
> @[]: 33410
> 
> @total: 315707
> 
> Note the highest hit above is __delay so probably not worth optimizing
> even if it would be more frequent than 2k hits per sec.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  arch/x86/events/intel/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index fcef678c3423..937363b803c1 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3323,8 +3323,19 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_RETPOLINE
> +static struct perf_guest_switch_msr *core_guest_get_msrs(int *nr);
> +static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr);
> +#endif
> +
>  struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
>  {
> +#ifdef CONFIG_RETPOLINE
> +	if (x86_pmu.guest_get_msrs == intel_guest_get_msrs)
> +		return intel_guest_get_msrs(nr);
> +	else if (x86_pmu.guest_get_msrs == core_guest_get_msrs)
> +		return core_guest_get_msrs(nr);
> +#endif
>  	if (x86_pmu.guest_get_msrs)
>  		return x86_pmu.guest_get_msrs(nr);
>  	*nr = 0;
> 

Queued, thanks.

Paolo
