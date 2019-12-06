Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CCCC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412922077B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Kbwn0bhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfLFCt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 21:49:26 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15998 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfLFCtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:49:15 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de9c1950000>; Thu, 05 Dec 2019 18:48:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Dec 2019 18:49:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Dec 2019 18:49:10 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 02:49:09 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 02:49:09 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Dec 2019 02:49:08 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.163.171]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5de9c1a30001>; Thu, 05 Dec 2019 18:49:08 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <tglx@linutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alexios.zavras@intel.com>, <alsa-devel@alsa-project.org>
Subject: [PATCH v3 08/15] ASoC: tegra: Add audio mclk control through clk_out_1 and extern1
Date:   Thu, 5 Dec 2019 18:48:48 -0800
Message-ID: <1575600535-26877-9-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575600533; bh=C8ogo7PFlkowNwgYuCMhfHS/nrwB/RSqHS/qmHQ/Fpc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Kbwn0bhFtW2q/rZt2u6MK8d0GQA1uRvGJ8F6mOd7tF2TI6Ab5yURb3EZ+I3QmMryp
         J4UoIBKCwSoVlLAD3gbIrfduYvP//0bhzTJnNK2ihzLqeuDv4tTdPezMa44paPK0bv
         GFvKko2N73YDVTK43OSxaN42E8wrZwZCKFZdVny8CEz15J7yYuDenTB4JRI47YZqzB
         7CveJHu3nvqZ10/8b75nfQ1Pb+E3j+l1uxvfxbI8oVe///DIwLMrzxS6xrUiGHFkxv
         5fFgBL6FaLlbOS8BhoE8agDv7MeNXj1AUvIbSt+0501wwAkFGJnNrWBfz3jQO9BUzO
         JYjyy33X1u33w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current ASoC driver uses extern1 as cdev1 clock from Tegra30 onwards
through device tree.

Actual audio mclk is clk_out_1 and to use PLLA for mclk rate control,
need to clk_out_1_mux parent to extern1 and extern1 parent to PLLA_OUT0.

Currently Tegra clock driver init sets the parents and enables both
clk_out_1 and extern1 clocks. But these clocks parent and enables should
be controlled by ASoC driver.

Clock parents can be specified in device tree using assigned-clocks
and assigned-clock-parents.

To enable audio mclk, both clk_out_1 and extern1 clocks need to be
enabled.

This patch configures parents for clk_out_1 and extern1 clocks if device
tree does not specify clock parents inorder to support old device tree
and controls mclk using both clk_out_1 and extern1 clocks.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 sound/soc/tegra/tegra_asoc_utils.c | 66 ++++++++++++++++++++++++++++++++++++++
 sound/soc/tegra/tegra_asoc_utils.h |  1 +
 2 files changed, 67 insertions(+)

diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
index 536a578e9512..8e3a3740df7c 100644
--- a/sound/soc/tegra/tegra_asoc_utils.c
+++ b/sound/soc/tegra/tegra_asoc_utils.c
@@ -60,6 +60,7 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
 	data->set_mclk = 0;
 
 	clk_disable_unprepare(data->clk_cdev1);
+	clk_disable_unprepare(data->clk_extern1);
 	clk_disable_unprepare(data->clk_pll_a_out0);
 	clk_disable_unprepare(data->clk_pll_a);
 
@@ -89,6 +90,14 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
 		return err;
 	}
 
+	if (!IS_ERR_OR_NULL(data->clk_extern1)) {
+		err = clk_prepare_enable(data->clk_extern1);
+		if (err) {
+			dev_err(data->dev, "Can't enable extern1: %d\n", err);
+			return err;
+		}
+	}
+
 	err = clk_prepare_enable(data->clk_cdev1);
 	if (err) {
 		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
@@ -109,6 +118,7 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data *data)
 	int err;
 
 	clk_disable_unprepare(data->clk_cdev1);
+	clk_disable_unprepare(data->clk_extern1);
 	clk_disable_unprepare(data->clk_pll_a_out0);
 	clk_disable_unprepare(data->clk_pll_a);
 
@@ -142,6 +152,14 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data *data)
 		return err;
 	}
 
+	if (!IS_ERR_OR_NULL(data->clk_extern1)) {
+		err = clk_prepare_enable(data->clk_extern1);
+		if (err) {
+			dev_err(data->dev, "Can't enable extern1: %d\n", err);
+			return err;
+		}
+	}
+
 	err = clk_prepare_enable(data->clk_cdev1);
 	if (err) {
 		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
@@ -158,6 +176,7 @@ EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
 int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
 			  struct device *dev)
 {
+	struct clk *clk_out_1_mux;
 	int ret;
 
 	data->dev = dev;
@@ -196,6 +215,51 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
 		goto err_put_pll_a_out0;
 	}
 
+	/*
+	 * If clock parents are not set in DT, configure here to use clk_out_1
+	 * as mclk and extern1 as parent for Tegra30 and higher.
+	 */
+	if (!of_find_property(dev->of_node, "assigned-clock-parents", NULL) &&
+	    data->soc > TEGRA_ASOC_UTILS_SOC_TEGRA20) {
+		data->clk_extern1 = clk_get_sys("clk_out_1", "extern1");
+		if (IS_ERR(data->clk_extern1)) {
+			dev_err(data->dev, "Can't retrieve clk extern1\n");
+			ret = PTR_ERR(data->clk_extern1);
+			goto err_put_cdev1;
+		}
+
+		ret = clk_set_parent(data->clk_extern1, data->clk_pll_a_out0);
+		if (ret < 0) {
+			dev_err(data->dev,
+				"Set parent failed for clk extern1: %d\n",
+				ret);
+			goto err_put_cdev1;
+		}
+
+		clk_out_1_mux = clk_get_sys(NULL, "clk_out_1_mux");
+		if (IS_ERR(clk_out_1_mux)) {
+			dev_err(data->dev, "Can't retrieve clk clk_out_1_mux\n");
+			ret = PTR_ERR(clk_out_1_mux);
+			goto err_put_cdev1;
+		}
+
+		ret = clk_set_parent(clk_out_1_mux, data->clk_extern1);
+		if (ret < 0) {
+			dev_err(data->dev,
+				"Set parent failed for clk_out_1_mux: %d\n",
+				ret);
+			clk_put(clk_out_1_mux);
+			goto err_put_cdev1;
+		}
+
+		data->clk_cdev1 = clk_get_sys(NULL, "clk_out_1");
+		if (IS_ERR(data->clk_cdev1)) {
+			dev_err(data->dev, "Can't retrieve clk clk_out_1\n");
+			ret = PTR_ERR(data->clk_cdev1);
+			goto err_put_cdev1;
+		}
+	}
+
 	ret = tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
 	if (ret)
 		goto err_put_cdev1;
@@ -215,6 +279,8 @@ EXPORT_SYMBOL_GPL(tegra_asoc_utils_init);
 
 void tegra_asoc_utils_fini(struct tegra_asoc_utils_data *data)
 {
+	if (!IS_ERR_OR_NULL(data->clk_extern1))
+		clk_put(data->clk_extern1);
 	clk_put(data->clk_cdev1);
 	clk_put(data->clk_pll_a_out0);
 	clk_put(data->clk_pll_a);
diff --git a/sound/soc/tegra/tegra_asoc_utils.h b/sound/soc/tegra/tegra_asoc_utils.h
index 0c13818dee75..5f2b96478caf 100644
--- a/sound/soc/tegra/tegra_asoc_utils.h
+++ b/sound/soc/tegra/tegra_asoc_utils.h
@@ -25,6 +25,7 @@ struct tegra_asoc_utils_data {
 	struct clk *clk_pll_a;
 	struct clk *clk_pll_a_out0;
 	struct clk *clk_cdev1;
+	struct clk *clk_extern1;
 	int set_baseclock;
 	int set_mclk;
 };
-- 
2.7.4

