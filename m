Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EB4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A6520645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfCYV7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:59:19 -0400
Received: from muru.com ([72.249.23.125]:42642 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730641AbfCYV7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:59:16 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 8869880CC;
        Mon, 25 Mar 2019 21:59:28 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/14] bus: ti-sysc: Manage clocks for the interconnect target module in all cases
Date:   Mon, 25 Mar 2019 14:58:43 -0700
Message-Id: <20190325215849.13182-9-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are currently not managing interconnect target module clocks in the
for legacy platform data based case. This causes a problem for using the
platform data based functions when dropping the platform data for the
interconnect target module configuration.

To avoid a situation where we need to populate the main and optional
clocks also for the platform data based functions, let's just manage the
clocks directly in ti-sysc driver. This means that until the interconnect
target module confugration platform data is dropped our use count for
clk_enable() will be 2 instead of 1.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -783,10 +783,8 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 
 	if (ddata->legacy_mode) {
 		error = sysc_runtime_suspend_legacy(dev, ddata);
-		if (!error)
-			ddata->enabled = false;
-
-		return error;
+		if (error)
+			return error;
 	}
 
 	sysc_disable_main_clocks(ddata);
@@ -809,14 +807,6 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 	if (ddata->enabled)
 		return 0;
 
-	if (ddata->legacy_mode) {
-		error = sysc_runtime_resume_legacy(dev, ddata);
-		if (!error)
-			ddata->enabled = true;
-
-		return error;
-	}
-
 	if (sysc_opt_clks_needed(ddata)) {
 		error = sysc_enable_opt_clocks(ddata);
 		if (error)
@@ -825,13 +815,21 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 
 	error = sysc_enable_main_clocks(ddata);
 	if (error)
-		goto err_main_clocks;
+		goto err_opt_clocks;
+
+	if (ddata->legacy_mode) {
+		error = sysc_runtime_resume_legacy(dev, ddata);
+		if (error)
+			goto err_main_clocks;
+	}
 
 	ddata->enabled = true;
 
 	return 0;
 
 err_main_clocks:
+	sysc_disable_main_clocks(ddata);
+err_opt_clocks:
 	if (sysc_opt_clks_needed(ddata))
 		sysc_disable_opt_clocks(ddata);
 
-- 
2.21.0
