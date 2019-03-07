Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B98C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D89420684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfR+74cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfCGKim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:38:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39787 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfCGKil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:38:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id i20so11109140pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 02:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GvVX5xtAALRyUNVls6AsSTHRSenEjxpBMBmhnGntEko=;
        b=dfR+74cvAo+bhw2VHMG+RddYr5cDhucibdnijRR4WoK2d29iPt4xn1nz3C7K1x6Bia
         H64U93p0rv8voRomVvAsoGb7b797BIfpBO8BzHcWpS4wdlUikFMEz0tj5/mVk1sJN5MT
         OuixPJKkxPDONJXXs8xFPjQqZxIZKpdkqvlD61/zDzn5Xq0AHp4xJgNuC2zUE2TitovZ
         fFsGNeYvPjInVJvdKn0p9DJoNntDnepOMjcu4b628jQ9K7MFkRMBVF2nJQdcHpzXJE+h
         bM6TdEG8uSiGr78QX0mTxjHA7eZ+KuJ0dDGeldbhD1Sly10l0HONDX0A/AwH9N+wh7oS
         BU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GvVX5xtAALRyUNVls6AsSTHRSenEjxpBMBmhnGntEko=;
        b=ot8gBAHnWKVzRS2qcRxQYqCuGdem+8bTxVkmKIGnqKM6vr6uBv5ZK2QhQRM52BoF3p
         B1aCnXc5nobGZ/EhaMjL0Egl+EyDG/fXcF9V+1hiFyhzWV5ox8gM1YlKTB9SUBRW1UF0
         NBr+etki2fudTiS+f5PUfe+HJHB2l3aykdU0c35rBRWCk4SX/+o0do+Jn/9sghc+Y368
         HyC/Ta1md6tmA9VfyOeKcDNBFjoVpyZ2CkhrXxe+3u+W8r+CXbTsqsefJQKoEQi6wocv
         V+/oVb+TPjH3W7Q/3bX7AZQa65fCIwHZySgAV/1pR1OEiYI/W4YoucdT3uJkg3Gte12s
         Enyw==
X-Gm-Message-State: APjAAAVSo+zbykxlk+04VT4TPKw/GhzmtrUtCYfoYO1Hl/C/fTwvMiP+
        EkZc9qQghLqUlxT882AlnBQV6Q==
X-Google-Smtp-Source: APXvYqwvJOc3Al1pwt8oJGwU75+G5TXc9t233fHlKDWBALIDckZzvNQhaLwpySiTf4X7flktA7kkKw==
X-Received: by 2002:a63:112:: with SMTP id 18mr10321075pgb.139.1551955120439;
        Thu, 07 Mar 2019 02:38:40 -0800 (PST)
Received: from localhost ([122.171.71.18])
        by smtp.gmail.com with ESMTPSA id m20sm14814239pfj.142.2019.03.07.02.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 02:38:39 -0800 (PST)
Date:   Thu, 7 Mar 2019 16:08:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: pxa2xx: remove incorrect __init annotation
Message-ID: <20190307103837.zuva5f6y2gexxjk6@vireshk-i7>
References: <20190307102250.1140038-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307102250.1140038-1-arnd@arndb.de>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-03-19, 11:22, Arnd Bergmann wrote:
> pxa_cpufreq_init_voltages() is marked __init but usually inlined into
> the non-__init pxa_cpufreq_init() function. When building with clang,
> it can stay as a standalone function in a discarded section, and produce
> this warning:
> 
> WARNING: vmlinux.o(.text+0x616a00): Section mismatch in reference from the function pxa_cpufreq_init() to the function .init.text:pxa_cpufreq_init_voltages()
> The function pxa_cpufreq_init() references
> the function __init pxa_cpufreq_init_voltages().
> This is often because pxa_cpufreq_init lacks a __init
> annotation or the annotation of pxa_cpufreq_init_voltages is wrong.
> 
> Fixes: 50e77fcd790e ("ARM: pxa: remove __init from cpufreq_driver->init()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/pxa2xx-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
> index 46254e583982..74e0e0c20c46 100644
> --- a/drivers/cpufreq/pxa2xx-cpufreq.c
> +++ b/drivers/cpufreq/pxa2xx-cpufreq.c
> @@ -143,7 +143,7 @@ static int pxa_cpufreq_change_voltage(const struct pxa_freqs *pxa_freq)
>  	return ret;
>  }
>  
> -static void __init pxa_cpufreq_init_voltages(void)
> +static void pxa_cpufreq_init_voltages(void)
>  {
>  	vcc_core = regulator_get(NULL, "vcc_core");
>  	if (IS_ERR(vcc_core)) {
> @@ -159,7 +159,7 @@ static int pxa_cpufreq_change_voltage(const struct pxa_freqs *pxa_freq)
>  	return 0;
>  }
>  
> -static void __init pxa_cpufreq_init_voltages(void) { }
> +static void pxa_cpufreq_init_voltages(void) { }
>  #endif
>  
>  static void find_freq_tables(struct cpufreq_frequency_table **freq_table,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
