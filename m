Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2626C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2D92075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="ooQ5uocF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbfC0A1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:27:36 -0400
Received: from vps.xff.cz ([195.181.215.36]:53778 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727500AbfC0A1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553645934; bh=I5izUN897qvaOczp6yBx+0t770iPxiAokH6P0jHUEoI=;
        h=From:To:Cc:Subject:Date:From;
        b=ooQ5uocFFFjo4IyiBqhMJzyI8nmeYR7vguZR9/xM1DqhglIXx6R+oxmg2LLy7pFPX
         vi6xd5jUJQXzDyO+KUEgSEnrvNnVlQ/0ZdOjI2MoNuAPCneGXfrIp1m5F6eoHHfQUN
         XWlAGyVtZA+dcd4hdI/JztHQxGkj5c5GUbHX8lkQ=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 0/7] Add bluetooth, gps and accelerometer to TBS A711
Date:   Wed, 27 Mar 2019 01:18:36 +0100
Message-Id: <20190327001843.2420-1-megous@megous.com>
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

Ondrej Jirman (7):
  ARM: dts: sun8i: tbs-a711: Enable bluetooth
  ARM: dts: sun8i: tbs-a711: Add node for BMA250 accelerometer
  ARM: dts: sun8i: a83t: Add nodes for UART2-UART4
  ARM: dts: sun8i: a83t: Add UART2 PB pins
  gnss: Add u-blox,neo-6m compatible
  dt-bindings: gnss: Add u-blox,neo-6m compatible
  ARM: dts: sun8i: tbs-a711: Enable UART2 (for NEO-6M GPS module)

 .../devicetree/bindings/gnss/u-blox.txt       |  1 +
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts     | 49 +++++++++++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi             | 38 ++++++++++++++
 drivers/gnss/ubx.c                            |  1 +
 4 files changed, 89 insertions(+)

-- 
2.21.0

