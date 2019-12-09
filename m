Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142DCC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFB620637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lCdRbY8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfLITef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:34:35 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35463 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLITee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:34:34 -0500
Received: by mail-pl1-f194.google.com with SMTP id s10so6220690plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 11:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZXNGLW7mFianPc1VWLK8THUd4ZKwccb4YrTIuoMnGk0=;
        b=lCdRbY8AJYLHMjRur+qXl1k3An/CDtGgqw6W8jfX9s8665NNeVLR4dOHO7yRDfyr78
         GdGOWIaxq9afq2lFh621TEzdsn6+HdWl24evVkKZhm7dI+0z6KB6jK9Bln9LT2lPDllA
         snBmS3jLAwtnY78Mxg1+BhZUa2o3YY9qILbnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZXNGLW7mFianPc1VWLK8THUd4ZKwccb4YrTIuoMnGk0=;
        b=DPzHLl/nD++lYU9JyIjuMalCIWDXmic1V6i6WqSvcE21MX/UzUg5ZmfIwh7kf/zjOD
         Rk2vbYOrEVQ0MxCNnnB7/yklRJzIiBNTAGbldOYRfQBZCsEv22ACl3ssOsxZLXBGRTyt
         pF5zfDCxC/X6Vd3OeBbR8IYaN9dtbQs0gclVvMr2dHURziUcu+WedEa0+DBZ/Nk8oi76
         j3MpqS1c/CtVxexfLajsHd5Z60dX2ODRbeRCZ8XJHpnbt0zgP/f6K2qLqx2ebf2QUZzh
         S/VajZr2rNaksiD/TjM0RdTgKfk2fI9Xw4v+chQrU/Hi3xp9xM+FnEjQ+qNP5RzCH+fd
         EK2g==
X-Gm-Message-State: APjAAAXKtYKYXjel0oIdJoPem8unTUzM31btVgW6sOokrrEq+XhGNH32
        LLBHXI94EtxpDOSHIPUpTS2ayA==
X-Google-Smtp-Source: APXvYqyyadS5sS/1VnJWvbDbKx1ZcI7p3t0CLn71BLe7STUeHfSNIWMnpEdjyK8JcF/LTYJeq9PVpQ==
X-Received: by 2002:a17:902:363:: with SMTP id 90mr9706773pld.71.1575920074056;
        Mon, 09 Dec 2019 11:34:34 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id e11sm155563pjj.26.2019.12.09.11.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 11:34:33 -0800 (PST)
Date:   Mon, 9 Dec 2019 11:34:32 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 3/4] PM / devfreq: Kconfig: add DEVFREQ_DELAYED_TIMER
 option
Message-ID: <20191209193432.GQ228856@google.com>
References: <20191209144425.13321-1-k.konieczny@samsung.com>
 <CGME20191209144442eucas1p1e4f5cf4a1716262e2b6715fb41876f91@eucas1p1.samsung.com>
 <20191209144425.13321-4-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191209144425.13321-4-k.konieczny@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 03:44:24PM +0100, Kamil Konieczny wrote:
> Add Kconfig option DEVFREQ_DELAYED_TIMER. If set, devfreq workqueue
> will use delayed timer from its start.

s/from its start/by default/

> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> ---
>  drivers/devfreq/Kconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 38a94df749a2..c799917c34c9 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -74,6 +74,18 @@ config DEVFREQ_GOV_PASSIVE
>  	  through sysfs entries. The passive governor recommends that
>  	  devfreq device uses the OPP table to get the frequency/voltage.
>  
> +comment "DEVFREQ Options"
> +
> +config DEVFREQ_DELAYED_TIMER
> +	bool "Use delayed timer in Simple Ondemand Governor"

Is the use really limited to the Simple Ondemand Governor? I don't think
so, at least the Tegra devfreq driver also does monitoring and others
might follow.


> +	default false
> +	help
> +	  Simple Ondemand Governor uses polling for reading buses counters.
> +	  A default timer used is deferred, which saves power, but can
> +	  miss increased demand for higher bus frequency if timer was
> +	  assigned to idle cpu. If you want to change this to delayed
> +	  timer at the cost of more power used, say Yes here.
> +
>  comment "DEVFREQ Drivers"
>  
>  config ARM_EXYNOS_BUS_DEVFREQ


This patch on it's own does nothing. Squash it with '[4/4] PM / devfreq:
use delayed work if DEVFREQ_DELAYED_TIMER set'.
