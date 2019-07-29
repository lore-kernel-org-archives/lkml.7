Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC09C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1CF21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVbmB86K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfG2Qdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:33:32 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37102 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbfG2QdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:33:25 -0400
Received: by mail-vs1-f66.google.com with SMTP id v6so41275591vsq.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H5OjemuZecMAb99bi2dOA9LV9giMPI14c3KRHJNod1Y=;
        b=eVbmB86KNL3hg/6szqN46y2vPcjG+t1zRVqB9e3+A2a1MqdxJDdQYJA2i8m6c/yO+g
         RN8hIgQAjT+IG8eNXG+PQ2e3WZYT7IFvmmGJVebVbHwk8KYavVwtiGgiDGkuXFss+nYN
         W25VwnpXq3GdoCyX7l9PG0dijgche9ANQ1WzCwRWhPpKWvYuCEY8X43DZzKjP1cNptFZ
         PdnpUaF4hYWmztc+wO9dCmo9WsnDMLfEgYi9WuX/2w4uhzT6kge5J3TCbufZs62IqQ2f
         peuUxdcMeruNAkBv7p2RonlFunH+quicPdCOsTEAv/YYBSCIjDTlcL6YA5r6QC6hO21s
         D4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H5OjemuZecMAb99bi2dOA9LV9giMPI14c3KRHJNod1Y=;
        b=JQsnKNDs3DjYN2izho6YLznI2F7taI25WSUml6nEycbZLth8K5WLmSLvKCUk3i3Ary
         nbOvhHt431NfxNl3rMG1dapngIBDwyr556fKyPS3Hg5mHGKhivCpRGV4U6D3LnGBTqb6
         eCOfNCHWEo92/fxrPwpP/9CZXYtZmHtlWWCGyEWKlyudP5UcJvAeD/dq1kLhkn37gX6F
         8WxJ2fy7aYeA87zZE+k4EoqX13U7JHl/6tYAdaqpOEAW+I79i/jE0WKUp7b1UtBmB/Fv
         g/0E+qMDLl3n/GPMQvksOXkWMP0BgcQFTgbP+uSk/CFcd3msdi9bqZQN86NhmDguPxt4
         0MHQ==
X-Gm-Message-State: APjAAAWdQSpnciz4mxbN0Df8vPtzxiTKkjJO1Ay8qzySqsbFgY4tRM7E
        RJJmH9eDfGhlywOPf4wC7RRkBQ==
X-Google-Smtp-Source: APXvYqxXjZg6iktzUuEGcBwQ4KrnWKJttQ3CuIFL3eiMs9MVIbkULV3LyUlSokhPcTXgpwodQzp8QQ==
X-Received: by 2002:a67:b14c:: with SMTP id z12mr4505264vsl.11.1564418003895;
        Mon, 29 Jul 2019 09:33:23 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id o9sm39762738vkd.27.2019.07.29.09.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jul 2019 09:33:23 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] soc: qcom: Extend AOSS QMP driver to support resources that are used to wake up the SoC.
Date:   Mon, 29 Jul 2019 12:33:20 -0400
Message-Id: <1564418001-24940-2-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1564418001-24940-1-git-send-email-thara.gopinath@linaro.org>
References: <1564418001-24940-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AOSS QMP driver is extended to communicate with the additional
resources. These resources are then registered as cooling devices
with the thermal framework.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/soc/qcom/qcom_aoss.c | 129 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index 5f88519..010877e 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -10,6 +10,8 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/thermal.h>
+#include <linux/slab.h>
 
 #define QMP_DESC_MAGIC			0x0
 #define QMP_DESC_VERSION		0x4
@@ -40,6 +42,16 @@
 /* 64 bytes is enough to store the requests and provides padding to 4 bytes */
 #define QMP_MSG_LEN			64
 
+#define QMP_NUM_COOLING_RESOURCES	2
+
+static bool qmp_cdev_init_state = 1;
+
+struct qmp_cooling_device {
+	struct thermal_cooling_device *cdev;
+	struct qmp *qmp;
+	bool state;
+};
+
 /**
  * struct qmp - driver state for QMP implementation
  * @msgram: iomem referencing the message RAM used for communication
@@ -69,6 +81,7 @@ struct qmp {
 
 	struct clk_hw qdss_clk;
 	struct genpd_onecell_data pd_data;
+	struct qmp_cooling_device *cooling_devs;
 };
 
 struct qmp_pd {
@@ -385,6 +398,117 @@ static void qmp_pd_remove(struct qmp *qmp)
 		pm_genpd_remove(data->domains[i]);
 }
 
+static int qmp_cdev_get_max_state(struct thermal_cooling_device *cdev,
+				  unsigned long *state)
+{
+	*state = qmp_cdev_init_state;
+	return 0;
+}
+
+static int qmp_cdev_get_cur_state(struct thermal_cooling_device *cdev,
+				  unsigned long *state)
+{
+	struct qmp_cooling_device *qmp_cdev = cdev->devdata;
+
+	*state = qmp_cdev->state;
+	return 0;
+}
+
+static int qmp_cdev_set_cur_state(struct thermal_cooling_device *cdev,
+				  unsigned long state)
+{
+	struct qmp_cooling_device *qmp_cdev = cdev->devdata;
+	char buf[QMP_MSG_LEN] = {};
+	bool cdev_state;
+	int ret;
+
+	/* Normalize state */
+	cdev_state = !!state;
+
+	if (qmp_cdev->state == state)
+		return 0;
+
+	snprintf(buf, sizeof(buf),
+		 "{class: volt_flr, event:zero_temp, res:%s, value:%s}",
+			qmp_cdev->name,
+			cdev_state ? "off" : "on");
+
+	ret = qmp_send(qmp_cdev->qmp, buf, sizeof(buf));
+
+	if (!ret)
+		qmp_cdev->state = cdev_state;
+
+	return ret;
+}
+
+static struct thermal_cooling_device_ops qmp_cooling_device_ops = {
+	.get_max_state = qmp_cdev_get_max_state,
+	.get_cur_state = qmp_cdev_get_cur_state,
+	.set_cur_state = qmp_cdev_set_cur_state,
+};
+
+static int qmp_cooling_device_add(struct qmp *qmp,
+				  struct qmp_cooling_device *qmp_cdev,
+				  struct device_node *node)
+{
+	char *cdev_name = (char *)node->name;
+
+	qmp_cdev->qmp = qmp;
+	qmp_cdev->state = qmp_cdev_init_state;
+	qmp_cdev->cdev = devm_thermal_of_cooling_device_register
+				(qmp->dev, node,
+				cdev_name,
+				qmp_cdev, &qmp_cooling_device_ops);
+
+	if (IS_ERR(qmp_cdev->cdev))
+		dev_err(qmp->dev, "unable to register %s cooling device\n",
+			cdev_name);
+
+	return PTR_ERR_OR_ZERO(qmp_cdev->cdev);
+}
+
+static int qmp_cooling_devices_register(struct qmp *qmp)
+{
+	struct device_node *np, *child;
+	int count = QMP_NUM_COOLING_RESOURCES;
+	int ret;
+
+	np = qmp->dev->of_node;
+
+	qmp->cooling_devs = devm_kcalloc(qmp->dev, count,
+					 sizeof(*qmp->cooling_devs),
+					 GFP_KERNEL);
+
+	if (!qmp->cooling_devs)
+		return -ENOMEM;
+
+	for_each_available_child_of_node(np, child) {
+		if (!of_find_property(child, "#cooling-cells", NULL))
+			continue;
+		ret = qmp_cooling_device_add(qmp, &qmp->cooling_devs[count++],
+					     child);
+		if (ret)
+			goto uroll_cooling_devices;
+	}
+
+	return 0;
+
+uroll_cooling_devices:
+	while (--count >= 0)
+		thermal_cooling_device_unregister
+			(qmp->cooling_devs[count].cdev);
+
+	return ret;
+}
+
+static void qmp_cooling_devices_remove(struct qmp *qmp)
+{
+	int i;
+
+	for (i = 0; i < QMP_NUM_COOLING_RESOURCES; i++)
+		thermal_cooling_device_unregister(qmp->cooling_devs[i].cdev);
+}
+
 static int qmp_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -433,6 +557,10 @@ static int qmp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_remove_qdss_clk;
 
+	ret = qmp_cooling_devices_register(qmp);
+	if (ret)
+		dev_err(&pdev->dev, "failed to register aoss cooling devices\n");
+
 	platform_set_drvdata(pdev, qmp);
 
 	return 0;
@@ -453,6 +581,7 @@ static int qmp_remove(struct platform_device *pdev)
 
 	qmp_qdss_clk_remove(qmp);
 	qmp_pd_remove(qmp);
+	qmp_cooling_devices_remove(qmp);
 
 	qmp_close(qmp);
 	mbox_free_channel(qmp->mbox_chan);
-- 
2.1.4

