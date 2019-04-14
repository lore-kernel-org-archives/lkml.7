Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1847AC282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DC820850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avzx//De"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfDNSGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:06:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35702 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfDNSF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:05:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so7467058pfh.2;
        Sun, 14 Apr 2019 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+Y23+vC9B4RqCaEcK8mExSN5AW1iCVVFid4qSNM/+w=;
        b=avzx//De6wvvPnmqoVGEfs/cCMo95YEi031OH7Dl+AzyCCpv2l6+Y1v7M1/H2E6UvT
         /8uY1uXCymoSaDKjT0sCKt+RJyt06DlAqOysjI9OVTp+luJA2as9hlpVU7gECxkIJ1uv
         QB+bGNDOOg5Wa+6EVg1CnFL25eEywmeuS1FPfsRd3jwmo5zOXfU1z8lds7htBhJ3p7/V
         5JN4cZz1UqmU0DoLU5zMKttjMwaiHyVO34Vc2kU0Wg00kHpdVsIh29Dub/PVX8WUlrtL
         baV/pJoCU03qVAwub/4pw++cMNL6EQZ3vGd7h1I+huFQmLeTw/7ROhMVEsMUmaRM3Hws
         l7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+Y23+vC9B4RqCaEcK8mExSN5AW1iCVVFid4qSNM/+w=;
        b=XexkC+PtfN//kAFQTgHM0FZyDvU/uu6RgzO3fm9+SKVIGkrDA+jYLxfCkGRZBseVx0
         LVRQlCFn+BIbRnps0BMkmLeVNNNAWt4nOFep06siSGXNqP8/qZTOwz/pq97T79luQV1a
         bsdgqmhwOhAgaLev+KlaqcDr5tjT/DDg4i2qF0nSMebOWJH4QH92ge6Ouq2/OFKkYVTW
         oYFmrji8zQHuhfwty5XhA+YcRvN0sMeRp2JyhJBynpMEtcoukyGR8yfVHqoWpVrA97GF
         06Ntf2Z959VuOoMa/z57j+MFFIgPRkcztj4vSe3O/YXhS/iuCcgb5eZH45tyjqS+6qMF
         7BFg==
X-Gm-Message-State: APjAAAVaP3yuXmk2KXwBtI6Z3X/vgydexIeBlaI4ago6OeFfFKO8e3O7
        5KJHs+jD2udqNI7aq55L+lc=
X-Google-Smtp-Source: APXvYqwasMKAu+/HVD/sM4rgvzkkBNhQFTTvm1KSGcQeGJJmIgrl64tDOgzrNhQlSv7Roime8M5Fzw==
X-Received: by 2002:aa7:9294:: with SMTP id j20mr6958756pfa.64.1555265157759;
        Sun, 14 Apr 2019 11:05:57 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id e7sm43359712pfc.132.2019.04.14.11.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 11:05:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/6] regulator: core: Parse max-spread value per regulator couple
Date:   Sun, 14 Apr 2019 20:59:35 +0300
Message-Id: <20190414175939.12368-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190414175939.12368-1-digetx@gmail.com>
References: <20190414175939.12368-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse and validate max-spread value per regulator couple. Now regulator
core can take multiple regulator couples, although balancing is still
limited to a single couple.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c          | 13 ++++----
 drivers/regulator/of_regulator.c  | 49 +++++++++++++++++++++----------
 include/linux/regulator/machine.h |  3 +-
 3 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a98af47e0feb..cdb25bbee631 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3440,7 +3440,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
 	struct regulator_dev **c_rdevs = c_desc->coupled_rdevs;
 	struct regulation_constraints *constraints = rdev->constraints;
-	int max_spread = constraints->max_spread;
+	int max_spread = constraints->max_spread[0];
 	int desired_min_uV = 0, desired_max_uV = INT_MAX;
 	int max_current_uV = 0, min_current_uV = INT_MAX;
 	int highest_min_uV = 0, target_uV, possible_uV;
@@ -3604,6 +3604,12 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 		return machine_regulators_coupler->balance_voltage(
 				machine_regulators_coupler, rdev, state);
 
+	if (n_coupled > 2) {
+		rdev_err(rdev,
+			 "Voltage balancing for multiple regulator couples is unimplemented\n");
+		return -EPERM;
+	}
+
 	for (i = 0; i < n_coupled; i++)
 		c_rdev_done[i] = false;
 
@@ -4821,11 +4827,6 @@ static int regulator_init_coupling(struct regulator_dev *rdev)
 		return -EPERM;
 	}
 
-	if (rdev->constraints->max_spread <= 0) {
-		rdev_err(rdev, "wrong max_spread value\n");
-		return -EPERM;
-	}
-
 	if (!of_check_coupling_data(rdev))
 		return -EPERM;
 
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 6dca0ba044d8..ccca09de92d6 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -34,8 +34,14 @@ static void of_get_regulation_constraints(struct device_node *np,
 	struct device_node *suspend_np;
 	unsigned int mode;
 	int ret, i, len;
+	int n_phandles;
+	u32 pvals[MAX_COUPLED];
 	u32 pval;
 
+	n_phandles = of_count_phandle_with_args(np, "regulator-coupled-with",
+						NULL);
+	n_phandles = max(n_phandles, 0);
+
 	constraints->name = of_get_property(np, "regulator-name", NULL);
 
 	if (!of_property_read_u32(np, "regulator-min-microvolt", &pval))
@@ -167,9 +173,12 @@ static void of_get_regulation_constraints(struct device_node *np,
 	if (!of_property_read_u32(np, "regulator-system-load", &pval))
 		constraints->system_load = pval;
 
-	if (!of_property_read_u32(np, "regulator-coupled-max-spread",
-				  &pval))
-		constraints->max_spread = pval;
+	if (!of_property_read_u32_array(np, "regulator-coupled-max-spread",
+					pvals, n_phandles)) {
+
+		for (i = 0; i < n_phandles; i++)
+			constraints->max_spread[i] = pvals[i];
+	}
 
 	if (!of_property_read_u32(np, "regulator-max-step-microvolt",
 				  &pval))
@@ -477,7 +486,8 @@ int of_get_n_coupled(struct regulator_dev *rdev)
 
 /* Looks for "to_find" device_node in src's "regulator-coupled-with" property */
 static bool of_coupling_find_node(struct device_node *src,
-				  struct device_node *to_find)
+				  struct device_node *to_find,
+				  int *index)
 {
 	int n_phandles, i;
 	bool found = false;
@@ -499,8 +509,10 @@ static bool of_coupling_find_node(struct device_node *src,
 
 		of_node_put(tmp);
 
-		if (found)
+		if (found) {
+			*index = i;
 			break;
+		}
 	}
 
 	return found;
@@ -521,22 +533,28 @@ static bool of_coupling_find_node(struct device_node *src,
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
+	if (n_phandles >= MAX_COUPLED) {
+		dev_err(&rdev->dev, "please bump MAX_COUPLED number\n");
 		return false;
 	}
 
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
 
@@ -553,22 +571,23 @@ bool of_check_coupling_data(struct regulator_dev *rdev)
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
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index f15c8c5f7f6c..0ade1247d3f6 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -15,6 +15,7 @@
 #ifndef __LINUX_REGULATOR_MACHINE_H_
 #define __LINUX_REGULATOR_MACHINE_H_
 
+#include <linux/regulator/driver.h>
 #include <linux/regulator/consumer.h>
 #include <linux/suspend.h>
 
@@ -157,7 +158,7 @@ struct regulation_constraints {
 	int system_load;
 
 	/* used for coupled regulators */
-	int max_spread;
+	int max_spread[MAX_COUPLED];
 
 	/* used for changing voltage in steps */
 	int max_uV_step;
-- 
2.21.0

