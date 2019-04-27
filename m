Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A80C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3699C208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329607;
	bh=j2kyNLypqmuPdxZ4sBgK303V10UtV0B5eXfCEn/wCV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rZZb3+qKc2nzvQXU4EMHiLyS3aJBig73tLix3I4WvXOOm5bndt/rJNb+g+0yYDS/W
	 2si9V/ZCU9oaNOmjgSyfZ4N9Qjai1d/r5KkgtMDAzHrC6cXNZ88kd5QrJKQqSnX24w
	 SfCAzSxUqOonHUCWzzZ19hynSIVquRzhDSBaVY8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfD0BnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbfD0BnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:43:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3045C208CB;
        Sat, 27 Apr 2019 01:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329395;
        bh=j2kyNLypqmuPdxZ4sBgK303V10UtV0B5eXfCEn/wCV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JseIFofjbhmcrphxDvD3k/ydvDG78R//IXm24REP5FGKv+1Y1uf7hJAStHX+2Ir7a
         CpMrfflzzkHm0DOi0rG/PLyy88drWZU4+9jhx9xa3k6ADoMuu+36n+UBxkSWLnXMaF
         CN9PmKO713jUmyUTKkfBqhIzP+9A61IkSS0A+S0k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?David=20M=C3=BCller?= <dave.mueller@gmx.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 27/32] clk: x86: Add system specific quirk to mark clocks as critical
Date:   Fri, 26 Apr 2019 21:42:18 -0400
Message-Id: <20190427014224.8274-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014224.8274-1-sashal@kernel.org>
References: <20190427014224.8274-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Müller <dave.mueller@gmx.ch>

[ Upstream commit 7c2e07130090ae001a97a6b65597830d6815e93e ]

Since commit 648e921888ad ("clk: x86: Stop marking clocks as
CLK_IS_CRITICAL"), the pmc_plt_clocks of the Bay Trail SoC are
unconditionally gated off. Unfortunately this will break systems where these
clocks are used for external purposes beyond the kernel's knowledge. Fix it
by implementing a system specific quirk to mark the necessary pmc_plt_clks as
critical.

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Signed-off-by: David Müller <dave.mueller@gmx.ch>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/x86/clk-pmc-atom.c                | 14 ++++++++++---
 drivers/platform/x86/pmc_atom.c               | 21 +++++++++++++++++++
 .../linux/platform_data/x86/clk-pmc-atom.h    |  3 +++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
index d977193842df..19174835693b 100644
--- a/drivers/clk/x86/clk-pmc-atom.c
+++ b/drivers/clk/x86/clk-pmc-atom.c
@@ -165,7 +165,7 @@ static const struct clk_ops plt_clk_ops = {
 };
 
 static struct clk_plt *plt_clk_register(struct platform_device *pdev, int id,
-					void __iomem *base,
+					const struct pmc_clk_data *pmc_data,
 					const char **parent_names,
 					int num_parents)
 {
@@ -184,9 +184,17 @@ static struct clk_plt *plt_clk_register(struct platform_device *pdev, int id,
 	init.num_parents = num_parents;
 
 	pclk->hw.init = &init;
-	pclk->reg = base + PMC_CLK_CTL_OFFSET + id * PMC_CLK_CTL_SIZE;
+	pclk->reg = pmc_data->base + PMC_CLK_CTL_OFFSET + id * PMC_CLK_CTL_SIZE;
 	spin_lock_init(&pclk->lock);
 
+	/*
+	 * On some systems, the pmc_plt_clocks already enabled by the
+	 * firmware are being marked as critical to avoid them being
+	 * gated by the clock framework.
+	 */
+	if (pmc_data->critical && plt_clk_is_enabled(&pclk->hw))
+		init.flags |= CLK_IS_CRITICAL;
+
 	ret = devm_clk_hw_register(&pdev->dev, &pclk->hw);
 	if (ret) {
 		pclk = ERR_PTR(ret);
@@ -332,7 +340,7 @@ static int plt_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(parent_names);
 
 	for (i = 0; i < PMC_CLK_NUM; i++) {
-		data->clks[i] = plt_clk_register(pdev, i, pmc_data->base,
+		data->clks[i] = plt_clk_register(pdev, i, pmc_data,
 						 parent_names, data->nparents);
 		if (IS_ERR(data->clks[i])) {
 			err = PTR_ERR(data->clks[i]);
diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index 77bac859342d..75f69cf0d45f 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -17,6 +17,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/platform_data/x86/clk-pmc-atom.h>
@@ -421,11 +422,27 @@ static int pmc_dbgfs_register(struct pmc_dev *pmc)
 }
 #endif /* CONFIG_DEBUG_FS */
 
+/*
+ * Some systems need one or more of their pmc_plt_clks to be
+ * marked as critical.
+ */
+static const struct dmi_system_id critclk_systems[] __initconst = {
+	{
+		.ident = "MPL CEC1x",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MPL AG"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CEC10 Family"),
+		},
+	},
+	{ /*sentinel*/ }
+};
+
 static int pmc_setup_clks(struct pci_dev *pdev, void __iomem *pmc_regmap,
 			  const struct pmc_data *pmc_data)
 {
 	struct platform_device *clkdev;
 	struct pmc_clk_data *clk_data;
+	const struct dmi_system_id *d = dmi_first_match(critclk_systems);
 
 	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
 	if (!clk_data)
@@ -433,6 +450,10 @@ static int pmc_setup_clks(struct pci_dev *pdev, void __iomem *pmc_regmap,
 
 	clk_data->base = pmc_regmap; /* offset is added by client */
 	clk_data->clks = pmc_data->clks;
+	if (d) {
+		clk_data->critical = true;
+		pr_info("%s critclks quirk enabled\n", d->ident);
+	}
 
 	clkdev = platform_device_register_data(&pdev->dev, "clk-pmc-atom",
 					       PLATFORM_DEVID_NONE,
diff --git a/include/linux/platform_data/x86/clk-pmc-atom.h b/include/linux/platform_data/x86/clk-pmc-atom.h
index 3ab892208343..7a37ac27d0fb 100644
--- a/include/linux/platform_data/x86/clk-pmc-atom.h
+++ b/include/linux/platform_data/x86/clk-pmc-atom.h
@@ -35,10 +35,13 @@ struct pmc_clk {
  *
  * @base:	PMC clock register base offset
  * @clks:	pointer to set of registered clocks, typically 0..5
+ * @critical:	flag to indicate if firmware enabled pmc_plt_clks
+ *		should be marked as critial or not
  */
 struct pmc_clk_data {
 	void __iomem *base;
 	const struct pmc_clk *clks;
+	bool critical;
 };
 
 #endif /* __PLATFORM_DATA_X86_CLK_PMC_ATOM_H */
-- 
2.19.1

