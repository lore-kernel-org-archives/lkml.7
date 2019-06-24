Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2DEC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029C92063F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OgoQ6QB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfFXOsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:48:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38695 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfFXOsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:48:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so13666906wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:references:reply-to:message-id:mime-version;
        bh=t3gx4CW2mBs3JN+/WIyX7pTLkZS3fRc0wyPs3jrglog=;
        b=OgoQ6QB8KfytnEKNbqfHjNm8UJkRclyxG8kKItYXWzuLf2+ItMLuqzZYvR87PvjPT8
         I1Nr4mRS2NWL+Wcl/BEGIH88enr3Z8oWN3Xrg+rLK4Ts+QBpE0n5oVxZT0L/vbwTEqgh
         VXRGYMOjF+mvNyvaZNbNINR6W28R0EUIDfHbQMvuVw5c4El9SNhb6dq4lNY+roQEtBSB
         1kTeXMaJqzyLiVfsD8gUn+wGwbPLKTE/8M7pJ2PBHUpW2gZmMjA+3LXcNg1GGH+7vsYK
         amzV/RxgVLqs1ml/G1HH7trn59/KUOv6UAmdmCLG30ShA93zBPEcpPNPmj8Zle9KhNp2
         S3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:reply-to
         :message-id:mime-version;
        bh=t3gx4CW2mBs3JN+/WIyX7pTLkZS3fRc0wyPs3jrglog=;
        b=eVD1Sbzc5pcWSiY4otx+wF1iFfntn5J+XcACXIQ6zskKdmQ3b8b8rJNnCSFOmbyqOi
         AnNy7vyy060DGD5ysPrlcYo5bufzsWd8FQbbcRZsPc8PdMzFIrmxZRRGvQK3aE/Kd9Pn
         c3vKpSsCJJZCkPTs2VugQllmVjzYn1RSwNLPHpwKKw0dk+0/58DyBJK22CZmro1gkxfq
         Z4W5LqCf+BVB30Y3gCE7jp2jpT0Mdqra1fOozCrhxBpmCWntdv8a0KaRAJV24MxGPWjy
         CM5RqwHzwnvd2u6jmTmzdwu17JrrCeGhDPlhXod91PyfG3lqpwLAaY+CwfVcRwER8oJn
         O5vQ==
X-Gm-Message-State: APjAAAUS2E1yq/mf7Npda0Nb1Y3N7BErgaxZR6Rkpv4zfaMNRm1DOME3
        W3CiMsTnJ+5U2e35P1fyWiZzMQ==
X-Google-Smtp-Source: APXvYqzrHd650JT9hi2tr1385IrvFj/niI09iC8N4X0o5wZ49+Tjdpy2oO9/0/usF55unwPrZZ44mA==
X-Received: by 2002:a7b:c310:: with SMTP id k16mr15453054wmj.133.1561387715052;
        Mon, 24 Jun 2019 07:48:35 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y1sm8450447wma.32.2019.06.24.07.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:48:34 -0700 (PDT)
From:   Julien Masson <jmasson@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Julien Masson <jmasson@baylibre.com>
Subject: [PATCH 3/9] drm: meson: drv: use macro when initializing vpu
Date:   Mon, 24 Jun 2019 16:48:27 +0200
References: <86zhm782g5.fsf@baylibre.com>
Reply-To: <86zhm782g5.fsf@baylibre.com>
Message-ID: <86v9wv82f1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add new macro which is used to set WRARB/RDARB mode of
the VPU.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c       | 26 +++++++++++++++++++++----
 drivers/gpu/drm/meson/meson_registers.h |  1 +
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 2310c96fff46..50096697adc3 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -149,10 +149,28 @@ static struct regmap_config meson_regmap_config = {
 
 static void meson_vpu_init(struct meson_drm *priv)
 {
-	writel_relaxed(0x210000, priv->io_base + _REG(VPU_RDARB_MODE_L1C1));
-	writel_relaxed(0x10000, priv->io_base + _REG(VPU_RDARB_MODE_L1C2));
-	writel_relaxed(0x900000, priv->io_base + _REG(VPU_RDARB_MODE_L2C1));
-	writel_relaxed(0x20000, priv->io_base + _REG(VPU_WRARB_MODE_L2C1));
+	u32 value;
+
+	/*
+	 * Slave dc0 and dc5 connected to master port 1.
+	 * By default other slaves are connected to master port 0.
+	 */
+	value = VPU_RDARB_SLAVE_TO_MASTER_PORT(0, 1) |
+		VPU_RDARB_SLAVE_TO_MASTER_PORT(5, 1);
+	writel_relaxed(value, priv->io_base + _REG(VPU_RDARB_MODE_L1C1));
+
+	/* Slave dc0 connected to master port 1 */
+	value = VPU_RDARB_SLAVE_TO_MASTER_PORT(0, 1);
+	writel_relaxed(value, priv->io_base + _REG(VPU_RDARB_MODE_L1C2));
+
+	/* Slave dc4 and dc7 connected to master port 1 */
+	value = VPU_RDARB_SLAVE_TO_MASTER_PORT(4, 1) |
+		VPU_RDARB_SLAVE_TO_MASTER_PORT(7, 1);
+	writel_relaxed(value, priv->io_base + _REG(VPU_RDARB_MODE_L2C1));
+
+	/* Slave dc1 connected to master port 1 */
+	value = VPU_RDARB_SLAVE_TO_MASTER_PORT(1, 1);
+	writel_relaxed(value, priv->io_base + _REG(VPU_WRARB_MODE_L2C1));
 }
 
 static void meson_remove_framebuffers(void)
diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meson/meson_registers.h
index 55f5fe21ff5e..a9db49e5bdd6 100644
--- a/drivers/gpu/drm/meson/meson_registers.h
+++ b/drivers/gpu/drm/meson/meson_registers.h
@@ -1496,6 +1496,7 @@
 #define VPU_RDARB_MODE_L1C2 0x2799
 #define VPU_RDARB_MODE_L2C1 0x279d
 #define VPU_WRARB_MODE_L2C1 0x27a2
+#define		VPU_RDARB_SLAVE_TO_MASTER_PORT(dc, port) (port << (16 + dc))
 
 /* osd super scale */
 #define OSDSR_HV_SIZEIN 0x3130
-- 
2.17.1

