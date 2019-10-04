Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7DDC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17726222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfJDQ5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:57:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730043AbfJDQ5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:57:18 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BBE62CE90A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2019 16:57:18 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id n3so2906906wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 09:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4DO6HRjszW9MYsu/gJ4YiZkg106jhOFShol6836AY7U=;
        b=dpCsp+MiKzeFObzpy+aNb4fvas6B50kfD7fhwPJ+RoMSUL5SZjJkI0fvDzEom0EO6m
         gb+hGNdfiWauba2JMZ5V3UxTRHwF+V7OuLH5C0Hjo+iU9FdPhm022sVit1cHhH97Yd87
         rNKFi9nx71n431Y0+JU31zi932c+QmiC0JhbtGsAlkP+I1/ETmSvce3gXfgKPyXGRqzb
         jO5HfzPasgubbbFYsd50Mcc/vM6cBAhiYtM3nCj6mWhCdjKkAuzYPqIYtxu3XurygSfZ
         JiEWFsbS0ECbYxXlqPc4TjiuYjQ2dI8Qz/biO/oQp7h3L/DXmJYuIBoeI1yqhk2FAisT
         SkFg==
X-Gm-Message-State: APjAAAUGnNLuGwjvHrq9jRuH6wEOB8zJqOwvadfTW8M0cUu3Qi9uFvk6
        g61JO5fJs+MCHtR3iJ6mjq7IwbOHGrTEUSMw+xKqUSSHuciQYnvYqg1BRkp1I9YjbKFDsADBWty
        NIAeo3DQ8K8mmWk/eDlN1i+6s
X-Received: by 2002:adf:ce89:: with SMTP id r9mr4693340wrn.335.1570208236659;
        Fri, 04 Oct 2019 09:57:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxZHhNq7nQiI6Fd/RsV8j3dFIp0ycu+uqTI+ubiO6/TGoQoY612gvIeAT0G0evGhIrNPG1XXw==
X-Received: by 2002:adf:ce89:: with SMTP id r9mr4693320wrn.335.1570208236389;
        Fri, 04 Oct 2019 09:57:16 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a192sm5727832wma.1.2019.10.04.09.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 09:57:15 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        x86@kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH 1/2] x86/hyperv: Allow guests to enable InvariantTSC
In-Reply-To: <20191003155200.22022-1-parri.andrea@gmail.com>
References: <20191003155200.22022-1-parri.andrea@gmail.com>
Date:   Fri, 04 Oct 2019 18:57:14 +0200
Message-ID: <87k19k1mad.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Parri <parri.andrea@gmail.com> writes:

> If the hardware supports TSC scaling, Hyper-V will set bit 15 of the
> HV_PARTITION_PRIVILEGE_MASK in guest VMs with a compatible Hyper-V
> configuration version.  Bit 15 corresponds to the
> AccessTscInvariantControls privilege.  If this privilege bit is set,
> guests can access the HvSyntheticInvariantTscControl MSR: guests can
> set bit 0 of this synthetic MSR to enable the InvariantTSC feature.
> After setting the synthetic MSR, CPUID will enumerate support for
> InvariantTSC.

I tried getting more information from TLFS but as of 5.0C this feature
is not described there. I'm really interested in why this additional
interface is needed, e.g. why can't Hyper-V just set InvariantTSC
unconditionally when TSC scaling is supported?

>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 5 +++++
>  arch/x86/kernel/cpu/mshyperv.c     | 7 ++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 7741e211f7f51..5f10f7f2098db 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -86,6 +86,8 @@
>  #define HV_X64_ACCESS_FREQUENCY_MSRS		BIT(11)
>  /* AccessReenlightenmentControls privilege */
>  #define HV_X64_ACCESS_REENLIGHTENMENT		BIT(13)
> +/* AccessTscInvariantControls privilege */
> +#define HV_X64_ACCESS_TSC_INVARIANT		BIT(15)
>  
>  /*
>   * Feature identification: indicates which flags were specified at partition
> @@ -278,6 +280,9 @@
>  #define HV_X64_MSR_TSC_EMULATION_CONTROL	0x40000107
>  #define HV_X64_MSR_TSC_EMULATION_STATUS		0x40000108
>  
> +/* TSC invariant control */
> +#define HV_X64_MSR_TSC_INVARIANT_CONTROL	0x40000118
> +
>  /*
>   * Declare the MSR used to setup pages used to communicate with the hypervisor.
>   */
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 267daad8c0360..105844d542e5c 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -286,7 +286,12 @@ static void __init ms_hyperv_init_platform(void)
>  	machine_ops.shutdown = hv_machine_shutdown;
>  	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
>  #endif
> -	mark_tsc_unstable("running on Hyper-V");
> +	if (ms_hyperv.features & HV_X64_ACCESS_TSC_INVARIANT) {
> +		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
> +		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> +	} else {
> +		mark_tsc_unstable("running on Hyper-V");
> +	}
>  
>  	/*
>  	 * Generation 2 instances don't support reading the NMI status from

-- 
Vitaly
