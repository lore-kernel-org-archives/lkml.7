Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0320C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7292148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfDHQv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:51:26 -0400
Received: from muru.com ([72.249.23.125]:44774 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729064AbfDHQvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:51:25 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 078FA80AA;
        Mon,  8 Apr 2019 16:51:38 +0000 (UTC)
Date:   Mon, 8 Apr 2019 09:51:20 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/14] bus: ti-sysc: Add quirk handling for external
 optional functional clock
Message-ID: <20190408165120.GJ49658@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
 <20190325215849.13182-12-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325215849.13182-12-tony@atomide.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [190325 22:00]:
> @@ -200,6 +278,12 @@ static int sysc_get_clocks(struct sysc *ddata)
>  	if (ddata->nr_clocks < 1)
>  		return 0;
>  
> +	if ((ddata->cfg.quirks & SYSC_QUIRK_EXT_OPT_CLOCK)) {
> +		error = sysc_init_ext_opt_clock(ddata, NULL);
> +		if (error)
> +			return error;
> +	}
> +

After some more testing with mcpdm, these flags are not enough
for dropping the platform data. We need to use the same flags
as in platform data, and add SYSC_QUIRK_NO_RESET_ON_INIT and
SYSC_QUIRK_SWSUP_SIDLE to avoid patching this again. Updated
patch below.

Regards,

Tony

8< ----------------------
From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 21 Mar 2019 11:00:21 -0700
Subject: [PATCH] bus: ti-sysc: Add quirk handling for external optional
 functional clock

We cannot access mcpdm registers at all unless there is an optional pdmclk
configured. As this is currently only needed for mcpdm, let's check for
mcpdm in sysc_get_clocks(). If it turns out to be needed for other modules
too, we can add more flags to the quirks table for this.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c                 | 91 ++++++++++++++++++++++++++-
 include/linux/platform_data/ti-sysc.h |  1 +
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -47,7 +47,10 @@ enum sysc_clocks {
 	SYSC_MAX_CLOCKS,
 };
 
-static const char * const clock_names[SYSC_ICK + 1] = { "fck", "ick", };
+static const char * const clock_names[SYSC_MAX_CLOCKS] = {
+	"fck", "ick", "opt0", "opt1", "opt2", "opt3", "opt4",
+	"opt5", "opt6", "opt7",
+};
 
 #define SYSC_IDLEMODE_MASK		3
 #define SYSC_CLOCKACTIVITY_MASK		3
@@ -129,6 +132,81 @@ static u32 sysc_read_revision(struct sysc *ddata)
 	return sysc_read(ddata, offset);
 }
 
+static int sysc_add_named_clock_from_child(struct sysc *ddata,
+					   const char *name,
+					   const char *optfck_name)
+{
+	struct device_node *np = ddata->dev->of_node;
+	struct device_node *child;
+	struct clk_lookup *cl;
+	struct clk *clock;
+	const char *n;
+
+	if (name)
+		n = name;
+	else
+		n = optfck_name;
+
+	/* Does the clock alias already exist? */
+	clock = of_clk_get_by_name(np, n);
+	if (!IS_ERR(clock)) {
+		clk_put(clock);
+
+		return 0;
+	}
+
+	child = of_get_next_available_child(np, NULL);
+	if (!child)
+		return -ENODEV;
+
+	clock = devm_get_clk_from_child(ddata->dev, child, name);
+	if (IS_ERR(clock))
+		return PTR_ERR(clock);
+
+	/*
+	 * Use clkdev_add() instead of clkdev_alloc() to avoid the MAX_DEV_ID
+	 * limit for clk_get(). If cl ever needs to be freed, it should be done
+	 * with clkdev_drop().
+	 */
+	cl = kcalloc(1, sizeof(*cl), GFP_KERNEL);
+	if (!cl)
+		return -ENOMEM;
+
+	cl->con_id = n;
+	cl->dev_id = dev_name(ddata->dev);
+	cl->clk = clock;
+	clkdev_add(cl);
+
+	clk_put(clock);
+
+	return 0;
+}
+
+static int sysc_init_ext_opt_clock(struct sysc *ddata, const char *name)
+{
+	const char *optfck_name;
+	int error, index;
+
+	if (ddata->nr_clocks < SYSC_OPTFCK0)
+		index = SYSC_OPTFCK0;
+	else
+		index = ddata->nr_clocks;
+
+	if (name)
+		optfck_name = name;
+	else
+		optfck_name = clock_names[index];
+
+	error = sysc_add_named_clock_from_child(ddata, name, optfck_name);
+	if (error)
+		return error;
+
+	ddata->clock_roles[index] = optfck_name;
+	ddata->nr_clocks++;
+
+	return 0;
+}
+
 static int sysc_get_one_clock(struct sysc *ddata, const char *name)
 {
 	int error, i, index = -ENODEV;
@@ -200,6 +278,12 @@ static int sysc_get_clocks(struct sysc *ddata)
 	if (ddata->nr_clocks < 1)
 		return 0;
 
+	if ((ddata->cfg.quirks & SYSC_QUIRK_EXT_OPT_CLOCK)) {
+		error = sysc_init_ext_opt_clock(ddata, NULL);
+		if (error)
+			return error;
+	}
+
 	if (ddata->nr_clocks > SYSC_MAX_CLOCKS) {
 		dev_err(ddata->dev, "too many clocks for %pOF\n", np);
 
@@ -901,6 +985,11 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47422e03, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
 
+	/* Quirks that need to be set based on the module address */
+	SYSC_QUIRK("mcpdm", 0x40132000, 0, 0x10, -1, 0x50000800, 0xffffffff,
+		   SYSC_QUIRK_EXT_OPT_CLOCK | SYSC_QUIRK_NO_RESET_ON_INIT |
+		   SYSC_QUIRK_SWSUP_SIDLE),
+
 #ifdef DEBUG
 	SYSC_QUIRK("adc", 0, 0, 0x10, -1, 0x47300001, 0xffffffff, 0),
 	SYSC_QUIRK("atl", 0, 0, -1, -1, 0x0a070100, 0xffffffff, 0),
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -46,6 +46,7 @@ struct sysc_regbits {
 	s8 emufree_shift;
 };
 
+#define SYSC_QUIRK_EXT_OPT_CLOCK	BIT(10)
 #define SYSC_QUIRK_LEGACY_IDLE		BIT(9)
 #define SYSC_QUIRK_RESET_STATUS		BIT(8)
 #define SYSC_QUIRK_NO_IDLE		BIT(7)
-- 
2.21.0
