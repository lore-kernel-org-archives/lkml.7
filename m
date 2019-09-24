Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947BFC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B436214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xVzA8y35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440980AbfIXMkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:40:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44737 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436675AbfIXMkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:40:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id i18so1754935wru.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qi/Gc3Tpy0QJ++xo7u/xxUW782IGlDyvorHvSnC/YAU=;
        b=xVzA8y35Oii0iE40wE9lsz9FtNQqt+dg+GcigSV+Q1lf1ZrVsLY1lorxmVsgf362B6
         Z33LTBKLA0eo1gKgLAJ7TOh/psIX8l2H4UnV7YhGgTeyyjApR5mfI+kvE+AjlIEyrlev
         3O0NSB6O2yGLdAzSHfMDsBbOnnsdnt1z8w3ME+LPvqp0flXlA1+74sDUjTUVL5z+ZpH6
         1t214qYiCHLc+QMVU1ve5Cd7pmJe+AxNKHqQesqEP9rZJRloxY0WHmSWiHcWQINBQ+Ih
         grkGSaFD+x3qJVrkRPNUfkhMY42VDJiSdC6705TSz7TfkFU21iNGL6FT9cXpAGWiSZ11
         8p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qi/Gc3Tpy0QJ++xo7u/xxUW782IGlDyvorHvSnC/YAU=;
        b=em2WLB1rVkER0+wFvEZp1XIXErlulmKnfNUFDaqmxE/UN33s/fkZoUBZ/ItKfuvgly
         vPC0YZafFHOHGhWGC35pXEk+Gv6tqBZEkR4D+wRGKQCbqGWRq4nu/lv5rb6ICTn7QrS/
         z2lCxq5RE8YUhycqf1zRi+dV/IXRNeytn6FzvF9B+3GAxN9VY8jf8kHCHc/0h5KntrjD
         ePxmr9yQeh8jRNtWp+vEi4ZFTFS/lsHjLfwzVcOQH8PCwLVjL3V6trt83z6AtqX9Bf7b
         ly1Hnm/2wlu/fWOCRAYiDD8cUC6pvjUwajLSu0+JPogD7uzXmscZio9xLu8dHb8iHcwN
         1p2w==
X-Gm-Message-State: APjAAAWL+MbQL+21tmDe00VcnjZg4XRRu/r6T/69iNkWi9i/uzOcNMRu
        s4VVGjtvwrg7jJ9sy/k0ONypDA==
X-Google-Smtp-Source: APXvYqzBghGV1Vgi9EQ3Px35/1wfK6N+ygAoSGgLs02Jt0FBtSIG4euGb3vteJcxOsqLO3AVFhwvfg==
X-Received: by 2002:a05:6000:11cb:: with SMTP id i11mr2294992wrx.171.1569328814069;
        Tue, 24 Sep 2019 05:40:14 -0700 (PDT)
Received: from starbuck.baylibre.local (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id u83sm2888165wme.0.2019.09.24.05.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 05:40:13 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] clk: add terminate callback to clk_ops
Date:   Tue, 24 Sep 2019 14:39:54 +0200
Message-Id: <20190924123954.31561-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190924123954.31561-1-jbrunet@baylibre.com>
References: <20190924123954.31561-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a terminate callback to the clk_ops to release the resources
claimed in .init()

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk.c            | 7 ++++++-
 include/linux/clk-provider.h | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index df853a98fad2..926f49c78b5d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3844,6 +3844,7 @@ static void clk_core_evict_parent_cache(struct clk_core *core)
 void clk_unregister(struct clk *clk)
 {
 	unsigned long flags;
+	const struct clk_ops *ops;
 
 	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
 		return;
@@ -3852,7 +3853,8 @@ void clk_unregister(struct clk *clk)
 
 	clk_prepare_lock();
 
-	if (clk->core->ops == &clk_nodrv_ops) {
+	ops = clk->core->ops;
+	if (ops == &clk_nodrv_ops) {
 		pr_err("%s: unregistered clock: %s\n", __func__,
 		       clk->core->name);
 		goto unlock;
@@ -3865,6 +3867,9 @@ void clk_unregister(struct clk *clk)
 	clk->core->ops = &clk_nodrv_ops;
 	clk_enable_unlock(flags);
 
+	if (ops->terminate)
+		ops->terminate(clk->core->hw);
+
 	if (!hlist_empty(&clk->core->children)) {
 		struct clk_core *child;
 		struct hlist_node *t;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index b82ec4c4ca95..5a5a64785923 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -197,6 +197,8 @@ struct clk_duty {
  *		such as rate or parents.
  *		Returns 0 on success, -EERROR otherwise.
  *
+ * @terminate:  Free any resource allocated by init.
+ *
  * @debug_init:	Set up type-specific debugfs entries for this clock.  This
  *		is called once, after the debugfs directory entry for this
  *		clock has been created.  The dentry pointer representing that
@@ -248,6 +250,7 @@ struct clk_ops {
 	int		(*set_duty_cycle)(struct clk_hw *hw,
 					  struct clk_duty *duty);
 	int		(*init)(struct clk_hw *hw);
+	void		(*terminate)(struct clk_hw *hw);
 	void		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
 };
 
-- 
2.21.0

