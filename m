Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F622C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44E32077B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfH1NXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:23:15 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:60032 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfH1NXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:23:15 -0400
Received: from ramsan ([84.194.98.4])
        by laurent.telenet-ops.be with bizsmtp
        id udPD2000605gfCL01dPDy1; Wed, 28 Aug 2019 15:23:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i2xur-00009L-3a; Wed, 28 Aug 2019 15:23:13 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i2xur-0004xS-1U; Wed, 28 Aug 2019 15:23:13 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Raman Banka <raman.k2@samsung.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] clk: Add support for setting clk_rate via debugfs
Date:   Wed, 28 Aug 2019 15:23:06 +0200
Message-Id: <20190828132306.19012-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For testing, it is useful to be able to specify a clock rate manually.
As this is a dangerous feature, it is not enabled by default.
Users need to modify the source directly and #define
CLOCK_ALLOW_WRITE_DEBUGFS.

This follows the spirit of commit 09c6ecd394105c48 ("regmap: Add support
for writing to regmap registers via debugfs").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Stephen: you suggested this approach in
https://lore.kernel.org/linux-clk/153029668040.143105.2059491089047180792@swboyd.mtv.corp.google.com/

v2:
  - Rebased.
---
 drivers/clk/clk.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2ba52b8dafcc1cc5..5b3c915b9507634c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2990,6 +2990,41 @@ static int clk_dump_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(clk_dump);
 
+#undef CLOCK_ALLOW_WRITE_DEBUGFS
+#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
+/*
+ * This can be dangerous, therefore don't provide any real compile time
+ * configuration option for this feature.
+ * People who want to use this will need to modify the source code directly.
+ */
+static int clk_rate_set(void *data, u64 val)
+{
+	struct clk_core *core = data;
+	int ret;
+
+	clk_prepare_lock();
+	ret = clk_core_set_rate_nolock(core, val);
+	clk_prepare_unlock();
+
+	return ret;
+}
+
+#define clk_rate_mode	0644
+#else
+#define clk_rate_set	NULL
+#define clk_rate_mode	0444
+#endif
+
+static int clk_rate_get(void *data, u64 *val)
+{
+	struct clk_core *core = data;
+
+	*val = core->rate;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(clk_rate_fops, clk_rate_get, clk_rate_set, "%llu\n");
+
 static const struct {
 	unsigned long flag;
 	const char *name;
@@ -3139,7 +3174,8 @@ static void clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
 	root = debugfs_create_dir(core->name, pdentry);
 	core->dentry = root;
 
-	debugfs_create_ulong("clk_rate", 0444, root, &core->rate);
+	debugfs_create_file("clk_rate", clk_rate_mode, root, core,
+			    &clk_rate_fops);
 	debugfs_create_file("clk_min_rate", 0444, root, core, &clk_min_rate_fops);
 	debugfs_create_file("clk_max_rate", 0444, root, core, &clk_max_rate_fops);
 	debugfs_create_ulong("clk_accuracy", 0444, root, &core->accuracy);
-- 
2.17.1

