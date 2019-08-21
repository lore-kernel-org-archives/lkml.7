Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834E9C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 23:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599CD23401
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 23:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="znM/oClH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfHUXji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 19:39:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39446 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfHUXji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 19:39:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so2286409pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 16:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=RoJLziPgJY9mLs+fRu2lKqTyEaUKSYiiOnVn7t9lzGo=;
        b=znM/oClHkBR6pN7RG6wDMkQnx6pbsRIaoNYQc2ceYPiPEl7hq69Qo14MyokFBCw2Xe
         FQ20sImAG9QaU+NbtIppKgexVWzDXK7u3I2TJkT7ch4fu0lhJyBfxEQnkTfHBDvjMSBK
         SBjbbFjeIO1/Uug6SqmyTdB2c9tIYDcPZZc5y1rgtbC2kpInFxWKmChK9bLwT7GvdFbD
         zXk4Lw6gFtHp+EJz64710+rpjuMARq6Zx3BHACB26ZRCfJoRZD+X+W7tc6iRJTi2dOXi
         K6vTKICEJmVxIQEBRpUEaBsT6/s5TODqCjYQ7Ba0Bc8KTkwktqpTmNnvQe18Qg4JtDPr
         HDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=RoJLziPgJY9mLs+fRu2lKqTyEaUKSYiiOnVn7t9lzGo=;
        b=fXx8zTpePyQrak3wcSUN7Dk6bY5DTLUchFriwMzZotj7FhWdSWv8lGe3LcUjIE/125
         OiFaC/kPWYi/Hb8emS31bHrVNkn0zQatR3Wh9uB8nOBGP0/iDOPWZ6IAmxtcUBJ6CGB6
         2/FmQJ7KKSOi8h9nTfCniJ63zF4AbH3yzxDzsCGtv9na6AnUvxl73D2SuvbCQmv2VddL
         9+CtORqIuSuUFYH4DHo6DxwGzQctoiqa0L4PTSXEgE1uPOXGwAEe/uzKDajp0Z504Ooy
         GzSlbnE4vR3w6WVgjv7t7YjKzHX98um1Cp9wPt6TrewhojQULrl2rYLeebc5Uze2B3nd
         6ezw==
X-Gm-Message-State: APjAAAUk3spIMQHNv4JWBKgrSSLPyK+bllxdS9z2ZEzCNMCZXfhOkBe8
        D43U9kPgoEgF4JaOZzpPzXAgew==
X-Google-Smtp-Source: APXvYqxbUoVvUvpMfuvIMtOftEIUIVFxHRXscpTOlg7Xd4x9nP3Em83MNj+d7QIroKxxfU76f9qS/w==
X-Received: by 2002:a17:90a:d793:: with SMTP id z19mr2480702pju.36.1566430777357;
        Wed, 21 Aug 2019 16:39:37 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id s5sm24549074pfm.97.2019.08.21.16.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 16:39:36 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v4 0/6] Add support of New Amlogic temperature sensor for G12 SoCs
In-Reply-To: <20190821222421.30242-1-glaroque@baylibre.com>
References: <20190821222421.30242-1-glaroque@baylibre.com>
Date:   Wed, 21 Aug 2019 16:39:36 -0700
Message-ID: <7hk1b65brb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume La Roque <glaroque@baylibre.com> writes:

> This patchs series add support of New Amlogic temperature sensor and minimal
> thermal zone for SEI510 and ODROID-N2 boards.
>
> First implementation was doing on IIO[1] but after comments i move on thermal framework.
> Formulas and calibration values come from amlogic.
>
> Changes since v3:
>   - Add cooling map and trip point for hot type
>   - move compatible on g12a instead of g12 to be aligned with others
>   - add all reviewer, sorry for this mistake
>
> Changes since v2:
>   - fix yaml documention
>   - remove unneeded status variable for temperature-sensor node
>   - rework driver after Martin review
>   - add some information in commit message
>
> Changes since v1:
>   - fix enum vs const in documentation
>   - fix error with thermal-sensor-cells value set to 1 instead of 0
>   - add some dependencies needed to add cooling-maps
>
> Dependencies :
> - patch 3,4 & 5: depends on Neil's patch and series :
>               - missing dwc2 phy-names[2]
>               - patchsets to add DVFS on G12a[3] which have deps on [4] and [5]
>
> [1] https://lore.kernel.org/linux-amlogic/20190604144714.2009-1-glaroque@baylibre.com/
> [2] https://lore.kernel.org/linux-amlogic/20190625123647.26117-1-narmstrong@baylibre.com/
> [3] https://lore.kernel.org/linux-amlogic/20190729132622.7566-1-narmstrong@baylibre.com/
> [4] https://lore.kernel.org/linux-amlogic/20190731084019.8451-5-narmstrong@baylibre.com/
> [5] https://lore.kernel.org/linux-amlogic/20190729132622.7566-3-narmstrong@baylibre.com/
>
>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>

nit: you should put these on the individual patches, since the cover
letter does not get applied to any tree, any tags here get lost.

Kevin
