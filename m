Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50856ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2822E2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLkbH/AL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391077AbfJPDey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:34:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46945 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403847AbfJPDdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:33:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id e15so5392352pgu.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 20:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mmGMZQlCR6mgA59oWS1f2Nk927cLgLJYDtngM3i0DmQ=;
        b=uLkbH/AL8pOg7wAkq783Kv7Wli+S4S1fkwXvQK1hsdZz8RMDlTmkhaDVpBDw/mkoO4
         zBTWunDgn6kC1ewqFmgahk4sa4DL54pMRwCKWKiTye44tvTXsqTp6tTiQkBUQj9ZE7WX
         GFlecPGJ8qg9BS/QnlLtz2ltiSGv/DD9h60Nk3yaik8zidbbaF1cr9PvCiBb3MgexH43
         QqgoYOBBbb1zOJvedENxG6asKQFB/TzSZAY/z04OpFQSmYX6mevmQD1DMHMmEQbMZkNW
         uW8J/Od3UKmRiRZSjx5lUM8HYObGLRFjd7aVMByq0wV3Rc+Qi/ZvxrF44OpKP2tjyR0R
         0vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mmGMZQlCR6mgA59oWS1f2Nk927cLgLJYDtngM3i0DmQ=;
        b=dNtecFIT+kwkj7f1rpyTQQ+IeCI1QJcXDyzzbr9i8X9axNej4nRT1ZFzkxJwHgFP3K
         zOWSU79XpOyVrk961K5Y8W/RC8YLjZeZHhvD3JXcm3oJg7AUgm95Aki0HnwdnI5VTEUN
         UlAFn+dOHsKib6lYONUAaHiEsye3MyX3TXhwn2Ft8J4J9rPadysgTKlrq1MoIJ1MIO7h
         9SmIbwP7uXYhR4t1VushNG5GQ734MXBrpGwJCezeowIQ9Bo3lVpn2MTrk66Qe/z/q/pF
         3uVRPWpOGcAZyx1qYlZY+kz8lO9ymJU6gRp0dDYczmQsSorDRYhIMy/VMY7VHYUmNH1w
         DUUg==
X-Gm-Message-State: APjAAAWWzteDCtzxqkVzTnUKqcokMCokusZt7Ehz6RpsDUrgzkvD8xfO
        Dyy5NIbG+kX1AUNj8Jev3r5RGj0ETGg=
X-Google-Smtp-Source: APXvYqws+YMGIIyJ9Z71j/JJfgVn5iU2tJXSMhO0gdaPFucclq53zCDhmjLlxCTNhG2oSTVllo97hA==
X-Received: by 2002:a62:e206:: with SMTP id a6mr42231705pfi.64.1571196830986;
        Tue, 15 Oct 2019 20:33:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id l23sm748356pjy.12.2019.10.15.20.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 20:33:50 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC][PATCH v3 05/11] usb: dwc3: Rework clock initialization to be more flexible
Date:   Wed, 16 Oct 2019 03:33:34 +0000
Message-Id: <20191016033340.1288-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016033340.1288-1-john.stultz@linaro.org>
References: <20191016033340.1288-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc3 core binding specifies three clocks:
  ref, bus_early, and suspend

which are all controlled in the driver together.

However some variants of the hardware my not have all three clks

So this patch reworks the reading of the clks from the dts to
use devm_clk_bulk_get_all() will will fetch all the clocks
specified in the dts together.

This patch was reccomended by Rob Herring <Rob.Herring@arm.com>
as an alternative to creating multiple bindings for each variant
of hardware when the only unique bits were clocks and resets.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
CC: ShuFan Lee <shufan_lee@richtek.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Suggested-by: Rob Herring <Rob.Herring@arm.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Rework dwc3 core rather then adding another dwc-of-simple
    binding.
---
 drivers/usb/dwc3/core.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a039e35ec7ad..4d4f1836b62c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -305,12 +305,6 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	return 0;
 }
 
-static const struct clk_bulk_data dwc3_core_clks[] = {
-	{ .id = "ref" },
-	{ .id = "bus_early" },
-	{ .id = "suspend" },
-};
-
 /*
  * dwc3_frame_length_adjustment - Adjusts frame length if required
  * @dwc3: Pointer to our controller context structure
@@ -1418,11 +1412,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (!dwc)
 		return -ENOMEM;
 
-	dwc->clks = devm_kmemdup(dev, dwc3_core_clks, sizeof(dwc3_core_clks),
-				 GFP_KERNEL);
-	if (!dwc->clks)
-		return -ENOMEM;
-
 	dwc->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1458,17 +1447,18 @@ static int dwc3_probe(struct platform_device *pdev)
 		return PTR_ERR(dwc->reset);
 
 	if (dev->of_node) {
-		dwc->num_clks = ARRAY_SIZE(dwc3_core_clks);
-
-		ret = devm_clk_bulk_get(dev, dwc->num_clks, dwc->clks);
+		ret = devm_clk_bulk_get_all(dev, &dwc->clks);
 		if (ret == -EPROBE_DEFER)
 			return ret;
 		/*
 		 * Clocks are optional, but new DT platforms should support all
 		 * clocks as required by the DT-binding.
 		 */
-		if (ret)
+		if (ret < 0)
 			dwc->num_clks = 0;
+		else
+			dwc->num_clks = ret;
+
 	}
 
 	ret = reset_control_deassert(dwc->reset);
-- 
2.17.1

