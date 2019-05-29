Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A16EC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1342D217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VwWx2e0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfE2E2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 00:28:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38928 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfE2E2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 00:28:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id g9so480903plm.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 21:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=5JJ5fP/lDTAT9lV7xByh9EU/tkZg+0nZnzbUrujyoZg=;
        b=VwWx2e0HwwRwK0C62hjuz8p3/tQoUAnhbSI3PetFw5nW0AMUJ59MgGwwwc2b/gs5e7
         LKEhhcwF/Em6KAi1PXvoJofgHSbb/kaV+sOVVrz5rwOLE7OATGvk1kXh8FJziGzChbzt
         BroYgXEbDagyC9WHgMOxyJ9HVJtxa0FokrKGfd/9OmUJPsQBhrvQPCOwN9IM+vSj1jkm
         hxaGT6pZeo8RXAsd1LXOU6o9NoXnUoo5v+BK8lh96GN6F9K2DFWphzXYiqopCL+n94Ep
         AwuT+IIi/zx6yvDFvnCCxlw9Po7nYyq4+JbTgmdhXMJ39dEAhTwC5xtMlcBvOQ5AkB0U
         8/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=5JJ5fP/lDTAT9lV7xByh9EU/tkZg+0nZnzbUrujyoZg=;
        b=Zkgkyylpw0qV4TNPwNQm7HZU35FBJJnHcLtGy+P3YBhqagn1ybaKaMdV/6RXLhyiXs
         RqwXcmPl/joW/KKRFx+3Y2xjS+3sHYfV5rEtOPwuflgU/ulFHpxv+uETBWk7YRqyq8n6
         iIWFZVwTB+yiJ4z0iDJ57wd/lAV+NFD9SjxjM1nnPlOQ/quS82etaiSox3dR96oyINV8
         J+oIoMzpSp0CblihpXvbNg2ONrhSp2Xf1E6KTVjL7eo+hzFcNGW6I0GQfXNzrvYuB+hJ
         x95D8siKJkbSNmzhPGeznkvOq1VV1v3+DGHLgXwEWyN4rAJyYvCTtmo7/avLx7lfE7fX
         LOKQ==
X-Gm-Message-State: APjAAAVWzV3JD7r4RyocQ7lLsdf8vwL39y04XV9/I283I0Mdak4ZBNh8
        q3H3tfOxkMJLv1cVZeMGl38Yjw==
X-Google-Smtp-Source: APXvYqyYf973izL2A0wRDCEjqkuA1hxQXBamMEkpV/TS8VWbL9TEPW0wLR0FofKCM//j85s7BuA/rQ==
X-Received: by 2002:a17:902:7d83:: with SMTP id a3mr25638922plm.305.1559104087497;
        Tue, 28 May 2019 21:28:07 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id c15sm16444591pfi.172.2019.05.28.21.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 21:28:07 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/3] i2c-ocores: sifive: add polling mode workaround for FU540-C000 SoC.
Date:   Wed, 29 May 2019 09:57:27 +0530
Message-Id: <1559104047-13920-4-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559104047-13920-1-git-send-email-sagar.kadam@sifive.com>
References: <1559104047-13920-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-ocore driver already has a polling mode interface.But it needs
a workaround for FU540 Chipset on HiFive unleashed board (RevA00).
There is an erratum in FU540 chip that prevents interrupt driven i2c
transfers from working, and also the I2C controller's interrupt bit
cannot be cleared if set, due to this the existing i2c polling mode
interface added in mainline earlier doesn't work, and CPU stall's
infinitely, when-ever i2c transfer is initiated.

Ref:
	commit dd7dbf0eb090 ("i2c: ocores: refactor setup for polling")

The workaround / fix under OCORES_FLAG_BROKEN_IRQ is particularly for
FU540-COOO SoC.

The polling function identifies a SiFive device based on the device node
and enables the workaround.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/i2c/busses/i2c-ocores.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index b334fa2..4117f1a 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -35,6 +35,7 @@ struct ocores_i2c {
 	int iobase;
 	u32 reg_shift;
 	u32 reg_io_width;
+	unsigned long flags;
 	wait_queue_head_t wait;
 	struct i2c_adapter adap;
 	struct i2c_msg *msg;
@@ -84,6 +85,8 @@ struct ocores_i2c {
 #define TYPE_GRLIB		1
 #define TYPE_SIFIVE_REV0	2
 
+#define OCORES_FLAG_BROKEN_IRQ BIT(1) /* Broken IRQ for FU540-C000 SoC */
+
 static void oc_setreg_8(struct ocores_i2c *i2c, int reg, u8 value)
 {
 	iowrite8(value, i2c->base + (reg << i2c->reg_shift));
@@ -236,9 +239,12 @@ static irqreturn_t ocores_isr(int irq, void *dev_id)
 	struct ocores_i2c *i2c = dev_id;
 	u8 stat = oc_getreg(i2c, OCI2C_STATUS);
 
-	if (!(stat & OCI2C_STAT_IF))
+	if (i2c->flags & OCORES_FLAG_BROKEN_IRQ) {
+		if ((stat & OCI2C_STAT_IF) && !(stat & OCI2C_STAT_BUSY))
+			return IRQ_NONE;
+	} else if (!(stat & OCI2C_STAT_IF)) {
 		return IRQ_NONE;
-
+	}
 	ocores_process(i2c, stat);
 
 	return IRQ_HANDLED;
@@ -353,6 +359,11 @@ static void ocores_process_polling(struct ocores_i2c *i2c)
 		ret = ocores_isr(-1, i2c);
 		if (ret == IRQ_NONE)
 			break; /* all messages have been transferred */
+		else {
+			if (i2c->flags & OCORES_FLAG_BROKEN_IRQ)
+				if (i2c->state == STATE_DONE)
+					break;
+		}
 	}
 }
 
@@ -595,6 +606,7 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 {
 	struct ocores_i2c *i2c;
 	struct ocores_i2c_platform_data *pdata;
+	const struct of_device_id *match;
 	struct resource *res;
 	int irq;
 	int ret;
@@ -677,6 +689,14 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq == -ENXIO) {
 		ocores_algorithm.master_xfer = ocores_xfer_polling;
+
+		/*
+		 * Set in OCORES_FLAG_BROKEN_IRQ to enable workaround for
+		 * FU540-C000 SoC in polling mode.
+		 */
+		match = of_match_node(ocores_i2c_match, pdev->dev.of_node);
+		if (match && (long)match->data == TYPE_SIFIVE_REV0)
+			i2c->flags |= OCORES_FLAG_BROKEN_IRQ;
 	} else {
 		if (irq < 0)
 			return irq;
-- 
1.9.1

