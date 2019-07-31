Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FDAC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D225208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564601738;
	bh=kc72/E5XexhPlpGwGLpvTOqPNTR45fQ6H/K9mIVhkQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iHmu0xgObr/1Uo9bA8jmi5p+dCB7Lx6WLCLnpfmRHk1n9XPH3WoQ5k07SyBHI+AXN
	 TcCvCnnhPQnvS6bcIJJvgzgfdWrCx9hAXUtWX4MtQu6JOlFuYtArHSQUtpi20VNfyJ
	 G/pZa48f4Hsnlvgg4tdikhcHbHDwV50fW164j2o0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfGaTff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731000AbfGaTfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:35:22 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63449214DA;
        Wed, 31 Jul 2019 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564601721;
        bh=kc72/E5XexhPlpGwGLpvTOqPNTR45fQ6H/K9mIVhkQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bP64uCk5TDuTLBTED+NkynhYxzswLg9oxvXZflCv11C5ZUHVS8iq+4FiuzMbVwHYV
         q9xUEFKKVrjrVqG2xI0pdMketUubPQFbNkcbKQfRkPAlVYdtIv3CqW5YX7YkcQmarf
         VKKN5wlnPICZNA57Vs7NRgcwW1kj9UTMLTA+TCBQ=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH 9/9] clk: Overwrite clk_hw::init with NULL during clk_register()
Date:   Wed, 31 Jul 2019 12:35:17 -0700
Message-Id: <20190731193517.237136-10-sboyd@kernel.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190731193517.237136-1-sboyd@kernel.org>
References: <20190731193517.237136-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want clk provider drivers to use the init structure after clk
registration time, but we leave a dangling reference to it by means of
clk_hw::init. Let's overwrite the member with NULL during clk_register()
so that this can't be used anymore after registration time.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

Please ack so I can take this through clk tree

 drivers/clk/clk.c            | 24 ++++++++++++++++--------
 include/linux/clk-provider.h |  3 ++-
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c0990703ce54..efac620264a2 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3484,9 +3484,9 @@ static int clk_cpy_name(const char **dst_p, const char *src, bool must_exist)
 	return 0;
 }
 
-static int clk_core_populate_parent_map(struct clk_core *core)
+static int clk_core_populate_parent_map(struct clk_core *core,
+					const struct clk_init_data *init)
 {
-	const struct clk_init_data *init = core->hw->init;
 	u8 num_parents = init->num_parents;
 	const char * const *parent_names = init->parent_names;
 	const struct clk_hw **parent_hws = init->parent_hws;
@@ -3566,6 +3566,14 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 {
 	int ret;
 	struct clk_core *core;
+	const struct clk_init_data *init = hw->init;
+
+	/*
+	 * The init data is not supposed to be used outside of registration path.
+	 * Set it to NULL so that provider drivers can't use it either and so that
+	 * we catch use of hw->init early on in the core.
+	 */
+	hw->init = NULL;
 
 	core = kzalloc(sizeof(*core), GFP_KERNEL);
 	if (!core) {
@@ -3573,17 +3581,17 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 		goto fail_out;
 	}
 
-	core->name = kstrdup_const(hw->init->name, GFP_KERNEL);
+	core->name = kstrdup_const(init->name, GFP_KERNEL);
 	if (!core->name) {
 		ret = -ENOMEM;
 		goto fail_name;
 	}
 
-	if (WARN_ON(!hw->init->ops)) {
+	if (WARN_ON(!init->ops)) {
 		ret = -EINVAL;
 		goto fail_ops;
 	}
-	core->ops = hw->init->ops;
+	core->ops = init->ops;
 
 	if (dev && pm_runtime_enabled(dev))
 		core->rpm_enabled = true;
@@ -3592,13 +3600,13 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 	if (dev && dev->driver)
 		core->owner = dev->driver->owner;
 	core->hw = hw;
-	core->flags = hw->init->flags;
-	core->num_parents = hw->init->num_parents;
+	core->flags = init->flags;
+	core->num_parents = init->num_parents;
 	core->min_rate = 0;
 	core->max_rate = ULONG_MAX;
 	hw->core = core;
 
-	ret = clk_core_populate_parent_map(core);
+	ret = clk_core_populate_parent_map(core, init);
 	if (ret)
 		goto fail_parents;
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 2ae7604783dd..214c75ed62ae 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -299,7 +299,8 @@ struct clk_init_data {
  * into the clk API
  *
  * @init: pointer to struct clk_init_data that contains the init data shared
- * with the common clock framework.
+ * with the common clock framework. This pointer will be set to NULL once
+ * a clk_register() variant is called on this clk_hw pointer.
  */
 struct clk_hw {
 	struct clk_core *core;
-- 
Sent by a computer through tubes

