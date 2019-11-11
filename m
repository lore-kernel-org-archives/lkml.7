Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BCCC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5198E206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573457473;
	bh=I6YPAg/2DBiXFQxlRcBoOGngvlL8XXNy6dGGv9WTXxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eO7sL6q9/v2yzAttyKrbeMWu6dnRBytrrJfRFQZHHX1yowaDfKR8aZG/ABVcppN35
	 RH6odE1OK+gB1RCHpo6cjz70FDvNkIJsfXncAKzUSNydPUSNTEdCzA1lgaEEn3Ut2b
	 YjmdjYZbAiKYOxdPG5srkztIZtQCUKex3GvJcXXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfKKHbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:31:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40065 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfKKHbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:31:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id f3so12078237wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 23:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xtCaJhdJ6EwOkCplO79ttlAy7r1J9xISWiY4wP1HA50=;
        b=LDlkKE9zLm+4OLU1iXMbu2sL+ltxpCGv/0iOXy3/dPVES/qmAEPHvsS8RbKXSr+Odo
         gK5OnhB7byp7YANY9mLL9yYXyLfBkTTgNQJCMb7UmVSKMn6MLdxUbukEhKgo/LRHsdpY
         s+GT8iiPm76M1UpSCG2snoQJ1e5pFiOnMt4awShNwJ2sCgfDLTo3Qw6slWLpWZZc3Uwf
         h7fybKOemY47AGINyII+oHpl5571LmkhLI8zX2XS0Rg1t5NX6ChcuHEMW0TDg7RQ9web
         RdK1BtXZo3GF1CDZGygFv6ZknC0CFccSlqGnnN1Vebx85G7+ALW27jN0i/N0lVBaQa8o
         UZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xtCaJhdJ6EwOkCplO79ttlAy7r1J9xISWiY4wP1HA50=;
        b=Dq2DemJF2ApGVPvSZlpOb4m+5M0g9B+ie1FqtCEjOAortxdTcDANKBpS499LtXfpPQ
         taB6SJdfHOEnECNSsXANLy8gi8hnhPzJ3mQP/ow29hfqB5qmgMsfaAqR7+4qAiueG1qu
         gWl9tPWQTRmR8k3l7EAcKJ719z+O24frW6NOzzUaxD37HXrP/1A8zNuZvvszD3CyZneC
         nrX37d4gzRhGaohDHFaNi0LH/UZUtyUzofA5Lvb1DG8CmmYMJse6dJ4S6tZJ8Rr4SdQT
         Z0wCkblNtP2i8/BW0NNtkNTrQDOKMrXqEBVH+KaSa3p41mEfPdBuB8OVWIvUT2aEvzlY
         fDIg==
X-Gm-Message-State: APjAAAVNAnWfjZLZc79VQyrYTf2jaBi+fIFxWbMsWieTjdbBpDDhlpOV
        TkLRuSKXHvdBqLkt/k7fDyU=
X-Google-Smtp-Source: APXvYqx96pPO34f1SU2BKKqCYmWQ2Ax5fp8OObrxZyZ+VtCgqQcoRkOBGwvQcYdkpa/dKg+OFL2zHw==
X-Received: by 2002:a1c:7519:: with SMTP id o25mr18438252wmc.70.1573457469643;
        Sun, 10 Nov 2019 23:31:09 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x5sm14080525wmj.7.2019.11.10.23.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 23:31:09 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:31:06 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] arch/x86/amd: Remove set but not used variable 'active'
Message-ID: <20191111073106.GB112047@gmail.com>
References: <20191110094453.113001-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191110094453.113001-1-zhengyongjun3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zheng Yongjun <zhengyongjun3@huawei.com> wrote:

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> arch/x86/events/amd/core.c: In function amd_pmu_handle_irq:
> arch/x86/events/amd/core.c:656:6: warning: variable active set but not used [-Wunused-but-set-variable]
> 
> active is never used, so remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  arch/x86/events/amd/core.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 64c3e70b0556..1ff652a167db 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -653,14 +653,7 @@ static void amd_pmu_disable_event(struct perf_event *event)
>  static int amd_pmu_handle_irq(struct pt_regs *regs)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	int active, handled;
> -
> -	/*
> -	 * Obtain the active count before calling x86_pmu_handle_irq() since
> -	 * it is possible that x86_pmu_handle_irq() may make a counter
> -	 * inactive (through x86_pmu_stop).
> -	 */
> -	active = __bitmap_weight(cpuc->active_mask, X86_PMC_IDX_MAX);
> +	int handled;
>  
>  	/* Process any counter overflows */
>  	handled = x86_pmu_handle_irq(regs);

I'm sad that not only was this changelog of poor quality (you didn't 
follow title patterns, you didn't explain why the variable went unused, 
etc. etc.), you didn't even *build* the resulting file, which now 
produces a new warning on x86-64-defconfig:

  arch/x86/events/amd/core.c:655:24: warning: unused variable ‘cpuc’ [-Wunused-variable]

I fixed this up, but please be much more careful even with 'trivial' 
patches - we expect them to be perfect.

Thanks,

	Ingo
