Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F262C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F6E20825
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+DoBBYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbfFGXMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 19:12:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50859 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731388AbfFGXLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 19:11:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so3500476wmf.0;
        Fri, 07 Jun 2019 16:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7GEHwh/r4T7qgHwLm9BpliTLYMp1uwbqc4fRyWp+9LU=;
        b=L+DoBBYW26kUIiCrZIML4fSKfVB4+Han2fYg+Y+AEfOvdl6df+liQaUdhkPwlO/6Sf
         pRl9IKkOjj7XH+t7RhROSpgvi7iJ/cGIrO5K8x2XUaeBtCIlCN69lBw3xJGH0SCWdiTX
         3/Drvnay9CxdWDckD/1+NYBBoK0hkiW9wwCfEan0KIFCVtSgVGWhkkYuA4IVk6aO7/uw
         MSTuWMTP/BV2TLHL92zr7hK0rMHELO7ZjE35vSj9ASO3Xvkj8gj0+fCDol/d4lKNp26J
         bWllR9eNc40qX/5xhp9XWmMYN6Pr/pCpzLnzIQFczG2w2E7FfYajR75sYXUxGsMbJfni
         uECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7GEHwh/r4T7qgHwLm9BpliTLYMp1uwbqc4fRyWp+9LU=;
        b=FE7bjhZZU3fBPWaguXgyY23ae1nvPUorh+eucO1V4TTekWx3o/sDHK8K2++AoUENfO
         w+n78L3Dvxu5R9gIo/YLH7SjvI2PKmCBXPtMS5tP3ethXpnRUkxmSosb4sZVDs3Vo5Qw
         11kya/1LLsuJPOOKlOOB5kf9Jvy7ffraSmklT8JkKZaw9oF+RT/VVp5h0VOfw0VlhAt8
         f3frrakiKnFnlrmBcRUeBcilbxq6+s9x05bnArUtBbQ96Ew3oFyPViduPz9m9tqpqvIB
         0iYvsmU0xQc0uEn5+hCo8sIyiNLz4W2V2ZO5RtnUOY1Mi2xF+wjyprkb5jAGK+FcwmAr
         El7A==
X-Gm-Message-State: APjAAAX16nrpnTEFsUdtYpTrF2jCMIJ0SOWu1+OzYY6AufZZHJfAx56X
        DS5QHPtXB/qvBpA+gAWAXAA=
X-Google-Smtp-Source: APXvYqwUfHoRNiyI8qxZ99qGY5vY4n9q91qmbDFEOvJJaMrhrSb6D3nxxuEgESrd+BAF3/p7lUwjyQ==
X-Received: by 2002:a1c:1d83:: with SMTP id d125mr5140296wmd.63.1559949073446;
        Fri, 07 Jun 2019 16:11:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id h84sm4108559wmf.43.2019.06.07.16.11.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 16:11:12 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 04/13] media: rc: sunxi: Add RXSTA bits definition
Date:   Sat,  8 Jun 2019 01:10:51 +0200
Message-Id: <20190607231100.5894-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607231100.5894-1-peron.clem@gmail.com>
References: <20190607231100.5894-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are using RXINT bits definition when looking at RXSTA register.

These bits are equal but it's not really proper.

Introduce the RXSTA bits and use them to have coherency.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/media/rc/sunxi-cir.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
index 0504ebfc831f..5690d0bd51bc 100644
--- a/drivers/media/rc/sunxi-cir.c
+++ b/drivers/media/rc/sunxi-cir.c
@@ -48,11 +48,11 @@
 
 /* Rx Interrupt Enable */
 #define SUNXI_IR_RXINT_REG    0x2C
-/* Rx FIFO Overflow */
+/* Rx FIFO Overflow Interrupt Enable */
 #define REG_RXINT_ROI_EN		BIT(0)
-/* Rx Packet End */
+/* Rx Packet End Interrupt Enable */
 #define REG_RXINT_RPEI_EN		BIT(1)
-/* Rx FIFO Data Available */
+/* Rx FIFO Data Available Interrupt Enable */
 #define REG_RXINT_RAI_EN		BIT(4)
 
 /* Rx FIFO available byte level */
@@ -60,6 +60,12 @@
 
 /* Rx Interrupt Status */
 #define SUNXI_IR_RXSTA_REG    0x30
+/* Rx FIFO Overflow */
+#define REG_RXSTA_ROI			REG_RXINT_ROI_EN
+/* Rx Packet End */
+#define REG_RXSTA_RPE			REG_RXINT_RPEI_EN
+/* Rx FIFO Data Available */
+#define REG_RXSTA_RA			REG_RXINT_RAI_EN
 /* RX FIFO Get Available Counter */
 #define REG_RXSTA_GET_AC(val) (((val) >> 8) & (ir->fifo_size * 2 - 1))
 /* Clear all interrupt status value */
@@ -119,7 +125,7 @@ static irqreturn_t sunxi_ir_irq(int irqno, void *dev_id)
 	/* clean all pending statuses */
 	writel(status | REG_RXSTA_CLEARALL, ir->base + SUNXI_IR_RXSTA_REG);
 
-	if (status & (REG_RXINT_RAI_EN | REG_RXINT_RPEI_EN)) {
+	if (status & (REG_RXSTA_RA | REG_RXSTA_RPE)) {
 		/* How many messages in fifo */
 		rc  = REG_RXSTA_GET_AC(status);
 		/* Sanity check */
@@ -135,9 +141,9 @@ static irqreturn_t sunxi_ir_irq(int irqno, void *dev_id)
 		}
 	}
 
-	if (status & REG_RXINT_ROI_EN) {
+	if (status & REG_RXSTA_ROI) {
 		ir_raw_event_reset(ir->rc);
-	} else if (status & REG_RXINT_RPEI_EN) {
+	} else if (status & REG_RXSTA_RPE) {
 		ir_raw_event_set_idle(ir->rc, true);
 		ir_raw_event_handle(ir->rc);
 	}
-- 
2.20.1

