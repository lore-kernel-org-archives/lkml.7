Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F98FC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D8E21BF6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5kBznP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfGVS7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:59:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38041 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfGVS7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:59:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so19551720plb.5;
        Mon, 22 Jul 2019 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+BPPPji4KmMPm/LztN/u6Pt6WF0WdMzxA5bRmk4V+jc=;
        b=K5kBznP9TrTX6mK2UwTBWA0b1ZHBf7PBwvgbGv7SGT6Nsob+xzS03qXm7sk3xh7GkJ
         0NKg2BQA9BWzMFULMSN7zIkCox5HpecJKFh3NqUuX/6m0dvv39wieOWOS32YFBobK2zy
         Agb4M74KgFJ3FjCkVbOa7kQVLmC0q9MjQxrMeKhki4T4g5u3y9epGkMBjNMzesVIGa8v
         yCxzI9qV7+5q7xgF9rLiSzpWeaEPJz/tP10MfgPkTlAQRDigFJG1HX/TCt57t/UL2Ox+
         +TNodYNdPctkqKX3JvAt7F7tHA7wOPpRBgQdJjtHGI3VsLiNXHRqkkRAtB3hu0DU9g1f
         RoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+BPPPji4KmMPm/LztN/u6Pt6WF0WdMzxA5bRmk4V+jc=;
        b=DWK+/Zk70m+P3LmQ6ThhypuR2pRs3XN192WC5UUGtB2ggM6ZHzGhyuWV9sXGJvG5Fi
         /e8eggswSKWhu7nTyyaaSBdo7rWXaJjWc2KxKiTRMiJtWqH0e8H95MypLIJeqTXnUbMw
         9yAlPM8Reppmcu/QFYfskqMw0o3DiecjBiLKmVrQdLIvjyWGZraPoIYrFR/t/NWcHwql
         REQwDjSiib3DJZ9jAAcn8mrnhJm6qyydswXs/UR7sh5RRRVFp8/lblA3IScz7HwWTOta
         INw2SWfndWT8bpHiocY119V50MJY/17BddUVW/OLSzUpawcBZ2xIBRTK4vUQditqAJny
         Ovxg==
X-Gm-Message-State: APjAAAV7CrC/fRlzPMbiRTTJhzC0A+Eai68sQ1iS4WVDNZfdyZRRsOR5
        aZQDTRwR5QzNcXATmsgI0QlYCCKjo70=
X-Google-Smtp-Source: APXvYqxmBWHEKsY7z47iIqt7mkTYxNQkFloTQSjYLhZvsRcNoJkjHyvFOCmLFzxEi7Lf3myeENUJ2A==
X-Received: by 2002:a17:902:ba96:: with SMTP id k22mr78590271pls.44.1563821989510;
        Mon, 22 Jul 2019 11:59:49 -0700 (PDT)
Received: from localhost.localdomain ([103.51.73.174])
        by smtp.gmail.com with ESMTPSA id h1sm30777675pgv.93.2019.07.22.11.59.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:59:49 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC/RFT 1/5] phy: exynos5-usbdrd: read from correct offset of xhci linksystem
Date:   Tue, 23 Jul 2019 00:29:34 +0530
Message-Id: <20190722185938.9043-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190722185938.9043-1-linux.amoon@gmail.com>
References: <20190722185938.9043-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read from linksystem offset to update the xhci version.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 646259bee909..3c14bf7718c1 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -397,7 +397,8 @@ static int exynos5_usbdrd_phy_init(struct phy *phy)
 	 * Setting the Frame length Adj value[6:1] to default 0x20
 	 * See xHCI 1.0 spec, 5.2.4
 	 */
-	reg =	LINKSYSTEM_XHCI_VERSION_CONTROL |
+	reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_LINKSYSTEM);
+	reg |=	LINKSYSTEM_XHCI_VERSION_CONTROL |
 		LINKSYSTEM_FLADJ(0x20);
 	writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_LINKSYSTEM);
 
-- 
2.22.0

