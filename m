Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8FEC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 16:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA210215A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 16:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eg/2w4s0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfK2QRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 11:17:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44400 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfK2QRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 11:17:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so35764288wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 08:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2u4id74AuIDefeyl6HPZTpmm+BjNUkbxmsv8qghnzxE=;
        b=eg/2w4s0ARwwzJIyvoQV9eZtjhRTG0mLCFM2uJeucVbUwmBbr0EnTlmRi1O5LjCKc4
         Rq3YWQ/7YSShDjqGJvy17FsFYn93axz+BWMlrBUPGtj+jkzfcApSZTuKqKwBu1ubSNOb
         zN24rOxmy4NALD2wKVz+8CZ9A4goebPRfwznoDQ+tGQ7Mc/mM2bAD2xffLeT3Hh0NeYb
         28yfMaszMFyX7HAy7MPZaIMlN1W8JROkY/h0Jz4rVDelMYP9585ksfA6Sfls0TaID75E
         HFOsiJkopxlO2DOarRjQ5qeHmID66xo5V6QdJScr9RDb0oOwILX3eFYwU7ohjicgP/mK
         tTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2u4id74AuIDefeyl6HPZTpmm+BjNUkbxmsv8qghnzxE=;
        b=pjerwZz7RfK3J6u8KfsBkEvwWy2UW/nTt/EfiLyszul+/2BL1u7ujHh8AcubfpX1qH
         pXZH4bSQtCtSwMw3nQl+LYkWAwEBLU0cDSru5NxPrazcEpjKeiHIS7siABhAKvylU4rQ
         atBhbj7rGBGrAm7EABWlhVXMWUO64moQ7ptUggjLPT+vDKGOCxsxqDQaisyUs+f0gYka
         jyE6DcNdXMfjIayJFa8TvgmEPv7yj2UaSVUiV7SsOJao68hXdZCaWQwa7YVTjsxZ84O8
         a1SKXqKboJrcaF5ukm+hdKcDIcfiEOI9B6Y0EBlIe8caP2U1xkqcPH0frq8K1nE8bTfe
         dcaA==
X-Gm-Message-State: APjAAAUYbEJ0ztPXWVXJsfuzLyl7IGyrMSAmgcbZxheTtoxWwgUyqSjM
        h+T3gO74g5fXHtn5Taa1jEsy/A==
X-Google-Smtp-Source: APXvYqxZ+bxdoT3YaQeYAKePtV7Adt55hkXCYBiVIZqfZu8udIBJ2o7TfGUfLVi07mcuZSWRf/kbCw==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr20275395wrs.11.1575044223145;
        Fri, 29 Nov 2019 08:17:03 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 72sm28730412wrl.73.2019.11.29.08.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 08:17:02 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH] clk: walk orphan list on clock provider registration
Date:   Fri, 29 Nov 2019 17:16:58 +0100
Message-Id: <20191129161658.344517-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, we walked the orphan list every time a new clock was registered
in CCF. This was fine since the clocks were only referenced by name.

Now that the clock can be referenced through DT, it is not enough:
* Controller A register first a reference clocks from controller B
  through DT.
* Controller B register all its clocks then register the provider.

Each time controller B registers a new clock, the orphan list is walked
but it can't match since the provider is registered yet. When the
provider is finally registered, the orphan list is not walked unless
another clock is registered afterward.

This can lead to situation where some clocks remain orphaned even if
the parent is available.

Walking the orphan list on provider registration solves the problem.

Fixes: fc0c209c147f ("clk: Allow parents to be specified without string names")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk.c | 59 +++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ef4416721777..917ba37c3b9d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3249,6 +3249,34 @@ static inline void clk_debug_unregister(struct clk_core *core)
 }
 #endif
 
+static void __clk_core_reparent_orphan(void)
+{
+	struct clk_core *orphan;
+	struct hlist_node *tmp2;
+
+	/*
+	 * walk the list of orphan clocks and reparent any that newly finds a
+	 * parent.
+	 */
+	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
+		struct clk_core *parent = __clk_init_parent(orphan);
+
+		/*
+		 * We need to use __clk_set_parent_before() and _after() to
+		 * to properly migrate any prepare/enable count of the orphan
+		 * clock. This is important for CLK_IS_CRITICAL clocks, which
+		 * are enabled during init but might not have a parent yet.
+		 */
+		if (parent) {
+			/* update the clk tree topology */
+			__clk_set_parent_before(orphan, parent);
+			__clk_set_parent_after(orphan, parent, NULL);
+			__clk_recalc_accuracies(orphan);
+			__clk_recalc_rates(orphan, 0);
+		}
+	}
+}
+
 /**
  * __clk_core_init - initialize the data structures in a struct clk_core
  * @core:	clk_core being initialized
@@ -3259,8 +3287,6 @@ static inline void clk_debug_unregister(struct clk_core *core)
 static int __clk_core_init(struct clk_core *core)
 {
 	int ret;
-	struct clk_core *orphan;
-	struct hlist_node *tmp2;
 	unsigned long rate;
 
 	if (!core)
@@ -3416,27 +3442,8 @@ static int __clk_core_init(struct clk_core *core)
 		clk_enable_unlock(flags);
 	}
 
-	/*
-	 * walk the list of orphan clocks and reparent any that newly finds a
-	 * parent.
-	 */
-	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
-		struct clk_core *parent = __clk_init_parent(orphan);
+	__clk_core_reparent_orphan();
 
-		/*
-		 * We need to use __clk_set_parent_before() and _after() to
-		 * to properly migrate any prepare/enable count of the orphan
-		 * clock. This is important for CLK_IS_CRITICAL clocks, which
-		 * are enabled during init but might not have a parent yet.
-		 */
-		if (parent) {
-			/* update the clk tree topology */
-			__clk_set_parent_before(orphan, parent);
-			__clk_set_parent_after(orphan, parent, NULL);
-			__clk_recalc_accuracies(orphan);
-			__clk_recalc_rates(orphan, 0);
-		}
-	}
 
 	kref_init(&core->ref);
 out:
@@ -4288,6 +4295,10 @@ int of_clk_add_provider(struct device_node *np,
 	mutex_unlock(&of_clk_mutex);
 	pr_debug("Added clock from %pOF\n", np);
 
+	clk_prepare_lock();
+	__clk_core_reparent_orphan();
+	clk_prepare_unlock();
+
 	ret = of_clk_set_defaults(np, true);
 	if (ret < 0)
 		of_clk_del_provider(np);
@@ -4323,6 +4334,10 @@ int of_clk_add_hw_provider(struct device_node *np,
 	mutex_unlock(&of_clk_mutex);
 	pr_debug("Added clk_hw provider from %pOF\n", np);
 
+	clk_prepare_lock();
+	__clk_core_reparent_orphan();
+	clk_prepare_unlock();
+
 	ret = of_clk_set_defaults(np, true);
 	if (ret < 0)
 		of_clk_del_provider(np);
-- 
2.23.0

