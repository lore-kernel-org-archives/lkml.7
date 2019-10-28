Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD3BCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DA4218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lMEc5oJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390558AbfJ1V7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:59:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40458 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390356AbfJ1V7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:59:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id r4so2215604pfl.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sf5eKNCSIBpNdFo6pBKVICUJYVHElXUrV/RD8eO146c=;
        b=lMEc5oJeuYWUcVxXpphSMAIRavQ29nAcI5d2oKIF5KsDKcFZnIO8Rcwx8rlC2A8Zf/
         CF5EjelirIgQYnWaDQFgrG7r+Oh+liDGWYseTgIuogkTucMwvA9ZsP/LheVHE/zFsbcS
         MpnCEZ0dr7M6+w8sAnEgZXE/TPEx6kssrdjMLA9cAPy4zvF/Q7Z084sRASR5cfwrE156
         Dq2WaWlxclZJyvBepM8NvQKGSkQV4UrmPKJjFOsfHATm/IoZihLaQwjrWyKTuHXgICUq
         DI5KCli3WtY+muIL2MpvQmZSAfF1FcdKcY0GT06yRWMhwtT4FmfKoizuKQyE3WTTIj8a
         t4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sf5eKNCSIBpNdFo6pBKVICUJYVHElXUrV/RD8eO146c=;
        b=J/xyK3xyNYmGTQxsIGQO4xCMFRD5jjqqQUQZDc8raoxMMRv5Q3AQrv9yjMPM+mbKqd
         WFgX4WsSdSci3omBboLUmHKxGG3eXBKXTtc3tRKVAAmKiEHOYyJF5kCNnY2sFbR5bCTW
         +QUGlBkJlP+D+oUC1mWhTH9PW7vpyUinZWzhQapn6kWVEe1kIYMx6WOPjJ0hCGhfad8x
         KdVMHnbZuHATOHiYOwmj9prY3iNaAvzOfs52BhvIPP6Aj13h8xwQqo1+Hj3uW9TgnZcc
         0uQa63mJ8ne79TEx4rRWcbZqFYMXbZFtSTuPupFkMWUPhgzJT9b2U4yNzxvjQw8mbEko
         96jQ==
X-Gm-Message-State: APjAAAWgjIVX3/kPmINE1nDSlZ8Yf1xRQVvMOaBSwn3qUJplcYV1YCNi
        HsdTUgtRX2gkJMScgbCzQexSzFuc5EE=
X-Google-Smtp-Source: APXvYqzV4dIrv4WayXRoBFG9n15lx1cNIer3M6DVGTDjqIPPzgjtWxEe21YsXYhKjId/Zy5mg6XkmQ==
X-Received: by 2002:a62:5c07:: with SMTP id q7mr22638078pfb.159.1572299969484;
        Mon, 28 Oct 2019 14:59:29 -0700 (PDT)
Received: from localhost.localdomain (c-67-170-172-113.hsd1.or.comcast.net. [67.170.172.113])
        by smtp.gmail.com with ESMTPSA id f12sm10880612pfn.152.2019.10.28.14.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:59:28 -0700 (PDT)
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
Subject: [PATCH v4 5/9] usb: dwc3: Rework clock initialization to be more flexible
Date:   Mon, 28 Oct 2019 21:59:15 +0000
Message-Id: <20191028215919.83697-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028215919.83697-1-john.stultz@linaro.org>
References: <20191028215919.83697-1-john.stultz@linaro.org>
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

This patch was reccomended by Rob Herring <robh@kernel.org>
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
Suggested-by: Rob Herring <robh@kernel.org>
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

