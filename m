Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF230C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B855520989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="JkXdyGmJ";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="pdqP/1Ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfE1M6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:58:05 -0400
Received: from node.akkea.ca ([192.155.83.177]:43696 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfE1M6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:58:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id F33C34E2058;
        Tue, 28 May 2019 12:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1559048283; bh=lelvFHTb/2EBptwvKMw/2mYGKmO6s1cDu3Iox9D0FcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JkXdyGmJ2y3fdeNURfH40q0V2TzVmj7c5hFqDKGyIIZZy7ICKem/ZA0WQMdW8l4IF
         PraYfN2Hxy8xrq2XOusDcxyHvsgvzoUv4Rc/6KEsODhwwrjIa0uAuCihV9xFqo+4YM
         QXENwNuFgdRdnbf1zTWeOF1cKkxkslIo2rFlo424=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MgtEvu5V1tXn; Tue, 28 May 2019 12:58:01 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 1074A4E204B;
        Tue, 28 May 2019 12:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1559048281; bh=lelvFHTb/2EBptwvKMw/2mYGKmO6s1cDu3Iox9D0FcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pdqP/1OtumjtWqPKfsu7mxUpU57Pz+1Fsh7eMH63d0x60oPzTQWvb0H1RH+kHO+PM
         wBE0Xy+TKWB32fVwyZcRGgIT5in2rARN/90L/pm906yVe/ozlWHBc3u/0aJ7JD0zgI
         yoZmPKOEdkPhjyM+ES02QhZKGHRJQFEyT47PR6KY=
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
Subject: [PATCH v15 2/3] dt-bindings: Add an entry for Purism SPC
Date:   Tue, 28 May 2019 05:57:46 -0700
Message-Id: <20190528125747.1047-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528125747.1047-1-angus@akkea.ca>
References: <20190528125747.1047-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Purism, SPC

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index c0881d51aa91..0faa0edbecd6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -687,6 +687,8 @@ patternProperties:
     description: PROBOX2 (by W2COMP Co., Ltd.)
   "^pulsedlight,.*":
     description: PulsedLight, Inc
+  "^purism,.*":
+    description: Purism, SPC
   "^qca,.*":
     description: Qualcomm Atheros, Inc.
   "^qcom,.*":
-- 
2.17.1

