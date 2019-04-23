Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA16C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4872B20645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfDWIeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:34:17 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:38079 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDWIeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:34:16 -0400
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 56D14200012;
        Tue, 23 Apr 2019 08:34:11 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH v5 0/6] Add CPU clock support for Armada 7K/8K
Date:   Tue, 23 Apr 2019 10:33:48 +0200
Message-Id: <20190423083354.17785-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is the forth version of a series allowing to manage the cpu clock
for Armada 7K/8K. The third version was sent more than 3 months
without any relevant feedback since this end of decembe last year.

For these SoCs, the CPUs share the same clock by cluster, so actually
the clock management is done at cluster level.

As for the other Armada 7K/8K clocks it is possible to have multiple
AP so here again we need to have unique name: the purpose of the second
patch is to share a common code which will be used in 3 drivers.

The last 2 patch enable the driver at dt and platform level and will
be applied through the mvebu subsystem.

Changelog v4->v5:

 - As requested by the device tree maintainer make the reg property
   mandatory

 - Updated the device tree files accordingly with the new binding

Changelog v3->v4:
 - Rebased on v5.1-rc1
 - Mention in the binding that a reg property can be used to make the
   device tree maintainer happy in the hope that there will be finally
   a review on this patch blocking the whole series.

Changelog v2->v3:
 - Add back the first patch documenting the binding

Changelog v1->v2:
 - Header cleanup
 - Use unsigned int instead of it for cluster member of the ap_cpu_clk struct
 - Use clk_hw instead of clk
 - Use regmap_read_poll_timeout
 - Use for_each_of_cpu_node
 - Remove unnecessary WARN_ON()
 - Remove headers from armada_ap_cp_helper.h
 - Few other minor cleanup

Gregory CLEMENT (6):
  dt-bindings: ap806: add the cluster clock node in the syscon file
  clk: mvebu: add helper file for Armada AP and CP clocks
  clk: mvebu: add CPU clock driver for Armada 7K/8K
  clk: mvebu: ap806: Fix clock name for the cluster
  arm64: marvell: enable the  Armada 7K/8K CPU clk driver
  arm64: dts: marvell: Add cpu clock node on Armada 7K/8K

 .../arm/marvell/ap806-system-controller.txt   |  26 ++
 arch/arm64/Kconfig.platforms                  |   1 +
 .../boot/dts/marvell/armada-ap806-quad.dtsi   |   4 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi |   7 +
 drivers/clk/mvebu/Kconfig                     |   8 +
 drivers/clk/mvebu/Makefile                    |   2 +
 drivers/clk/mvebu/ap-cpu-clk.c                | 259 ++++++++++++++++++
 drivers/clk/mvebu/ap806-system-controller.c   |  24 +-
 drivers/clk/mvebu/armada_ap_cp_helper.c       |  30 ++
 drivers/clk/mvebu/armada_ap_cp_helper.h       |  11 +
 drivers/clk/mvebu/cp110-system-controller.c   |  32 +--
 11 files changed, 362 insertions(+), 42 deletions(-)
 create mode 100644 drivers/clk/mvebu/ap-cpu-clk.c
 create mode 100644 drivers/clk/mvebu/armada_ap_cp_helper.c
 create mode 100644 drivers/clk/mvebu/armada_ap_cp_helper.h

-- 
2.20.1

