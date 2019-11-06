Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29DEC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3F5214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpmoyKx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbfKFGD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:03:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38657 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfKFGD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:03:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id c13so18017394pfp.5;
        Tue, 05 Nov 2019 22:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pvETq++L0sfvJDo0Ujf7rGASfz2pwG/aDIcZe0oPC2w=;
        b=qpmoyKx4Cj9u60GOe3E+wR8joIEGdfPOyRI2Pht9E/19kymCpZadHv/V0Lzsuw6/BD
         tp8MkjdGkY2/10DD/vNT+2uMwxV3Q3dN4PNQGEqXbrvTVuEzgwEg/zvSkugvqryjQSkl
         8DaTRNFEA1U1F8J87X0CYbidhvCH0Pb/y5c36Xk4pZLdAvpQQKBfWvICJGrr6BpaW8JM
         KjC9GdK5uWWzTJKVhD0C8goiJDJUpJ3r4w/NBwh3vL1GkyLGLad7+3TF8nYWFFveTF8M
         K5o8M7LRdGtcbDSPhvtlhUr/DZy3r51j0tzmYFpaVWdie0zBOsoE6yRc2AqYlIKBWacS
         8oEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pvETq++L0sfvJDo0Ujf7rGASfz2pwG/aDIcZe0oPC2w=;
        b=OcD+/QkThKGjqUWgnE29WGTbRX/LevIBxkH2FylrnoFMuTLMpDDeveHZGvmAcQi8Ej
         J8rYEeirKVwBIUKYJZJBfqka+kN8GLlxaEvqTBkUdrhhcpPKp2VXDpZbjOFvYQnGLHXA
         Rqe5j7gydxXeb0n/38DPik4XW1Bwm0G6xS5+WBCuOq0dQlAT/mALnTPFzzcbP9j0ICpW
         AihjSrHw2OO/n9rLpuXrJXy8pvO27ch89WzNOpzCUoLuNfMGWWMKnaSYkgSVRNFK+ZnL
         LRbWCHRhR7/ZL8Q/K92gF+EM/cT1KqpNFiMia+L2t0qN4hffAn3MMpzJ3dc21xTytOdK
         8+Ww==
X-Gm-Message-State: APjAAAXwgDZ+n5+Cq1xReTG+MaoQsLRwYrn/Iyq8zu7T+bBEGVmVXCKY
        z5J61ogXWhRCKoi0p+YYRV0=
X-Google-Smtp-Source: APXvYqwv45O2BzcCUC681URzfCfiamldxhHYFlqGyTR8FFMH3/5zlS9zvqlltxk8zOoCK4UyXb5M0w==
X-Received: by 2002:a17:90a:d818:: with SMTP id a24mr1461626pjv.40.1573020206005;
        Tue, 05 Nov 2019 22:03:26 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id u65sm23177676pfb.35.2019.11.05.22.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 22:03:25 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH 3/4] clocksource: fttmr010: Add support for ast2600
Date:   Wed,  6 Nov 2019 16:33:00 +1030
Message-Id: <20191106060301.17408-4-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191106060301.17408-1-joel@jms.id.au>
References: <20191106060301.17408-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ast2600 has some minor differences to previous versions. The
interrupt handler must acknowledge the timer interrupt in a status
register. Secondly the control register becomes write to set only,
requiring the use of a separate set to clear register.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clocksource/timer-fttmr010.c | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index 8a79025339d0..688d540ebddd 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -37,6 +37,11 @@
 #define TIMER3_MATCH2		(0x2c)
 #define TIMER_CR		(0x30)
 
+/*
+  Control register set to clear for ast2600 only.
+ */
+#define TIMER_CR_CLR		(0x3c)
+
 /*
  * Control register (TMC30) bit fields for fttmr010/gemini/moxart timers.
  */
@@ -163,6 +168,16 @@ static int fttmr010_timer_set_next_event(unsigned long cycles,
 	return 0;
 }
 
+static int ast2600_timer_shutdown(struct clock_event_device *evt)
+{
+	struct fttmr010 *fttmr010 = to_fttmr010(evt);
+
+	/* Stop */
+	writel(fttmr010->t1_enable_val, fttmr010->base + TIMER_CR_CLR);
+
+	return 0;
+}
+
 static int fttmr010_timer_shutdown(struct clock_event_device *evt)
 {
 	struct fttmr010 *fttmr010 = to_fttmr010(evt);
@@ -244,6 +259,17 @@ static irqreturn_t fttmr010_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t ast2600_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	struct fttmr010 *fttmr010 = to_fttmr010(evt);
+
+	writel(0x1, fttmr010->base + TIMER_INTR_STATE);
+
+	evt->event_handler(evt);
+	return IRQ_HANDLED;
+}
+
 static int __init fttmr010_common_init(struct device_node *np,
 		bool is_aspeed,
 		int (*timer_shutdown)(struct clock_event_device *),
@@ -404,6 +430,13 @@ static int __init fttmr010_common_init(struct device_node *np,
 	return ret;
 }
 
+static __init int ast2600_timer_init(struct device_node *np)
+{
+	return fttmr010_common_init(np, true,
+			ast2600_timer_shutdown,
+			ast2600_timer_interrupt);
+}
+
 static __init int aspeed_timer_init(struct device_node *np)
 {
 	return fttmr010_common_init(np, true,
@@ -423,3 +456,4 @@ TIMER_OF_DECLARE(gemini, "cortina,gemini-timer", fttmr010_timer_init);
 TIMER_OF_DECLARE(moxart, "moxa,moxart-timer", fttmr010_timer_init);
 TIMER_OF_DECLARE(ast2400, "aspeed,ast2400-timer", aspeed_timer_init);
 TIMER_OF_DECLARE(ast2500, "aspeed,ast2500-timer", aspeed_timer_init);
+TIMER_OF_DECLARE(ast2600, "aspeed,ast2600-timer", ast2600_timer_init);
-- 
2.24.0.rc1

