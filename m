Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CCAC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90F420693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="QeZJxMjL";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="QeZJxMjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfDVPaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:30:19 -0400
Received: from node.akkea.ca ([192.155.83.177]:38376 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbfDVPaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 11:30:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 9F8CE4E2056;
        Mon, 22 Apr 2019 15:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555947015; bh=EcCG5BHlQcQhwE/EjWPG7SnhP7EtT6S3cNHENhNVccA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QeZJxMjLigvrkahMpsyIDbY1VB0f9SwbhCaUppY5f6Sa64sJ0Z9lZIyeA/iFGJLmF
         MyWlnNUl6p2cf4w54BvKt7TVXhQPWgzyg+duzvEQJSKYNaOJOpYFjRCZkjlJzserZD
         R8U8GBUu+OojjxciT8+aJ0kGy6s84eFO44r+ITnY=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Oi-P7L0JbXYd; Mon, 22 Apr 2019 15:30:15 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 5DD934E204B;
        Mon, 22 Apr 2019 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555947015; bh=EcCG5BHlQcQhwE/EjWPG7SnhP7EtT6S3cNHENhNVccA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QeZJxMjLigvrkahMpsyIDbY1VB0f9SwbhCaUppY5f6Sa64sJ0Z9lZIyeA/iFGJLmF
         MyWlnNUl6p2cf4w54BvKt7TVXhQPWgzyg+duzvEQJSKYNaOJOpYFjRCZkjlJzserZD
         R8U8GBUu+OojjxciT8+aJ0kGy6s84eFO44r+ITnY=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jacky Bai <ping.bai@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] dt-bindings: Add an entry for Purism SPC
Date:   Mon, 22 Apr 2019 08:30:02 -0700
Message-Id: <20190422153003.10223-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190422153003.10223-1-angus@akkea.ca>
References: <20190422153003.10223-1-angus@akkea.ca>
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

