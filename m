Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AB0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854EE2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbfCZXNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:13:11 -0400
Received: from muru.com ([72.249.23.125]:42954 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731583AbfCZXNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:13:11 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0310B8030;
        Tue, 26 Mar 2019 23:13:22 +0000 (UTC)
Date:   Tue, 26 Mar 2019 16:13:06 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/14] bus: ti-sysc: Move rstctrl reset to happen later
Message-ID: <20190326231306.GC49658@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
 <20190325215849.13182-10-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325215849.13182-10-tony@atomide.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [190325 22:00]:
> We should not do the reset until the clocks are enabled. Let's only init
> restctrl in sysc_init_resets() and do the reset later on in sysc_reset().
...

>  static int sysc_reset(struct sysc *ddata)
>  {
>  	int offset = ddata->offsets[SYSC_SYSCONFIG];
> -	int val;
> +	int error, val;
>  
>  	if (ddata->legacy_mode || offset < 0 ||
>  	    ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
> -		return 0;
> +		return sysc_rstctrl_reset_deassert(ddata, false);
> +
> +	error = sysc_rstctrl_reset_deassert(ddata, true);
> +	if (error)
> +		return error;

This change is wrong, we need to deassert rstctrl reset before
we enable clocks, not after. Updated version below.

Regards,

Tony

8< --------------------
From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 21 Mar 2019 11:00:21 -0700
Subject: [PATCH] bus: ti-sysc: Move rstctrl reset to happen later

We can do the rsstctrl a bit later, but need to deassert rstctrl reset
before the clocks are enabled if asserted. Let's only init restctrl
in sysc_init_resets() and do the reset later on just before we enable
the device clocks.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 61 +++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -339,38 +339,18 @@ static void sysc_disable_opt_clocks(struct sysc *ddata)
 }
 
 /**
- * sysc_init_resets - reset module on init
+ * sysc_init_resets - init rstctrl reset line if configured
  * @ddata: device driver data
  *
- * A module can have both OCP softreset control and external rstctrl.
- * If more complicated rstctrl resets are needed, please handle these
- * directly from the child device driver and map only the module reset
- * for the parent interconnect target module device.
- *
- * Automatic reset of the module on init can be skipped with the
- * "ti,no-reset-on-init" device tree property.
+ * See sysc_rstctrl_reset_deassert().
  */
 static int sysc_init_resets(struct sysc *ddata)
 {
-	int error;
-
 	ddata->rsts =
 		devm_reset_control_array_get_optional_exclusive(ddata->dev);
 	if (IS_ERR(ddata->rsts))
 		return PTR_ERR(ddata->rsts);
 
-	if (ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
-		goto deassert;
-
-	error = reset_control_assert(ddata->rsts);
-	if (error)
-		return error;
-
-deassert:
-	error = reset_control_deassert(ddata->rsts);
-	if (error)
-		return error;
-
 	return 0;
 }
 
@@ -1031,6 +1011,35 @@ static int sysc_legacy_init(struct sysc *ddata)
 	return error;
 }
 
+/**
+ * sysc_rstctrl_reset_deassert - deassert rstctrl reset
+ * @ddata: device driver data
+ * @reset: reset before deassert
+ *
+ * A module can have both OCP softreset control and external rstctrl.
+ * If more complicated rstctrl resets are needed, please handle these
+ * directly from the child device driver and map only the module reset
+ * for the parent interconnect target module device.
+ *
+ * Automatic reset of the module on init can be skipped with the
+ * "ti,no-reset-on-init" device tree property.
+ */
+static int sysc_rstctrl_reset_deassert(struct sysc *ddata, bool reset)
+{
+	int error;
+
+	if (!ddata->rsts)
+		return 0;
+
+	if (reset) {
+		error = reset_control_assert(ddata->rsts);
+		if (error)
+			return error;
+	}
+
+	return reset_control_deassert(ddata->rsts);
+}
+
 static int sysc_reset(struct sysc *ddata)
 {
 	int offset = ddata->offsets[SYSC_SYSCONFIG];
@@ -1071,6 +1080,14 @@ static int sysc_init_module(struct sysc *ddata)
 {
 	int error = 0;
 	bool manage_clocks = true;
+	bool reset = true;
+
+	if (ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
+		reset = false;
+
+	error = sysc_rstctrl_reset_deassert(ddata, reset);
+	if (error)
+		return error;
 
 	if (ddata->cfg.quirks &
 	    (SYSC_QUIRK_NO_IDLE | SYSC_QUIRK_NO_IDLE_ON_INIT))
-- 
2.21.0
