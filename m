Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F92C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E199721773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Rjmy9Daz";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="m4K2oWHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfDXXRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:17:23 -0400
Received: from node.akkea.ca ([192.155.83.177]:50426 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfDXXRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:17:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 58C7B4E2051;
        Wed, 24 Apr 2019 23:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1556147840; bh=EcCG5BHlQcQhwE/EjWPG7SnhP7EtT6S3cNHENhNVccA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Rjmy9Daze/nYCw8OTzvhfXb+BbsJVL7QdZAzFUz6bGjwn1lHSLTtZFvhlUD4obHAu
         d2U3Vvi/MSDy+afg/SxjzGoMaDP1A2nf5xNbVZrmMMDnqlNxi40sm0Nsb5pCqI/PX2
         t/NnYujFKPl8HgyBCElHur6hwQKXVhzXuTH8FtYE=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QQOKwP2IViUd; Wed, 24 Apr 2019 23:17:19 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 4FEB44E204B;
        Wed, 24 Apr 2019 23:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1556147839; bh=EcCG5BHlQcQhwE/EjWPG7SnhP7EtT6S3cNHENhNVccA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=m4K2oWHEdh91o8HvLVZx52qxRaVO/+V9hfk5gVztt933ViXj1avze+4RA17URI8JX
         rGGV/B2F72dIfbyVCABStfOgeNfevOn7SvaCSLjGGIAYnUqVxgFEbHcax26JwJimYo
         8L2wmkYcGS8lCNE2/fcRfNFWBeC4eEi3aftG5uUQ=
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
Subject: [PATCH v7 2/3] dt-bindings: Add an entry for Purism SPC
Date:   Wed, 24 Apr 2019 16:17:10 -0700
Message-Id: <20190424231711.14156-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424231711.14156-1-angus@akkea.ca>
References: <20190424231711.14156-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Purism, SPC

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index d058b5102664..81f097f26953 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -332,6 +332,7 @@ poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
 probox2	PROBOX2 (by W2COMP Co., Ltd.)
 pulsedlight	PulsedLight, Inc
+purism	Purism, SPC
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm Technologies, Inc
 qemu	QEMU, a generic and open source machine emulator and virtualizer
-- 
2.17.1

