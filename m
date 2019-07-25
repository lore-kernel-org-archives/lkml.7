Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8D3C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A4D22C7E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cLqjJ6Tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfGYWS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:18:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43275 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfGYWS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:18:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so23700034pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NVLzievBgAW2kTNQ4IEdhARg8wdn1fX0hhOxE5e3+74=;
        b=cLqjJ6TzLW3C14g++C0UiRgOWuPiD4AbxAy1kd/QqmjjrhPahabScD3tUJEHzOnzhd
         AUnfZmiZ2LhPk9mYrmJiXd/1yiieI+xtf9NvDs3w93GfM++Hu/DWkgFjOZoBp3Ij9Xra
         JIhFOf2u4fmlaSnfUGzcNbLephleyNk1l+EkL+ZVE+KT9uYkRb4mfBBlaugUGMGCEQwx
         UD0U6exjKJQS78zmA9TB8GeWX4JNO29747mR5z179rz2OgTgdaoHwAo+66L6AOMa+Zej
         AKrKfqM7jyBXxK7f97ZjLAoagykpYBUur+nnUWql5k4LpxNdYe6M3XNMGxKgUkkDp4Fz
         SAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NVLzievBgAW2kTNQ4IEdhARg8wdn1fX0hhOxE5e3+74=;
        b=izfW8XYNnCR9IbgpajLBcXuC2/2J+tx75+aUIAwrP4OqV6cmy5Ulq+JtRlLe62/ek4
         /b1rQtQvNxC1U5LOZquy8BBT+Px2k2rS5n2X/JpcdBnkArxPm5HOzi4yS7hw7Gp9QxWD
         K63CZvToE6h5+OHjcWa955RDjWH73M+A6NyfeXu9f3bBZ4sGTVAu42jxccFyhiS8V7jr
         xZicQGcaE9puNh172iUGpcZCmOKY9ToBxUB3zJL/morUfYgBz0+h9tdTRQUoHVlOnuiU
         tzZRTvgUa6ikZdqYWNfQT17bfrWDOJOfwMxylmBQGD2orZWcBi0rTQQThPNS/B4tbSsA
         CyJQ==
X-Gm-Message-State: APjAAAUZyggHQ2Np0cD975vU8Bc+WoaJ8hisZyjJH1dj7zEDXveEeDhv
        4QyHuTVJrHePeAmDI1N75dZ7jxn/8QxMrg==
X-Google-Smtp-Source: APXvYqxL6PmLuB36DChPLNPqejwMve0KfCx5pZgv1HkmNYQcHxAHvTB1jjrdTdLUgfkizEIKdFoX0w==
X-Received: by 2002:aa7:93bb:: with SMTP id x27mr19445645pff.10.1564093138071;
        Thu, 25 Jul 2019 15:18:58 -0700 (PDT)
Received: from localhost ([49.248.170.216])
        by smtp.gmail.com with ESMTPSA id c130sm49074069pfc.184.2019.07.25.15.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 15:18:57 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     marc.w.gonzalez@free.fr, masneyb@onstation.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 00/15] thermal: qcom: tsens: Add interrupt support
Date:   Fri, 26 Jul 2019 03:48:35 +0530
Message-Id: <cover.1564091601.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt support to TSENS. The first 6 patches are general fixes and
cleanups to the driver before interrupt support is introduced.

This series has been developed against qcs404 and sdm845 and then tested on
msm8916. Testing on msm8998 and msm8974 would be appreciated since I don't
have hardware handy. Further, I plan to test on msm8996 and also submit to
kernelci.

I'm sending this out for more review to get help with testing.

Amit Kucheria (15):
  drivers: thermal: tsens: Get rid of id field in tsens_sensor
  drivers: thermal: tsens: Simplify code flow in tsens_probe
  drivers: thermal: tsens: Add __func__ identifier to debug statements
  drivers: thermal: tsens: Add debugfs support
  arm: dts: msm8974: thermal: Add thermal zones for each sensor
  arm64: dts: msm8916: thermal: Fixup HW ids for cpu sensors
  dt: thermal: tsens: Document interrupt support in tsens driver
  arm64: dts: sdm845: thermal: Add interrupt support
  arm64: dts: msm8996: thermal: Add interrupt support
  arm64: dts: msm8998: thermal: Add interrupt support
  arm64: dts: qcs404: thermal: Add interrupt support
  arm64: dts: msm8974: thermal: Add interrupt support
  arm64: dts: msm8916: thermal: Add interrupt support
  drivers: thermal: tsens: Create function to return sign-extended
    temperature
  drivers: thermal: tsens: Add interrupt support

 .../bindings/thermal/qcom-tsens.txt           |   5 +
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 108 +++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  26 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  60 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  82 +--
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  42 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  88 +--
 drivers/thermal/qcom/tsens-8960.c             |   4 +-
 drivers/thermal/qcom/tsens-common.c           | 610 +++++++++++++++++-
 drivers/thermal/qcom/tsens-v0_1.c             |  11 +
 drivers/thermal/qcom/tsens-v1.c               |  29 +
 drivers/thermal/qcom/tsens-v2.c               |  18 +
 drivers/thermal/qcom/tsens.c                  |  52 +-
 drivers/thermal/qcom/tsens.h                  | 285 +++++++-
 14 files changed, 1214 insertions(+), 206 deletions(-)

-- 
2.17.1

