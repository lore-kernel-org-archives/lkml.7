Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC52C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC072173E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="j/qmk0il"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388972AbfHWQKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:10:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37014 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388851AbfHWQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:10:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id d16so9630540wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=qCpJ5DiOoAHU5lhDofCgzNtjT/DAKjPBpHrmlHOG6vQ=;
        b=j/qmk0ilPhQUF7l0BN9NueVXnVk2TKnE2zRM8pYHg2uQDvM/AGnH+Bfx6hFLi7fMA5
         +pwScOhCd4T7VHxRIEH4eBmsM4mLGXagmBK8019XMPY7vfm4XHPmV9qMAoyE+idALv01
         o7oNlPtNdnmURS3gpvwjKwUcVItSTRYeVFdCPkJZZPVwvRd1joN4Ni+1b0OLf73t1wbN
         th/Tv6JxhO5HfB+s8kXKbo0JAlOSinY2G7P9cRqm4RQSzqsYnM3u3JxjmeJRPXAqt19Y
         CtUXa/GyRT/rRgMqOLJofptHhMWhFh8rOycf/niTiIfDQd+JvLT3tunPocq01Y86lZHg
         8hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qCpJ5DiOoAHU5lhDofCgzNtjT/DAKjPBpHrmlHOG6vQ=;
        b=JFgkom1wqRol03yX87leQ+IoxuzcRGKfx+91gIe6YJas1ppgsk0J6EfgV0Uyo58M3M
         XYLIEFmxZs4ep8sVUd1ANDEMb4dictETwyt7pMsISdkSSqT3RnpwcjI4How8uCqUeH/I
         SwU1ox7kqK1WzLmm7FJo5WG2Gc4Kw3CGEVHGyyv+rl8T+qT/MxJdFyNGQClluZ2bUpK/
         UyqoALIJdtOxN4xAdsWdui4+MqqJiCq+bFNo6bkfT0i46FMxRt0UXcNkJ4h2l0sF25Ui
         CwDiBU3u/FuCqu3b+xgcjh1y8uBpGkd2hPQYVOZtXlqHbUlDCrY0GBuOmys3PU+E4L2V
         9gKA==
X-Gm-Message-State: APjAAAWOThoe++vZs222n2Htl/0II3CnO5lIAunacIU7eYQ8Qb22zoGW
        xOlnx1Qi+cdj1ExaQ/OfR8NVPA==
X-Google-Smtp-Source: APXvYqzAdjPuuRgo0jN5MfNpSucyg8E+yaUYECo/wLyzD0iRmP6TdW/S7hVnAWdyxU8Skx4en26LQQ==
X-Received: by 2002:a7b:cd17:: with SMTP id f23mr6259424wmj.177.1566576603459;
        Fri, 23 Aug 2019 09:10:03 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s2sm2909998wrp.32.2019.08.23.09.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 09:10:02 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] arm64: meson-sm1: add support for DVFS
In-Reply-To: <20190822142455.12506-1-narmstrong@baylibre.com>
References: <20190822142455.12506-1-narmstrong@baylibre.com>
Date:   Fri, 23 Aug 2019 18:10:01 +0200
Message-ID: <1jlfvjeucm.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22 Aug 2019 at 16:24, Neil Armstrong <narmstrong@baylibre.com> wrote:

> Following DVFS support for the Amlogic G12A and G12B SoCs, this serie
> enables DVFS on the SM1 SoC for the SEI610 board.
>
> The SM1 Clock structure is slightly different because of the Cortex-A55
> core used, having the capability for each core of a same cluster to run
> at a different frequency thanks to the newly used DynamIQ Shared Unit.
>
> This is why SM1 has a CPU clock tree for each core and for DynamIQ Shared Unit,
> with a bypass mux to use the CPU0 instead of the dedicated trees.
>
> The DSU uses a new GP1 PLL as default clock, thus GP1 is added as read-only.
>
> The SM1 OPPs has been taken from the Amlogic Vendor tree, and unlike
> G12A only a single version of the SoC is available.
>
> Dependencies:
> - patch 6 is based on the "arm64: meson: add support for SM1 Power Domains" serie,
> 	but is not a strong dependency, it will work without
>
> Neil Armstrong (6):
>   dt-bindings: clk: meson: add sm1 periph clock controller bindings
>   clk: meson: g12a: add support for SM1 GP1 PLL
>   clk: meson: g12a: add support for SM1 DynamIQ Shared Unit clock
>   clk: meson: g12a: add support for SM1 CPU 1, 2 & 3 clocks
>   clk: meson: g12a: expose SM1 CPU 1, 2 & 3 clocks
>   arm64: dts: meson-sm1-sei610: enable DVFS
>
>  .../bindings/clock/amlogic,gxbb-clkc.txt      |   1 +
>  .../boot/dts/amlogic/meson-sm1-sei610.dts     |  59 +-
>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  69 +++
>  drivers/clk/meson/g12a.c                      | 544 ++++++++++++++++++
>  drivers/clk/meson/g12a.h                      |  26 +-
>  include/dt-bindings/clock/g12a-clkc.h         |   3 +
>  6 files changed, 697 insertions(+), 5 deletions(-)

Series looks good to me overall.
Just drop patch 5 and expose every ID necessary directly with patch 1
(same goes for the GP1 clock ID)

>
> -- 
> 2.22.0
