Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E892BC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DCE218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcXolU53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbfKGJm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:42:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35124 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbfKGJmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:42:53 -0500
Received: by mail-pl1-f194.google.com with SMTP id s10so1043167plp.2;
        Thu, 07 Nov 2019 01:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l6fQtcELJmj8Ufi/6HsaS+YZlcVXTo33kel1eq2jWiM=;
        b=FcXolU53yZMd7MxontPqybCpuQCOcNID8VJPWI8Ojv1IU1HtTdnaEs+LSzmCD0XPBv
         PykuyNth+2KkAiFplj2GuansWh5sG3fAwVB+/3ewwP7gkfU/GnhxQWMl95sPhb+hEmem
         jqDwUP+9SJlS8hkA0ZqSBoHXgduPrXGEkp12XOYHCLJlimcedaJQu7T6/yzfwRgfefrH
         RGvqrGbfSM1HM1iGOrgd4adSjUW6o9/YGkiZid+TqlY/myY9RcGdQ6jdgavMPVaAi9m5
         wvMTOFNq8cAQe2S9uqj4I7RwOyULG3bUhhHVN6TV3xny6rvMZ0ZoTJtZhp18GDNIkkz/
         1q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=l6fQtcELJmj8Ufi/6HsaS+YZlcVXTo33kel1eq2jWiM=;
        b=MSnKfCFvnLYua6O+ID5D5xR293UQvJyrmExPOmcgz2HdAsimRHckInqlN4Y+/l5SAy
         Y7R9wuwXJbLRX/ppMbLmVVLsfWLjIR76zZoyDhIBb9yQxIII9N+Az2UCSNlz7JAyYx/3
         QMiIjBdruPpVLR4PLHF55gnQ5CD+geUwtGJFCjuUjkfvQOgk74EIoRh5MRkOBgKHjGUp
         Nup3/ukkOgqlg4A43QVBnwcqLNTZSQLVpMcozBOYwh+7PkNMV8uRbomK8LtBGH3ryEgH
         pheCpSzPjS+9vxxN0iP00F3CqJoyqTEV1ZsMvUC6/61hSwyI/2ZUFH19wYBLDFO59RAN
         RXwQ==
X-Gm-Message-State: APjAAAVA0RqE8M+1DIAu13F6z/g4g89DeBegU3KUB3rIxFgf7tXT6POS
        NEnpZXsgAupvu1osH5jRNDw=
X-Google-Smtp-Source: APXvYqzN50Oa8h9XEMmNxQUiXMv10W2nkVb7jn1du5dGzeAaffSiEa9nTvbpbaX8ruc0v1SrNQE3KQ==
X-Received: by 2002:a17:902:8348:: with SMTP id z8mr2825994pln.130.1573119771780;
        Thu, 07 Nov 2019 01:42:51 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id 12sm1958195pfp.79.2019.11.07.01.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 01:42:51 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v2 3/4] clocksource: fttmr010: Add support for ast2600
Date:   Thu,  7 Nov 2019 20:12:17 +1030
Message-Id: <20191107094218.13210-4-joel@jms.id.au>
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

The ast2600 has some minor differences to previous versions. The
interrupt handler must acknowledge the timer interrupt in a status
register. Secondly the control register becomes write to set only,
requiring the use of a separate set to clear register.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
--
v2: Add ast2600 prefix to define to make it clear it's for ast2600 only
---
 drivers/clocksource/timer-fttmr010.c | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index 7c20a3debd96..1510ee106e8d 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -37,6 +37,11 @@
 #define TIMER3_MATCH2		(0x2c)
 #define TIMER_CR		(0x30)
 
+/*
+  Control register set to clear for ast2600 only.
+ */
+#define AST2600_TIMER_CR_CLR	(0x3c)
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
+	writel(fttmr010->t1_enable_val, fttmr010->base + AST2600_TIMER_CR_CLR);
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

