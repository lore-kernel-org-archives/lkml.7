Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DECECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39B5218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n99gsNcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394502AbfJPThm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:37:42 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35691 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394477AbfJPThh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 15:37:37 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so23935902qkf.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 12:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AYapJscjdiPe7azvtC5J+VuWqRbuSj4S49kPVeQ4UUs=;
        b=n99gsNcs/xsd9f7sLUlIs3n+dodwMDeGOMCNrhZpuxG/g48jzQ3odfdm9C5SItRE4k
         Pafa14Sxnq3Plc+4HV1HZDJ/zTM4zonb27dCFMd8wWCbT2z62TV3RHjnQGnDGEOz6kr5
         5EMwt6BaMboBRfZXl1Cy+we5hcQ+lGV7ecTFgdHmj7Y7trSTvgKCppJOz2O8i0M4dRvv
         avS/QLCrHfaDjCSvlGM2r4nN+y+kR8tik6/rHm3cfsw/vx1rXMiW23dOFRkLwuBGANWH
         Twc4EH7XpIp9YvZ/wyksM8n4OvXVrCm6bQAre7VXS+wMcQtiIg0//Ik1l+doB2Az5LZD
         g1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AYapJscjdiPe7azvtC5J+VuWqRbuSj4S49kPVeQ4UUs=;
        b=li86XYTBymOtevvW9rwdxBaa/03NhXMwO1h1i1dkxA0FYbwjuCkTTTj6yDZtnx7tTa
         ksDQF2cxSEbgLVCrjNFSZbJiD3IKLWZsB+1XBZRwloW4HbxA51r6AyB3lVeEKvdzB13i
         KOM1V+weuZHX9W1gH0H65hwkpzxvewFTbo2ss21UWyJLXVk6pROQBvYnnNrpU6SAshex
         q24hZ4rqLWWwyuzm4/w8Yhnh+PzjIzfFMa+CkvJ450WpVKRDv4FAOZna0LjyfZVhHglH
         3oxrAWUluY5t30OtVJiEO1wfFHIrmURaLfuGSKYGxcAEwxZ5l2UMm9At23/LNesEiI8v
         CV3w==
X-Gm-Message-State: APjAAAWJe+QQVFF8iw7jiChUjYWpDbIAmfpwfhIO9xEcPek1JqskcxAv
        8omFGsgOWRY8eAH7kGgQdl2YDg==
X-Google-Smtp-Source: APXvYqwjhLmydDxR6n9KQ+Op9t6AVav/TtrvXLkrhRiWQ52DzzaBeKb8lL45Bm5G/lxSph3JXitzAA==
X-Received: by 2002:a37:7dc2:: with SMTP id y185mr30531737qkc.348.1571254656219;
        Wed, 16 Oct 2019 12:37:36 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 54sm16246030qts.75.2019.10.16.12.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 12:37:35 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] soc: qcom: Extend RPMh power controller driver to register warming devices.
Date:   Wed, 16 Oct 2019 15:37:19 -0400
Message-Id: <1571254641-13626-6-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPMh power control hosts power domains that can be used as
thermal warming devices. Register these power domains
with the generic power domain warming device thermal framework.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/soc/qcom/rpmhpd.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 9d37534..88ba615 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -11,6 +11,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/pwr_domain_warming.h>
 #include <soc/qcom/cmd-db.h>
 #include <soc/qcom/rpmh.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -333,6 +334,7 @@ static int rpmhpd_probe(struct platform_device *pdev)
 	struct genpd_onecell_data *data;
 	struct rpmhpd **rpmhpds;
 	const struct rpmhpd_desc *desc;
+	struct device_node *child;
 
 	desc = of_device_get_match_data(dev);
 	if (!desc)
@@ -396,7 +398,24 @@ static int rpmhpd_probe(struct platform_device *pdev)
 					       &rpmhpds[i]->pd);
 	}
 
-	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
+	ret = of_genpd_add_provider_onecell(pdev->dev.of_node, data);
+
+	if (ret)
+		return ret;
+
+	for_each_available_child_of_node(dev->of_node, child) {
+		if (!of_find_property(child, "#cooling-cells", NULL))
+			continue;
+
+		for (i = 0; i < num_pds; i++)
+			if (strcmp(child->name, rpmhpds[i]->pd.name) == 0)
+				break;
+		if (i == num_pds)
+			continue;
+		pwr_domain_warming_register(child, &rpmhpds[i]->pd);
+	}
+
+	return 0;
 }
 
 static struct platform_driver rpmhpd_driver = {
-- 
2.1.4

