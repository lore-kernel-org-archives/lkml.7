Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A7CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A52820854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+LtFYWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfCGP0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:26:38 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45842 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGP0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:26:38 -0500
Received: by mail-ed1-f68.google.com with SMTP id f19so13770908eds.12;
        Thu, 07 Mar 2019 07:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yotb0BDf1wLqkP6HU8zfxiMRzCtG3Cx+Y/EAufUXSqw=;
        b=I+LtFYWX6Kaf+7jk8GUd+4a/K5xs8dgSarhacNAoO8IljKF1A7x3Ai6AmBQN5Je1fK
         Ff03eMFUe+LAta9J4h9IqoKUvNC/kaG92MJRkWW8rXj8o2ir4Ysvoc7RByP+0dvhViwo
         7SZ1XUpB1mKjAdCdbivHy93JujSNxus8Jzz1ng0uAHawY2zee7JCsUp3quF/jZZ7enP7
         7gdTyGQkHt7KPzh2w6QmI0gFNiPxFvM68wBHkoD4ejyNgyu1XpsmtCOLJgz4sgodVMbS
         mwvh0Oxg2MsFr8t0YNMb/biEfY+MV6U3qAfK8kZvpAizBuSZl/JebXJbMq1cCsVfORY/
         Q2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yotb0BDf1wLqkP6HU8zfxiMRzCtG3Cx+Y/EAufUXSqw=;
        b=bj5/4MS3OjYiYAhopLhDhe+ITYXM0DuqrNfWBNOJfxCz9CJ646zMK5r7LyA/7f/FRm
         e/nAyGTd2ABdpdOpcQMj0FuQQPAS/o1Am9tk9FgYQ9/xPRO74zPsnDx8eaI5+6FSbAZf
         JnSjv6n828/TQQFo6GvUy4aaVKTl3/Ei67B3iJ8EO4GxBfA8P6FxglE0KD+U5PRbL/hj
         HYcMbvYsdZQ+Ral/AXpVeyNslZo+QHoacvUexn1W8JWdUY2eRqtzc4+IsFZiXZm381hk
         oYX/gRWMsKAzB7aLpE7uzDXHArQzuxMfLUNJEH7csJytvn3StNi2umUXEtj9D2VT8+50
         V23w==
X-Gm-Message-State: APjAAAUWivGcV40cr6CuHV4dy8d9A4cTice2wXRyckVv0BJ3sEJuM94b
        1W68AEpDPkOPSz+32ihvjBk=
X-Google-Smtp-Source: APXvYqxMRN+YvuUaaLWlhLYnlDY4ct8YWkwnZdNm23O0rvS/0yoS4SG2qBOXIT9EMrvf+TiEi5bf6A==
X-Received: by 2002:aa7:c3d3:: with SMTP id l19mr28358532edr.117.1551972395936;
        Thu, 07 Mar 2019 07:26:35 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id o8sm931301eju.0.2019.03.07.07.26.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Mar 2019 07:26:35 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:26:33 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: pxa2xx: remove incorrect __init annotation
Message-ID: <20190307152633.GH20201@archlinux-ryzen>
References: <20190307102250.1140038-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307102250.1140038-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 11:22:41AM +0100, Arnd Bergmann wrote:
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

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

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
> -- 
> 2.20.0
> 
