Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC6AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62DB20645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfCYV7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:59:08 -0400
Received: from muru.com ([72.249.23.125]:42610 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729478AbfCYV7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:59:06 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 9C0DD81AE;
        Mon, 25 Mar 2019 21:59:18 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/14] bus: ti-sysc: Move legacy platform data idling into separate functions
Date:   Mon, 25 Mar 2019 14:58:39 -0700
Message-Id: <20190325215849.13182-5-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move the legacy idle and enable into separate functions to simplify
PM runtime functions a bit.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 78 +++++++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -622,9 +622,50 @@ static void sysc_show_registers(struct sysc *ddata)
 		buf);
 }
 
-static int __maybe_unused sysc_runtime_suspend(struct device *dev)
+static int __maybe_unused sysc_runtime_suspend_legacy(struct device *dev,
+						      struct sysc *ddata)
+{
+	struct ti_sysc_platform_data *pdata;
+	int error;
+
+	pdata = dev_get_platdata(ddata->dev);
+	if (!pdata)
+		return 0;
+
+	if (!pdata->idle_module)
+		return -ENODEV;
+
+	error = pdata->idle_module(dev, &ddata->cookie);
+	if (error)
+		dev_err(dev, "%s: could not idle: %i\n",
+			__func__, error);
+
+	return 0;
+}
+
+static int __maybe_unused sysc_runtime_resume_legacy(struct device *dev,
+						     struct sysc *ddata)
 {
 	struct ti_sysc_platform_data *pdata;
+	int error;
+
+	pdata = dev_get_platdata(ddata->dev);
+	if (!pdata)
+		return 0;
+
+	if (!pdata->enable_module)
+		return -ENODEV;
+
+	error = pdata->enable_module(dev, &ddata->cookie);
+	if (error)
+		dev_err(dev, "%s: could not enable: %i\n",
+			__func__, error);
+
+	return 0;
+}
+
+static int __maybe_unused sysc_runtime_suspend(struct device *dev)
+{
 	struct sysc *ddata;
 	int error = 0, i;
 
@@ -634,19 +675,11 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 		return 0;
 
 	if (ddata->legacy_mode) {
-		pdata = dev_get_platdata(ddata->dev);
-		if (!pdata)
-			return 0;
-
-		if (!pdata->idle_module)
-			return -ENODEV;
-
-		error = pdata->idle_module(dev, &ddata->cookie);
-		if (error)
-			dev_err(dev, "%s: could not idle: %i\n",
-				__func__, error);
+		error = sysc_runtime_suspend_legacy(dev, ddata);
+		if (!error)
+			ddata->enabled = false;
 
-		goto idled;
+		return error;
 	}
 
 	for (i = 0; i < ddata->nr_clocks; i++) {
@@ -659,7 +692,6 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 		clk_disable(ddata->clocks[i]);
 	}
 
-idled:
 	ddata->enabled = false;
 
 	return error;
@@ -667,7 +699,6 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 
 static int __maybe_unused sysc_runtime_resume(struct device *dev)
 {
-	struct ti_sysc_platform_data *pdata;
 	struct sysc *ddata;
 	int error = 0, i;
 
@@ -677,19 +708,11 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 		return 0;
 
 	if (ddata->legacy_mode) {
-		pdata = dev_get_platdata(ddata->dev);
-		if (!pdata)
-			return 0;
+		error = sysc_runtime_resume_legacy(dev, ddata);
+		if (!error)
+			ddata->enabled = true;
 
-		if (!pdata->enable_module)
-			return -ENODEV;
-
-		error = pdata->enable_module(dev, &ddata->cookie);
-		if (error)
-			dev_err(dev, "%s: could not enable: %i\n",
-				__func__, error);
-
-		goto awake;
+		return error;
 	}
 
 	for (i = 0; i < ddata->nr_clocks; i++) {
@@ -704,7 +727,6 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 			return error;
 	}
 
-awake:
 	ddata->enabled = true;
 
 	return error;
-- 
2.21.0
