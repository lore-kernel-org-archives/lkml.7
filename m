Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D386C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48BB21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrPFocA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbfKGKtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:49:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44456 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfKGKtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:49:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id f2so2405656wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 02:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BoJC2vTkuWcgoU9/Gd+NZ3si/SA7xiwzAE9kV4SdCkQ=;
        b=VrPFocA9qBjuCcuN8Tn5qHHG8bdYdAAfDQXKn7yQF4JsYcVDKDKg8LZbIrc8M0c+UR
         Uu46B6aPG+9GSNvUn3rMsVn98X/y2ci3T4qtdUCWyXITGWU30nzdKYcHCM4MhXYIJpTA
         qWK24YuKpxU/ho6LtVdkjQnORnE0nmyfo64+sW7JYOOSKE6JwJzKGLbIzx2sXnkGtGuw
         qMDxMdIL9aFAleVNvsXKquPC1SPET6RMeZuZEaM3ETeoVxXgLggxgCFz7kBPpvVGNywI
         5mWEoD9kS6DDnOuZlZSuNDWyj/7mE03GpthdFKL3qPt5fafJ8+LUmVmP0c3cd2+yMK29
         LDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BoJC2vTkuWcgoU9/Gd+NZ3si/SA7xiwzAE9kV4SdCkQ=;
        b=DhKwA6I0KfIjlwy1Nty3g8+oxQv1Z8JzJg0KnPqDk6QjUlgwiON5vb1JSmg/XxSbJI
         WJlS7A0uEh3QbZ7iSdyxgS4LCrIPTJH8dOA2MiJ2rbrKdQTD6i4eTvhkcBqCJwXNY6ww
         XI/I54ZaOsDzRRp2C2ONYv7mfv6P8l3mKphDMyWggKDkyaNrLHdRXxXbNnx78YgH8fZ+
         9CPtpf9Obq9a+jKrvm05Q2777jKNSM54m+AmM2XMFlLqLrkRDCzM6ACyYRi7CrkEtmeP
         bFM3/JAa7nslkidZ7GATUddYm9BP9Isbpp6fbkwYaPrj/8TRtQ+y0aEX1yICLN03w8hJ
         5VIg==
X-Gm-Message-State: APjAAAWYuJmbhdwp2BkZKC82sUpE50z+ZkiwFw5CSBX4lamfZkyW+0Uu
        kEjaPd+W4+wjp+XwYBJoUlbGlA==
X-Google-Smtp-Source: APXvYqzOETIKdw2q2EWHS49YE7Q9FgbNjhavNXZvbJwd9forsxCnZjVAbHexquaz+zezZ4hQZP0eBQ==
X-Received: by 2002:a5d:4f06:: with SMTP id c6mr2186806wru.211.1573123744329;
        Thu, 07 Nov 2019 02:49:04 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:7de6:e8c6:ca61:22f0])
        by smtp.gmail.com with ESMTPSA id w81sm2074459wmg.5.2019.11.07.02.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 02:49:03 -0800 (PST)
Date:   Thu, 7 Nov 2019 11:49:01 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [Patch v5 6/6] sched/fair: Enable tuning of decay period
Message-ID: <20191107104901.GA472@linaro.org>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-7-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1572979786-20361-7-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tuesday 05 Nov 2019 à 13:49:46 (-0500), Thara Gopinath a écrit :
> Thermal pressure follows pelt signas which means the
> decay period for thermal pressure is the default pelt
> decay period. Depending on soc charecteristics and thermal
> activity, it might be beneficial to decay thermal pressure
> slower, but still in-tune with the pelt signals.
> One way to achieve this is to provide a command line parameter
> to set a decay shift parameter to an integer between 0 and 10.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v4->v5:
> 	- Changed _coeff to _shift as per review comments on the list.
> 
>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>  kernel/sched/fair.c                             | 25 +++++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c82f87c..0b8f55e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4281,6 +4281,11 @@
>  			incurs a small amount of overhead in the scheduler
>  			but is useful for debugging and performance tuning.
>  
> +	sched_thermal_decay_shift=
> +			[KNL, SMP] Set decay shift for thermal pressure signal.
> +			Format: integer betweer 0 and 10
> +			Default is 0.
> +
>  	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
>  			xtime_lock contention on larger systems, and/or RCU lock
>  			contention on all systems with CONFIG_MAXSMP set.
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5f6c371..61a020b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -91,6 +91,18 @@ const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
>   * and maximum available capacity due to thermal events.
>   */
>  static DEFINE_PER_CPU(unsigned long, thermal_pressure);
> +/**
> + * By default the decay is the default pelt decay period.
> + * The decay shift can change the decay period in
> + * multiples of 32.
> + *  Decay shift		Decay period(ms)
> + *	0			32
> + *	1			64
> + *	2			128
> + *	3			256
> + *	4			512
> + */
> +static int sched_thermal_decay_shift;
>  
>  static void trigger_thermal_pressure_average(struct rq *rq);
>  
> @@ -10435,6 +10447,15 @@ void update_thermal_pressure(int cpu, unsigned long capped_capacity)
>  	delta = arch_scale_cpu_capacity(cpu) - capped_capacity;
>  	per_cpu(thermal_pressure, cpu) = delta;
>  }
> +
> +static int __init setup_sched_thermal_decay_shift(char *str)
> +{
> +	if (kstrtoint(str, 0, &sched_thermal_decay_shift))
> +		pr_warn("Unable to set scheduler thermal pressure decay shift parameter\n");
> +
> +	return 1;
> +}
> +__setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
>  #endif
>  
>  /**
> @@ -10444,8 +10465,8 @@ void update_thermal_pressure(int cpu, unsigned long capped_capacity)
>  static void trigger_thermal_pressure_average(struct rq *rq)
>  {
>  #ifdef CONFIG_SMP
> -	update_thermal_load_avg(rq_clock_task(rq), rq,
> -				per_cpu(thermal_pressure, cpu_of(rq)));
> +	update_thermal_load_avg(rq_clock_task(rq) >> sched_thermal_decay_shift,
> +				rq, per_cpu(thermal_pressure, cpu_of(rq)));

Would be better to create

+static inline u64 rq_clock_thermal(struct rq *rq)
+{
+       lockdep_assert_held(&rq->lock);
+       assert_clock_updated(rq);
+
+       return rq_clock_task(rq) >> sched_thermal_decay_shift;
+}
+

and use it when calling update_thermal_load_avg(rq_clock_thermal(rq)...


>  #endif
>  }
>  
> -- 
> 2.1.4
> 
