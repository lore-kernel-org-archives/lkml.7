Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1789C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8821720830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbfCYV7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:59:17 -0400
Received: from muru.com ([72.249.23.125]:42636 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729478AbfCYV7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:59:13 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 27AE881AE;
        Mon, 25 Mar 2019 21:59:26 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/14] bus: ti-sysc: Allocate mdata as needed and do platform data based init later
Date:   Mon, 25 Mar 2019 14:58:42 -0700
Message-Id: <20190325215849.13182-8-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform data based init functions typically reset the interconnect
target module configure the registers. As we may need the interconnect
target module specific quirks configured based on the revision register,
we want to move the platform data based init to happen later.

Let's allocate mdata as needed so it's available for sysc_legacy_init()
that we call with module clocks enabled from sysc_init_module().

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 54 +++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -75,6 +75,7 @@ struct sysc {
 	u32 module_size;
 	void __iomem *module_va;
 	int offsets[SYSC_MAX_REGS];
+	struct ti_sysc_module_data *mdata;
 	struct clk **clocks;
 	const char **clock_roles;
 	int nr_clocks;
@@ -1012,6 +1013,26 @@ static void sysc_init_revision_quirks(struct sysc *ddata)
 	}
 }
 
+/*
+ * Note that pdata->init_module() typically does a reset first. After
+ * pdata->init_module() is done, PM runtime can be used for the interconnect
+ * target module.
+ */
+static int sysc_legacy_init(struct sysc *ddata)
+{
+	struct ti_sysc_platform_data *pdata = dev_get_platdata(ddata->dev);
+	int error;
+
+	if (!ddata->legacy_mode || !pdata || !pdata->init_module)
+		return 0;
+
+	error = pdata->init_module(ddata->dev, ddata->mdata, &ddata->cookie);
+	if (error == -EEXIST)
+		error = 0;
+
+	return error;
+}
+
 static int sysc_reset(struct sysc *ddata)
 {
 	int offset = ddata->offsets[SYSC_SYSCONFIG];
@@ -1070,10 +1091,15 @@ static int sysc_init_module(struct sysc *ddata)
 	ddata->revision = sysc_read_revision(ddata);
 	sysc_init_revision_quirks(ddata);
 
+	error = sysc_legacy_init(ddata);
+	if (error)
+		goto err_main_clocks;
+
 	error = sysc_reset(ddata);
 	if (error)
 		dev_err(ddata->dev, "Reset failed with %d\n", error);
 
+err_main_clocks:
 	if (manage_clocks)
 		sysc_disable_main_clocks(ddata);
 err_opt_clocks:
@@ -1715,28 +1741,26 @@ static const struct sysc_capabilities sysc_dra7_mcan = {
 static int sysc_init_pdata(struct sysc *ddata)
 {
 	struct ti_sysc_platform_data *pdata = dev_get_platdata(ddata->dev);
-	struct ti_sysc_module_data mdata;
-	int error = 0;
+	struct ti_sysc_module_data *mdata;
 
 	if (!pdata || !ddata->legacy_mode)
 		return 0;
 
-	mdata.name = ddata->legacy_mode;
-	mdata.module_pa = ddata->module_pa;
-	mdata.module_size = ddata->module_size;
-	mdata.offsets = ddata->offsets;
-	mdata.nr_offsets = SYSC_MAX_REGS;
-	mdata.cap = ddata->cap;
-	mdata.cfg = &ddata->cfg;
+	mdata = devm_kzalloc(ddata->dev, sizeof(*mdata), GFP_KERNEL);
+	if (!mdata)
+		return -ENOMEM;
 
-	if (!pdata->init_module)
-		return -ENODEV;
+	mdata->name = ddata->legacy_mode;
+	mdata->module_pa = ddata->module_pa;
+	mdata->module_size = ddata->module_size;
+	mdata->offsets = ddata->offsets;
+	mdata->nr_offsets = SYSC_MAX_REGS;
+	mdata->cap = ddata->cap;
+	mdata->cfg = &ddata->cfg;
 
-	error = pdata->init_module(ddata->dev, &mdata, &ddata->cookie);
-	if (error == -EEXIST)
-		error = 0;
+	ddata->mdata = mdata;
 
-	return error;
+	return 0;
 }
 
 static int sysc_init_match(struct sysc *ddata)
-- 
2.21.0
