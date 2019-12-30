Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE3AC2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F04B2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="Qdo1i01I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tro/wOl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfL3Tba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:31:30 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44531 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727614AbfL3Tba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:31:30 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3D16A21E50;
        Mon, 30 Dec 2019 14:31:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 30 Dec 2019 14:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=dY6hg8MzE0V3cPrXrFYMw67ASv
        /T3eJMrmoA83uijGM=; b=Qdo1i01IPB8kmiW9Zmrzu9r8TtFBgUSSJxuLXWoCeT
        eOGDPcraXbTkN4aS1Bs4Zfqrto7IPrMk5gMF4xBK1ENRX2PiGzb9Vsg/hvias9YA
        RQtfth2uSRxUofBIzNrS0mHKSNVgl+jkkxYjh5RrASLCUPQTivdbADXYJpKfkuUg
        jr7JS/2mL/Mb664CYfLzlR16vmfS2qRcQdwKAmHtJ6ncUBscqWe6jjPoitE1Z4N4
        lvQMfgPuBO5o22KZtPt1ZHoLzYThtgO9RIEjP5EvSDhBXiR2Q7DzZ8c+mGuo+CGE
        8dHg8CZW5vfiyFHPnujEQFZEn7QYEbqZ1uxC7bdq33hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dY6hg8MzE0V3cPrXr
        FYMw67ASv/T3eJMrmoA83uijGM=; b=Tro/wOl17SEhCMJdw47O7XKFh/R4Jguik
        3n04oIRwrEfnkNg5eoj2PJXVxAskNVE+kaKy5R34y/yxGs2lks5FZj1SWL9DINYo
        ye1tWYehPQECheC23FP/t+8n7BfgnAMv7Zmjw6XMgWY0OgwC4ezcv/At2n7nQus/
        hr/NijmS/7fvOvY4vIGa+qR3deH21QZhiHrhibrKT3cMdbvF/GiUH3KUf17cSSTu
        XWGDNP5Lz16xXkJNBsEE0b0n45nj2ffDX3JsfrrIVnXl/R3g/qemjPgy02xhTrxJ
        NQDbkYeMUVZFwCogowTVo8EMvoVlKof+cfqiMwr0C9GKbyr+gjueg==
X-ME-Sender: <xms:kFAKXvrCZOxT6CAdGUXMJbxJmxRP5njNeTLpxSnsR0jYHSaQJ-T6ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdefhedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:kFAKXl-NNnp0z8iKKqEgzJZcbkbyq5oj9lwZFbtDR6WA6qTQ_cSP5Q>
    <xmx:kFAKXu-U0NBXgDvTY5UitiewV4rjn0Ck5OZMrLNjLfi7hOyBIrIejQ>
    <xmx:kFAKXkvDhbWlgTFZCzIX-XtlARovV3NYSGpMJGRlyhLHApZm3FDbBA>
    <xmx:kVAKXvKUDCwJzrzMTj5B5sHT7EOrJvj6q7RROeRBKPKIdefZjg7zkw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5D4D13060802;
        Mon, 30 Dec 2019 14:31:28 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [RFC PATCH] clk: Implement protected-clocks for all OF clock providers
Date:   Mon, 30 Dec 2019 13:31:27 -0600
Message-Id: <20191230193127.8803-1-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a generic implementation of the "protected-clocks" property from
the common clock binding. It comes with some caveats:

1) Clocks that have CLK_IS_CRITICAL in their init data are prepared/
enabled before they are attached to the clock tree. protected-clocks are
only protected once the clock provider is added, which is generally
after all of the clocks it provides have been registered. This leaves a
window of opportunity where something could disable or modify the clock,
such as a driver running on another CPU, or the clock core itself. There
is a comment to this effect in __clk_core_init():

  /*
   * Enable CLK_IS_CRITICAL clocks so newly added critical clocks
   * don't get accidentally disabled when walking the orphan tree and
   * reparenting clocks
   */

Similarly, these clocks will be enabled after they are first reparented,
unlike other CLK_IS_CRITICAL clocks. See the comment in
clk_core_reparent_orphans_nolock():

  /*
   * We need to use __clk_set_parent_before() and _after() to
   * to properly migrate any prepare/enable count of the orphan
   * clock. This is important for CLK_IS_CRITICAL clocks, which
   * are enabled during init but might not have a parent yet.
   */

Ideally we could detect protected clocks before they are reparented, but
there are two problems with that:

  i)  From the clock core's perspective, hw->init is const.

  ii) The clock core doesn't see the device_node until __clk_register is
      called on the first clock.

So the only race-free way to detect protected-clocks is to do it in the
middle of __clk_register, between when core->flags is initialized and
calling __clk_core_init(). That requires scanning the device tree again
for each clock, which is part of why I didn't do it that way.

2) __clk_protect needs to be idempotent, for two reasons:

  i)  Clocks with CLK_IS_CRITICAL in their init data are already
      prepared/enabled, and we don't want to prepare/enable them again.
      Note that if the clock did not have CLK_SET_RATE_GATE in its init
      data, it was *not* rate protected during the initial call to
      clk_core_prepare().  As far as I can tell, none of the other flags
      affect the internal state of the clock, so they don't need any
      "parallel reconstruction".

  ii) of_clk_set_defaults() is called twice for (at least some) clock
      controllers registered with CLK_OF_DECLARE. It is called first in
      of_clk_add_provider()/of_clk_add_hw_provider() inside clk_init_cb,
      and again afterward in of_clk_init(). I think that the second call
      in of_clk_init() should be removed, but that would require
      auditing all users of CLK_OF_DECLARE to ensure they called one of
      the of_clk_add{,_hw}_provider functions.

3) It is not clear specifically which flags should be implied by being
in protected-clocks. I took it to mean "this clock is outside of OS
control, so don't modify it, and assume it can change at any time".

For that reason, I added the following flags:
  - CLK_SET_RATE_GATE: prevents clk_set_rate() once prepared
  - CLK_SET_PARENT_GATE: prevents clk_set_parent() once prepared
  - CLK_GET_RATE_NOCACHE: allows the rate to change behind the OS's back
  - CLK_GET_ACCURACY_NOCACHE: ditto for the accuracy
  - CLK_IS_CRITICAL: causes the clock to always be prepared + enabled

Some problems I see with this:

  i)  We are still modifying the clock, once, to prepare/enable it. It
      sounds like this may not be a safe thing to do. But none of the
      protections in the clock core apply if a clock isn't prepared.

      Possibly we could prepare and not enable it, assuming that the
      "enable" step is what actually touches the hardware. However, that
      would have different semantics from existing CLK_IS_CRITICAL
      clocks.

  ii) Protecting the rate protects all ancestor clock rates. This seems
      like an incredibly big hammer, but if we actually aren't allowed
      to change the rate of protected clocks, would actually be
      necessary.

Maybe both of these could be solved with a new flag? Otherwise, the only
way to prevent the clock core from allowing changes to the clock
hardware (and from making the changes itself) is to not register the
clock. Unfortunately, that also won't work in this situation, because
most of the clocks that I need to protect also have Linux drivers (or
their descendants have Linux drivers).

It is also unclear how protected-clocks and assigned-clocks should
interact. For now, it produces an error, since protected-clocks are
handled first.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/clk-conf.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk.c      | 44 ++++++++++++++++++++++++++++++++++
 drivers/clk/clk.h      |  2 ++
 3 files changed, 100 insertions(+)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 2ef819606c41..a57d28b0f397 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -11,6 +11,54 @@
 #include <linux/of.h>
 #include <linux/printk.h>
 
+#include "clk.h"
+
+static int __set_clk_flags(struct device_node *node)
+{
+	struct of_phandle_args clkspec;
+	struct property *prop;
+	int i, index = 0, rc;
+	const __be32 *cur;
+	struct clk *clk;
+	u32 nr_cells;
+
+	rc = of_property_read_u32(node, "#clock-cells", &nr_cells);
+	if (rc < 0) {
+		pr_err("clk: missing #clock-cells property on %pOF\n", node);
+		return rc;
+	}
+
+	clkspec.np         = node;
+	clkspec.args_count = nr_cells;
+
+	of_property_for_each_u32(node, "protected-clocks", prop, cur, clkspec.args[0]) {
+		/* read the remainder of the clock specifier */
+		for (i = 1; i < nr_cells; ++i) {
+			cur = of_prop_next_u32(prop, cur, &clkspec.args[i]);
+			if (!cur) {
+				pr_err("clk: invalid value of protected-clocks"
+				       " property at %pOF\n", node);
+				return -EINVAL;
+			}
+		}
+		clk = of_clk_get_from_provider(&clkspec);
+		if (IS_ERR(clk)) {
+			if (PTR_ERR(clk) != -EPROBE_DEFER)
+				pr_err("clk: couldn't get protected clock"
+				       " %u for %pOF\n", index, node);
+			return PTR_ERR(clk);
+		}
+
+		rc = __clk_protect(clk);
+		if (rc < 0)
+			pr_warn("clk: failed to protect %s: %d\n",
+				__clk_get_name(clk), rc);
+		clk_put(clk);
+		index++;
+	}
+	return 0;
+}
+
 static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 {
 	struct of_phandle_args clkspec;
@@ -135,6 +183,12 @@ int of_clk_set_defaults(struct device_node *node, bool clk_supplier)
 	if (!node)
 		return 0;
 
+	if (clk_supplier) {
+		rc = __set_clk_flags(node);
+		if (rc < 0)
+			return rc;
+	}
+
 	rc = __set_clk_parents(node, clk_supplier);
 	if (rc < 0)
 		return rc;
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 6a11239ccde3..e115e0199535 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4038,6 +4038,50 @@ void devm_clk_hw_unregister(struct device *dev, struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_unregister);
 
+/*
+ * clk-conf helpers
+ */
+
+int __clk_protect(struct clk *clk)
+{
+	struct clk_core *core = clk->core;
+	long prev_flags;
+	int ret = 0;
+
+	clk_prepare_lock();
+
+	prev_flags = core->flags;
+	core->flags |= CLK_SET_RATE_GATE |
+		       CLK_SET_PARENT_GATE |
+		       CLK_GET_RATE_NOCACHE |
+		       CLK_GET_ACCURACY_NOCACHE |
+		       CLK_IS_CRITICAL;
+
+	/*
+	 * If CLK_IS_CRITICAL was set in the clock's init data, then
+	 * the clock was already prepared/enabled when it was added.
+	 *
+	 * However, if CLK_SET_RATE_GATE was not set, rate protection was
+	 * not applied during clk_core_prepare(), and should be added now.
+	 */
+	if (prev_flags & CLK_IS_CRITICAL) {
+		if (!(prev_flags & CLK_SET_RATE_GATE))
+			clk_core_rate_protect(core);
+		goto out;
+	}
+
+	ret = clk_core_prepare(core);
+	if (ret)
+		goto out;
+
+	ret = clk_core_enable_lock(core);
+
+out:
+	clk_prepare_unlock();
+
+	return ret;
+}
+
 /*
  * clkdev helpers
  */
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index 2d801900cad5..367a0f036b13 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -24,6 +24,7 @@ struct clk_hw *clk_find_hw(const char *dev_id, const char *con_id);
 #ifdef CONFIG_COMMON_CLK
 struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
 			      const char *dev_id, const char *con_id);
+int __clk_protect(struct clk *clk);
 void __clk_put(struct clk *clk);
 #else
 /* All these casts to avoid ifdefs in clkdev... */
@@ -33,6 +34,7 @@ clk_hw_create_clk(struct device *dev, struct clk_hw *hw, const char *dev_id,
 {
 	return (struct clk *)hw;
 }
+static inline int __clk_protect(struct clk *clk) { return 0; }
 static inline void __clk_put(struct clk *clk) { }
 
 #endif
-- 
2.23.0

