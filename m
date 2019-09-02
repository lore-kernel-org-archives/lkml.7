Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1426C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D402173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKZpfUR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfIBIjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:39:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38753 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbfIBIjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:39:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id o184so13636726wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1mkscZs0uu9IwenYpN+gcYhKeJIx57LFJyMj96zqdM0=;
        b=vKZpfUR5yqDb9PeDz8JN+b3Bi5x1D8g1WlPSu7T3WiFC4CnfcdJTCfXRdzNsfZ0sZA
         uM4YC/zBIf1aOlgJi39vaOZBDu2KAm/y2YvMyT1n1+YuvsF6wSeHKB2zqGO2ao5VU9QF
         sPQSCuw+FsC74i6k/ntjXOJcYfL4vcEWTasRPZy4EcPSwiq4NBdBATTvMQMlNzu4COiW
         DAQU75a5uQAeWhxqnBoWNUu6S2qjPNw89lNSHoJ2iOeAug5bWHTAc1AO/W1q34kTFpz2
         cn+T2fN5Rtg3fUNYU5Vmsdic+Y6OMbBJUiAIpW9zbBW1ajVn9aQ11IZJoFYd9jRYKQRu
         thHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1mkscZs0uu9IwenYpN+gcYhKeJIx57LFJyMj96zqdM0=;
        b=c7RoCjXkVIP7BlO2ebOxElsIjlr28nECiPQ5l3L3kdxbl1Ug9l2yrks6IB7+925pLA
         SpSb4ZxsIDLNzQ8sFkUZHT3mW+QG+7A/dVhI/duCbjMNyPDbb9O6TAyZle/FhJ1ZDbGQ
         Nlc9rTpdWPrIl5ekuP0lMmIrstTp9Eq/QvNbwKD+k+gl9zjDqnWi90VdcW+UqHMNtd7m
         BTrbKDhS+jueLIMgMnbeCcN1iF02Atf1OaJCycn5u4pymFTiIyL0rCEzHEevIQTRtv03
         Lw9rtvo0Y9zA03e4XCisST/J4goYM9yUEx/P6zA3nyNsdmnl/fwT4AVDwAx7oApa1pOE
         cEfg==
X-Gm-Message-State: APjAAAXJaiC7/E6CAFmHaju5SiBbebvkFK1VdIJatkwLebei0WtCYa3N
        4NPbGKxpAmnUPdExXMXl9ZPRbQ==
X-Google-Smtp-Source: APXvYqwCXrctAp3oHpVQnuoQoukgyKKmqiIFKu7Oc0cormhrJ4graVSTN4/zkGB7jjO5Iz4XhCV+2Q==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr35626768wml.175.1567413541059;
        Mon, 02 Sep 2019 01:39:01 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id i93sm19615039wri.57.2019.09.02.01.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 01:39:00 -0700 (PDT)
Date:   Mon, 2 Sep 2019 09:38:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mfd: Add support for Merrifield Basin Cove PMIC
Message-ID: <20190902083859.GQ4804@dell>
References: <20190801190335.37726-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190801190335.37726-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Aug 2019, Andy Shevchenko wrote:

> Add an MFD driver for Intel Merrifield Basin Cove PMIC.
> 
> Firmware on the platforms which are using Basin Cove PMIC is "smarter"
> than on the rest supported by vanilla kernel. It handles first level
> of interrupt itself, while others do it on OS level.
> 
> The driver is done in the same way as the rest of Intel PMIC MFD drivers
> in the kernel to support the initial design. The design allows to use
> one driver among few PMICs without knowing implementation details of
> the each hardware version or generation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v4: elaborate in the commit message the design choice
>  drivers/mfd/Kconfig                      |  11 ++
>  drivers/mfd/Makefile                     |   1 +
>  drivers/mfd/intel_soc_pmic_mrfld.c       | 157 +++++++++++++++++++++++
>  include/linux/mfd/intel_soc_pmic_mrfld.h |  81 ++++++++++++
>  4 files changed, 250 insertions(+)
>  create mode 100644 drivers/mfd/intel_soc_pmic_mrfld.c
>  create mode 100644 include/linux/mfd/intel_soc_pmic_mrfld.h

Reluctantly applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
