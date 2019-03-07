Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9136BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A8320851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfCGQ6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:58:44 -0500
Received: from mailoutvs14.siol.net ([185.57.226.205]:45969 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726161AbfCGQ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:58:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 3F4845237BE;
        Thu,  7 Mar 2019 17:58:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Jev7DHsK1iut; Thu,  7 Mar 2019 17:58:39 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id E24175237CE;
        Thu,  7 Mar 2019 17:58:39 +0100 (CET)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 0FB805237BE;
        Thu,  7 Mar 2019 17:58:36 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        jernej.skrabec@siol.net
Subject: [PATCH 1/6] dt-bindings: arm64: allwinner: h6: Add binding for DMA controller
Date:   Thu,  7 Mar 2019 17:58:24 +0100
Message-Id: <20190307165829.9086-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307165829.9086-1-jernej.skrabec@siol.net>
References: <20190307165829.9086-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA in H6 is similar to other DMA controller, except it is first which
supports more than 32 request sources and has 16 channels. It also needs
additional clock to be enabled.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 Documentation/devicetree/bindings/dma/sun6i-dma.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Docume=
ntation/devicetree/bindings/dma/sun6i-dma.txt
index 7fccc20d8331..cae31f4e77ba 100644
--- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
@@ -28,12 +28,17 @@ Example:
 	};
=20
 ------------------------------------------------------------------------=
------
-For A64 DMA controller:
+For A64 and H6 DMA controller:
=20
 Required properties:
-- compatible:	"allwinner,sun50i-a64-dma"
+- compatible:	Must be one of
+		  "allwinner,sun50i-a64-dma"
+		  "allwinner,sun50i-h6-dma"
 - dma-channels: Number of DMA channels supported by the controller.
 		Refer to Documentation/devicetree/bindings/dma/dma.txt
+- clocks:	In addition to parent AHB clock, it should also contain mbus
+		clock (H6 only)
+- clock-names:	Should contain "bus" and "mbus" (H6 only)
 - all properties above, i.e. reg, interrupts, clocks, resets and #dma-ce=
lls
=20
 Optional properties:
--=20
2.21.0

