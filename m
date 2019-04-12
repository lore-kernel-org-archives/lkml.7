Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AE6C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4587420652
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="qNBillmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfDLMHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:07:34 -0400
Received: from vps.xff.cz ([195.181.215.36]:36266 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfDLMHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1555070851; bh=IcfFAAQX97LzQohXDRrWYm6n9WHbCZodqxmuciTySWw=;
        h=From:To:Cc:Subject:Date:From;
        b=qNBillmgiitA/aE9aH0hRWLkVwBgTy+Q2amrxvCnQamsxrZnb/7wtNPTZM+Y08QkZ
         ExGmktrcYRSj9Dx2lZhaoNhwtU0uUFzKSQY1PmSp53EuWlrLAsGZDe/uHfaoR0FY5s
         fpk64ZqPT9giTCYNRM8X431LTlwtIXEP1I2EIo+k=
From:   megous@megous.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 0/3] Add basic support for RTC on Allwinner H6 SoC
Date:   Fri, 12 Apr 2019 14:07:27 +0200
Message-Id: <20190412120730.473-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

I went through the datasheets for H6 and H5, and compared the differences.
RTCs are largely similar, but not entirely compatible. Incompatibilities
are in details not yet implemented by the rtc driver though.

I also corrected the clock tree in H6 DTSI.

There's a small detail here, that's not described absolutely correctly in
DTSI, but the difference is not really that material. ext_osc32k is
originally modelled as a fixed clock that feeds into RTC module, but in
reality it's the RTC module that implements via its registers enabling and
disabling of this oscillator/clock.

Though:
- there's no other possible user of ext_osc32k than RTC module
- there's no other possible external configuration for the crystal
  circuit that would need to be handled in the dts per board

So I guess, while the description is not perfect, this patch series still
improves the current situation. Or maybe I'm misunderstanding something,
and &ext_osc32k node just describes a fact that there's a crystal on
the board. Then, everything is perhaps fine. :)

For now, the enable bit for this oscillator is toggled by the re-parenting
code automatically, as needed.

This patchset is necessary for implementing the WiFi/Bluetooth support
on boards using H6 SoC.

Please take a look.

Thank you and regards,
  Ondrej Jirman

Ondrej Jirman (3):
  dt-bindings: Add compatible for H6 RTC
  rtc: sun6i: Add support for H6 RTC
  arm64: dts: sun50i-h6: Add support for RTC and fix the clock tree

 .../devicetree/bindings/rtc/sun6i-rtc.txt     |  1 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 30 +++++++-------
 drivers/rtc/rtc-sun6i.c                       | 40 ++++++++++++++++++-
 3 files changed, 55 insertions(+), 16 deletions(-)

-- 
2.21.0

