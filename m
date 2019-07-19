Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA21C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33932173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVStTN9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfGSMOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:14:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47030 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfGSMOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:14:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so32018362wru.13;
        Fri, 19 Jul 2019 05:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wmETNdP8G4IomK6UdNByAWasEGXpLpu0D66rsobKPls=;
        b=lVStTN9LxMvaF3HLQiIoaRpoAHy2uYjWyTEQ5UAU8MCqeh5e3EhPpC2uG+mRAkv5rk
         NR0HRS1l1Tgrhjx/s6O38KKl1bYJbQecSBHTQJrRD/Jd7BF2ul/noqpKRsAdcqA185Xh
         EFCsuGBkjxVLIQ239cCNYLCMTJDG627NuEnrONnAs7uWuaOuUd9UEBBNqYJ34ENcRnOT
         /wqUpls/N0E/GuVhiiocrnK+Jdz3U6UWMFgt8u5xL0dX18x2HOy25vN86zke9fDJ/pMK
         BGqNDUA4WoSRBxcKG/SMuPswzSOJDlqUknAqovuzdv7MEJ7wysS4o5w3GODPy3PAssxc
         wnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wmETNdP8G4IomK6UdNByAWasEGXpLpu0D66rsobKPls=;
        b=LoLLuhKpiOWFItSUDuYm3s/aB81mImhNoJsFrkT8RuKOM36Y1bD4e0i8MMrAaL0shz
         4Jt4WLdDW80bzyfjJdkZZQg02zk2+pT9BEjaIU8AeW77HPpPF2sBFe7bKq2Mxhd9+0HJ
         xCrQhmXXydUc7Yu5xI5ZquCbGeze2kKZM3z9qAvwIaUqI6s9uSJ9AFqQGw4XIIIySsYH
         k5cTLlSMZ5rz+nGa2rvjHLPe8K6UDknk67mb4LC7p//nGI1xfDKqBuUFBlxlp16pj4hW
         utOxzHhibSUi/oA+zZMf6+pBsVXjFmGNo/Kw6s+2lyv+ekeJyoNGZy/I3yfQHA52lACS
         1PHQ==
X-Gm-Message-State: APjAAAXdmN4SVIwMiSTp9ImrPzljcSZjNaWmgI8iv+UxiP7T0ewMxXFO
        iDvs2FS/0CScMZiZ7xRfajE=
X-Google-Smtp-Source: APXvYqxk5QuuVR5lXOLPTqmA0tHUgcecgIlI/ixpqMS3k1E8fLqpCMSKDN2mww5m5DioeAB18LmQsQ==
X-Received: by 2002:a5d:6949:: with SMTP id r9mr53174197wrw.73.1563538486503;
        Fri, 19 Jul 2019 05:14:46 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id y18sm30135261wmi.23.2019.07.19.05.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 05:14:45 -0700 (PDT)
From:   andradanciu1997 <andradanciu1997@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        j.neuschaefer@gmx.net, andradanciu1997@gmail.com,
        aisheng.dong@nxp.com, leoyang.li@nxp.com, l.stach@pengutronix.de,
        pankaj.bansal@nxp.com, bhaskar.upadhaya@nxp.com,
        pramod.kumar_1@nxp.com, angus@akkea.ca, richard.hu@technexion.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/2] Add basic support for pico-pi-imx8m
Date:   Fri, 19 Jul 2019 15:14:28 +0300
Message-Id: <20190719121430.9318-1-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TechNexion PICO-PI-IMX8M based on patches from Richard Hu
Datasheet is at: https://s3.us-east-2.amazonaws.com/technexion/datasheets/picopiimx8m.pdf

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
 arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts | 414 +++++++++++++++++++++++
 3 files changed, 416 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts

-- 
2.11.0

