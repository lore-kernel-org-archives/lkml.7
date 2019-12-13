Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3176C751E4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D194247E1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDhmaget"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfLMQF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:05:57 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38674 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbfLMQFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:05:55 -0500
Received: by mail-yb1-f196.google.com with SMTP id f130so955350ybb.5;
        Fri, 13 Dec 2019 08:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PmiKmTwTQ0CJkoTG6PszHCX+iZK7oZLHF5W+m4h4bCQ=;
        b=pDhmaget9UZMaNSsEBxSXNQ00A0aG9sLNvD5tQaF2lcttifPiL88bfjbYQRg82MwkP
         L3F8of4RkLvvx7oK2+c/1Vt7y1wbPGw3G0LeSM2jX9Gp/peLvgpnrF8iWWCxA1Li9lqZ
         oKFfkI5+IcXuro6IkIkc18HzX0fMkKr0yrSINUgSzgVQ8lJS1S1S4oMC6SwQ0pP/dbyQ
         ToCAalYk+hgBA8B7GNOYLbDBJhGFqK79bqFU215XzYAfi/yLzhxcdzzcGUKx0Wt+N63j
         0FXWHvmNUggzuePqnUdQGhHJ6inQDP+zTWgTKYTzciyoJVxPgkGDAaRaS7ew3/SYrQIL
         +Xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PmiKmTwTQ0CJkoTG6PszHCX+iZK7oZLHF5W+m4h4bCQ=;
        b=kdXhq7CrDqvv+hkQM5wLRu49E+jMPSaOoEdDm+diDXq1WkYGgDFB6W9eCGQfgisNWL
         vy+e0nbHyM73CGIO/pTl00jGjqn87nKY4Bw9euogFDRkR/iCnCTS3QqFvBu3ZNWTSZPr
         tLFM+6WDv9rTo95NNXTnfGaRc+gWOMdFIxpogJhd2sVSbHLL8p+uoJ0sW1c9gH5fcpOg
         UKHib962h78J6Ly5XsCDE3dif+wO7yl0oWJBe+jInGqdcphxc9jl5VXlpXt8UKKcrOp5
         y2acNDoHwvujZEw47gOxqYImYHxTrBwRPczFZ9BSSdtmslslTmaWsc5QR4saSvdWCeqj
         pglA==
X-Gm-Message-State: APjAAAVdJc6u3y45er22+x3Gu+LC62uYn4tkEyP/ZfYVayilvYMVpUmm
        K2ZWi9+zTxsr0qvquB+/kr4=
X-Google-Smtp-Source: APXvYqyvMxo0m9J9o7pzqtQ4LDSJYU1J4I8OigUuQ/pFrJPc6HZMKaZZVwpP0Dg4mAOHuGg59i6WEw==
X-Received: by 2002:a25:4258:: with SMTP id p85mr9366936yba.121.1576253154449;
        Fri, 13 Dec 2019 08:05:54 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id v38sm3984694ywh.63.2019.12.13.08.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 08:05:53 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     peng.fan@nxp.com, ping.bai@nxp.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/7] soc: imx: gpcv2: Update imx8m-power.h to include iMX8M Mini
Date:   Fri, 13 Dec 2019 10:05:37 -0600
Message-Id: <20191213160542.15757-3-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213160542.15757-1-aford173@gmail.com>
References: <20191213160542.15757-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for i.MX8M Mini support in the GPC driver, the
include file used by both the device tree and the source needs to
have the appropriate references for it.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  No Change

 include/dt-bindings/power/imx8m-power.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/dt-bindings/power/imx8m-power.h b/include/dt-bindings/power/imx8m-power.h
index 8a513bd9166e..0054bba744b8 100644
--- a/include/dt-bindings/power/imx8m-power.h
+++ b/include/dt-bindings/power/imx8m-power.h
@@ -18,4 +18,18 @@
 #define IMX8M_POWER_DOMAIN_MIPI_CSI2	9
 #define IMX8M_POWER_DOMAIN_PCIE2	10
 
+#define IMX8MM_POWER_DOMAIN_MIPI	0
+#define IMX8MM_POWER_DOMAIN_PCIE	1
+#define IMX8MM_POWER_DOMAIN_USB_OTG1	2
+#define IMX8MM_POWER_DOMAIN_USB_OTG2	3
+#define IMX8MM_POWER_DOMAIN_DDR1	4
+#define IMX8MM_POWER_DOMAIN_GPU2D	5
+#define IMX8MM_POWER_DOMAIN_GPU	6
+#define IMX8MM_POWER_DOMAIN_VPU	7
+#define IMX8MM_POWER_DOMAIN_GPU3D	8
+#define IMX8MM_POWER_DOMAIN_DISP	9
+#define IMX8MM_POWER_VPU_G1		10
+#define IMX8MM_POWER_VPU_G2		11
+#define IMX8MM_POWER_VPU_H1		12
+
 #endif
-- 
2.20.1

