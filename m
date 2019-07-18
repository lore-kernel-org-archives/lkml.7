Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E85C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0CA21841
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI5+xloA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390163AbfGRMQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 08:16:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42137 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRMQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:16:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so13451720wrr.9;
        Thu, 18 Jul 2019 05:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HlKgdAFzp18sETE1uDUVicMGRgYUwku23fLq36LfrKo=;
        b=PI5+xloAJufCBhwAGyxRbfL4TwEOinM7rEWJhL5tQhF7gL75dcwscoNH3SuhECb2kH
         V3KOiIEXFTUFOcOMoREj3YNwFu/q03NnYg5V+ACIAeloEY05ADjFPtRH2Br58TpTFd7i
         wDYTIhfBxuiDYAAOkyGTufbU0bdrmTl4PJ03ybIogGU1VrMN+kwfpnZEqia6y1ypCXyc
         6XbN8F4d1dKCWOyxV+cdd1aTAm2Sl9jNGHwZQA0/X/bAdO/hlL/ShDesqgQzh2/Fy3Yw
         iCoShhyVpf6mCWugD5gpY0/5r4/CpbJksYX6SUrgHTwd0KfN+Tai0ahYkT8rJYzy1CNi
         Z/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HlKgdAFzp18sETE1uDUVicMGRgYUwku23fLq36LfrKo=;
        b=aM/V1ClCSk2LnODxOU+zZSRBvExexuyrehs053SY4W4qmhg+3EErOFarb9SLNoP43n
         IarNlqTMhIIgVgXtl+jj7tfAAymNvQFdiLTRPWpjsUgAvnwgdZtbI6MLN9AO1zPVj97f
         vs1qIJAYf8m2o0JJB8VmwsKTCXTHizK/MvcwFgyOovp89EB922mAMxzokyULbY1tePzC
         C+zqVI3LDWdcr1eyMKwNTDHjMTOaobnHGzd6OVZEpLqmHd3hnWPpFzNg6x/7+0Zj8j1A
         lI56Mq5t7XZGpPa+SsW3cHcPtEiyKb2n8fycLGCEyOkxwQ9LsDkWL70QAG0S4RmifOty
         5GsA==
X-Gm-Message-State: APjAAAXK7VLQg1bwKFX8aGd9VYJOua8+gyg/5rkIvLcmzUW2Hz/WQEYD
        xPVAoc7KLU86CUsRsHSORK0=
X-Google-Smtp-Source: APXvYqx2Vrkyj853VRaFPhtIGDn21ERmcu8ofvYr0lb7++IeNlIdeINLTBFtoYlWTCac/x3BBu0zvQ==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr51486358wrs.93.1563452209900;
        Thu, 18 Jul 2019 05:16:49 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id f17sm22897463wmf.27.2019.07.18.05.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 05:16:49 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        u.kleine-koenig@pengutronix.de, aisheng.dong@nxp.com,
        andradanciu1997@gmail.com, leoyang.li@nxp.com, festevam@gmail.com,
        sriram.dash@nxp.com, l.stach@pengutronix.de, pankaj.bansal@nxp.com,
        ping.bai@nxp.com, pramod.kumar_1@nxp.com, bhaskar.upadhaya@nxp.com,
        richard.hu@technexion.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add basic support for pico-pi-imx8m
Date:   Thu, 18 Jul 2019 15:16:26 +0300
Message-Id: <20190718121628.23991-1-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TechNexion PICO-PI-IMX8M based on patches from Richard Hu
Datasheet is at: https://s3.us-east-2.amazonaws.com/technexion/datasheets/picopiimx8m.pdf

Changes since v2:
 - changed PICO-PI-8M bord compatible from wand,imx8mq-pico-pi to
   technexion,pico-pi-imx8m
 - removed bootargs property
 - removed regulators node and put fixed regulator directly under root node
 - changed node name from usb_otg_vbus to regulator-usb-otg-vbus
 - removed pinctrl-names property from iomuxc node
 - removed wand-pi-8m container node
 - sorted pinctrl nodes alphabetically
 - removed tusb320_irqgrp, tusb320_irqgrp nodes because there is no upstream
   driver
 - changed properties' order in usb_dwc3_1 node

Changes since v1:
 - renamed wandboard-pi-8m.dts to pico-pi-8m.dts
 - removed pinctrl_csi1, pinctrl_wifi_ctrl
 - used generic name for pmic
 - removed gpo node
 - delete regulator-virtuals node
 - remove always-on property from buck1-8 and ldo3-7
 - remove pmic-buck-uses-i2c-dvs property for buck1-4

Andra Danciu (1):
  dt-bindings: arm: fsl: Add the pico-pi-imx8m board

Richard Hu (1):
  arm64: dts: fsl: pico-pi: Add a device tree for the PICO-PI-IMX8M

 Documentation/devicetree/bindings/arm/fsl.yaml |   1 +
 arch/arm64/boot/dts/freescale/Makefile         |   1 +
 arch/arm64/boot/dts/freescale/pico-pi-8m.dts   | 417 +++++++++++++++++++++++++
 3 files changed, 419 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/pico-pi-8m.dts

-- 
2.11.0

