Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2DBC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D062186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfHZWwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:52:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41443 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfHZWwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:52:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2NqN-0006lm-44; Tue, 27 Aug 2019 00:52:11 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 449DD1C07BA;
        Tue, 27 Aug 2019 00:52:10 +0200 (CEST)
Date:   Mon, 26 Aug 2019 22:52:09 -0000
From:   tip-bot2 for Stephen Boyd <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Remove dev_err() usage after
 platform_get_irq()
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156685992999.1273.17571593064236730961.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9f475d084c032116cbecd4dc840003dc36465db5
Gitweb:        https://git.kernel.org/tip/9f475d084c032116cbecd4dc840003dc36465db5
Author:        Stephen Boyd <swboyd@chromium.org>
AuthorDate:    Tue, 30 Jul 2019 11:15:04 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Aug 2019 00:31:39 +02:00

clocksource: Remove dev_err() usage after platform_get_irq()

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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/em_sti.c | 4 +---
 drivers/clocksource/sh_cmt.c | 5 +----
 drivers/clocksource/sh_tmu.c | 5 +----
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index 8e12b11..9039df4 100644
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
index 55d3e03..f6424b6 100644
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
index 49f1c80..8c4f375 100644
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
