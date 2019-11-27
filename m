Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9395FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71ED520835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfK0Kza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:55:30 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:51915 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfK0Kz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:55:28 -0500
X-Originating-IP: 90.76.211.102
Received: from localhost.localdomain (lfbn-1-2154-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id B240AFF805;
        Wed, 27 Nov 2019 10:55:25 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Bernhard Frauendienst <kernel@nospam.obeliks.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v5 1/4] dt-bindings: mtd: Describe MTD partitions concatenation
Date:   Wed, 27 Nov 2019 11:55:19 +0100
Message-Id: <20191127105522.31445-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127105522.31445-1-miquel.raynal@bootlin.com>
References: <20191127105522.31445-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main use case to concatenate MTD devices is probably SPI-NOR
flashes where the number of address bits is limited to 24, which can
access a range of 16MiB. Board manufacturers might want to double the
SPI storage size by adding a second flash asserted thanks to a second
chip selects which enhances the addressing capabilities to 25 bits,
32MiB. Having two devices for twice the size is great but without more
glue, we cannot define partition boundaries spread across the two
devices. This is the gap mtd-concat intends to address.

There are three options to describe concatenated devices:
1/ One flash chip is described in the DT with two CS;
2/ Two flash chips are described in the DT with one CS each, a virtual
   device is also created to describe the concatenation.
3/ Partitions that must be concatenated are described in the
   partitions subnodes in a specific part-concat property.

Solution 1/ presents at least 3 issues:
* The hardware description is abused;
* The concatenation only works for SPI devices (while it could be
  helpful for any MTD);
* It would require a lot of rework in the SPI core as most of the
  logic assumes there is and there always will be only one CS per
  chip.

Solution 2/ also has caveats:
* The virtual device has no hardware reality;
* Possible optimizations at the hardware level will be hard to enable
  efficiently (ie. a common direct mapping abstracted by a SPI
  memories oriented controller).

Solution 3/ is maybe better from the bindings point of view but
introduces a real mess in kernel code and the amount of boilerplate is
insane compared to solution 2. This is the one finally implemented.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/mtd/partition.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/partition.txt b/Documentation/devicetree/bindings/mtd/partition.txt
index afbbd870496d..6e3ac87ff988 100644
--- a/Documentation/devicetree/bindings/mtd/partition.txt
+++ b/Documentation/devicetree/bindings/mtd/partition.txt
@@ -61,6 +61,7 @@ Optional properties:
   clobbered.
 - lock : Do not unlock the partition at initialization time (not supported on
   all devices)
+- part-concat : List of MTD partitions phandles that should be concatenated.
 
 Examples:
 
-- 
2.20.1

