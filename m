Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632D4C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BFB2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDrvrGap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfH0MtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:49:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33453 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfH0MtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:49:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so18689272wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=K6sGGcnkNfJ7ijmDZaaObo8SqOBDw8MmU1nR9YFrhj8=;
        b=VDrvrGap44JQj1pV7ukPNeiNPrl33ZJdIjVWQNuThmlV/RYhymoEVyAKwyHwndqZvN
         qww7p2ZMRh7JgLOD2y6mCnT9y/evAWEtC13jipki/Uy0KE4NEJMlUVXT7/P1tqUgy+GN
         SIP39SOCRSxRfHcWg81XLLReIFmnYZCnf2KyBbYHfCu5kPicUx2bOrALKil0Pu4UmcNT
         sHALJwpk0rPk8rvhl1DqjMWnHyUKetqGj1uVr5HiobXyyXTSmSsdhUneZ6MPsDaVk/hp
         huWtxDHsBk3K/R8ZJHQOZQs8gJOReqB3jTJGDqd52oAdYlKduIhTFKZ/U6+vDVrc++vY
         bI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K6sGGcnkNfJ7ijmDZaaObo8SqOBDw8MmU1nR9YFrhj8=;
        b=pAwyKhLndYVnP5aboaCt/oRkIjfaAEUqmaE9kTfjrb1uXDCNNhtJizI9fOmgraHgom
         olIwyR9X+6uRAC7caJQZsUjW4BbsdguKX1CuwU1eRj380BGzxQ80xTZ3UaWG0mR//mvH
         6pqK2vdIZp8zusl9qD1qi+imChUpXC2M4GTeqvjl4tCaNiL72Ns9CXCR3w/D681WiNLX
         xb3X7znj0ML4xZu78C1DHcI4HMuVfV+t7zmKbIrarpp3J8Oh2CekJPHM7EYxOj9RDjEg
         kkrOvGx9mZLq7SgCWWfdQL5vePhmLLB4RzzMMJCWfz1Rm1YWoJhdSfYG+BC6jN07onCf
         MakA==
X-Gm-Message-State: APjAAAXZH+RYWkt8mBqhVoRG8vds8uDeMRXXobtcgMMsvCIbbRToIv+I
        0fOsW6YV4BSVz6wC8Y9UaOaS4Q==
X-Google-Smtp-Source: APXvYqwNsNJ89B57qTK4F90oQyhoU6bn99bji2y67EUH88lzxmr0C/UR7DYf6KN5yZwh7dNbo4+uiw==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr28897624wrr.11.1566910163278;
        Tue, 27 Aug 2019 05:49:23 -0700 (PDT)
Received: from dell ([2.27.35.174])
        by smtp.gmail.com with ESMTPSA id r17sm39025961wrg.93.2019.08.27.05.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:49:22 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:49:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v6 11/11] arm/arm64: defconfig: Update configs to use the
 new CROS_EC options
Message-ID: <20190827124921.GE4804@dell>
References: <20190823125331.5070-1-enric.balletbo@collabora.com>
 <20190823125331.5070-12-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190823125331.5070-12-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019, Enric Balletbo i Serra wrote:

> Recently we refactored the CrOS EC drivers moving part of the code from
> the MFD subsystem to the platform chrome subsystem. During this change
> we needed to rename some config options, so, update the defconfigs
> accordingly.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/configs/exynos_defconfig   | 6 +++++-
>  arch/arm/configs/multi_v7_defconfig | 6 ++++--
>  arch/arm/configs/pxa_defconfig      | 4 +++-
>  arch/arm/configs/tegra_defconfig    | 2 +-
>  arch/arm64/configs/defconfig        | 6 ++++--
>  5 files changed, 17 insertions(+), 7 deletions(-)

This needs an ARM-SoC Ack before I can take it.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
