Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C534DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D8D214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I3r7GRr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfDDFKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:10:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32841 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfDDFKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:10:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so628569pgh.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 22:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mdOJYDtANreHncbeef90zrWtNG5DJsKAdH3zS7ujZ1U=;
        b=I3r7GRr+snPvFd86Mi8jhruOQUNWmdQmm7b7ecIcS4EHj+oanQWssoHtBXIkn+SnYs
         0w73rCjZadVrqKxbWQAnB/YE8hVEXIEYZBybv5CJ+9iP5+xbfx4F/G5Yih5yIEJhu+uQ
         twbx3KiZqUOw30D/xSZ/Ry7bQwQ6y72jCZZ/2NCipPOAbkr1JOr0Bazn0lybvp5H34aZ
         T0XlScQ5jVShxh+p6UdaUhudPIJ9nIIwGOMd7HYJOpIsZCmzxD3yQY63DukRrvyplI5X
         mJev8i1yZg9q2PAox8OImn78RPANFXIEPBDJp4pi3QvnN1s9nChyPuxt6We/gHlQoKO5
         U7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mdOJYDtANreHncbeef90zrWtNG5DJsKAdH3zS7ujZ1U=;
        b=C8RJmno7hYhYWRu9w74059LDhtSih8+g1E/nZm2D3gxO/vpi+SpdVtNXmWXSUjzAfm
         2AoQZd9aEryUwJ4EZmvDrqzQcLVDRYeaBTqEwFZGdz9NiM05gLBeWwQpZ2k8gt9+W6hS
         cEdnYduuuT6BXAVQpIIa93/S6yd3K0NvXTlXk+7f/+RqMyKt9c3+XFSi2cAdkXRTT+FA
         YBV+5p97zHZPA+Z6afyvgT2A4WbfI45eNdT8andzETxpohgPy8Aa8lUP2igQOHOBSZSf
         +BGY+yxJ2Usf58y6wOPRbGUdXPV2Kj41hpJTvy5riEfsLSnleB5gJ+TR9CngyFz2eMMj
         AUcQ==
X-Gm-Message-State: APjAAAWD/iatAPoy//2sHlLhd06ZEV2/RusAIl/vmLwdMs4M4RWEFwcY
        JGOO7zXQiqxdXxlJmZ9NukxL3A==
X-Google-Smtp-Source: APXvYqzSg8jZaNaCln033SSe+y7aDDYAn05/YD7lzAIk2Vgdae5LzuQ4Ulyeb1lj8Cv2p315ZsreRg==
X-Received: by 2002:a63:6fcd:: with SMTP id k196mr3772020pgc.238.1554354616065;
        Wed, 03 Apr 2019 22:10:16 -0700 (PDT)
Received: from centauri.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id q80sm27623011pfa.66.2019.04.03.22.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 22:10:15 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/9] cpufreq: qcom: support qcs404 on nvmem driver
Date:   Thu,  4 Apr 2019 07:09:25 +0200
Message-Id: <20190404050931.9812-5-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404050931.9812-1-niklas.cassel@linaro.org>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 366c65a7132a..7fdc38218390 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
@@ -79,6 +80,13 @@ static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
 	return version;
 }
 
+static int qcom_cpufreq_qcs404_name_version(struct device *cpu_dev,
+					    struct nvmem_cell *speedbin_nvmem,
+					    struct qcom_cpufreq_drv *drv)
+{
+	return 0;
+}
+
 static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 					  struct nvmem_cell *speedbin_nvmem,
 					  struct qcom_cpufreq_drv *drv)
@@ -191,6 +199,14 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 			dev_err(cpu_dev, "Failed to set supported hardware\n");
 			goto free_opp;
 		}
+
+		ret = dev_pm_domain_attach(cpu_dev, false);
+		if (ret) {
+			if (ret == -EPROBE_DEFER)
+				goto free_opp;
+			dev_err(cpu_dev, "Could not attach to pm_domain: %d\n",
+				ret);
+		}
 	}
 
 	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
@@ -247,6 +263,8 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	  .data = qcom_cpufreq_kryo_name_version },
 	{ .compatible = "qcom,msm8996",
 	  .data = qcom_cpufreq_kryo_name_version },
+	{ .compatible = "qcom,qcs404",
+	  .data = qcom_cpufreq_qcs404_name_version },
 	{},
 };
 
-- 
2.20.1

