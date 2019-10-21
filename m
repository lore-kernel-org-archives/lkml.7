Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987F9CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662962084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vRxWMzYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfJUKgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:36:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34386 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbfJUKf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:35:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id k7so6428572pll.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vKvS2rESDoy6PQiz2SnKaFwj6LTgApvN5b42XLtJTXo=;
        b=vRxWMzYJfmSP5fBSVSoLcZ1X39pHCGWkElQMy6zu8HkFuokcu0mfeAJ/UUtKqLyv+V
         YZS6CRMM59EUmmX2V0BrStC4nWZHeW9Jo6JQlByfl/Oda7KvXo3Z3ROpxef2xOG1RBYo
         fKkeckIsDBRNSC4aZCFpCxfMh55Le5ijR8n4Yq7Cv/VqgEm3SmLY+CqRpQK1K8QVBIEb
         UXpqXO4N/bRCQhOetk0X2G3u4G29dKtvvfvnH7Wi4SIHwyqEEoP29fXGknmf/wTaSDZ/
         CJwuOAQKDUnnNw/iCvNTftcPgzQZiwDOTNgQuOmduE2smAjWcnF1Jhe9S/EqgGTzXyFK
         XPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vKvS2rESDoy6PQiz2SnKaFwj6LTgApvN5b42XLtJTXo=;
        b=HBNsHRf+JzE9KA5yh46k8O27GoR3ASiRW6/FnVJzAguBf6UenewQGUKcSxovHzPzZQ
         8dsOGVNCHnGo0Zl4wUqsYF/ZPTqMd50uT6Chx9PFXZjYet7LspLlslHU3etg+gq0PP8H
         vA53vydHcLJAI/sjno5hK+7jSNm2LXYBkZY6z94X/3AkHLqOKdkCaC1x7DfnP0IiKdLL
         +GoH41+Aympk4MV85h2sQo5EXRdJ2Qil5+EZL2l7dW2xnt5SgGKZOxTmgFqYdEyZgtS1
         OWJLElo0CHOoAywIuxrtev9x16tRyX3u9cyymhMcNAGxP7YIlPgslf5xBkqYu5fi81xW
         TzBw==
X-Gm-Message-State: APjAAAXucpbHl9EBauBXURtGiYn2X9xki0ObbFPpJNb2KI/zYy5ZYan0
        ObZ4D9D8/s7kScRPwI/ykmFNriHpWINCYQ==
X-Google-Smtp-Source: APXvYqzGn+TI1jpeBTOt9uwQ6HDo8psV5zqWw3sVCRx90e5+iK3FEJKd4SlRSxXoJMy0kWcB2CRz8w==
X-Received: by 2002:a17:902:aa91:: with SMTP id d17mr23259072plr.69.1571654156571;
        Mon, 21 Oct 2019 03:35:56 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id w25sm14423643pfi.60.2019.10.21.03.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 03:35:56 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v6 04/15] drivers: thermal: tsens: Add debugfs support
Date:   Mon, 21 Oct 2019 16:05:23 +0530
Message-Id: <16e39c1bbfc18b5cf6274620cd72cc63205f53a5.1571652874.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dump some basic version info and sensor details into debugfs. Example
from qcs404 below:

--(/sys/kernel/debug) $ ls tsens/
4a9000.thermal-sensor  version
--(/sys/kernel/debug) $ cat tsens/version
1.4.0
--(/sys/kernel/debug) $ cat tsens/4a9000.thermal-sensor/sensors
max: 11
num: 10

      id    slope   offset
------------------------
       0     3200   404000
       1     3200   404000
       2     3200   404000
       3     3200   404000
       4     3200   404000
       5     3200   404000
       6     3200   404000
       7     3200   404000
       8     3200   404000
       9     3200   404000

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/thermal/qcom/tsens-common.c | 83 +++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c        |  2 +
 drivers/thermal/qcom/tsens.h        |  6 +++
 3 files changed, 91 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 7437bfe196e50..ea2c46cc6a66a 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/nvmem-consumer.h>
@@ -139,6 +140,77 @@ int get_temp_common(struct tsens_sensor *s, int *temp)
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static int dbg_sensors_show(struct seq_file *s, void *data)
+{
+	struct platform_device *pdev = s->private;
+	struct tsens_priv *priv = platform_get_drvdata(pdev);
+	int i;
+
+	seq_printf(s, "max: %2d\nnum: %2d\n\n",
+		   priv->feat->max_sensors, priv->num_sensors);
+
+	seq_puts(s, "      id    slope   offset\n--------------------------\n");
+	for (i = 0;  i < priv->num_sensors; i++) {
+		seq_printf(s, "%8d %8d %8d\n", priv->sensor[i].hw_id,
+			   priv->sensor[i].slope, priv->sensor[i].offset);
+	}
+
+	return 0;
+}
+
+static int dbg_version_show(struct seq_file *s, void *data)
+{
+	struct platform_device *pdev = s->private;
+	struct tsens_priv *priv = platform_get_drvdata(pdev);
+	u32 maj_ver, min_ver, step_ver;
+	int ret;
+
+	if (tsens_ver(priv) > VER_0_1) {
+		ret = regmap_field_read(priv->rf[VER_MAJOR], &maj_ver);
+		if (ret)
+			return ret;
+		ret = regmap_field_read(priv->rf[VER_MINOR], &min_ver);
+		if (ret)
+			return ret;
+		ret = regmap_field_read(priv->rf[VER_STEP], &step_ver);
+		if (ret)
+			return ret;
+		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
+	} else {
+		seq_puts(s, "0.1.0\n");
+	}
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(dbg_version);
+DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
+
+static void tsens_debug_init(struct platform_device *pdev)
+{
+	struct tsens_priv *priv = platform_get_drvdata(pdev);
+	struct dentry *root, *file;
+
+	root = debugfs_lookup("tsens", NULL);
+	if (!root)
+		priv->debug_root = debugfs_create_dir("tsens", NULL);
+	else
+		priv->debug_root = root;
+
+	file = debugfs_lookup("version", priv->debug_root);
+	if (!file)
+		debugfs_create_file("version", 0444, priv->debug_root,
+				    pdev, &dbg_version_fops);
+
+	/* A directory for each instance of the TSENS IP */
+	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
+	debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
+}
+#else
+static inline void tsens_debug_init(struct platform_device *pdev) {}
+#endif
+
 static const struct regmap_config tsens_config = {
 	.name		= "tm",
 	.reg_bits	= 32,
@@ -199,6 +271,15 @@ int __init init_common(struct tsens_priv *priv)
 		goto err_put_device;
 	}
 
+	if (tsens_ver(priv) > VER_0_1) {
+		for (i = VER_MAJOR; i <= VER_STEP; i++) {
+			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
+							      priv->fields[i]);
+			if (IS_ERR(priv->rf[i]))
+				return PTR_ERR(priv->rf[i]);
+		}
+	}
+
 	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
 						     priv->fields[TSENS_EN]);
 	if (IS_ERR(priv->rf[TSENS_EN])) {
@@ -238,6 +319,8 @@ int __init init_common(struct tsens_priv *priv)
 		}
 	}
 
+	tsens_debug_init(op);
+
 	return 0;
 
 err_put_device:
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 06c6bbd69a1a7..772aa76b50e12 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -176,6 +177,7 @@ static int tsens_remove(struct platform_device *pdev)
 {
 	struct tsens_priv *priv = platform_get_drvdata(pdev);
 
+	debugfs_remove_recursive(priv->debug_root);
 	if (priv->ops->disable)
 		priv->ops->disable(priv);
 
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 84e5447c56860..00899c17e848c 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -293,6 +293,8 @@ struct tsens_context {
  * @feat: features of the IP
  * @fields: bitfield locations
  * @ops: pointer to list of callbacks supported by this device
+ * @debug_root: pointer to debugfs dentry for all tsens
+ * @debug: pointer to debugfs dentry for tsens controller
  * @sensor: list of sensors attached to this device
  */
 struct tsens_priv {
@@ -306,6 +308,10 @@ struct tsens_priv {
 	const struct tsens_features	*feat;
 	const struct reg_field		*fields;
 	const struct tsens_ops		*ops;
+
+	struct dentry			*debug_root;
+	struct dentry			*debug;
+
 	struct tsens_sensor		sensor[0];
 };
 
-- 
2.17.1

