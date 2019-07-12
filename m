Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A6C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A8820863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cB0TVUt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfGLH0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 03:26:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35763 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfGLH0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:26:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so4152214pgl.2;
        Fri, 12 Jul 2019 00:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWwViFouQwIqf+g6UOw7AyeWqZT4DAg0WEkB/L7FLMM=;
        b=cB0TVUt6dyKb/5lupeLcQvlW5q+/B9s2ocU5oy6XlYQw3nNCRrNPrWXgqDk+X828c5
         tvMfwQ4ASQ7PSdCF2oEB1jZPCsDexgRfg3ElMjq4N6+bJhrXVb6CJGWNSjc+DrBjAIwK
         GQLLiLqB5a+je2oG5C6VlDl1LRrs0t2fduLKZ6iPXO2q5nYaPjyRfWtxHsT9pc3fFQ5/
         ozW4sBTnyrIn3CBUgs7a2Z5WAfy+hTQfb699pFetLBxxZlGkT8Z03LQLKTIFmUgyqUHh
         +Fjz+2r7mvDnX6YzatFej80xBKk9TjMahbDSXKLi4flSgiuyUl/Hp72XSnQbk3NFetBV
         ct+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWwViFouQwIqf+g6UOw7AyeWqZT4DAg0WEkB/L7FLMM=;
        b=LTdN8J7u/KB/tFm5YXAsy0ZEh1yRMmFMcVAO6BxKNCRr6nCxzm4Z2lepo3V0aK6HZ/
         l94U/oQEjQHkmJXXutiFWOUsF3+LqjUgyLZnQbif3CsfY13wT3QsGuiQfnaHm1Kovmi+
         SAVJC6jYiRzz+7Gxo2m4R9GsJLwuAVM2dkhn8PGOylsmT/tIxrXorPqq2lbbuX26NsKb
         RnQFT4+Il9u6MVsUay5yZnBO6cflTai4JH2evB0cIfSu6vzV0iyY1bUB/SlyVAUCUTDZ
         0+FV+xZlKOmyQDDkAu2Vmfw4DEaX+MciZwcEZJz4jlfzIxRTpB1ANOnNhfyT4WkP/mhy
         WeYg==
X-Gm-Message-State: APjAAAW94lJQecpJDL8LsqnZLN4XPDJh3PHRMAnqo9Ul0XX+EZ5RHkHv
        0z0oSRbaD8/qAmV3XhU7z/vkQMt2QIs=
X-Google-Smtp-Source: APXvYqz6HFxbeWNJWr/m54Pkxgp4cifA4bybur1EvREhe7MrAKgMwL+fneDTNbo/65f+WZ/+dyV1ew==
X-Received: by 2002:a17:90a:32c7:: with SMTP id l65mr9950937pjb.1.1562916401807;
        Fri, 12 Jul 2019 00:26:41 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id c8sm13795725pjq.2.2019.07.12.00.26.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 00:26:41 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb: dwc3: Use clk_bulk_prepare_enable()
Date:   Fri, 12 Jul 2019 00:26:34 -0700
Message-Id: <20190712072634.3107-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190712072634.3107-1-andrew.smirnov@gmail.com>
References: <20190712072634.3107-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clk_bulk_prepare_enable() and clk_bulk_disable_unprepare() to
simplify code a bit. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/usb/dwc3/core.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 768023a2553c..f0e0cbe9254a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -686,8 +686,7 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	phy_power_off(dwc->usb2_generic_phy);
 	phy_power_off(dwc->usb3_generic_phy);
-	clk_bulk_disable(dwc->num_clks, dwc->clks);
-	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
 	reset_control_assert(dwc->reset);
 }
 
@@ -1451,14 +1450,10 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare(dwc->num_clks, dwc->clks);
+	ret = clk_bulk_prepare_enable(dwc->num_clks, dwc->clks);
 	if (ret)
 		goto assert_reset;
 
-	ret = clk_bulk_enable(dwc->num_clks, dwc->clks);
-	if (ret)
-		goto unprepare_clks;
-
 	if (!dwc3_core_is_valid(dwc)) {
 		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
 		ret = -ENODEV;
@@ -1531,9 +1526,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 disable_clks:
-	clk_bulk_disable(dwc->num_clks, dwc->clks);
-unprepare_clks:
-	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
 assert_reset:
 	reset_control_assert(dwc->reset);
 
@@ -1571,14 +1564,10 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare(dwc->num_clks, dwc->clks);
+	ret = clk_bulk_prepare_enable(dwc->num_clks, dwc->clks);
 	if (ret)
 		goto assert_reset;
 
-	ret = clk_bulk_enable(dwc->num_clks, dwc->clks);
-	if (ret)
-		goto unprepare_clks;
-
 	ret = dwc3_core_init(dwc);
 	if (ret)
 		goto disable_clks;
@@ -1586,9 +1575,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	return 0;
 
 disable_clks:
-	clk_bulk_disable(dwc->num_clks, dwc->clks);
-unprepare_clks:
-	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
 assert_reset:
 	reset_control_assert(dwc->reset);
 
-- 
2.21.0

