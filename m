Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BFFC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11802070D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qeVUxo93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfHEEyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 00:54:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41099 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfHEEyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 00:54:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so35834432pls.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 21:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2GskBwU0LKm3Qey9cLPXZ9UmAlsONTLCvAR16WwJe5c=;
        b=qeVUxo93f4JOkWG7HfvkEB937Vk6VFrHtvF1i1NykVMXAzNUEa198UwcV47V6Nv1CT
         D0o1aLts4e0Ld9plI+Dg+ngBG4WrF2AxBPWzRhXCI/FUu9O6AaTKi7SuPsESGKx+gNav
         TRddsdN9xws2/tSL4HqgvAFzxdf9NCk6ApAK63mMcYf/vKW7Awsa5ECQGVBKsgl0xCyw
         HI6/JaW2B87aGdQdkac2PmHcXUW9IkK1M4QaL2pnXFcT8b4MKAYD5XJ2/9ov9UF3kbcm
         Fg9FMPC2lEY3pfutB1jszDrgHDM448ChAxPi10YMA07hlWVlulXXULYnF91VHKfaiAIT
         R6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2GskBwU0LKm3Qey9cLPXZ9UmAlsONTLCvAR16WwJe5c=;
        b=WXtsZpZKZNl4QPtvZCHPybmzTmpvYmhmCXsO0kqmfZnGVn5617m/BCmUbHen+dDIhL
         3lzKMmTxbNOJgnV08V6nXXfHHUlO34rAeoFgFNI6fKCg5UA1Vgd5aPulnjF0/mwJKfBh
         Exf+HXgKzzr/h/T1GRz0sWC/2wC/jDwdNvk25z0vpO6mlsKhEkmLNymN77tBBjAxoEWL
         ygb90nkK5Lyc+mGgplXSOWgdvxj8WdHrMVeW8bcVqdIpjd7icAMljWeProsM0BIBMmah
         /WbtMeuH7qXfFgx6yOcQRT0iaYmBuDDSmv1CS39pVpV93+1zQ0HPPigbeveek7iBH+f6
         5QMg==
X-Gm-Message-State: APjAAAV3RvxYWei5CcJo2N5Ivvr/oW/zIeXqgcUxfySQc6tm5lQ5/Cc9
        5S+a/B4XfZFcb0icK55+u4LmCA==
X-Google-Smtp-Source: APXvYqy3U7fwQvB7hj3O5W4wMzVfpz0JNUEdznUkbw5QJXAnYMzfYbrvwKtCiyY4LqpDlH+N+o+24g==
X-Received: by 2002:a17:902:20e5:: with SMTP id v34mr20812881plg.136.1564980885324;
        Sun, 04 Aug 2019 21:54:45 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id u97sm16043672pjb.26.2019.08.04.21.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 21:54:44 -0700 (PDT)
Date:   Mon, 5 Aug 2019 10:24:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: fix equation in comment
Message-ID: <20190805045442.3pnaawo4nlrieoie@vireshk-i7>
References: <20190802104628.8410-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802104628.8410-1-qais.yousef@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-08-19, 11:46, Qais Yousef wrote:
> scale_irq_capacity() call in schedutil_cpu_util() does
> 
> 	util *= (max - irq)
> 	util /= max
> 
> But the comment says
> 
> 	util *= (1 - irq)
> 	util /= max
> 
> Fix the comment to match what the scaling function does.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 636ca6f88c8e..e127d89d5974 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -259,9 +259,9 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
>  	 * irq metric. Because IRQ/steal time is hidden from the task clock we
>  	 * need to scale the task numbers:
>  	 *
> -	 *              1 - irq
> -	 *   U' = irq + ------- * U
> -	 *                max
> +	 *              max - irq
> +	 *   U' = irq + --------- * U
> +	 *                 max
>  	 */
>  	util = scale_irq_capacity(util, irq, max);
>  	util += irq;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
