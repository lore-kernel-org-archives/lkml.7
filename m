Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678E7C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0CB2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MTmVbzT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfG3SUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:20:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39992 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfG3SQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so30255273pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WqnP5pBY6aQYlpjg6EOYyndcooTiqsLsFL8lZlLzN+U=;
        b=MTmVbzT3m0PXTQ9blNFhLXdJJ1/PA9DulRvg9x45w14FOHgKM5QBLmsH+mBfY2XflK
         ReHiXz0JsNu4/f/5PZJ8crgr/2/VaA3sveOh5vrV3ygXnjK0/7GpiESxhi9vzsNGo3Dn
         tMK/mpQwKLyLYsQd+eE2qD339vyfdxhUMRsgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WqnP5pBY6aQYlpjg6EOYyndcooTiqsLsFL8lZlLzN+U=;
        b=kd3bnKrPHjNrIUvf47UzD0Cio7cuV2OJ4BSoxb8CqmwWZtKGdMuJ1wvJ1+RSkKIIM2
         tWMOkEFOp3d/jODJbPIQDh1Zcldg84R7cv54OkanJi94+goonZmLZ0SmibrfZsvmRhUK
         BeIKYUIgqvGx5F3wlC7T7LhZRpUF4WZ79F3IAktTvrC6A3qXX/+xszEMVWgO8d2O5grv
         ZyrxgfU0VSL8hUJ7xyIZDufKgBP8jGeXKO0XA5Jmhb2RnUCZW00ZCjoHprg9TwqvPX11
         +uo9kRaKOYAP/vETeyWnr5I1NIhP6/WsBg/jFGth+ALhsPQK4xlJIRyvnqSoGgslfxm/
         VpMw==
X-Gm-Message-State: APjAAAX1UDuXDhx1M/bUl3TbioSD+ZHLB+7s+L2qpDJu0dzPVk4/jdyD
        INmHcvzTi043EgPqboDuvLuVDpaeynw=
X-Google-Smtp-Source: APXvYqx3NAn8hmPXUNVhZt3irZVuWFfprkMsdB5KsNDxO+BhG8v0uXxUdNs0kGYdTa0IeW/sz59WoQ==
X-Received: by 2002:a63:5d54:: with SMTP id o20mr93933941pgm.413.1564510562231;
        Tue, 30 Jul 2019 11:16:02 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:01 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v6 04/57] clocksource: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:04 -0700
Message-Id: <20190730181557.90391-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/clocksource/em_sti.c | 4 +---
 drivers/clocksource/sh_cmt.c | 5 +----
 drivers/clocksource/sh_tmu.c | 5 +----
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index 8e12b11e81b0..9039df4f90e2 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -291,10 +291,8 @@ static int em_sti_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, p);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	/* map memory, let base point to the STI instance */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 55d3e03f2cd4..f6424b61e212 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -776,11 +776,8 @@ static int sh_cmt_register_clockevent(struct sh_cmt_channel *ch,
 	int ret;
 
 	irq = platform_get_irq(ch->cmt->pdev, ch->index);
-	if (irq < 0) {
-		dev_err(&ch->cmt->pdev->dev, "ch%u: failed to get irq\n",
-			ch->index);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = request_irq(irq, sh_cmt_interrupt,
 			  IRQF_TIMER | IRQF_IRQPOLL | IRQF_NOBALANCING,
diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 49f1c805fc95..8c4f3753b36e 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -462,11 +462,8 @@ static int sh_tmu_channel_setup(struct sh_tmu_channel *ch, unsigned int index,
 		ch->base = tmu->mapbase + 8 + ch->index * 12;
 
 	ch->irq = platform_get_irq(tmu->pdev, index);
-	if (ch->irq < 0) {
-		dev_err(&tmu->pdev->dev, "ch%u: failed to get irq\n",
-			ch->index);
+	if (ch->irq < 0)
 		return ch->irq;
-	}
 
 	ch->cs_enabled = false;
 	ch->enable_count = 0;
-- 
Sent by a computer through tubes

