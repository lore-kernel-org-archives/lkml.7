Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B29EC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 11:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B6B2087F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 11:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWxaRb40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDFLWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 07:22:39 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44636 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfDFLWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 07:22:39 -0400
Received: by mail-yw1-f65.google.com with SMTP id c4so3254532ywa.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 04:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4LpYRL6amcq1y1zo/McGCepepBd+6zq1F9/XI0pWbWY=;
        b=wWxaRb40D0nkGfztICIU4j026UzE7ocN8AtAYEA8pCkUGYLCR4QoxCHjBG9GB0VvTA
         DBBHq87i/otSdRUyHHVwSwirB3/P9d1J5QH+/Gv043QjbnFBUPK+mhBcCZRZ2efv2TSg
         yP8Qb6clB2ZVZhz2ibessyTH7Jr7reva7D064QN4FO/ODDHkko7Ifd2+6T316j+e41ip
         k/lf/MrIsivgH7lxyFjNc9W3WzVRubCqdxUCb/Nt68jjzVqn9QsgiAjCg4vJhtJdB126
         7nqIf4Ovo6P9tbo23lqPggyafdKxkSUqtdUvwnTImIFKl8A6euWGpmoXisYo6cpYqL8/
         6rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4LpYRL6amcq1y1zo/McGCepepBd+6zq1F9/XI0pWbWY=;
        b=Tq+6d4apSTVCKuukse6rmxigkPhv8ecpTiy3OOpO3u6PW3ePuIwxtiEnOAl8wd7HwF
         BOy9Jt6rN2/UXeOgWTNK1pVlvpvAmC4yW8T56xR4ycimQK6TkkldbcHvjfqHucAHbTy7
         dkbfQTb3Bg6AdGJF7Kho1RZsiyp4vEMBkIETxtu8kGIzC20nLhaPFmnY9++PRFMCJf1D
         8A/4TY/qGWTgd15qNxbhorWK/JSx+Lm1nQJSGSuLhaMVqsBJFWblE+scSaGRrgyk5VC2
         s+11AQjrq/10zULxFHcG7jM1bTllFU5iaPQbRJ7KpUjOzkdTbTzRNUX5aaZr0ziYFyMo
         WEeA==
X-Gm-Message-State: APjAAAVfo6EEkntSXSJyqmAePeqaa4TbhTGSixuC21RMljeFfhok2nKm
        Fmh8PtoZltGAjTJ8e25lzId0qNPCCk+RxyrF
X-Google-Smtp-Source: APXvYqyuc6KSGW/uvBF2LfpdGNjPJWpgqVA4v17WKWmjAFeO7cRqPCJOUurFKfhX0BYtkIZ0WepRvw==
X-Received: by 2002:a81:a00e:: with SMTP id x14mr12492599ywg.281.1554549757934;
        Sat, 06 Apr 2019 04:22:37 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id w22sm12729360yww.58.2019.04.06.04.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:22:37 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wanglai Shi <shiwanglai@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 4/4] coresight: funnel: Support static funnel
Date:   Sat,  6 Apr 2019 19:21:45 +0800
Message-Id: <20190406112145.15184-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190406112145.15184-1-leo.yan@linaro.org>
References: <20190406112145.15184-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since CoreSight hardware topology can use a 'hidden' funnel in the
trace data path, this kind funnel doesn't have register for accessing
and is used by default from hardware design perspective.  Below is an
example for related hardware topology:

  +------+  +------+
  | cpu0 |->| ETM  |-\
  +------+  +------+  \-> +--------+  +-----+
   ......                 | Funnel |->| ETF |-\    Hidden funnel
  +------+  +------+  /-> +--------+  +-----+  \        |
  | cpu3 |->| ETM  |-/                          \       V
  +------+  +------+                             \-> +--------+
                                                     | Funnel |-> ...
  +------+  +------+                             /-> +--------+
  | cpu4 |->| ETM  |-\                          /
  +------+  +------+  \-> +--------+  +-----+  /
   ......                 | Funnel |->| ETF |-/
  +------+  +------+  /-> +--------+  +-----+
  | cpu7 |->| ETM  |-/
  +------+  +------+

The CoreSight funnel driver only supports dynamic funnel with
registration register resource, thus it cannot support for the static
funnel case and it's impossible to create trace data path for this case.

This patch is to extend CoreSight funnel driver to support both for
static funnel and dynamic funnel.  For the dynamic funnel it reuses the
code existed in the driver, for static funnel the driver will support
device probe if without providing register resource and the driver skips
registers accessing when detect the register base is NULL.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Wanglai Shi <shiwanglai@hisilicon.com>
Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../hwtracing/coresight/coresight-funnel.c    | 112 +++++++++++++-----
 1 file changed, 85 insertions(+), 27 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 927925151509..2030d2596d90 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/coresight.h>
 #include <linux/amba/bus.h>
@@ -43,7 +44,7 @@ struct funnel_drvdata {
 	unsigned long		priority;
 };
 
-static int funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
+static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
 {
 	u32 functl;
 	int rc = 0;
@@ -71,17 +72,19 @@ static int funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
 static int funnel_enable(struct coresight_device *csdev, int inport,
 			 int outport)
 {
-	int rc;
+	int rc = 0;
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	rc = funnel_enable_hw(drvdata, inport);
+	if (drvdata->base)
+		rc = dynamic_funnel_enable_hw(drvdata, inport);
 
 	if (!rc)
 		dev_dbg(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
 	return rc;
 }
 
-static void funnel_disable_hw(struct funnel_drvdata *drvdata, int inport)
+static void dynamic_funnel_disable_hw(struct funnel_drvdata *drvdata,
+				      int inport)
 {
 	u32 functl;
 
@@ -103,7 +106,8 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
 {
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	funnel_disable_hw(drvdata, inport);
+	if (drvdata->base)
+		dynamic_funnel_disable_hw(drvdata, inport);
 
 	dev_dbg(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
 }
@@ -177,54 +181,67 @@ static struct attribute *coresight_funnel_attrs[] = {
 };
 ATTRIBUTE_GROUPS(coresight_funnel);
 
-static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
+static int funnel_probe(struct device *dev, struct resource *res)
 {
 	int ret;
 	void __iomem *base;
-	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata = NULL;
 	struct funnel_drvdata *drvdata;
-	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
-	struct device_node *np = adev->dev.of_node;
+	struct device_node *np = dev->of_node;
 
 	if (np) {
 		pdata = of_get_coresight_platform_data(dev, np);
 		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
-		adev->dev.platform_data = pdata;
+		dev->platform_data = pdata;
 	}
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->dev = &adev->dev;
-	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
+	drvdata->dev = dev;
+	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
 		if (ret)
 			return ret;
 	}
-	dev_set_drvdata(dev, drvdata);
 
-	/* Validity for the resource is already checked by the AMBA core */
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	/*
+	 * Map the device base for dynamic-funnel, which has been
+	 * validated by AMBA core.
+	 */
+	if (res) {
+		base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(base)) {
+			ret = PTR_ERR(base);
+			goto out_disable_clk;
+		}
+		drvdata->base = base;
+		desc.groups = coresight_funnel_groups;
+	}
 
-	drvdata->base = base;
-	pm_runtime_put(&adev->dev);
+	dev_set_drvdata(dev, drvdata);
 
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
 	desc.ops = &funnel_cs_ops;
 	desc.pdata = pdata;
 	desc.dev = dev;
-	desc.groups = coresight_funnel_groups;
 	drvdata->csdev = coresight_register(&desc);
+	if (IS_ERR(drvdata->csdev)) {
+		ret = PTR_ERR(drvdata->csdev);
+		goto out_disable_clk;
+	}
+
+	pm_runtime_put(dev);
 
-	return PTR_ERR_OR_ZERO(drvdata->csdev);
+out_disable_clk:
+	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
+		clk_disable_unprepare(drvdata->atclk);
+	return ret;
 }
 
 #ifdef CONFIG_PM
@@ -253,7 +270,48 @@ static const struct dev_pm_ops funnel_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(funnel_runtime_suspend, funnel_runtime_resume, NULL)
 };
 
-static const struct amba_id funnel_ids[] = {
+static int static_funnel_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	/* Static funnel do not have programming base */
+	ret = funnel_probe(&pdev->dev, NULL);
+
+	if (ret) {
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
+
+	return ret;
+}
+
+static const struct of_device_id static_funnel_match[] = {
+	{.compatible = "arm,coresight-static-funnel"},
+	{}
+};
+
+static struct platform_driver static_funnel_driver = {
+	.probe          = static_funnel_probe,
+	.driver         = {
+		.name   = "coresight-static-funnel",
+		.of_match_table = static_funnel_match,
+		.pm	= &funnel_dev_pm_ops,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(static_funnel_driver);
+
+static int dynamic_funnel_probe(struct amba_device *adev,
+				const struct amba_id *id)
+{
+	return funnel_probe(&adev->dev, &adev->res);
+}
+
+static const struct amba_id dynamic_funnel_ids[] = {
 	{
 		.id     = 0x000bb908,
 		.mask   = 0x000fffff,
@@ -266,14 +324,14 @@ static const struct amba_id funnel_ids[] = {
 	{ 0, 0},
 };
 
-static struct amba_driver funnel_driver = {
+static struct amba_driver dynamic_funnel_driver = {
 	.drv = {
-		.name	= "coresight-funnel",
+		.name	= "coresight-dynamic-funnel",
 		.owner	= THIS_MODULE,
 		.pm	= &funnel_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
-	.probe		= funnel_probe,
-	.id_table	= funnel_ids,
+	.probe		= dynamic_funnel_probe,
+	.id_table	= dynamic_funnel_ids,
 };
-builtin_amba_driver(funnel_driver);
+builtin_amba_driver(dynamic_funnel_driver);
-- 
2.17.1

