Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBB5CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D934620663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571838602;
	bh=TLidFQmr/RJWhGE+WZlWN0NqIrvuU32Ofk0mmWFStVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ANsMYy7T3ea+PlpIqQP/xoRUTGF96knVIydh5kyeSLt+VNTjEf58lIswZPW/Eyk58
	 4ZpZQ1AaVPfkRBRLsHRbKGQsqiiJtoCMabcbGYS0ujxxTlzE7FtaukxD3EisbCfsy3
	 LPAlxLUeEJMvhm98vFCPM0PTnNPj6jc1kGTAF2O4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406161AbfJWNuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:50:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35299 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405956AbfJWNuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:50:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id k2so5124780edx.2;
        Wed, 23 Oct 2019 06:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8qBb291IPE2og/l7u8OiTDfQtbzmiVhAHgv1m3GbkfM=;
        b=PvPI2OUUIth0m6/ElRXyVRuYu9Qan/98GzjzGOkXBd5cUTPBNeyC1CjvIPtKtn1VQ5
         XKg24pqbXlp81cqT943pHDULu5qqNhSXr4hBAgj2CDhVOJH7/mXkV5DrDzXGFcaaJBDt
         ZGKnQgdBi5kir79+dSPmTkQkTjIGr4tgkGseYYxVe4ftNGu7nnicwoKW5yPfEAC5Rcpp
         TPmH/cRd861xPiqBiQs/ddK6b/aWKL7ews//H/01vvFLLpeSFQF4+U4MIMFCB8DiGroD
         EpUu7x4ieX+082Qqc4KklTZ/+cPk8k1g93bFxeyStPMNI3Nrzc/WeiY7wzvBff9Cu8QZ
         4+hA==
X-Gm-Message-State: APjAAAWm0xBPohVFjCswQjmCU2VAy7SOnr8jTJvWg6J4mEC3jUJmF25S
        2WdqDNAqQbmZLSmIeZ+v38k=
X-Google-Smtp-Source: APXvYqwjWvPU2P28o+R/0H7qCyJXE4W8hZoo+hrDHIsqBv9q1Xi6Hyp0zb62g4wWhOXMSl17h7J2Hw==
X-Received: by 2002:a50:ff19:: with SMTP id a25mr9916560edu.181.1571838599737;
        Wed, 23 Oct 2019 06:49:59 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id j43sm734313eda.19.2019.10.23.06.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 06:49:58 -0700 (PDT)
Date:   Wed, 23 Oct 2019 15:49:56 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 33/36] ARM: s3c: move low-level clk reg access into
 platform code
Message-ID: <20191023134956.GK11048@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-33-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-33-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:30:17PM +0200, Arnd Bergmann wrote:
> Rather than have the cpufreq drivers touch include the
> common headers to get the constants, add a small indirection.
> This is still not the proper way that would do this through
> the common clk API, but it lets us kill off the header file
> usage.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c24xx/Makefile               |  2 +-
>  arch/arm/mach-s3c24xx/cpufreq-utils.c        | 32 ++++++++++++++++++++
>  drivers/cpufreq/s3c2410-cpufreq.c            |  8 +----
>  drivers/cpufreq/s3c2412-cpufreq.c            | 10 ++----
>  drivers/cpufreq/s3c2440-cpufreq.c            | 16 +++-------
>  drivers/cpufreq/s3c24xx-cpufreq.c            | 11 ++-----
>  include/linux/soc/samsung/s3c-cpufreq-core.h |  7 +++++
>  7 files changed, 51 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
> index 695573df00b1..195a4cb23ecb 100644
> --- a/arch/arm/mach-s3c24xx/Makefile
> +++ b/arch/arm/mach-s3c24xx/Makefile
> @@ -38,7 +38,7 @@ obj-$(CONFIG_PM_SLEEP)		+= irq-pm.o sleep.o
>  
>  # common code
>  
> -obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += cpufreq-utils.o
> +obj-$(CONFIG_ARM_S3C24XX_CPUFREQ) += cpufreq-utils.o

Drop also here S3C2410_CPUFREQ_UTILS entirely.

Best regards,
Krzysztof

