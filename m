Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EB6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F4721773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="rcEXOMjL";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="uwUn1zET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfDXXRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:17:25 -0400
Received: from node.akkea.ca ([192.155.83.177]:50454 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbfDXXRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:17:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 10E784E2056;
        Wed, 24 Apr 2019 23:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1556147841; bh=sxy5B7Ps/51CJJ2+Vk/k0HCkeiFsTjkEf5lFm0F+sPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=rcEXOMjLqFkvNkSUr1hUROOekYYjQ3PULU6HhNhHnyX/ey+F7g53hrJlu9YQhfXEe
         Vzqg+csBGcOrAuyIj4D+PM/DYyusfsWzc0AF1gvTGwKB/o+3QTqT7DeMuD6kajXK0N
         Bf4p70fX4jfuTwM6jUq3Lr1wlhQatCw1LbnKOYRo=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Opfzvyl4AxDT; Wed, 24 Apr 2019 23:17:20 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 112844E204E;
        Wed, 24 Apr 2019 23:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1556147840; bh=sxy5B7Ps/51CJJ2+Vk/k0HCkeiFsTjkEf5lFm0F+sPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=uwUn1zETQYvI7rfKNfPiXIC9gCTj71uZz4xgs3N69pzZYwcJdLQBUylck7dFDtRh9
         64ij7oiStC25YahzYgb59hn0ZtghYAe9xTLAoaug5UH4den0+tvlrRM2WaoFaAK7Nq
         detzwzpEAklchUCqhozILoKfueKCXmivoocrIDXM=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        =?UTF-8?q?Vok=C3=A1=C4=8D=20Michal?= <Michal.Vokac@ysoft.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, m.felsch@pengutronix.de
Subject: [PATCH v7 3/3] dt-bindings: arm: fsl: Add the imx8mq boards
Date:   Wed, 24 Apr 2019 16:17:11 -0700
Message-Id: <20190424231711.14156-4-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424231711.14156-1-angus@akkea.ca>
References: <20190424231711.14156-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for imx8mq based boards

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 06762fe57227..ecf63a123950 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -175,6 +175,13 @@ properties:
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
           - const: fsl,imx8mm
 
+      - description: i.MX8MQ based Boards
+        items:
+          - enum:
+              - fsl,imx8mq-evk            # i.MX8MQ EVK Board
+              - purism,librem5-devkit     # Purism Librem5 devkit
+          - const: fsl,imx8mq
+
       - description: i.MX8QXP based Boards
         items:
           - enum:
-- 
2.17.1

