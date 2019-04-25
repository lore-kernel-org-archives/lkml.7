Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA7CC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDDD20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556216091;
	bh=0fZVwiGHaKunTp9CMxv8NomGl+zVMchSN8Bj28FxxUk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Efkarhihf3pOcOQVNicFMrRywBEqxBDt73GAAfIHBqR1xABbCKxwkoxK2r0v3BMSz
	 0o7SVYmZ0dDN4lqv+pNxy988WuB5mj6L2Mo1qgNwPhQosJLqSqORgG5Q9mRjF34LQY
	 vSLNzRRjslo6TBF/M+B+it0+Wy0A81Z8YH64IFoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfDYSOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfDYSOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:14:49 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A8CF20685;
        Thu, 25 Apr 2019 18:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556216088;
        bh=0fZVwiGHaKunTp9CMxv8NomGl+zVMchSN8Bj28FxxUk=;
        h=From:To:Cc:Subject:Date:From;
        b=Rw12ewFyQ3rmDqC3h6Y8cmy3Nno4MZaMg4x6MEczDng9/UG5vtifUzDUwScRvjMxy
         H3y/rwydXB1z+ntiwaeqy+0jik/v1nfgse3LXVjIcN9E8T2m9nwOww7nNbjNcqb0fk
         4HjGVVUuJauaYbDwZ4VGC/dKEqmkMwGRNV0Zoxkc=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Tero Kristo <t-kristo@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] clk: Remove CLK_IS_BASIC clk flag
Date:   Thu, 25 Apr 2019 11:14:47 -0700
Message-Id: <20190425181447.60726-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag was historically used to indicate that a clk is a "basic" type
of clk like a mux, divider, gate, etc. This never turned out to be very
useful though because it was hard to cleanly split "basic" clks from
other clks in a system. This one flag was a way for type introspection
and it just didn't scale. If anything, it was used by the TI clk driver
to indicate that a clk_hw wasn't contained in the SoC specific clk
structure. We can get rid of this define now that TI is finding those
clks a different way.

Cc: Tero Kristo <t-kristo@ti.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: <linux-mips@vger.kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: <linux-pwm@vger.kernel.org>
Cc: <linux-amlogic@lists.infradead.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/mips/alchemy/common/clock.c     | 2 +-
 drivers/clk/clk-composite.c          | 2 +-
 drivers/clk/clk-divider.c            | 2 +-
 drivers/clk/clk-fixed-factor.c       | 2 +-
 drivers/clk/clk-fixed-rate.c         | 2 +-
 drivers/clk/clk-fractional-divider.c | 2 +-
 drivers/clk/clk-gate.c               | 2 +-
 drivers/clk/clk-gpio.c               | 2 +-
 drivers/clk/clk-mux.c                | 2 +-
 drivers/clk/clk-pwm.c                | 2 +-
 drivers/clk/clk.c                    | 1 -
 drivers/clk/mmp/clk-gate.c           | 2 +-
 drivers/pwm/pwm-meson.c              | 2 +-
 include/linux/clk-provider.h         | 2 +-
 14 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index d129475fd40d..a95a894aceaf 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -160,7 +160,7 @@ static struct clk __init *alchemy_clk_setup_cpu(const char *parent_name,
 	id.name = ALCHEMY_CPU_CLK;
 	id.parent_names = &parent_name;
 	id.num_parents = 1;
-	id.flags = CLK_IS_BASIC;
+	id.flags = 0;
 	id.ops = &alchemy_clkops_cpu;
 	h->init = &id;
 
diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 46604214bba0..b06038b8f658 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -218,7 +218,7 @@ struct clk_hw *clk_hw_register_composite(struct device *dev, const char *name,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	init.flags = flags | CLK_IS_BASIC;
+	init.flags = flags;
 	init.parent_names = parent_names;
 	init.num_parents = num_parents;
 	hw = &composite->hw;
diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index e5a17265cfaf..568e10a33ea4 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -475,7 +475,7 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
 		init.ops = &clk_divider_ro_ops;
 	else
 		init.ops = &clk_divider_ops;
-	init.flags = flags | CLK_IS_BASIC;
+	init.flags = flags;
 	init.parent_names = (parent_name ? &parent_name: NULL);
 	init.num_parents = (parent_name ? 1 : 0);
 
diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 241b3f8c61a9..8aac2d1b6fea 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -84,7 +84,7 @@ struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
 
 	init.name = name;
 	init.ops = &clk_fixed_factor_ops;
-	init.flags = flags | CLK_IS_BASIC;
+	init.flags = flags;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 00ef4f5e53fe..a7e4aef7a376 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -68,7 +68,7 @@ struct clk_hw *clk_hw_register_fixed_rate_with_accuracy(struct device *dev,
 
 	init.name = name;
 	init.ops = &clk_fixed_rate_ops;
-	init.flags = flags | CLK_IS_BASIC;
+	init.flags = flags;
 	init.parent_names = (parent_name ? &parent_name: NULL);
 	init.num_parents = (parent_name ? 1 : 0);
 
diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index fdfe2e423d15..aa45dd257fe3 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -151,7 +151,7 @@ struct clk_hw *clk_hw_register_fractional_divider(struct device *dev,
 
 	init.name = name;
 	init.ops = &clk_fractional_divider_ops;
-	init.flags = flags | CLK_IS_BASIC;
+	init.flags = flags;
 	init.parent_names = parent_name ? &parent_name : NULL;
 	init.num_parents = parent_name ? 1 : 0;
 
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index f05823cd9b21..f58a58d5d80a 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -142,7 +142,7 @@ struct clk_hw *clk_hw_register_gate(struct device *dev, const char *name,
 
 	init.name = name;
 	init.ops = &clk_gate_ops;
-	init.flags = flags | CLK_IS_BASIC;
+	init.flags = flags;
 	init.parent_names = parent_name ? &parent_name : NULL;
 	init.num_parents = parent_name ? 1 : 0;
 
diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index c2f07f0d077c..9d930edd6516 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -137,7 +137,7 @@ static struct clk_hw *clk_register_gpio(struct device *dev, const char *name,
 
 	init.name = name;
 	init.ops = clk_gpio_ops;
-	init.flags = flags | CLK_IS_BASIC;
+	init.flags = flags;
 	init.parent_names = parent_names;
 	init.num_parents = num_parents;
 
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 2ad2df2e8909..7d60d690b7f2 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -159,7 +159,7 @@ struct clk_hw *clk_hw_register_mux_table(struct device *dev, const char *name,
 		init.ops = &clk_mux_ro_ops;
 	else
 		init.ops = &clk_mux_ops;
-	init.flags = flags | CLK_IS_BASIC;
+	init.flags = flags;
 	init.parent_names = parent_names;
 	init.num_parents = num_parents;
 
diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index 8cb9d117fdbf..02b472a1f9b0 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -101,7 +101,7 @@ static int clk_pwm_probe(struct platform_device *pdev)
 
 	init.name = clk_name;
 	init.ops = &clk_pwm_ops;
-	init.flags = CLK_IS_BASIC;
+	init.flags = 0;
 	init.num_parents = 0;
 
 	clk_pwm->pwm = pwm;
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 96053a96fe2f..7279573eefd5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2850,7 +2850,6 @@ static const struct {
 	ENTRY(CLK_SET_PARENT_GATE),
 	ENTRY(CLK_SET_RATE_PARENT),
 	ENTRY(CLK_IGNORE_UNUSED),
-	ENTRY(CLK_IS_BASIC),
 	ENTRY(CLK_GET_RATE_NOCACHE),
 	ENTRY(CLK_SET_RATE_NO_REPARENT),
 	ENTRY(CLK_GET_ACCURACY_NOCACHE),
diff --git a/drivers/clk/mmp/clk-gate.c b/drivers/clk/mmp/clk-gate.c
index 7355595c42e2..1755916ddef2 100644
--- a/drivers/clk/mmp/clk-gate.c
+++ b/drivers/clk/mmp/clk-gate.c
@@ -108,7 +108,7 @@ struct clk *mmp_clk_register_gate(struct device *dev, const char *name,
 
 	init.name = name;
 	init.ops = &mmp_clk_gate_ops;
-	init.flags = flags | CLK_IS_BASIC;
+	init.flags = flags;
 	init.parent_names = (parent_name ? &parent_name : NULL);
 	init.num_parents = (parent_name ? 1 : 0);
 
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index c1ed641b3e26..4ae5d774443e 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -470,7 +470,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
 
 		init.name = name;
 		init.ops = &clk_mux_ops;
-		init.flags = CLK_IS_BASIC;
+		init.flags = 0;
 		init.parent_names = meson->data->parent_names;
 		init.num_parents = meson->data->num_parents;
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index b7cf80a71293..9245a377295b 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -24,7 +24,7 @@
 #define CLK_SET_RATE_PARENT	BIT(2) /* propagate rate change up one level */
 #define CLK_IGNORE_UNUSED	BIT(3) /* do not gate even if unused */
 				/* unused */
-#define CLK_IS_BASIC		BIT(5) /* Basic clk, can't do a to_clk_foo() */
+				/* unused */
 #define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
 #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
 #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */

base-commit: 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
prerequisite-patch-id: 6196ca807a15f9f4a67d5e6b8668b4f13442ac15
prerequisite-patch-id: 9532946d1be40c2b20af0591ac4636a4cf3b14dd
prerequisite-patch-id: 4e4a9591f5a4ac0d5a72e694da8fdae8c8dda352
prerequisite-patch-id: bcd75306e64ff866989a978127f6b16f7575d0d3
-- 
Sent by a computer through tubes

