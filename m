Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC24C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F05D2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfCGQ6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:58:40 -0500
Received: from mailoutvs36.siol.net ([185.57.226.227]:45934 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726161AbfCGQ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:58:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 6785E5237C4;
        Thu,  7 Mar 2019 17:58:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FzY0lPSKPsIp; Thu,  7 Mar 2019 17:58:36 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 0CB4F523799;
        Thu,  7 Mar 2019 17:58:36 +0100 (CET)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id D2E4D5237B1;
        Thu,  7 Mar 2019 17:58:34 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        jernej.skrabec@siol.net
Subject: [PATCH 0/6] Allwinner H6 DMA support
Date:   Thu,  7 Mar 2019 17:58:23 +0100
Message-Id: <20190307165829.9086-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA engine on H6 is almost the same as on older SoCs. The biggest
difference is that it has slightly rearranged bits in registers and
it needs additional clock, probably due to iommu.

These patches were tested with I2S connected to HDMI. I2S needs
additional patches which will be sent later.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (6):
  dt-bindings: arm64: allwinner: h6: Add binding for DMA controller
  dmaengine: sun6i: Add a quirk for additional mbus clock
  dmaengine: sun6i: Add a quirk for setting DRQ fields
  dmaengine: sun6i: Add a quirk for setting mode fields
  dmaengine: sun6i: Add support for H6 DMA
  arm64: dts: allwinner: h6: Add DMA node

 .../devicetree/bindings/dma/sun6i-dma.txt     |   9 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  12 ++
 drivers/dma/sun6i-dma.c                       | 147 +++++++++++++-----
 3 files changed, 131 insertions(+), 37 deletions(-)

--=20
2.21.0

