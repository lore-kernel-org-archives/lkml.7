Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354A2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0582720823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Kgp4IY2R";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Kgp4IY2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfC1NjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:39:18 -0400
Received: from node.akkea.ca ([192.155.83.177]:39802 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbfC1NjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:39:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 764A54E2058;
        Thu, 28 Mar 2019 13:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553780342; bh=yFSGJbOa0Wo51XYLFbexPfJIE+WP2x0UvwGBtXXasLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Kgp4IY2RjK+EYve6iO0+8TQ1TgnaMtewRND2VfrAFwcoHaSTup0mCjKUQZIVYT4sH
         xI8qumIEzru0vdHFDyuPQaUyjmTBD0LViOIL8TQUagWOn/4BCRF1fTsx+zeyB4UXMW
         JDC13dMdB3F+uUPRfStJMbR6Pg+TF7Ues+7TwNbQ=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jlDY3_WlXXBi; Thu, 28 Mar 2019 13:39:02 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 72BD74E204D;
        Thu, 28 Mar 2019 13:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553780342; bh=yFSGJbOa0Wo51XYLFbexPfJIE+WP2x0UvwGBtXXasLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Kgp4IY2RjK+EYve6iO0+8TQ1TgnaMtewRND2VfrAFwcoHaSTup0mCjKUQZIVYT4sH
         xI8qumIEzru0vdHFDyuPQaUyjmTBD0LViOIL8TQUagWOn/4BCRF1fTsx+zeyB4UXMW
         JDC13dMdB3F+uUPRfStJMbR6Pg+TF7Ues+7TwNbQ=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: Document the new imx8mq-sdma compatible string
Date:   Thu, 28 Mar 2019 06:38:27 -0700
Message-Id: <20190328133828.20999-4-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190328133828.20999-1-angus@akkea.ca>
References: <20190328133828.20999-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx8mq needs to be specified to check the clk ratio.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index 3c9a57a8443b..9d8bbac27d8b 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -9,6 +9,7 @@ Required properties:
       "fsl,imx53-sdma"
       "fsl,imx6q-sdma"
       "fsl,imx7d-sdma"
+      "fsl,imx8mq-sdma"
   The -to variants should be preferred since they allow to determine the
   correct ROM script addresses needed for the driver to work without additional
   firmware.
-- 
2.17.1

