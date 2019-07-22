Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4074C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57A421897
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thLDftGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfGVK1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:27:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34527 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfGVK1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:27:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so38877985wrm.1;
        Mon, 22 Jul 2019 03:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O1NaI+e167gwqp1nbI+Zw4QE6pCqjybTcpuP6XfDCIw=;
        b=thLDftGmHKLnBj5QnR1d2+Vbfmk8FQ7L68PDST3PbFkzu8WNFsZUACurPi27NsjEjI
         E00CIuQXpOWTgNAWd39DIoPgiU+l5o/qU47v6byjEdXgVjHmcSp+u6SLDb2W3QKxBjp3
         8xJTLB9ytSP7JyBd/tRAuaUDBx6m5/Fc3LUdaFu84tSspGPirhMtT7sQf/NzTnNJQ6X/
         cRcIa1aQT++/5sW0xXDrNsl6X6RgS2cqwM+88F5h4evYSmYLcxV3WVYoR76ILaJETQAn
         In4B+RWbXDc8KVwQMw0Y0n73WcdW5SYOB6Avni/Pw+GT3hYAtx7fXoSBjIA4MGGmnu+1
         WAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O1NaI+e167gwqp1nbI+Zw4QE6pCqjybTcpuP6XfDCIw=;
        b=tA3C3PKHZlWO6Z7maOoJmjvoRY0kQP70oOuqNiKjQxJL8QJZqH3IguzIkYULtF+ZjQ
         o4b0va5awu+M8vmP18fwzBtj7k0GKAgWPxJnsat1KrqxLJpYAa26TOX8fxhgNWQ18Nqt
         jNSVdiLhz2/IDLrwmYO81uB1FOwEqaalE/vFCK8/g1dpUKCmE+BOrJqjeEtZpWKIfjVD
         lrumpr7+hum0vMrPkFIKclFWEBUwNLX1/lLS7g3cCU0nuzLt4//U7x2wcCZCfbkIXQp5
         qPOAcQZjx6asbsM27E8OvSf8/axT8kOy5kRwSt5WnlCKawn/CsGb294pEBGD+Upri6oe
         MoUg==
X-Gm-Message-State: APjAAAVzN18Qj5ZcCKDppfyyyNXOLLr7JKp2GF52sToVJju9uHSSXHNy
        qECUxbHiHWSdBYQu19AKadQ=
X-Google-Smtp-Source: APXvYqw8KaHNWY+yHPA2KIxFuie1Vc/IBYqd9mApKV+7G+3KDcScbci3+uU0LXIqGdEPbIaBSPPHdw==
X-Received: by 2002:adf:f206:: with SMTP id p6mr849488wro.216.1563791272953;
        Mon, 22 Jul 2019 03:27:52 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id o7sm34515181wmf.43.2019.07.22.03.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 03:27:52 -0700 (PDT)
From:   andradanciu1997 <andradanciu1997@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        Michal.Vokac@ysoft.com, ping.bai@nxp.com,
        u.kleine-koenig@pengutronix.de, leoyang.li@nxp.com,
        aisheng.dong@nxp.com, l.stach@pengutronix.de,
        pankaj.bansal@nxp.com, angus@akkea.ca, pramod.kumar_1@nxp.com,
        bhaskar.upadhaya@nxp.com, vabhav.sharma@nxp.com,
        andradanciu1997@gmail.com, richard.hu@technexion.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 0/2] Add basic support for pico-pi-imx8m
Date:   Mon, 22 Jul 2019 13:27:28 +0300
Message-Id: <20190722102730.15763-1-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TechNexion PICO-PI-IMX8M based on patches from Richard Hu
Datasheet is at: https://s3.us-east-2.amazonaws.com/technexion/datasheets/picopiimx8m.pdf

Changes since v5:
 - removed comment /* PMIC BD71837 PMIC_nINT GPIO1_IO12 */
 - added "Reviewed-by" tags

Changes since v4:
 - removed #address-cells and  #size-cells from regulators node

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
 arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts | 413 +++++++++++++++++++++++
 3 files changed, 415 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts

-- 
2.11.0

