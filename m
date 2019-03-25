Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC9EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5878520830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfCYV7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:59:22 -0400
Received: from muru.com ([72.249.23.125]:42654 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730641AbfCYV7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:59:20 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 0B9EF80CC;
        Mon, 25 Mar 2019 21:59:32 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/14] bus: ti-sysc: Add support for early quirks based on register address
Date:   Mon, 25 Mar 2019 14:58:45 -0700
Message-Id: <20190325215849.13182-11-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least mcpdm needs an optional external clock enabled to function and
this clock typically comes from the PMIC. We can detect mcpdm based on
the interconnect target module address and set a quirk flag early.

To do this, let's initialize the clocks a bit later and add a new
function for sysc_init_early_quirks(). Note that we cannot yet enable
the early quirks for mcpdm until the optional external clocks are
handled in the in the following patch.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 46 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -959,6 +959,42 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 #endif
 };
 
+/*
+ * Early quirks based on module base and register offsets only that are
+ * needed before the module revision can be read
+ */
+static void sysc_init_early_quirks(struct sysc *ddata)
+{
+	const struct sysc_revision_quirk *q;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sysc_revision_quirks); i++) {
+		q = &sysc_revision_quirks[i];
+
+		if (!q->base)
+			continue;
+
+		if (q->base != ddata->module_pa)
+			continue;
+
+		if (q->rev_offset >= 0 &&
+		    q->rev_offset != ddata->offsets[SYSC_REVISION])
+			continue;
+
+		if (q->sysc_offset >= 0 &&
+		    q->sysc_offset != ddata->offsets[SYSC_SYSCONFIG])
+			continue;
+
+		if (q->syss_offset >= 0 &&
+		    q->syss_offset != ddata->offsets[SYSC_SYSSTATUS])
+			continue;
+
+		ddata->name = q->name;
+		ddata->cfg.quirks |= q->quirks;
+	}
+}
+
+/* Quirks that also consider the revision register value */
 static void sysc_init_revision_quirks(struct sysc *ddata)
 {
 	const struct sysc_revision_quirk *q;
@@ -1825,10 +1861,6 @@ static int sysc_probe(struct platform_device *pdev)
 	if (error)
 		goto unprepare;
 
-	error = sysc_get_clocks(ddata);
-	if (error)
-		return error;
-
 	error = sysc_map_and_check_registers(ddata);
 	if (error)
 		goto unprepare;
@@ -1849,6 +1881,12 @@ static int sysc_probe(struct platform_device *pdev)
 	if (error)
 		goto unprepare;
 
+	sysc_init_early_quirks(ddata);
+
+	error = sysc_get_clocks(ddata);
+	if (error)
+		return error;
+
 	error = sysc_init_resets(ddata);
 	if (error)
 		return error;
-- 
2.21.0
