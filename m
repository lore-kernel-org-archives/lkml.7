Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201E5C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3B920872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/0/Gm79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfFFBDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 21:03:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46453 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfFFBC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 21:02:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so187256pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 18:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TRkaMCNla3WROe2zX2J+aawx5FPMRl6GLVsgLcTqYp4=;
        b=K/0/Gm794r4cZynF3tQa3us7NLsO4055saUEDKMdCoqEl8/U5h3/6Bcr1JpalYR7Ja
         WZilVpAMt32SJrlRaVuMyC9E2bRt5qpGoLFZmQBY/xLov2/FQG9+dPbH86jHN7SkdDOU
         Jv7hPFz25UgshRGGPpj/weMhRpcPpKV/44/J//8xxQYn16cjNJ6fKmxz3vjoXyctwMii
         YJSFbuFXe68CJl2iaCJc7ADESb6+q3pU9W3s0glKdeEFPVffRYDCsLmZQsjGqpL531H0
         /iTsZGABgYdgBYVkp/Z9x3KvjLrIx8bUnklmu2n93jGrNvlO16/qNXp8Da9h8nyFRfvE
         Knew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TRkaMCNla3WROe2zX2J+aawx5FPMRl6GLVsgLcTqYp4=;
        b=aNPTvsn/Lx5XE5aYrTtxVK585F0dYDSi3HzkuF92PA+iT6DPaDuCtaHeyDn+NGlI+A
         M9hgdmoLnTiu+8cXCwdn10PoBkkGT0T1wvf3/SjoTJbel79nveZ3Zl6qeknN1mBrNukQ
         06D2q6v1FlyJMz6oG13pftE4CEuKL/TmUkHfPC8OZ1LMGm0yiE/XNXL2AT3jC1l3J54M
         PXEQD0CHqT2z5ayzq8LeeDCxHab2bkt/Iwp5obYzEt3JJNxvsP41G5vnV14aU8kZw8Ba
         a89znsnIOz+L/tGnIfX+owSgQprAKoblLb0LSTDW5rlNyOU3w9TSKlO2aPXh5sorOGvt
         woYA==
X-Gm-Message-State: APjAAAUA6x+HiXYDmyLf0nYxyHMmRizuGjtJoS3yGzba4ki7cGMa/MfU
        J1QvB8GFPphoFfmMCF77iG/CVA==
X-Google-Smtp-Source: APXvYqz0Wl8+7BRo6ntYu2fbO9EBmcaEbyuJ/+383dEnyNIdggHsSWHbztq8JtmY0bfoPMm91C9itg==
X-Received: by 2002:a17:902:1003:: with SMTP id b3mr48249534pla.172.1559782975403;
        Wed, 05 Jun 2019 18:02:55 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 144sm170856pfy.54.2019.06.05.18.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 18:02:54 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v2 2/3] scsi: ufs: Allow resetting the UFS device
Date:   Wed,  5 Jun 2019 18:02:48 -0700
Message-Id: <20190606010249.3538-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190606010249.3538-1-bjorn.andersson@linaro.org>
References: <20190606010249.3538-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acquire the device-reset GPIO and toggle this to reset the UFS device
during initialization and host reset.

Based on downstream support implemented by Subhash Jadavani
<subhashj@codeaurora.org>.

Tested-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Added gpio to DT binding document
- Fixed spelling of UFS

 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |  2 +
 drivers/scsi/ufs/ufshcd.c                     | 44 +++++++++++++++++++
 drivers/scsi/ufs/ufshcd.h                     |  4 ++
 3 files changed, 50 insertions(+)

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
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index a208589426b1..eaa384d67684 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -42,6 +42,7 @@
 #include <linux/nls.h>
 #include <linux/of.h>
 #include <linux/bitfield.h>
+#include <linux/gpio/consumer.h>
 #include "ufshcd.h"
 #include "ufs_quirks.h"
 #include "unipro.h"
@@ -6135,6 +6136,25 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	return err;
 }
 
+/**
+ * ufshcd_device_reset() - toggle the (optional) device reset line
+ * @hba: per-adapter instance
+ *
+ * Toggles the (optional) reset line to reset the attached device.
+ */
+static void ufshcd_device_reset(struct ufs_hba *hba)
+{
+	/*
+	 * The UFS device shall detect reset pulses of 1us, sleep for 10us to
+	 * be on the safe side.
+	 */
+	gpiod_set_value_cansleep(hba->device_reset, 1);
+	usleep_range(10, 15);
+
+	gpiod_set_value_cansleep(hba->device_reset, 0);
+	usleep_range(10, 15);
+}
+
 /**
  * ufshcd_host_reset_and_restore - reset and restore host controller
  * @hba: per-adapter instance
@@ -6190,6 +6210,9 @@ static int ufshcd_reset_and_restore(struct ufs_hba *hba)
 	int retries = MAX_HOST_RESET_RETRIES;
 
 	do {
+		/* Reset the attached device */
+		ufshcd_device_reset(hba);
+
 		err = ufshcd_host_reset_and_restore(hba);
 	} while (err && --retries);
 
@@ -7386,6 +7409,18 @@ static void ufshcd_variant_hba_exit(struct ufs_hba *hba)
 	ufshcd_vops_exit(hba);
 }
 
+static int ufshcd_init_device_reset(struct ufs_hba *hba)
+{
+	hba->device_reset = devm_gpiod_get_optional(hba->dev, "device-reset",
+						    GPIOD_OUT_HIGH);
+	if (IS_ERR(hba->device_reset)) {
+		dev_err(hba->dev, "failed to acquire reset gpio: %ld\n",
+			PTR_ERR(hba->device_reset));
+	}
+
+	return PTR_ERR_OR_ZERO(hba->device_reset);
+}
+
 static int ufshcd_hba_init(struct ufs_hba *hba)
 {
 	int err;
@@ -7425,9 +7460,15 @@ static int ufshcd_hba_init(struct ufs_hba *hba)
 	if (err)
 		goto out_disable_vreg;
 
+	err = ufshcd_init_device_reset(hba);
+	if (err)
+		goto out_disable_variant;
+
 	hba->is_powered = true;
 	goto out;
 
+out_disable_variant:
+	ufshcd_vops_setup_regulators(hba, false);
 out_disable_vreg:
 	ufshcd_setup_vreg(hba, false);
 out_disable_clks:
@@ -8321,6 +8362,9 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 		goto exit_gating;
 	}
 
+	/* Reset the attached device */
+	ufshcd_device_reset(hba);
+
 	/* Host controller enable */
 	err = ufshcd_hba_enable(hba);
 	if (err) {
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 994d73d03207..4443928ba7d2 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -72,6 +72,8 @@
 #define UFSHCD "ufshcd"
 #define UFSHCD_DRIVER_VERSION "0.2"
 
+struct gpio_desc;
+
 struct ufs_hba;
 
 enum dev_cmd_type {
@@ -706,6 +708,8 @@ struct ufs_hba {
 
 	struct device		bsg_dev;
 	struct request_queue	*bsg_queue;
+
+	struct gpio_desc *device_reset;
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
-- 
2.18.0

