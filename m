Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4D6C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F367421D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7mVJluO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfKGURO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:17:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46627 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfKGURM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:17:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so4498228wrs.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uRNUCzVHW/hIxF0Wt4MmTdiGKyzYHqRtim9CvhWuCl8=;
        b=b7mVJluOUKDmGOK+t5dkGpYLWACM0Mxg3I2ksDrXsV1AOUrTp020NCVz230yrSTP/6
         DsxSuhNMEy6hu09xnJobHQOLiX5IeSHLjqIJqftr5asuGNcTQl6BHiZcLC3A+sodKArM
         csxbPNu4j18wVGFbXdDLUuQY33K3NqBaJes9EI8G7L1WEq0Lxy3ROyEs+Yl4joelU2YV
         l0xDUhDfve2NP6fBEQkmBtGju0TqgZ4axK/N7OkA2nZf6TFqJCdA20qiBiNAzffnaEut
         kiN5BUcF0+K+4B2bh/VvBBI7cojqw2G/6IO8Tg+NgVm5f+RTTlMDsajo/pLP2YNh9S7Y
         vHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uRNUCzVHW/hIxF0Wt4MmTdiGKyzYHqRtim9CvhWuCl8=;
        b=hh2JQ4bO4YdZD6joN7r4cpyYqZJcpNZx0GyiBcGRkczwbCk7s4njVeammW7Pqq8Mgj
         3BgsM2tp1hQut5fy0pIwLg+KnirnkQtqby4uB7VXMBRmcm3Coovrj5h97ZgaUl8YSAUL
         R4b/cEkd52s+4FywRkPVUtpr5EtQSfs9lHLk86RzKPDYaHZ/WSIrZ4/9aAf9qhDTeBoz
         K/31gRveW8S2mGKcFUGqqd4vYET9v6DDiglse1K3so4fw6HjM5nrVtBNrUXM8SmVkzhb
         TM4lsp368vgqCIYUkQk8RAtHOrtJcShOryLIUY65ysKXon96bS+AJEVFh7sriQPV8Ff2
         68TA==
X-Gm-Message-State: APjAAAXGi1oauH5U49yHjcMjBr+7J7kMBGqvNT4R+jN0CbPd6A3L5NXK
        GLf0hQLaDc0ypXSoPeCSerDoyA==
X-Google-Smtp-Source: APXvYqyRQPyz/sEvlLIRqSi+f8ccU5mRAvmLwG9ITZbMlr/3R4OPvKN5MHxXdK3a18tbASmtAYi7OQ==
X-Received: by 2002:a5d:6203:: with SMTP id y3mr4835347wru.142.1573157830378;
        Thu, 07 Nov 2019 12:17:10 -0800 (PST)
Received: from localhost.localdomain ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id d11sm3215162wrn.28.2019.11.07.12.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:17:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anson Huang <anson.huang@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 05/10] Input: imx_keypad - make sure keyboard can always wake up system
Date:   Thu,  7 Nov 2019 20:16:57 +0000
Message-Id: <20191107201702.27023-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107201702.27023-1-lee.jones@linaro.org>
References: <20191107201702.27023-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

[ Upstream commit ce9a53eb3dbca89e7ad86673d94ab886e9bea704 ]

There are several scenarios that keyboard can NOT wake up system
from suspend, e.g., if a keyboard is depressed between system
device suspend phase and device noirq suspend phase, the keyboard
ISR will be called and both keyboard depress and release interrupts
will be disabled, then keyboard will no longer be able to wake up
system. Another scenario would be, if a keyboard is kept depressed,
and then system goes into suspend, the expected behavior would be
when keyboard is released, system will be waked up, but current
implementation can NOT achieve that, because both depress and release
interrupts are disabled in ISR, and the event check is still in
progress.

To fix these issues, need to make sure keyboard's depress or release
interrupt is enabled after noirq device suspend phase, this patch
moves the suspend/resume callback to noirq suspend/resume phase, and
enable the corresponding interrupt according to current keyboard status.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Change-Id: I576fa685e1ab2c764703e5f65a3443e794bdafdd
---
 drivers/input/keyboard/imx_keypad.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 20a99c368d16..a5a4c83f2632 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -531,11 +531,12 @@ static int imx_keypad_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused imx_kbd_suspend(struct device *dev)
+static int __maybe_unused imx_kbd_noirq_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct imx_keypad *kbd = platform_get_drvdata(pdev);
 	struct input_dev *input_dev = kbd->input_dev;
+	unsigned short reg_val = readw(kbd->mmio_base + KPSR);
 
 	/* imx kbd can wake up system even clock is disabled */
 	mutex_lock(&input_dev->mutex);
@@ -545,13 +546,20 @@ static int __maybe_unused imx_kbd_suspend(struct device *dev)
 
 	mutex_unlock(&input_dev->mutex);
 
-	if (device_may_wakeup(&pdev->dev))
+	if (device_may_wakeup(&pdev->dev)) {
+		if (reg_val & KBD_STAT_KPKD)
+			reg_val |= KBD_STAT_KRIE;
+		if (reg_val & KBD_STAT_KPKR)
+			reg_val |= KBD_STAT_KDIE;
+		writew(reg_val, kbd->mmio_base + KPSR);
+
 		enable_irq_wake(kbd->irq);
+	}
 
 	return 0;
 }
 
-static int __maybe_unused imx_kbd_resume(struct device *dev)
+static int __maybe_unused imx_kbd_noirq_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct imx_keypad *kbd = platform_get_drvdata(pdev);
@@ -575,7 +583,9 @@ err_clk:
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(imx_kbd_pm_ops, imx_kbd_suspend, imx_kbd_resume);
+static const struct dev_pm_ops imx_kbd_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_kbd_noirq_suspend, imx_kbd_noirq_resume)
+};
 
 static struct platform_driver imx_keypad_driver = {
 	.driver		= {
-- 
2.24.0

