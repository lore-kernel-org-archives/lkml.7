Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604E8C17448
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3870721925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtXGnuhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfKLTWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:22:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35790 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfKLTWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:22:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id s5so8736804wrw.2;
        Tue, 12 Nov 2019 11:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZpEDoN5a5h6fV7ZiE3D69/PGx599J+5pvS1M8/D7rEU=;
        b=PtXGnuhiB8iHD5lBqu+iKKNrAFCGvcM3PwOHEFNhjSf3PtFG6aVLSF3vtNYolZmc7j
         /w8g/CtrAsWvzTkfRzrDBQZqy8ygryYeR5Q5QB+9tEV+6QWCBV/P5qk/l0r4gJ1eE87e
         MYo17lJWztQ7xFIDb3VwIcERrLN34nd1Kwred7wsuxx7kaDLsde2rgiMpRsJzPJ8hJ0y
         X1/Qy6TLwLFNVGggF7HgAyplqcGH/Lt8PQbUvQE+pBS75cqS7yHvxxepFwGbAcNJk24S
         xjHsuNXIQRG7q0GeYX3m680kox5udElJlpHx7icuIxVA1dzuwllg34oisSpAhLaBkBDU
         +4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZpEDoN5a5h6fV7ZiE3D69/PGx599J+5pvS1M8/D7rEU=;
        b=HMzzD1Eqkr/y3B0JAC9FaPI/20ZrinXVduT32BNK7HFQuvcLkPg4rFV8fRQ0NKhK/x
         TYfkvATo/X1+4ys4VFfoD1gz0JfX1OcvqOS4eUYPKq2mMfH5KoOQoP3A9Qj39tE2JIIZ
         mddQN7XPjzNoOjZQQx58PHB+oluS1lMaG7zG9PhCT/iLd1Fm3uOqBZZJX3e8hDPrDXMV
         loIj6MA+lI+SuBVmrqOGu5pOqeu5cBMq1XetP0yvnBfV7/oIHQ7+fwMgCkj5ET1VsxhZ
         KqVaQwlu6Yp4d8fpgLBi7+ScUaxxpyy/SDkcqc+Hni3xVQL2/1mytGDAWE4li82EVW56
         ba0w==
X-Gm-Message-State: APjAAAVVY4Eyvh1AfeBatwWueXn6492BdzhR/RiPEY5+bAsVqA0UTv+3
        1huzcyB0yvf7laB7+FFrBck=
X-Google-Smtp-Source: APXvYqxmgR0LNDT2aA2VphXtdJJyNweCg4ramG2+PSK6zKdwAeK/GjCrCGV/ESC/K96/pVllEvHutQ==
X-Received: by 2002:a05:6000:1621:: with SMTP id v1mr28728212wrb.62.1573586572256;
        Tue, 12 Nov 2019 11:22:52 -0800 (PST)
Received: from localhost (ip1f113d5e.dynamic.kabel-deutschland.de. [31.17.61.94])
        by smtp.gmail.com with ESMTPSA id y6sm14894974wrn.21.2019.11.12.11.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 11:22:51 -0800 (PST)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     shawnguo@kernel.org
Cc:     oliver.graute@gmail.com, m.felsch@pengutronix.de,
        narmstrong@baylibre.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] dt-bindings: arm64: fsl: Add Variscite i.MX6UL compatibles
Date:   Tue, 12 Nov 2019 20:22:03 +0100
Message-Id: <1573586526-15007-4-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573586526-15007-1-git-send-email-oliver.graute@gmail.com>
References: <1573586526-15007-1-git-send-email-oliver.graute@gmail.com>
X-Patchwork-Bot: notify
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatibles for Variscite i.MX6UL compatibles
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f79683a..d0c7e60 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -182,6 +182,7 @@ properties:
               - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
               - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
               - kontron,imx6ul-n6311-som  # Kontron N6311 SOM
+              - variscite,6ulcustomboard" # i.MX UltraLite Carrier-board
           - const: fsl,imx6ul
 
       - description: Kontron N6310 S Board
-- 
2.7.4

