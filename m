Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801B8C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C85724654
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cGOZzqU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfLLBnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:43:02 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46381 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfLLBmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:42:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so257871pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 17:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G6kjJoovlC6cVfetXCubnmxNfzySZyzH70fmpOskqm8=;
        b=cGOZzqU13JOBPam+xdKigkTIGiAjbtkPvBYtjMIcRGUuLi4JiP7MUinvcn6DCHl3if
         FfTvBb4dk8U5AMVmF2CjA3dX++wBfx3pTTGhYpwAXjF+gVP7q2lyOJ71aGuUEDGgLDk+
         TMnP3JbWjTdAvowKhz6F66lifrsJQu8cJUerpX+PE5lpkYRjgLc7ZYnOaB5FZFDeXZLZ
         4XTD82pAK9BsC4PJHfrpswrG46E7SuRpdj1/clKJtXJ/dD0FqdjFwSmynLis5GtK1lV7
         /4QvRxBrdkNP0ceSSZ49Ot9qJNQWbR+IUoA7OE66lecnIgheFt5rQQ4O7VaQtW+J/H3+
         w9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G6kjJoovlC6cVfetXCubnmxNfzySZyzH70fmpOskqm8=;
        b=FdFD6hIUyRpgKIxFZaIAeG5GCUhAhg/0RhMR9g4H7GrGYWF6io5N8QxGgf0Qa7zCL9
         cERBKnmG4PiTQkCHFbnKTWJPVtTELZFEnZ0CExNZlXPPmNT/rh9LX3sYNFuwpvN78tXY
         NWmlLb9hncZF3yeujCFlYRKC62y+VcS0zqD4cxx3B80pKZ1N5mTKx4koeMtIdIPWYUdD
         IRKYl7uvnune9kyGZ0tqWF5N3dhj1/OQmpdfzGPt5/I1UkqKhD50C68Rzsts9je4NX95
         903TxImpEdqW8FU9TXRN8kxPhyX/2xYGESSMdkJrxu10VM/k55e7PrMQcdQxC4NkKy8d
         sFjw==
X-Gm-Message-State: APjAAAXEZ34G70dYa0GRNbU+pB/hPqu88nOYmeGlYJeLaAK2TZn3kuia
        Ybexe9esJRsYIVk7l7Zy1XMknFlssFw=
X-Google-Smtp-Source: APXvYqwpqM70vNZbKae/RwdZ2CYgbgIkvtbmpvMV4ONBua+4aE8gJ9REa97neloI95Wm/o50zRSkzw==
X-Received: by 2002:a62:1a97:: with SMTP id a145mr7398556pfa.244.1576114961674;
        Wed, 11 Dec 2019 17:42:41 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id p16sm4217996pgi.50.2019.12.11.17.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 17:42:41 -0800 (PST)
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
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 5/8] usb: dwc3: Rework clock initialization to be more flexible
Date:   Thu, 12 Dec 2019 01:42:30 +0000
Message-Id: <20191212014233.32799-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212014233.32799-1-john.stultz@linaro.org>
References: <20191212014233.32799-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc3 core binding specifies three clocks:
  ref, bus_early, and suspend

which are all controlled in the driver together.

However some variants of the hardware my not have all three
clks, or some may have more. Usually this was handled by using
the dwc3-of-simple glue driver, but that resulted in a
proliferation of bindings for for every variant, when the only
difference was the clocks and resets lists.

So this patch reworks the reading of the clks from the dts to
use devm_clk_bulk_get_all() will will fetch all the clocks
specified in the dts together.

This patch was recommended by Rob Herring <robh@kernel.org>
as an alternative to creating multiple bindings for each variant
of hardware.

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
Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Rework dwc3 core rather then adding another dwc-of-simple
    binding.
v6: Re-introduce this patch, on Rob's suggestion
---
 drivers/usb/dwc3/core.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f561c6c9e8a9..c6316d4b7593 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -289,12 +289,6 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
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
@@ -1438,11 +1432,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (!dwc)
 		return -ENOMEM;
 
-	dwc->clks = devm_kmemdup(dev, dwc3_core_clks, sizeof(dwc3_core_clks),
-				 GFP_KERNEL);
-	if (!dwc->clks)
-		return -ENOMEM;
-
 	dwc->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1478,17 +1467,18 @@ static int dwc3_probe(struct platform_device *pdev)
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

