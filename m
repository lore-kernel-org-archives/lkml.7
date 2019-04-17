Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190ECC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAD92173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gKv18u2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbfDQOrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:47:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33807 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfDQOrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:47:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id w16so2369690wrl.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PkEAOEiMzCEaJhtas7PAWSYNdvyzA7yFJpIHTqreR8A=;
        b=gKv18u2Dcj1ZxRC0dLdKT1Cg3ih6bcMPrni8U1SZ7Mdu4PjpWH4c+LJqbXxkd3cSbp
         kyGFclhWJAI6xy0hriXtHZ10ptiaXleLUCjxojur3zVeikz1HAmDH/4SZmgabkTM/ggL
         mbQjLLAtYeh3R/OlCzzbl1rcznB88fVam46IJiANH7IDcE4zgMophKTpCYOxi2Q7AHz5
         NQoIASVxckgaNmkP1fY/w5pjCD5LDV+QoLF351n1LAkbJJil5nIDbJG4Gy7S/eWq68pu
         DVJ8tsC9Lr/lvYwAxq5k46wh4YQRR5qIzomhcF1NfqRPprmCoZN5crnT1Yw6OrmSkAFN
         GlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PkEAOEiMzCEaJhtas7PAWSYNdvyzA7yFJpIHTqreR8A=;
        b=cUCb7n/eioU7OK75BE1OmThuvfGQJnwmN2n+4j7TZB0ffQ3QFXW8VmG2Nfovuq91Yf
         zreFIoQvsDJazxVto887omxCjD0bptokFkHhoX6ZYGORDr12JJ4KXSKJBqPMctindHGU
         mnEGNBK7BsZNzjC8qc0vt5qhdXTkkff+pyrXwyayA8dcgc+bDeXlloBp7Qtu5Ah1bJUw
         D2fAVBX7qqMfo9PKFUcdrOYUUnVOiJXP8tMOzJD/y0TDOCtSYxhUKA/CKU3Abn2iqsvt
         PG9WWqhMsAvDKOTZ4fbSGLgAcMFRQzxT02IGxo6ZurgKjt8j7EvDZgzjhQs75ZZpaRlh
         oX5Q==
X-Gm-Message-State: APjAAAUX2Fn5+EEz16gk60cdVysdGzWTof1MJBv/d4GSytBQUfxTsn4E
        bdvv/o3O3XmkP3i8YPyRb0mnCw==
X-Google-Smtp-Source: APXvYqwN+bSAzaX1I+kboL1bDFXatlPHaX54h5qvTFWj+vUA/ejLFp/ewmMOa6PwqUKzsP/wmF6dOw==
X-Received: by 2002:a5d:6b07:: with SMTP id v7mr108084wrw.311.1555512437024;
        Wed, 17 Apr 2019 07:47:17 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-15-216.w90-86.abo.wanadoo.fr. [90.86.218.216])
        by smtp.gmail.com with ESMTPSA id u17sm5582862wmu.36.2019.04.17.07.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:47:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RFC 2/2] clocksource: timer-davinci: add support for clocksource
Date:   Wed, 17 Apr 2019 16:47:09 +0200
Message-Id: <20190417144709.19588-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417144709.19588-1-brgl@bgdev.pl>
References: <20190417144709.19588-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Extend the davinci-timer driver to also register a clock source.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clocksource/timer-davinci.c | 70 +++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index d30f81a4088e..d630fca98123 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -42,6 +42,8 @@
 #define DAVINCI_TIMER_MIN_DELTA			0x01
 #define DAVINCI_TIMER_MAX_DELTA			0xfffffffe
 
+#define DAVINCI_TIMER_CLKSRC_BITS		32
+
 #define DAVINCI_TIMER_TGCR_DEFAULT \
 		(DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED | DAVINCI_TIMER_UNRESET)
 
@@ -59,6 +61,16 @@ struct davinci_clockevent {
 	unsigned int enamode_mask;
 };
 
+/*
+ * This must be globally accessible by davinci_timer_read_sched_clock(), so
+ * let's keep it here.
+ */
+static struct {
+	struct clocksource dev;
+	void __iomem *base;
+	unsigned int tim_off;
+} davinci_clocksource;
+
 static struct davinci_clockevent *
 to_davinci_clockevent(struct clock_event_device *clockevent)
 {
@@ -148,6 +160,32 @@ static irqreturn_t davinci_timer_irq_timer(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static u64 notrace davinci_timer_read_sched_clock(void)
+{
+	return readl_relaxed(davinci_clocksource.base +
+			     davinci_clocksource.tim_off);
+}
+
+static u64 davinci_clocksource_read(struct clocksource *dev)
+{
+	return davinci_timer_read_sched_clock();
+}
+
+static void davinci_clocksource_init(void __iomem *base, unsigned int tim_off,
+				     unsigned int prd_off, unsigned int shift)
+{
+	davinci_reg_update(base, DAVINCI_TIMER_REG_TCR,
+			   DAVINCI_TIMER_ENAMODE_MASK << shift,
+			   DAVINCI_TIMER_ENAMODE_DISABLED << shift);
+
+	writel_relaxed(0x0, base + tim_off);
+	writel_relaxed(UINT_MAX, base + prd_off);
+
+	davinci_reg_update(base, DAVINCI_TIMER_REG_TCR,
+			   DAVINCI_TIMER_ENAMODE_MASK << shift,
+			   DAVINCI_TIMER_ENAMODE_PERIODIC << shift);
+}
+
 static void davinci_timer_init(void __iomem *base)
 {
 	/* Set clock to internal mode and disable it. */
@@ -235,6 +273,38 @@ int __init davinci_timer_register(struct clk *clk,
 					DAVINCI_TIMER_MIN_DELTA,
 					DAVINCI_TIMER_MAX_DELTA);
 
+	davinci_clocksource.dev.rating = 300;
+	davinci_clocksource.dev.read = davinci_clocksource_read;
+	davinci_clocksource.dev.mask =
+			CLOCKSOURCE_MASK(DAVINCI_TIMER_CLKSRC_BITS);
+	davinci_clocksource.dev.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	davinci_clocksource.base = base;
+
+	if (timer_cfg->cmp_off) {
+		davinci_clocksource.dev.name = "tim12";
+		davinci_clocksource.tim_off = DAVINCI_TIMER_REG_TIM12;
+		davinci_clocksource_init(base,
+					 DAVINCI_TIMER_REG_TIM12,
+					 DAVINCI_TIMER_REG_PRD12,
+					 DAVINCI_TIMER_ENAMODE_SHIFT_TIM12);
+	} else {
+		davinci_clocksource.dev.name = "tim34";
+		davinci_clocksource.tim_off = DAVINCI_TIMER_REG_TIM34;
+		davinci_clocksource_init(base,
+					 DAVINCI_TIMER_REG_TIM34,
+					 DAVINCI_TIMER_REG_PRD34,
+					 DAVINCI_TIMER_ENAMODE_SHIFT_TIM34);
+	}
+
+	rv = clocksource_register_hz(&davinci_clocksource.dev, tick_rate);
+	if (rv) {
+		pr_err("Unable to register clocksource");
+		return rv;
+	}
+
+	sched_clock_register(davinci_timer_read_sched_clock,
+			     DAVINCI_TIMER_CLKSRC_BITS, tick_rate);
+
 	return 0;
 }
 
-- 
2.21.0

