Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D26EC41514
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A12233FF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567622118;
	bh=NDskAU3EZM/kSTfk8HyDaVjeJ7BcQ1qVr7nJn7qS9xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bmg1SzkbxVYiCEFfTfJtAhfubOWht8Fl/OJ+a3NdKcdkandoqvXwqxKTYyYdhW1eo
	 /n+U5+sJG/TAVMqHJrTn9IZKqmV/buMdnWvoOYbxAIOGLTlVlDVqDJSsUzJcJqAOgo
	 EsVIyVWFgTpXSrniomuYJzBJzvv/bPy68dum4g4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732951AbfIDSfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:35:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38511 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732542AbfIDSfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:35:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id l11so13523104wrx.5;
        Wed, 04 Sep 2019 11:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YYvy5JDq8wduxQvbZiHxp3SZAOhECKg/qQw/mqdhCPs=;
        b=JDB5r4Sa8nWSbjbo7NyBk0PLy0ws0affbjEsTbz5ACI6jcEfA2OZ8hr3e6SecYMI5A
         PMi0D3o6fGXrj+L8DwRdGWSRoXOlMX17rHFBMgHjRZtgCozR6fNT4omXzrUjeF7SK+Co
         gW/qnAu7MC5otLaQNGVqf/qoM0B6FDygMd6cT6JvFgdyg5bhMH1GBUiPLQ8tIDzRm9ak
         UvdS+LMGYXKrB5Nhf4/ZCYy4SckrALjvf1MFHTAo3yQzAJzmL6ReuhSOKnwraVryGCKc
         xK8icNrxUbhLztE/7tKhZ1kzP6/akF+5xFfbFBOF5pvBYIWySu5uzibYtrjPy8ciQNDP
         tMMw==
X-Gm-Message-State: APjAAAUchTpmzH8A1fuHhe8xoMqbty3CADO3S20B9HSgWKJ7N8rIZ8FV
        g9RJU080mxITQvzSSb815Vg=
X-Google-Smtp-Source: APXvYqwhDiVqMHvqzUFC15cl+L5VQH0uEboP5JjpEqJoaX0jr8C+QbK38ChLrI8pf5C0OKuzZ8HRAA==
X-Received: by 2002:adf:f18c:: with SMTP id h12mr46945525wro.47.1567622114456;
        Wed, 04 Sep 2019 11:35:14 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id u10sm733191wmm.43.2019.09.04.11.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 11:35:13 -0700 (PDT)
Date:   Wed, 4 Sep 2019 20:35:10 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, b.zolnierkie@samsung.com, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v13 5/8] drivers: memory: add DMC driver for Exynos5422
Message-ID: <20190904183510.GC12918@kozik-lap>
References: <20190821104303.32079-1-l.luba@partner.samsung.com>
 <CGME20190821104323eucas1p1ab979133de45373866e9db1a5f63fb76@eucas1p1.samsung.com>
 <20190821104303.32079-6-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821104303.32079-6-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 12:43:00PM +0200, Lukasz Luba wrote:
> This patch adds driver for Exynos5422 Dynamic Memory Controller.
> The driver provides support for dynamic frequency and voltage scaling
> for DMC and DRAM. It supports changing timings of DRAM running with
> different frequency. There is also an algorithm to calculate timigns
> based on memory description provided in DT.
> The patch also contains needed MAINTAINERS file update.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  MAINTAINERS                             |    8 +
>  drivers/memory/samsung/Kconfig          |   13 +
>  drivers/memory/samsung/Makefile         |    1 +
>  drivers/memory/samsung/exynos5422-dmc.c | 1257 +++++++++++++++++++++++
>  4 files changed, 1279 insertions(+)
>  create mode 100644 drivers/memory/samsung/exynos5422-dmc.c

Thanks, applied... or almost. Let's fix it incrementally.

You have two smatch warnings:
  CHECK   ../drivers/memory/samsung/exynos5422-dmc.c
drivers/memory/samsung/exynos5422-dmc.c:272 exynos5_init_freq_table() warn: passing devm_ allocated variable to kfree. 'dmc->opp'
  CHECK   ../drivers/memory/jedec_ddr_data.c
drivers/memory/samsung/exynos5422-dmc.c:565 exynos5_dmc_get_volt_freq() warn: passing zero to 'PTR_ERR'

The second looks like false positive, but first seems to be real.

You have also sparse warning to fix:
../drivers/memory/samsung/exynos5422-dmc.c:736:1: warning: symbol 'exynos5_dmc_align_init_freq' was not declared. Should it be static?

Best regards,
Krzysztof

