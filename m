Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B1EC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CD52184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvJVE2Ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfHZUol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:44:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46128 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfHZUol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:44:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so16584957wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qsyqwo/7IzN3JSHEHiK8TRXncaQG6D+RLJ1heXtDIs0=;
        b=fvJVE2DsN4hPUHTHlqLGnsV7U//T7wLenuDI4BZlpfMSSPF2NCpNCccfjhg05pUtkU
         LQQla8rZQUNfdu4RAUa+pwxR8yx7gINvMIwo41b8ADw2XKkcrLE1iqs3GUu7WinwFvyp
         ZE4l8/40dTHBGLLhXBfPnKQiqxhLAU6L06RG96VU2nMXsBYAe0oixZpa6XVmVL9yd8pT
         fx+Unu+WbbMScX5dMW3CLn86cWmU6cpxxkfWaJhn3PdftvmB11+QjCYu61WtNCl5jsvZ
         3KRyXDIwtkFFI/0AiBT6nM+AWVZugqplcI8aeRpGgNkUB8jJpmnBr7Ul/PIsQhaB3Xgs
         BmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qsyqwo/7IzN3JSHEHiK8TRXncaQG6D+RLJ1heXtDIs0=;
        b=FwEuEBWFAKYbaRQVHjEwbT4kJNRoF09gqJrBn8o1gCKPWvAl7dx29eBDBJSusvQK2V
         XDp/K3uXduJVflbnLJb0wBquP/QdeqIvTtQYNd9+Hav0fuM107XNvOsHg3yDTuArY0Us
         FrO+Tpu5TJNlHJ/rg9wmBbuRYUP0yYI9/U1VTbSXJYvthScqb7nzrL+yUAwVb0B9nlXe
         sTaR9xAI1sgMCYqQuon53F4e8VPTch0Gd+gVP0uxX4wpatlXY21SXDWjHqKlaHcK/NrC
         843bE4Kc2uzixJlmBjtCD6EWM0dE2GoaKroc0iFjFOZelMx/11BbQXNmUK1qBZVMCQl9
         mBhQ==
X-Gm-Message-State: APjAAAUn9GHhblHqymqAZcWMM1c2l5YamYgtFso/u8z4XYFyeu73WeS/
        qJODXEypMQCgZ0v4HDu1OWYmeKOtWCg=
X-Google-Smtp-Source: APXvYqzbVln4ACLylQBnLOO0yt13MtqhiboJ90eMdpG02kbo38scjAEIVFi5TMZuvZcD29JuP7AQEw==
X-Received: by 2002:a5d:4cc5:: with SMTP id c5mr23365381wrt.278.1566852279372;
        Mon, 26 Aug 2019 13:44:39 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:44:38 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 01/20] clocksource: Remove dev_err() usage after platform_get_irq()
Date:   Mon, 26 Aug 2019 22:43:48 +0200
Message-Id: <20190826204407.17759-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

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
2.17.1

