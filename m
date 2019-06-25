Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1507C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F3820656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561461646;
	bh=EX2/p+Bjcu79jxltETrKeXLPdVaL6Opxz25+LepDUVw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=rJsM4VJrbsmdniz3hVp4bZ9SAxlYFgpVGk2t0xW2MYf2x9/B7motYb7ljlBI6gq2J
	 wIJdOUPx0I37aWFiiHh2cABgtr3Pp2IcWp+HX5phXn9GiEK/RSzTpu9j1kAd3QXAjY
	 VoJhKLVSLJZPZ9W6I5FlvY3YtXIscNv6HU0aTqjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbfFYLUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:20:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41792 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfFYLUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=jflzM9ivyyyVpdMXAgtt9p90yefihgv40iO/5R3R65Q=; b=R1CzL+75NJaX
        3ZSb1JmgLKD7X5QPvj3Wk/QUVVVlK9pkvqX+Qpop3GOlbQM903oDAJ3K+y0J1VUtHUDsHSuvxpewS
        IOsiZ/N3il9Vy9kBgcQ5h6mPQz3AVKat/Mz0zYfI24Gp28yAa+ZeyhmntTAREjAPQS4eFGAmVtzik
        keB+E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hfjV9-00057u-PM; Tue, 25 Jun 2019 11:20:39 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 47B83440046; Tue, 25 Jun 2019 12:20:39 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: core: Introduce API for regulators coupling customization" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190625112039.47B83440046@finisterre.sirena.org.uk>
Date:   Tue, 25 Jun 2019 12:20:39 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Introduce API for regulators coupling customization

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From d8ca7d184b33af7913c244900df77c6cad6a5590 Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Mon, 24 Jun 2019 00:08:31 +0300
Subject: [PATCH] regulator: core: Introduce API for regulators coupling
 customization

Right now regulator core supports only one type of regulators coupling,
the "voltage max-spread" which keeps voltages of coupled regulators in a
given range from each other. A more sophisticated coupling may be required
in practice, one example is the NVIDIA Tegra SoCs which besides the
max-spreading have other restrictions that must be adhered. Introduce API
that allow platforms to provide their own customized coupling algorithms.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c          | 136 +++++++++++++++++++++++++-----
 drivers/regulator/of_regulator.c  |  63 +++++++++-----
 include/linux/regulator/coupler.h |  62 ++++++++++++++
 include/linux/regulator/driver.h  |   6 +-
 include/linux/regulator/machine.h |   2 +-
 5 files changed, 225 insertions(+), 44 deletions(-)
 create mode 100644 include/linux/regulator/coupler.h

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 955a0a15b9cb..12c870f790f5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -28,6 +28,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regulator/coupler.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/module.h>
@@ -55,6 +56,7 @@ static DEFINE_MUTEX(regulator_list_mutex);
 static LIST_HEAD(regulator_map_list);
 static LIST_HEAD(regulator_ena_gpio_list);
 static LIST_HEAD(regulator_supply_alias_list);
+static LIST_HEAD(regulator_coupler_list);
 static bool has_full_constraints;
 
 static struct dentry *debugfs_root;
@@ -3439,11 +3441,10 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
 	struct regulator_dev **c_rdevs = c_desc->coupled_rdevs;
 	struct regulation_constraints *constraints = rdev->constraints;
-	int max_spread = constraints->max_spread;
 	int desired_min_uV = 0, desired_max_uV = INT_MAX;
 	int max_current_uV = 0, min_current_uV = INT_MAX;
 	int highest_min_uV = 0, target_uV, possible_uV;
-	int i, ret;
+	int i, ret, max_spread;
 	bool done;
 
 	*current_uV = -1;
@@ -3497,6 +3498,8 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 		}
 	}
 
+	max_spread = constraints->max_spread[0];
+
 	/*
 	 * Let target_uV be equal to the desired one if possible.
 	 * If not, set it to minimum voltage, allowed by other coupled
@@ -3578,9 +3581,11 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 	struct regulator_dev **c_rdevs;
 	struct regulator_dev *best_rdev;
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	struct regulator_coupler *coupler = c_desc->coupler;
 	int i, ret, n_coupled, best_min_uV, best_max_uV, best_c_rdev;
-	bool best_c_rdev_done, c_rdev_done[MAX_COUPLED];
 	unsigned int delta, best_delta;
+	unsigned long c_rdev_done = 0;
+	bool best_c_rdev_done;
 
 	c_rdevs = c_desc->coupled_rdevs;
 	n_coupled = c_desc->n_coupled;
@@ -3597,8 +3602,9 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 		return -EPERM;
 	}
 
-	for (i = 0; i < n_coupled; i++)
-		c_rdev_done[i] = false;
+	/* Invoke custom balancer for customized couplers */
+	if (coupler && coupler->balance_voltage)
+		return coupler->balance_voltage(coupler, rdev, state);
 
 	/*
 	 * Find the best possible voltage change on each loop. Leave the loop
@@ -3625,7 +3631,7 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 			 */
 			int optimal_uV = 0, optimal_max_uV = 0, current_uV = 0;
 
-			if (c_rdev_done[i])
+			if (test_bit(i, &c_rdev_done))
 				continue;
 
 			ret = regulator_get_optimal_voltage(c_rdevs[i],
@@ -3660,7 +3666,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 		if (ret < 0)
 			goto out;
 
-		c_rdev_done[best_c_rdev] = best_c_rdev_done;
+		if (best_c_rdev_done)
+			set_bit(best_c_rdev, &c_rdev_done);
 
 	} while (n_coupled > 1);
 
@@ -4712,8 +4719,60 @@ static int regulator_register_resolve_supply(struct device *dev, void *data)
 	return 0;
 }
 
+int regulator_coupler_register(struct regulator_coupler *coupler)
+{
+	mutex_lock(&regulator_list_mutex);
+	list_add_tail(&coupler->list, &regulator_coupler_list);
+	mutex_unlock(&regulator_list_mutex);
+
+	return 0;
+}
+
+static struct regulator_coupler *
+regulator_find_coupler(struct regulator_dev *rdev)
+{
+	struct regulator_coupler *coupler;
+	int err;
+
+	/*
+	 * Note that regulators are appended to the list and the generic
+	 * coupler is registered first, hence it will be attached at last
+	 * if nobody cared.
+	 */
+	list_for_each_entry_reverse(coupler, &regulator_coupler_list, list) {
+		err = coupler->attach_regulator(coupler, rdev);
+		if (!err) {
+			if (!coupler->balance_voltage &&
+			    rdev->coupling_desc.n_coupled > 2)
+				goto err_unsupported;
+
+			return coupler;
+		}
+
+		if (err < 0)
+			return ERR_PTR(err);
+
+		if (err == 1)
+			continue;
+
+		break;
+	}
+
+	return ERR_PTR(-EINVAL);
+
+err_unsupported:
+	if (coupler->detach_regulator)
+		coupler->detach_regulator(coupler, rdev);
+
+	rdev_err(rdev,
+		"Voltage balancing for multiple regulator couples is unimplemented\n");
+
+	return ERR_PTR(-EPERM);
+}
+
 static void regulator_resolve_coupling(struct regulator_dev *rdev)
 {
+	struct regulator_coupler *coupler = rdev->coupling_desc.coupler;
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
 	int n_coupled = c_desc->n_coupled;
 	struct regulator_dev *c_rdev;
@@ -4729,6 +4788,12 @@ static void regulator_resolve_coupling(struct regulator_dev *rdev)
 		if (!c_rdev)
 			continue;
 
+		if (c_rdev->coupling_desc.coupler != coupler) {
+			rdev_err(rdev, "coupler mismatch with %s\n",
+				 rdev_get_name(c_rdev));
+			return;
+		}
+
 		regulator_lock(c_rdev);
 
 		c_desc->coupled_rdevs[i] = c_rdev;
@@ -4742,10 +4807,12 @@ static void regulator_resolve_coupling(struct regulator_dev *rdev)
 
 static void regulator_remove_coupling(struct regulator_dev *rdev)
 {
+	struct regulator_coupler *coupler = rdev->coupling_desc.coupler;
 	struct coupling_desc *__c_desc, *c_desc = &rdev->coupling_desc;
 	struct regulator_dev *__c_rdev, *c_rdev;
 	unsigned int __n_coupled, n_coupled;
 	int i, k;
+	int err;
 
 	n_coupled = c_desc->n_coupled;
 
@@ -4775,21 +4842,33 @@ static void regulator_remove_coupling(struct regulator_dev *rdev)
 		c_desc->coupled_rdevs[i] = NULL;
 		c_desc->n_resolved--;
 	}
+
+	if (coupler && coupler->detach_regulator) {
+		err = coupler->detach_regulator(coupler, rdev);
+		if (err)
+			rdev_err(rdev, "failed to detach from coupler: %d\n",
+				 err);
+	}
+
+	kfree(rdev->coupling_desc.coupled_rdevs);
+	rdev->coupling_desc.coupled_rdevs = NULL;
 }
 
 static int regulator_init_coupling(struct regulator_dev *rdev)
 {
-	int n_phandles;
+	int err, n_phandles;
+	size_t alloc_size;
 
 	if (!IS_ENABLED(CONFIG_OF))
 		n_phandles = 0;
 	else
 		n_phandles = of_get_n_coupled(rdev);
 
-	if (n_phandles + 1 > MAX_COUPLED) {
-		rdev_err(rdev, "too many regulators coupled\n");
-		return -EPERM;
-	}
+	alloc_size = sizeof(*rdev) * (n_phandles + 1);
+
+	rdev->coupling_desc.coupled_rdevs = kzalloc(alloc_size, GFP_KERNEL);
+	if (!rdev->coupling_desc.coupled_rdevs)
+		return -ENOMEM;
 
 	/*
 	 * Every regulator should always have coupling descriptor filled with
@@ -4803,23 +4882,35 @@ static int regulator_init_coupling(struct regulator_dev *rdev)
 	if (n_phandles == 0)
 		return 0;
 
-	/* regulator, which can't change its voltage, can't be coupled */
-	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_VOLTAGE)) {
-		rdev_err(rdev, "voltage operation not allowed\n");
+	if (!of_check_coupling_data(rdev))
 		return -EPERM;
-	}
 
-	if (rdev->constraints->max_spread <= 0) {
-		rdev_err(rdev, "wrong max_spread value\n");
-		return -EPERM;
+	rdev->coupling_desc.coupler = regulator_find_coupler(rdev);
+	if (IS_ERR(rdev->coupling_desc.coupler)) {
+		err = PTR_ERR(rdev->coupling_desc.coupler);
+		rdev_err(rdev, "failed to get coupler: %d\n", err);
+		return err;
 	}
 
-	if (!of_check_coupling_data(rdev))
+	return 0;
+}
+
+static int generic_coupler_attach(struct regulator_coupler *coupler,
+				  struct regulator_dev *rdev)
+{
+	if (rdev->coupling_desc.n_coupled > 2) {
+		rdev_err(rdev,
+			 "Voltage balancing for multiple regulator couples is unimplemented\n");
 		return -EPERM;
+	}
 
 	return 0;
 }
 
+static struct regulator_coupler generic_regulator_coupler = {
+	.attach_regulator = generic_coupler_attach,
+};
+
 /**
  * regulator_register - register regulator
  * @regulator_desc: regulator to register
@@ -4981,7 +5072,9 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	if (ret < 0)
 		goto wash;
 
+	mutex_lock(&regulator_list_mutex);
 	ret = regulator_init_coupling(rdev);
+	mutex_unlock(&regulator_list_mutex);
 	if (ret < 0)
 		goto wash;
 
@@ -5030,6 +5123,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 unset_supplies:
 	mutex_lock(&regulator_list_mutex);
 	unset_regulator_supplies(rdev);
+	regulator_remove_coupling(rdev);
 	mutex_unlock(&regulator_list_mutex);
 wash:
 	kfree(rdev->constraints);
@@ -5485,6 +5579,8 @@ static int __init regulator_init(void)
 #endif
 	regulator_dummy_init();
 
+	regulator_coupler_register(&generic_regulator_coupler);
+
 	return ret;
 }
 
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 6dca0ba044d8..db1cb2714b92 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -25,7 +25,8 @@ static const char *const regulator_states[PM_SUSPEND_MAX + 1] = {
 	[PM_SUSPEND_MAX]	= "regulator-state-disk",
 };
 
-static void of_get_regulation_constraints(struct device_node *np,
+static int of_get_regulation_constraints(struct device *dev,
+					struct device_node *np,
 					struct regulator_init_data **init_data,
 					const struct regulator_desc *desc)
 {
@@ -34,8 +35,13 @@ static void of_get_regulation_constraints(struct device_node *np,
 	struct device_node *suspend_np;
 	unsigned int mode;
 	int ret, i, len;
+	int n_phandles;
 	u32 pval;
 
+	n_phandles = of_count_phandle_with_args(np, "regulator-coupled-with",
+						NULL);
+	n_phandles = max(n_phandles, 0);
+
 	constraints->name = of_get_property(np, "regulator-name", NULL);
 
 	if (!of_property_read_u32(np, "regulator-min-microvolt", &pval))
@@ -167,9 +173,17 @@ static void of_get_regulation_constraints(struct device_node *np,
 	if (!of_property_read_u32(np, "regulator-system-load", &pval))
 		constraints->system_load = pval;
 
-	if (!of_property_read_u32(np, "regulator-coupled-max-spread",
-				  &pval))
-		constraints->max_spread = pval;
+	if (n_phandles) {
+		constraints->max_spread = devm_kzalloc(dev,
+				sizeof(*constraints->max_spread) * n_phandles,
+				GFP_KERNEL);
+
+		if (!constraints->max_spread)
+			return -ENOMEM;
+
+		of_property_read_u32_array(np, "regulator-coupled-max-spread",
+					   constraints->max_spread, n_phandles);
+	}
 
 	if (!of_property_read_u32(np, "regulator-max-step-microvolt",
 				  &pval))
@@ -246,6 +260,8 @@ static void of_get_regulation_constraints(struct device_node *np,
 		suspend_state = NULL;
 		suspend_np = NULL;
 	}
+
+	return 0;
 }
 
 /**
@@ -271,7 +287,9 @@ struct regulator_init_data *of_get_regulator_init_data(struct device *dev,
 	if (!init_data)
 		return NULL; /* Out of memory? */
 
-	of_get_regulation_constraints(node, &init_data, desc);
+	if (of_get_regulation_constraints(dev, node, &init_data, desc))
+		return NULL;
+
 	return init_data;
 }
 EXPORT_SYMBOL_GPL(of_get_regulator_init_data);
@@ -477,7 +495,8 @@ int of_get_n_coupled(struct regulator_dev *rdev)
 
 /* Looks for "to_find" device_node in src's "regulator-coupled-with" property */
 static bool of_coupling_find_node(struct device_node *src,
-				  struct device_node *to_find)
+				  struct device_node *to_find,
+				  int *index)
 {
 	int n_phandles, i;
 	bool found = false;
@@ -499,8 +518,10 @@ static bool of_coupling_find_node(struct device_node *src,
 
 		of_node_put(tmp);
 
-		if (found)
+		if (found) {
+			*index = i;
 			break;
+		}
 	}
 
 	return found;
@@ -521,22 +542,23 @@ static bool of_coupling_find_node(struct device_node *src,
  */
 bool of_check_coupling_data(struct regulator_dev *rdev)
 {
-	int max_spread = rdev->constraints->max_spread;
 	struct device_node *node = rdev->dev.of_node;
 	int n_phandles = of_get_n_coupled(rdev);
 	struct device_node *c_node;
+	int index;
 	int i;
 	bool ret = true;
 
-	if (max_spread <= 0) {
-		dev_err(&rdev->dev, "max_spread value invalid\n");
-		return false;
-	}
-
 	/* iterate over rdev's phandles */
 	for (i = 0; i < n_phandles; i++) {
+		int max_spread = rdev->constraints->max_spread[i];
 		int c_max_spread, c_n_phandles;
 
+		if (max_spread <= 0) {
+			dev_err(&rdev->dev, "max_spread value invalid\n");
+			return false;
+		}
+
 		c_node = of_parse_phandle(node,
 					  "regulator-coupled-with", i);
 
@@ -553,22 +575,23 @@ bool of_check_coupling_data(struct regulator_dev *rdev)
 			goto clean;
 		}
 
-		if (of_property_read_u32(c_node, "regulator-coupled-max-spread",
-					 &c_max_spread)) {
+		if (!of_coupling_find_node(c_node, node, &index)) {
+			dev_err(&rdev->dev, "missing 2-way linking for coupled regulators\n");
 			ret = false;
 			goto clean;
 		}
 
-		if (c_max_spread != max_spread) {
-			dev_err(&rdev->dev,
-				"coupled regulators max_spread mismatch\n");
+		if (of_property_read_u32_index(c_node, "regulator-coupled-max-spread",
+					       index, &c_max_spread)) {
 			ret = false;
 			goto clean;
 		}
 
-		if (!of_coupling_find_node(c_node, node)) {
-			dev_err(&rdev->dev, "missing 2-way linking for coupled regulators\n");
+		if (c_max_spread != max_spread) {
+			dev_err(&rdev->dev,
+				"coupled regulators max_spread mismatch\n");
 			ret = false;
+			goto clean;
 		}
 
 clean:
diff --git a/include/linux/regulator/coupler.h b/include/linux/regulator/coupler.h
new file mode 100644
index 000000000000..98dd1f74d605
--- /dev/null
+++ b/include/linux/regulator/coupler.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * coupler.h -- SoC Regulator support, coupler API.
+ *
+ * Regulator Coupler Interface.
+ */
+
+#ifndef __LINUX_REGULATOR_COUPLER_H_
+#define __LINUX_REGULATOR_COUPLER_H_
+
+#include <linux/kernel.h>
+#include <linux/suspend.h>
+
+struct regulator_coupler;
+struct regulator_dev;
+
+/**
+ * struct regulator_coupler - customized regulator's coupler
+ *
+ * Regulator's coupler allows to customize coupling algorithm.
+ *
+ * @list: couplers list entry
+ * @attach_regulator: Callback invoked on creation of a coupled regulator,
+ *                    couples are unresolved at this point. The callee should
+ *                    check that it could handle the regulator and return 0 on
+ *                    success, -errno on failure and 1 if given regulator is
+ *                    not suitable for this coupler (case of having multiple
+ *                    regulators in a system). Callback shall be implemented.
+ * @detach_regulator: Callback invoked on destruction of a coupled regulator.
+ *                    This callback is optional and could be NULL.
+ * @balance_voltage: Callback invoked when voltage of a coupled regulator is
+ *                   changing. Called with all of the coupled rdev's being held
+ *                   under "consumer lock". The callee should perform voltage
+ *                   balancing, changing voltage of the coupled regulators as
+ *                   needed. It's up to the coupler to verify the voltage
+ *                   before changing it in hardware, i.e. coupler should
+ *                   check consumer's min/max and etc. This callback is
+ *                   optional and could be NULL, in which case a generic
+ *                   voltage balancer will be used.
+ */
+struct regulator_coupler {
+	struct list_head list;
+
+	int (*attach_regulator)(struct regulator_coupler *coupler,
+				struct regulator_dev *rdev);
+	int (*detach_regulator)(struct regulator_coupler *coupler,
+				struct regulator_dev *rdev);
+	int (*balance_voltage)(struct regulator_coupler *coupler,
+			       struct regulator_dev *rdev,
+			       suspend_state_t state);
+};
+
+#ifdef CONFIG_REGULATOR
+int regulator_coupler_register(struct regulator_coupler *coupler);
+#else
+static inline int regulator_coupler_register(struct regulator_coupler *coupler)
+{
+	return 0;
+}
+#endif
+
+#endif
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 377da2357118..31b38a2b6995 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -15,8 +15,6 @@
 #ifndef __LINUX_REGULATOR_DRIVER_H_
 #define __LINUX_REGULATOR_DRIVER_H_
 
-#define MAX_COUPLED		2
-
 #include <linux/device.h>
 #include <linux/notifier.h>
 #include <linux/regulator/consumer.h>
@@ -426,7 +424,8 @@ struct regulator_config {
  * incremented.
  */
 struct coupling_desc {
-	struct regulator_dev *coupled_rdevs[MAX_COUPLED];
+	struct regulator_dev **coupled_rdevs;
+	struct regulator_coupler *coupler;
 	int n_resolved;
 	int n_coupled;
 };
@@ -552,4 +551,5 @@ void regulator_unlock(struct regulator_dev *rdev);
  */
 int regulator_desc_list_voltage_linear_range(const struct regulator_desc *desc,
 					     unsigned int selector);
+
 #endif
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 1d34a70ffda2..21db06e5c1ed 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -156,7 +156,7 @@ struct regulation_constraints {
 	int system_load;
 
 	/* used for coupled regulators */
-	int max_spread;
+	u32 *max_spread;
 
 	/* used for changing voltage in steps */
 	int max_uV_step;
-- 
2.20.1

