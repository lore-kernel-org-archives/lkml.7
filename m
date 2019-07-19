Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBF1C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7589D2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUFXT19k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfGSKs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 06:48:27 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:34156 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfGSKs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:48:26 -0400
Received: by mail-wm1-f50.google.com with SMTP id w9so23447873wmd.1;
        Fri, 19 Jul 2019 03:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=R5IjW3oGqQUq2Up+LhsQmfFvBYfe7qjR4zv8CoQiT3g=;
        b=PUFXT19kUMbTrbKT+P/Ooq6STWmP4QVWYX3TzEK60ioRCOY+okcyE/Ye7H495VxV7m
         3aJaWJ1aujmBY5GSWMvk4ZyZI3mf6edExMJngLHGU8wmSHmLrsNGYkcekQ+t/tVhQy0U
         B6abbtQay8f2toveRVzDVB/TR8jGEXtVDcbAb4s8YpfTwwAz7f4CTvKzSQNXL1NsuRlP
         xc9Q1LMX8jnO39V+U5HDErK+esl6JU7aEKDnplwOJw9j5WGmilfyZ/VXq82nYm/6L+wq
         pDKgk3xK6swBuotGcq2vKqb2hGB4SPWlgt17pvtRPZWgofQQeePudi4SFItjgDjsSlvO
         5XCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R5IjW3oGqQUq2Up+LhsQmfFvBYfe7qjR4zv8CoQiT3g=;
        b=Px8WVAdlG3BAx/gwIsVBrYvY9LBDYKe75AlKrAPn72tQH5xQPvq1VrDf01PRI1sb3G
         RGytR1QH/IDmKR19/VgQpRMMq058QMjRt2EjNcHJortIqQ+gxblVp1CiblIujPxBFyMt
         Ef48ARU2OYe4g/SYaLUir5ajqppUQNvjm19giNJIEAIK2Mo/hzYuf4dMFI5gtmRIPzy5
         Hm8CW0L5PPWHMKr/A7kabgSUe/1vZtGKXZwSCKtDSJf47d1pbCiwLd7QoQMHySv2CRf/
         lCaC9Smyc6QsCCHsYqc8ZbkRJVvTlsH41cqt1DwWLvluVra1dXYQ0wULBuiuuMVKzIoM
         uFSg==
X-Gm-Message-State: APjAAAWqB2k6yq6rHJQRtMuRUcx5mGEVTrYrGVFIMPjPt/f4RFqJQn8m
        ruvdkBYXolmTTrIHrQYde9E=
X-Google-Smtp-Source: APXvYqxVPF4ktHM35tLzJSykO3KFUi5qSeDGE9eS/cE1UXxbHInkSFMksSH+nYOmCxFeTLN0ceoqHw==
X-Received: by 2002:a1c:d185:: with SMTP id i127mr49196684wmg.63.1563533304710;
        Fri, 19 Jul 2019 03:48:24 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id j17sm39635565wrb.35.2019.07.19.03.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 03:48:24 -0700 (PDT)
From:   andradanciu1997 <andradanciu1997@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        andrew.smirnov@gmail.com, manivannan.sadhasivam@linaro.org,
        ping.bai@nxp.com, Michal.Vokac@ysoft.com, leoyang.li@nxp.com,
        sriram.dash@nxp.com, l.stach@pengutronix.de, vabhav.sharma@nxp.com,
        bhaskar.upadhaya@nxp.com, pramod.kumar_1@nxp.com,
        pankaj.bansal@nxp.com, aisheng.dong@nxp.com, angus@akkea.ca,
        richard.hu@technexion.com, andradanciu1997@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/2] Add basic support for pico-pi-imx8m
Date:   Fri, 19 Jul 2019 13:48:00 +0300
Message-Id: <20190719104802.18070-1-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TechNexion PICO-PI-IMX8M based on patches from Richard Hu
Datasheet is at: https://s3.us-east-2.amazonaws.com/technexion/datasheets/picopiimx8m.pdf

Changes since v3:
 - renamed pico-pi-8m.dts to imx8mq-pico-pi.dts
 - moved iomuxc node as the last one
 - removed pinctrl-assert-gpios property from fec1 node
 - removed at803x,led-act-blind-workaround, at803x,eee-disabled
   properties from mdio node
 - added pinctrl-names = "default" to i2c1 node
 - changed bd71837 pmic support properties according to
   Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
 - removed A53_0 node

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

 Documentation/devicetree/bindings/arm/fsl.yaml   |   1 +
 arch/arm64/boot/dts/freescale/Makefile           |   1 +
 arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts | 417 +++++++++++++++++++++++
 3 files changed, 419 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts

-- 
2.11.0

