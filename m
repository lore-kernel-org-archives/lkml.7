Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C12DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC62206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="iuPg2zX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfDAL4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:56:22 -0400
Received: from vps.xff.cz ([195.181.215.36]:57728 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDAL4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1554119779; bh=bxuBeVnSIfMTqGV0TMQjmEOwQOQrwjdZKZV67XXxtdY=;
        h=From:To:Cc:Subject:Date:From;
        b=iuPg2zX7OgrINVFdEA30/QaqmzyTI4XKk9qwgW3NnZGwaJxFyIiu/LxCeBbv4+sks
         LpQZVoiww2jxijttx3Oc9U/mpvZ0hu6nP1zeHxz5GwHS9CXRe/GDrbOXu/OoZTdy66
         IrxhkVxRgdMUypNxd6kvYdjJxCaaT96In0gCxTZU=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 0/5] Add bluetooth, gps and accelerometer to TBS A711
Date:   Mon,  1 Apr 2019 13:56:11 +0200
Message-Id: <20190401115616.21337-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

This series enables some peripherals on TBS A711 tablet that already
have mainline drivers:

- GPS u-blox neo-6m (via gnss u-blox driver)
- Bluetooth (via recently added OF support in the Broadcom
  bluetooth driver)
- Accelermomter BMA-250 (hooked to the I2C bus)

It also modifies A83T DTSI and adds missing UART interfaces.

I've added additional compatible to the gnss/u-blox driver for NEO-6M,
because this board uses this module, and I don't think I can use
the existing compatible for u-blox,neo-m8, even as a fallback.

Please take a look, and apply the patches if you have no objections.

Many of the patches will go through the sunxi tree, but I'm not
sure who will want to take the GPS patches.

regards,
  Ondrej Jirman


Changes in v2:
- dropped already applied patches from the series (bluetooth,
  a83t uarts)
- added /omit-if-no-ref/ to "uart2-pb-pins"
- renamed node "bma250" to "accelerometer"
- removed pinctrl properties that are already in base dtsi
  (i2c1_pins)

Ondrej Jirman (5):
  ARM: dts: sun8i: tbs-a711: Add node for BMA250 accelerometer
  ARM: dts: sun8i: a83t: Add UART2 PB pins
  gnss: Add u-blox,neo-6m compatible
  dt-bindings: gnss: Add u-blox,neo-6m compatible
  ARM: dts: sun8i: tbs-a711: Enable UART2 (for NEO-6M GPS module)

 .../devicetree/bindings/gnss/u-blox.txt       |  1 +
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts     | 34 +++++++++++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  6 ++++
 drivers/gnss/ubx.c                            |  1 +
 4 files changed, 42 insertions(+)

-- 
2.21.0

