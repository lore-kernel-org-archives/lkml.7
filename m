Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06259C74A25
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2FC2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfGJNoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:44:13 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:37245 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfGJNoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:44:13 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 3A60CFF81A;
        Wed, 10 Jul 2019 13:44:09 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>,
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
Subject: [PATCH v7 0/6] Add CPU clock support for Armada 7K/8K
Date:   Wed, 10 Jul 2019 15:43:40 +0200
Message-Id: <20190710134346.30239-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is the seventh version of a series allowing to manage the cpu
clock for Armada 7K/8K.

For these SoCs, the CPUs share the same clock by cluster, so actually
the clock management is done at cluster level.

As for the other Armada 7K/8K clocks it is possible to have multiple
AP so here again we need to have unique name: the purpose of the second
patch is to share a common code which will be used in 3 drivers.

The last 2 patch enable the driver at dt and platform level and will
be applied through the mvebu subsystem.

Changelog v6->v7:

   - Update binding documentation for the AP clock to mention that
     they expose reference clocks for the cluster to make distinction
     with the cluster clocks themselves exposed by the cpu clock.

   - Add precision on the number of parent clock in the binding
     documentation.

   - Also fix the example by using the reg address in the node name.

Changelog v5->v6:

   - Restraint the reg property for the child node to not overlap the
     other node.
   - Give a specific compatible to ap_syscon1.

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

 .../arm/marvell/ap806-system-controller.txt   |  31 ++-
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
 11 files changed, 365 insertions(+), 44 deletions(-)
 create mode 100644 drivers/clk/mvebu/ap-cpu-clk.c
 create mode 100644 drivers/clk/mvebu/armada_ap_cp_helper.c
 create mode 100644 drivers/clk/mvebu/armada_ap_cp_helper.h

-- 
2.20.1

