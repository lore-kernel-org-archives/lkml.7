Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A6AC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135F52168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pQ/9+NLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbfJPDk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:40:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46491 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfJPDk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:40:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id e15so5402159pgu.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 20:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xyU0bddas5jZkFdUfMyKM2RU3/RqwFyZ6dwkUF1DQVQ=;
        b=pQ/9+NLyOjXkDIHnSbJmUIcVS2JKmUR+dLfWVdqFaXWgGClWL0NgAHRFYzEQAdIi5M
         bmQnjksvRo9bOSa4O6QZ3sOZxHeDIp/AGbAaSlM/cUpi2x3f/fx3zQaHc1iokTvmjHGd
         MG8HA8/Oo58zlRD98vDfsqCrB0z15IlqwVSYQTuATTJi7yjszPtmbIHOO7faxR8vs21e
         xuO13mOBLTNSqRb2JNagr378qnlsfMx24QHY7EdmN04UKGdeh8z3cWISNYxUx2GqzIO6
         8r/IYxfYgq9b0om8xvQ83gfioPH50atvjeWEUxq9jYO8qsdTlPtiU0Bj43OUzZRyHMSj
         barg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xyU0bddas5jZkFdUfMyKM2RU3/RqwFyZ6dwkUF1DQVQ=;
        b=DUfp1YCdDWFr2VGaP5J4ipnq5+ljsr5qKtTyilZmxyVpn2dVFXMtbDieNlBXwYVZSh
         m+9Xmba5H7KHo7KddwzMMRUNV7Cfr+JSXgtHxNDfjaiVv68PupPPwIhKp94kgujOdhGL
         8BEHvA6FtQ9AjRkKMui1jOV+gqfUr2qcWfUjVXCALAzYRu4jEdNC4i8vQz4LUAAoGVWn
         BaYVVrAaRxWiiBMSbTCaVQFAAlL7h6scwJqzF3PDmY+w5i04i+TWyS9kycrDptRZVfSP
         soOn3X92YU6it1d+z9+U2Bmb98a989kArE2rEheG0/j2CQtfnUptGckUvuJoqTWnHvEi
         imxA==
X-Gm-Message-State: APjAAAU6eSKR7mCzsKVpeoaHkvVOyYt3TawQmp9AnFZ0V95A6JY/Cul+
        zTPb20KqFusFLyOcgcp7xW22Ow==
X-Google-Smtp-Source: APXvYqxbZPHF0HWOinKOgSiHgLGsrwj2cRk28OdjS16byk75PH8EvjVRMMGGlKbVZyB31eYZFC7Dlg==
X-Received: by 2002:a17:90a:5896:: with SMTP id j22mr2138286pji.55.1571197257094;
        Tue, 15 Oct 2019 20:40:57 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id v3sm22599956pfn.18.2019.10.15.20.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 20:40:56 -0700 (PDT)
Date:   Wed, 16 Oct 2019 09:10:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 13/14] cpufreq: Use vtime aware kcpustat accessor to
 fetch CPUTIME_SYSTEM
Message-ID: <20191016034054.ufbsfuwvdk5hfvnx@vireshk-i7>
References: <20191016025700.31277-1-frederic@kernel.org>
 <20191016025700.31277-14-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016025700.31277-14-frederic@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-19, 04:56, Frederic Weisbecker wrote:
> Now that we have a vtime safe kcpustat accessor for CPUTIME_SYSTEM, use
> it to start fixing frozen kcpustat values on nohz_full CPUs.
> 
> Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c52d6fa32aac..a37ebfd7e0e8 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -120,7 +120,7 @@ static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
>  	cur_wall_time = jiffies64_to_nsecs(get_jiffies_64());
>  
>  	busy_time = kcpustat_cpu(cpu).cpustat[CPUTIME_USER];
> -	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_SYSTEM];
> +	busy_time += kcpustat_field(&kcpustat_cpu(cpu), CPUTIME_SYSTEM, cpu);
>  	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_IRQ];
>  	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_SOFTIRQ];
>  	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
