Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68A2C04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF2B208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="op+6fb8j";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="op+6fb8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfE1M6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:58:10 -0400
Received: from node.akkea.ca ([192.155.83.177]:43666 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfE1M6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:58:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id B3A2C4E2051;
        Tue, 28 May 2019 12:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1559048282; bh=SfqX2EFJOvWCTClrRDpHw/tV94ED1IxtbtG2u/MWNBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=op+6fb8jQS5e+mg1oamSso31s+ujtaCPmTkfHspqDwTuUlcwBXoZhWZwgmDoMl1pO
         0pO3qcnyxEJgwubiIobyTb3xx72QeQjdyNU6xJNzaITik+a3e0Sx/c23llgmEsCSQa
         gdudmLz1lvI6xAx5Q4AWaUOmNJ+HkjNTk6Vu2HfY=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wk_ZAWsA6PrL; Tue, 28 May 2019 12:58:02 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id C19214E2050;
        Tue, 28 May 2019 12:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1559048282; bh=SfqX2EFJOvWCTClrRDpHw/tV94ED1IxtbtG2u/MWNBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=op+6fb8jQS5e+mg1oamSso31s+ujtaCPmTkfHspqDwTuUlcwBXoZhWZwgmDoMl1pO
         0pO3qcnyxEJgwubiIobyTb3xx72QeQjdyNU6xJNzaITik+a3e0Sx/c23llgmEsCSQa
         gdudmLz1lvI6xAx5Q4AWaUOmNJ+HkjNTk6Vu2HfY=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Carlo Caione <ccaione@baylibre.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v15 3/3] dt-bindings: arm: fsl: Add the imx8mq boards
Date:   Tue, 28 May 2019 05:57:47 -0700
Message-Id: <20190528125747.1047-4-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528125747.1047-1-angus@akkea.ca>
References: <20190528125747.1047-1-angus@akkea.ca>
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
index 407138ebc0d0..41364b127200 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -177,6 +177,13 @@ properties:
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

