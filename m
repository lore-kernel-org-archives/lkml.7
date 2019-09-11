Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2B8ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81C92089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFGSzct6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfIKHQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:16:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45811 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfIKHQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:16:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so13058106pfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qUxVco5+9ktkoNCi0Mi64R9yup9qLyKawGp7kQ7ed2w=;
        b=HFGSzct6wcdfRhoSXr4x1ifFQAt+kMTqekWwXS6k2NfgZj9w5KBMQZYa/T2W7mmK28
         yLrVs/h+VFNkNcx6TtF4LZmHNRuniUy4MX6M0sSCq13mL8WWNlbuBDv3kvKJTm97XvV0
         zCbE9oQDQfUoC7ezO3TgjdW+MOcv4QsdbIbEjb2ziUMCJDgg9zQmZJ5ImnisNzk9sSVY
         WiLZAwnvmjbeXimxHb6q7s+bKsDO+MhGyR/TW7A61HtD2qTGgNdQCtndZXgk1MxfZGbJ
         UFNxJfeRZdgmvBZ00BnmAVgYpKjjHa2rNtCMYmeEWSv1KWKpm59y8cCRwFyoJY0FtnKi
         Vx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qUxVco5+9ktkoNCi0Mi64R9yup9qLyKawGp7kQ7ed2w=;
        b=Z3oItzvx30gKN2G/tpHRqZZczQOMcI13Ky78QWcyA5pF2oFtI5xcr5PDKQGzsJwoxm
         cKrM9av3M8aFyvkojgCdJ8g57Fxdugih0avj06sIJ3E2gCQ8JJGl8Iq+BZmHv56WxFRC
         BN+n7tEsxl8axFaUB2grveVR+lBrxZrpXKGkrHRPv8BJOX9gsq23FUHo6+LMP3SklKyx
         CzwQxmZCaY0bt/Y+qrU3w+4kgBk0U+nlKi9dk84KEn3oXbHI5wEqRBLzpjIGViBBlLy/
         hGucRleOUWOj9DPCuBhhLzs3EdJvq9gxe/Jn/Erlt6+gt7Gq2TRWS1aCjts267hsPVsH
         3bWw==
X-Gm-Message-State: APjAAAUy5+hjj/+Q2Z4Zz/jl7s13POx3XXcnVg4ANrcG+ilrUwr29kCp
        GAEdDv+phCuYriD2l8u4hxtdaaQuNQ/p+A==
X-Google-Smtp-Source: APXvYqwIwlbCdDcjnWBcmrrRCBki67IYc6HmBfZIKB+VpmUNhcS8cnxox+j8Ctb9q2YUlHKloGPOFw==
X-Received: by 2002:a17:90a:8509:: with SMTP id l9mr3834867pjn.10.1568186200477;
        Wed, 11 Sep 2019 00:16:40 -0700 (PDT)
Received: from localhost ([49.248.201.118])
        by smtp.gmail.com with ESMTPSA id c2sm21933784pfd.66.2019.09.11.00.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 00:16:39 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 00/15] thermal: qcom: tsens: Add interrupt support
Date:   Wed, 11 Sep 2019 12:46:17 +0530
Message-Id: <cover.1568185732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
- Addressed Stephen's review comment
- Moved the dt-bindings to yaml (This throws up some new warnings in various QCOM
devicetrees. I'll send out a separate series to fix them up)
- Collected reviews and acks
- Added the dt-bindings to MAINTAINERS

Changes since v1:
- Collected reviews and acks
- Addressed Stephen's review comments (hopefully I got them all).
- Completely removed critical interrupt infrastructure from this series.
  Will post that separately.
- Fixed a bug in sign-extension of temperature.
- Fixed DT bindings to use the name of the interrupt e.g. "uplow" and use
  platform_get_irq_byname().

Add interrupt support to TSENS. The first 6 patches are general fixes and
cleanups to the driver before interrupt support is introduced.

This series has been developed against qcs404 and sdm845 and then tested on
msm8916 and msm8974 (Thanks Brian). Testing on msm8998 would be appreciated since I don't
have hardware handy.

Amit Kucheria (15):
  drivers: thermal: tsens: Get rid of id field in tsens_sensor
  drivers: thermal: tsens: Simplify code flow in tsens_probe
  drivers: thermal: tsens: Add __func__ identifier to debug statements
  drivers: thermal: tsens: Add debugfs support
  arm: dts: msm8974: thermal: Add thermal zones for each sensor
  arm64: dts: msm8916: thermal: Fixup HW ids for cpu sensors
  dt-bindings: thermal: tsens: Convert over to a yaml schema
  arm64: dts: sdm845: thermal: Add interrupt support
  arm64: dts: msm8996: thermal: Add interrupt support
  arm64: dts: msm8998: thermal: Add interrupt support
  arm64: dts: qcs404: thermal: Add interrupt support
  arm: dts: msm8974: thermal: Add interrupt support
  arm64: dts: msm8916: thermal: Add interrupt support
  drivers: thermal: tsens: Create function to return sign-extended
    temperature
  drivers: thermal: tsens: Add interrupt support

 .../bindings/thermal/qcom-tsens.txt           |  55 --
 .../bindings/thermal/qcom-tsens.yaml          | 174 ++++++
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 108 +++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  26 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  60 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  82 +--
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  42 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  88 +--
 drivers/thermal/qcom/tsens-8960.c             |   4 +-
 drivers/thermal/qcom/tsens-common.c           | 529 ++++++++++++++++--
 drivers/thermal/qcom/tsens-v0_1.c             |  11 +
 drivers/thermal/qcom/tsens-v1.c               |  29 +
 drivers/thermal/qcom/tsens-v2.c               |  13 +
 drivers/thermal/qcom/tsens.c                  |  58 +-
 drivers/thermal/qcom/tsens.h                  | 286 ++++++++--
 16 files changed, 1254 insertions(+), 312 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml

-- 
2.17.1

