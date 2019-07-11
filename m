Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8565BC74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F142166E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfGKPDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:03:11 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:36491 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbfGKPDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:03:10 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B75B84000B;
        Thu, 11 Jul 2019 15:03:06 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: [PATCH v2 0/4]  Add system mmu support for Armada-806
Date:   Thu, 11 Jul 2019 17:02:38 +0200
Message-Id: <20190711150242.25290-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

last year a first version of this series was submitted to add support
for IOMMU for AP806, including workaround for accessing ARM SMMU 64bit
registers[1].

For the record, AP-806 can't access SMMU registers with 64bit width,
this patches split the readq/writeq for 32bit access, due to erratanum
#582743.

Based on the feedback from Robin Murphy, I also add code ensuring that
we won't try to use AArch64 format with 32 bits acces.

It was also discussed to not use compatible but propertu to support
this workaround. I agree to make this change if needed, but for now I
would like to have a feedback on the current code to know if it is
acceptable if there is still potential issue.

The series was tested on a vanilla v5.1 kernel, and without the
series, an USB stick was not detected under QEMU whereas with this
series it worked as expected.

Greogry

[1]: https://lkml.org/lkml/2018/10/15/373

Gregory CLEMENT (1):
  arm64: dts: marvell: armada-ap806: add smmu support

Hanna Hawa (3):
  iommu/arm-smmu: Introduce wrapper for writeq/readq
  iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum
    #582743
  dt-bindings: iommu/arm,smmu: add compatible string for Marvell

 Documentation/arm64/silicon-errata.txt        |  2 +
 .../devicetree/bindings/iommu/arm,smmu.txt    |  1 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 17 +++++
 drivers/iommu/arm-smmu.c                      | 74 ++++++++++++++++---
 4 files changed, 83 insertions(+), 11 deletions(-)

-- 
2.20.1

