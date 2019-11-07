Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B37C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC7D214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8Y0nqqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbfKGJmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:42:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39176 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbfKGJmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:42:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id 29so1761978pgm.6;
        Thu, 07 Nov 2019 01:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HMBhz2B2078XSHXGAaUjrkWUH2c5KSmST4NY/8p2sHM=;
        b=O8Y0nqqI4MAp9WMFEj00Ci1LhFjCLXkg82eKAgOJAZ/OtcQizSy8FlqZoHU+ojQKUo
         I7BqH0keVDSgJ+lWooX0CQANBV6WIAbV/wZqSrOS2MKz1AdzAIidQOIo817h4Gq4iPpy
         4YGjqDzXQ0kH1Pn5KtvH4S5UiqMOPNb3yFMv9qn0Pqu8or4LicWXVHYSdxctdutOQUL8
         UJGLO7fCS+m2RRwg8sASoDJh7qxbDIRu0XnKC3sdTkdtgND1kplk39kKayfo4PbYLlYi
         Vn8cilrjBCvIdV/KBuO+1CsICSimfGw4CXIxdlokF8xLcs0D8SlbGrzCWnEv8b95G9Gp
         IJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HMBhz2B2078XSHXGAaUjrkWUH2c5KSmST4NY/8p2sHM=;
        b=JtcXmm8R38tCGOIHv7HeAKngdVQrUt2HDVKQJ19QKxdnwY9qdvnvsfoOsAw3VEz/rt
         9XSQbzni5eulC15rGxU/4KHKJ3vuTNXTRC1qHn75/7YuTwcc8YFqBuRzItAEbcMamaI5
         1+VJzqQvVkPL70ICZNm3I1v2ijXOMyZWZDxVG/1ZBb/Z3pY8pFg4ETz6Fz7l3a2jf9eW
         mYij4RSsCRd1DJOjTP898AjHM9x9JbHnuPOZvAszyNAdja2yg46th1yQD5N5nSbk+Fnf
         hBm50Z971se0so6dOAr2zN5txaLkW/el2s9zor+I9kyMO0BkEmmyq+IGMHLVmcogBhGO
         Lycg==
X-Gm-Message-State: APjAAAUoIDw6+8hfc/z753/U1vKtMJ4aIpRBBoEtyxDm3Xawb9lECCo4
        TrxAzfyFQwD0i4QJtmG0K9w=
X-Google-Smtp-Source: APXvYqyYiZ1Qp0Ss4RxFGl8Uq7wmutTEutxTJCmkzJhML7cWYsIZN7yjrSo7HCUFueDQ4CXN2senBA==
X-Received: by 2002:a63:5946:: with SMTP id j6mr3284812pgm.214.1573119767378;
        Thu, 07 Nov 2019 01:42:47 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id 12sm1958195pfp.79.2019.11.07.01.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 01:42:46 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v2 2/4] clocksource: fttmr010: Set interrupt and shutdown
Date:   Thu,  7 Nov 2019 20:12:16 +1030
Message-Id: <20191107094218.13210-3-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191107094218.13210-1-joel@jms.id.au>
References: <20191107094218.13210-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting the ast2600, pass the shutdown and
interrupt functions to the common init callback.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
--
v2: call parameter 'irq_handler' instead of 'handler'
---
 drivers/clocksource/timer-fttmr010.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index c2d30eb9dc72..7c20a3debd96 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -244,7 +244,10 @@ static irqreturn_t fttmr010_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
+static int __init fttmr010_common_init(struct device_node *np,
+		bool is_aspeed,
+		int (*timer_shutdown)(struct clock_event_device *),
+		irq_handler_t irq_handler)
 {
 	struct fttmr010 *fttmr010;
 	int irq;
@@ -345,7 +348,7 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 				     fttmr010->tick_rate);
 	}
 
-	fttmr010->timer_shutdown = fttmr010_timer_shutdown;
+	fttmr010->timer_shutdown = timer_shutdown;
 
 	/*
 	 * Setup clockevent timer (interrupt-driven) on timer 1.
@@ -354,7 +357,7 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 	writel(0, fttmr010->base + TIMER1_LOAD);
 	writel(0, fttmr010->base + TIMER1_MATCH1);
 	writel(0, fttmr010->base + TIMER1_MATCH2);
-	ret = request_irq(irq, fttmr010_timer_interrupt, IRQF_TIMER,
+	ret = request_irq(irq, irq_handler, IRQF_TIMER,
 			  "FTTMR010-TIMER1", &fttmr010->clkevt);
 	if (ret) {
 		pr_err("FTTMR010-TIMER1 no IRQ\n");
@@ -403,12 +406,16 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 
 static __init int aspeed_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, true);
+	return fttmr010_common_init(np, true,
+			fttmr010_timer_shutdown,
+			fttmr010_timer_interrupt);
 }
 
 static __init int fttmr010_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, false);
+	return fttmr010_common_init(np, false,
+			fttmr010_timer_shutdown,
+			fttmr010_timer_interrupt);
 }
 
 TIMER_OF_DECLARE(fttmr010, "faraday,fttmr010", fttmr010_timer_init);
-- 
2.24.0.rc1

