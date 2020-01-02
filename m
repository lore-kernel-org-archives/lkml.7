Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE42FC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 01:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1EE22314
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 01:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgABB1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 20:27:19 -0500
Received: from foss.arm.com ([217.140.110.172]:43500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgABB1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 20:27:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C33C31B;
        Wed,  1 Jan 2020 17:27:18 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6A423F703;
        Wed,  1 Jan 2020 17:27:16 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/3] ARM: dts: sun8i: R40: DT fixes and updates
Date:   Thu,  2 Jan 2020 01:26:54 +0000
Message-Id: <20200102012657.9278-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

some changes I made to the R40 .dtsi when playing around with a
Bananapi M2 Berry board:
- The GICC region is wrongly reported as 4K only, preventing KVM
  from using its VGIC emulation.
- The PMU node is missing, similar story as with the other SoCs: this
  time the SPI numbers are not even mentioned in the manual.
- I hooked up a SPI flash to the PortC SPI0 header pins (from which
  the board can even boot from). So patch 3 adds the SPI nodes and its
  pinmux setup, in case people need this for their peripherals.

Please have a look and apply!

Cheers,
Andre.

Andre Przywara (3):
  ARM: dts: sun8i: R40: Upgrade GICC reg size to 8K
  ARM: dts: sun8i: R40: Add PMU node
  ARM: dts: sun8i: R40: Add SPI controllers nodes and pinmuxes

 arch/arm/boot/dts/sun8i-r40.dtsi | 108 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 5 deletions(-)

-- 
2.14.5

