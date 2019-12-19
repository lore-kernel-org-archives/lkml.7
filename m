Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89949C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5422A2467E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="i0v3MR1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfLSUVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:21:42 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:32538 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSUVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576786899;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=uGv1v4RMpZCWpTzrH/Tb+ANnm7EcldYwO4ikQvEyIyE=;
        b=i0v3MR1KsnYnadA1lkCgTpopbKZO9S7CdFtcYWDN+GI2BJHCe6e2UIhEs/NErEj8z2
        ZkeSS1xGshUDnSfaVTDGoK2WD5H0yTAOIAZi/8E0Xe3IDvCKQkzUz0iS4r43+bgBCsAA
        kgWB6sy488+KQrIWVVOOZMQXv+G/hyUzj7k2TmbtfJfaLoe3xM8eRpSRBouZofpEHbUo
        KSgQKuG9Eg6lx1uLUKRV51XYQ873krOs7aNiobLgJhzwHNlQSrkAvN7p5gtjWkn/QHHu
        ae/2Ohjm8llUTVVK8fy6jXamT48DUtuj8o24lBiGfyLnUx23teJkm4MB9JeeyCj3X5GR
        xpdQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXtszvsxM1"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.1.1 AUTH)
        with ESMTPSA id f021e2vBJKLb3Z7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 19 Dec 2019 21:21:37 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/9] Add device tree for Samsung Galaxy S III mini (GT-I8190)
Date:   Thu, 19 Dec 2019 21:20:43 +0100
Message-Id: <20191219202052.19039-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds initial support for booting mainline on
the Samsung Galaxy S III mini (GT-I8190), codename: "samsung-golden".
samsung-golden uses the Ux500 SoC, which has great support in mainline.

This is a project I have been working on for about an half year
in collaboration with Linus Walleij, who answered a sheer countless
amount of my questions. Thanks! :)

Stephan Gerhold (9):
  ARM: dts: ux500: Remove unused ste-href-ab8505.dtsi
  ARM: dts: ux500: Add device tree include for AB8505
  dt-bindings: arm: ux500: Document samsung,golden compatible
  ARM: dts: ux500: Add device tree for Samsung Galaxy S III mini
    (GT-I8190)
  ARM: dts: ux500: samsung-golden: Add IMU (accelerometer + gyroscope)
  ARM: dts: ux500: samsung-golden: Add touch screen
  ARM: dts: ux500: samsung-golden: Add WiFi
  ARM: dts: ux500: samsung-golden: Add Bluetooth
  ARM: defconfig: u8500: Enable new drivers for samsung-golden

 .../devicetree/bindings/arm/ux500.yaml        |   5 +
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/ste-ab8505.dtsi             | 275 +++++++++++
 arch/arm/boot/dts/ste-href-ab8505.dtsi        | 234 ---------
 .../arm/boot/dts/ste-ux500-samsung-golden.dts | 455 ++++++++++++++++++
 arch/arm/configs/u8500_defconfig              |   9 +
 6 files changed, 746 insertions(+), 235 deletions(-)
 create mode 100644 arch/arm/boot/dts/ste-ab8505.dtsi
 delete mode 100644 arch/arm/boot/dts/ste-href-ab8505.dtsi
 create mode 100644 arch/arm/boot/dts/ste-ux500-samsung-golden.dts

-- 
2.24.1

