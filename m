Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E72BC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E832070E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfKMRPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:15:13 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45543 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfKMRPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:15:13 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 3E329E0007;
        Wed, 13 Nov 2019 17:15:07 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 0/4] MTD concat
Date:   Wed, 13 Nov 2019 18:15:01 +0100
Message-Id: <20191113171505.26128-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A year ago Bernhard Frauendienst started an effort to bring MTD
devices concatenation generic [1]. Today I also need this
concatenation to be possible in order to support configurations where
two MTD devices are treated like one bigger in order to be able to
define partitions across chip boundaries, hence reviving this
patchset.

After having talked with Mark Brown and Boris Brezillon this approach
seems to be the cleanest and easiest one. If discussions need to
happen, it is probably on the dt-bindings file where I tried to
summarize the issue and the possible solutions in the commit log.

I changed a bit the code logic and style but not so much, all the
changes with the 2018 version are in [ ] in the commit logs.

I would like to add another way to concatenate devices: with module
parameters/arguments on the cmdline. I will extend this work once the
bindings will have been discussed and accepted.

Thanks,
Miquèl

[1] https://lwn.net/ml/linux-kernel/20180907173515.19990-1-kernel@nospam.obeliks.de/


Bernhard Frauendienst (3):
  mtd: Add get_mtd_device_by_node() helper
  dt-bindings: mtd: Describe mtd-concat devices
  mtd: Add driver for concatenating devices

Miquel Raynal (1):
  mtd: concat: Fix a comment referring to an unknown symbol

 .../devicetree/bindings/mtd/mtd-concat.yaml   |  56 ++++++++
 drivers/mtd/Kconfig                           |   8 ++
 drivers/mtd/Makefile                          |   1 +
 drivers/mtd/mtd_virt_concat.c                 | 132 ++++++++++++++++++
 drivers/mtd/mtdconcat.c                       |   5 +-
 drivers/mtd/mtdcore.c                         |  38 +++++
 include/linux/mtd/mtd.h                       |   2 +
 7 files changed, 238 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtd-concat.yaml
 create mode 100644 drivers/mtd/mtd_virt_concat.c

-- 
2.20.1

