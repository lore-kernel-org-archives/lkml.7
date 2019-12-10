Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACC3C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D08208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+yYutPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfLJNXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:23:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35966 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfLJNXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:23:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so20116493wru.3;
        Tue, 10 Dec 2019 05:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RT3uMjCTNXctwL3ki3eO315EjLjo+qSfc5PPzuNqLtA=;
        b=X+yYutPi8yUZOG9C1Uw+ViETHLH7JlmlE4bbqUKhFZxe/qSsACpb1gliLB9onE0nSF
         BXKyhVL543QJwkw42Mlbk2e+x2gcS3ACPuCKe+5yWJ1FOMOWiMTkkKv4Vh7WckEjpuIs
         ZPkWbBuvlz4JOA+n96j27KoW4RYmOzwuhq+QmqrFiRhYR2UabDNIn/w5AdceltKC9MA0
         LYCzrjY05Bgg4VSeNT/5j1Zz7AYomHaJRaa9rTR7KMDwk1PihKSewMLhEnRUjhDdtMia
         S56WwBMxRWuTwsSF/GDSaIik0pCCsqfNqlYwycXLSErWgXzfqSSVcm3+gWyX8a28Y/Ly
         ejXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RT3uMjCTNXctwL3ki3eO315EjLjo+qSfc5PPzuNqLtA=;
        b=N6GcB/ou6p4M8GBRK6TiiVfI843Jpx4k5kelGaUq6TE7Bp1yMK5KxMFyGjs+RDTZOV
         4Lb3GTZf4kVEdAxEpNaegk7Mx/pFjy5mH2f9bFk20Djbw4I4IxGmlRzVmHfJE8SJC4t4
         mdPZs57m7eEl9LSTUiVMKF7GTWxjdeFvxUcWI2eL4d69B1S+7qg9Tpi6LSoicHl/f77k
         d0uvsHkNegdPwS9EjGdW67ri3kuQLaRxAcr66eaFH36cOYQ+6R6HWqYLUEyWCeXGu3TE
         ptFD+zzI9Chbz0oNcl/ztfyOWZjX3EuNcjwaOLV+8GZub8pa3OM87ejeBNGPcfAgw8aA
         1hUw==
X-Gm-Message-State: APjAAAVu83Rl8AIpDHuwLaUwyDPnY/8PrsJjgtFgRZEUCVPxcF6S1uqH
        hL81YTGvPzzI5AUgSf5ocHBfs5TZ0fk=
X-Google-Smtp-Source: APXvYqwKZVP2WLlurttkV9HKNZIclds/Eaq4/8StTYfjsDUqPOqlIhn2p6BQSFtCn0/F0wZuNKhEVw==
X-Received: by 2002:adf:e984:: with SMTP id h4mr3168677wrm.275.1575984226392;
        Tue, 10 Dec 2019 05:23:46 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id s82sm3101680wms.28.2019.12.10.05.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 05:23:45 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 09/13] phy: usb: fix driver to defer on clk_get defer
Date:   Tue, 10 Dec 2019 08:21:28 -0500
Message-Id: <20191210132132.41509-10-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210132132.41509-1-alcooperx@gmail.com>
References: <20191210132132.41509-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle defer on clk_get because the new SCMI clock driver comes
up after this driver.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 5f7bfa09494d..c82d7ec15334 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -341,6 +341,8 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 
 	priv->usb_20_clk = of_clk_get_by_name(dn, "sw_usb");
 	if (IS_ERR(priv->usb_20_clk)) {
+		if (PTR_ERR(priv->usb_20_clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		dev_info(dev, "Clock not found in Device Tree\n");
 		priv->usb_20_clk = NULL;
 	}
@@ -371,6 +373,8 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 
 		priv->usb_30_clk = of_clk_get_by_name(dn, "sw_usb3");
 		if (IS_ERR(priv->usb_30_clk)) {
+			if (PTR_ERR(priv->usb_30_clk) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
 			dev_info(dev,
 				 "USB3.0 clock not found in Device Tree\n");
 			priv->usb_30_clk = NULL;
@@ -382,6 +386,8 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 
 	priv->suspend_clk = clk_get(dev, "usb0_freerun");
 	if (IS_ERR(priv->suspend_clk)) {
+		if (PTR_ERR(priv->suspend_clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		dev_err(dev, "Suspend Clock not found in Device Tree\n");
 		priv->suspend_clk = NULL;
 	}
-- 
2.17.1

