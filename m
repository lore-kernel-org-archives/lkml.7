Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F27C468BD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 05:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FA2208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 05:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycYqj/ut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfFHFE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 01:04:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34748 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730325AbfFHFE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 01:04:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so2305152pfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 22:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OPc6kbODFlIcyYEoeSG+YAdIIHdp3uyhG/4PAINTxrk=;
        b=ycYqj/utDSDZvWqoen1KQCkERQbZq7Wr00tpnbsBfyP6prbsSZkHBefD9Y9t+aoDxm
         i5B9gAHqC5rcJEyawiczXqbik8FOdtyb5sYT5Wc8syNCVYfAM5dHuz4GpmMTYzlEwXU+
         7hm3iVDJv8D4pm2wh+7f0pzwalnP5TzHK+pwfDOVYMcfVh2GXZVfqLs3dulvFbUiakma
         yltmxVEW9O8LQo/Kt6QgpWIXIWWkq1ssgRa5IHVhN0ObyV5hdpye3D4op9chjrX0c7Ls
         G5vbZaeI9XX4FKhIVKPT1Rqfa9YWx5b9PuhNbKHXOYpaP6p6g9S7a5espFDIKu6ZeQf+
         NewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OPc6kbODFlIcyYEoeSG+YAdIIHdp3uyhG/4PAINTxrk=;
        b=QkUUpbhxK+JcRMcVed8xZh3NGEXRt3MIJf9xVO7ZXUxdD14miJHNZc29KexJdSKQy7
         4ji1vf5mpYFuT3pTu044nJ8l5pjYprtdNecjOmEuXzbm4srbnwTdXFxd3ZIwTcdEi4H5
         7y5nwcAKZHzTVqVlSv5UlWlrK46d8JIXHeV73v6AEt4vqpu5eObIZZOTuL/ve8/ajB/G
         GXdWnsxwxObHF6f3eddPzXWdVkeP6Q7NbaJo+tiBWqlDKNsb9/SniimbD8Bof+7UiQr6
         XVI7y6zg1QLg6sm+EOgM6W3Nzunvhwpa8Sua+VCKWl4uvK2ZviL6PSM0gO6G0An2ru57
         D6pQ==
X-Gm-Message-State: APjAAAV6OZnAl4cNdz2IzgcH030IAR0VSdfaoJyPd7BByTdH0MBrcX0S
        dVH0kS3mmS0QjHYA6sSl85BABQ==
X-Google-Smtp-Source: APXvYqxn3ouT7PLyMXrOZfIA8iJJZNKJ66gVxyIxMKBKDm9FSBhUxHllnmKvWM5kgZTTMzVXa+HbXA==
X-Received: by 2002:aa7:8102:: with SMTP id b2mr36326194pfi.105.1559970295911;
        Fri, 07 Jun 2019 22:04:55 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b8sm4522482pff.20.2019.06.07.22.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 22:04:55 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v3 2/3] scsi: ufs-qcom: Implement device_reset vops
Date:   Fri,  7 Jun 2019 22:04:49 -0700
Message-Id: <20190608050450.12056-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190608050450.12056-1-bjorn.andersson@linaro.org>
References: <20190608050450.12056-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UFS_RESET pin on Qualcomm SoCs are controlled by TLMM and exposed
through the GPIO framework. Acquire the device-reset GPIO and use this
to implement the device_reset vops, to allow resetting the attached
memory.

Based on downstream support implemented by Subhash Jadavani
<subhashj@codeaurora.org>.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Moved implementation to Qualcomm driver

 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |  2 ++
 drivers/scsi/ufs/ufs-qcom.c                   | 32 +++++++++++++++++++
 drivers/scsi/ufs/ufs-qcom.h                   |  4 +++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
index a74720486ee2..d562d8b4919c 100644
--- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
+++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
@@ -54,6 +54,8 @@ Optional properties:
 			  PHY reset from the UFS controller.
 - resets            : reset node register
 - reset-names       : describe reset node register, the "rst" corresponds to reset the whole UFS IP.
+- device-reset-gpios	: A phandle and gpio specifier denoting the GPIO connected
+			  to the RESET pin of the UFS memory device.
 
 Note: If above properties are not defined it can be assumed that the supply
 regulators or clocks are always on.
diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index ea7219407309..efaf57ba618a 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
+#include <linux/gpio/consumer.h>
 #include <linux/reset-controller.h>
 
 #include "ufshcd.h"
@@ -1141,6 +1142,15 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 		goto out_variant_clear;
 	}
 
+	host->device_reset = devm_gpiod_get_optional(dev, "device-reset",
+						     GPIOD_OUT_HIGH);
+	if (IS_ERR(host->device_reset)) {
+		err = PTR_ERR(host->device_reset);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "failed to acquire reset gpio: %d\n", err);
+		goto out_variant_clear;
+	}
+
 	err = ufs_qcom_bus_register(host);
 	if (err)
 		goto out_variant_clear;
@@ -1546,6 +1556,27 @@ static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)
 	usleep_range(1000, 1100);
 }
 
+/**
+ * ufs_qcom_device_reset() - toggle the (optional) device reset line
+ * @hba: per-adapter instance
+ *
+ * Toggles the (optional) reset line to reset the attached device.
+ */
+static void ufs_qcom_device_reset(struct ufs_hba *hba)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	/*
+	 * The UFS device shall detect reset pulses of 1us, sleep for 10us to
+	 * be on the safe side.
+	 */
+	gpiod_set_value_cansleep(host->device_reset, 1);
+	usleep_range(10, 15);
+
+	gpiod_set_value_cansleep(host->device_reset, 0);
+	usleep_range(10, 15);
+}
+
 /**
  * struct ufs_hba_qcom_vops - UFS QCOM specific variant operations
  *
@@ -1566,6 +1597,7 @@ static struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.suspend		= ufs_qcom_suspend,
 	.resume			= ufs_qcom_resume,
 	.dbg_register_dump	= ufs_qcom_dump_dbg_regs,
+	.device_reset		= ufs_qcom_device_reset,
 };
 
 /**
diff --git a/drivers/scsi/ufs/ufs-qcom.h b/drivers/scsi/ufs/ufs-qcom.h
index 68a880185752..b96ffb6804e4 100644
--- a/drivers/scsi/ufs/ufs-qcom.h
+++ b/drivers/scsi/ufs/ufs-qcom.h
@@ -204,6 +204,8 @@ struct ufs_qcom_testbus {
 	u8 select_minor;
 };
 
+struct gpio_desc;
+
 struct ufs_qcom_host {
 	/*
 	 * Set this capability if host controller supports the QUniPro mode
@@ -241,6 +243,8 @@ struct ufs_qcom_host {
 	struct ufs_qcom_testbus testbus;
 
 	struct reset_controller_dev rcdev;
+
+	struct gpio_desc *device_reset;
 };
 
 static inline u32
-- 
2.18.0

