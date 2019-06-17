Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20E8C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C442084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JENV0KnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfFQLzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:55:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37533 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfFQLzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:55:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so9632220wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 04:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p0dSD1o3AHgXjVo+yieUQmDjtFsBPsysRj0uW6rU34Q=;
        b=JENV0KnCmt/Dwk1nXe4AAcmIlf8KhWmyC5H8iva+UYLv7mbtGJ0z6XGxDKgADB3mc6
         rWrDUEnlr7Z3WBR9EPiHQxpW0Y5lZKAqUubjryNHbX92fe9VM2FmqZYWPaXA2VskP5kP
         P+W8mb/lqsiQx19zu9P/AygnBVAedl1BkZpmDBLHAyoyfper03B+CGrryRT3MBS40yIF
         ardqfg0t+y0tjIZSl31JtWjeYOUhY7yewjXFSKHJHErNJfdMp7wjg4UgYWWRy5DEVR32
         CAklr0Q9IklvXe9CJ1rZQ9ejaPSM5hxzMhN+IcMFFNBvnR8l48AhNMGqPf8Zf1/+fgsf
         ApcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p0dSD1o3AHgXjVo+yieUQmDjtFsBPsysRj0uW6rU34Q=;
        b=jn6Neo6+boDitxKYsgxYIMBBaB6vCmTcCmZyXOJXTjjDbTyijY2YV1m6XpFeXICeqo
         p9qtZHe3b3EfcI0E5YGZJGRmlU8n/yYNph1Sivb5251cBNaxGVygKlIKBvkKoYLPIKPA
         XF/606NXVti8/d1nSyyFLkcTIUcVyeU2V7rvWNulxR3VwgiJUtwFlktNsMH4++RebF22
         8LPGDcXB4+mjYNcga0x7kZC5Niu2KD2oTVP19m4eScjjfYUWIUYFCSjq3yHLKs9Nwc53
         L62A2Vhp1eTrJ2vAKDAoNfuvG7sklPA2HtHGMvB14qUsPKh+UX8NvQ+gJizK/Bu4vCe+
         O5Ag==
X-Gm-Message-State: APjAAAVLhevxP6BbkOot7dKtXac4WMw+wOeXgDA5dqhBEfSYdxP5oQab
        ntg+k+EsbV3ykMflHbcCtC3z3Q==
X-Google-Smtp-Source: APXvYqxXsJTvKjCphVHMwx4/FebOUiKV+9+M6nNY9VXfS4ti2jmM79hV6vZe/fK3Ujbd/dMlNttV+A==
X-Received: by 2002:adf:dc45:: with SMTP id m5mr8831205wrj.148.1560772502724;
        Mon, 17 Jun 2019 04:55:02 -0700 (PDT)
Received: from dell.watershed.co.uk ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id n1sm10193748wrx.39.2019.06.17.04.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 04:55:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     agross@kernel.org, david.brown@linaro.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, pedrom.sousa@synopsys.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, jlhugo@gmail.com,
        bjorn.andersson@linaro.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/1] scsi: ufs-qcom: Add support for platforms booting ACPI
Date:   Mon, 17 Jun 2019 12:54:54 +0100
Message-Id: <20190617115454.3226-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New Qualcomm AArch64 based laptops are now available which use UFS
as their primary data storage medium.  These devices are supplied
with ACPI support out of the box.  This patch ensures the Qualcomm
UFS driver will be bound when the "QCOM24A5" H/W device is
advertised as present.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/ufs/ufs-qcom.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 3aeadb14aae1..364af6a63e35 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -12,6 +12,7 @@
  *
  */
 
+#include <linux/acpi.h>
 #include <linux/time.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -164,6 +165,9 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
 	int err = 0;
 	struct device *dev = host->hba->dev;
 
+	if (has_acpi_companion(dev))
+		return 0;
+
 	err = ufs_qcom_host_clk_get(dev, "rx_lane0_sync_clk",
 					&host->rx_l0_sync_clk, false);
 	if (err)
@@ -1208,9 +1212,13 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 			__func__, err);
 		goto out_variant_clear;
 	} else if (IS_ERR(host->generic_phy)) {
-		err = PTR_ERR(host->generic_phy);
-		dev_err(dev, "%s: PHY get failed %d\n", __func__, err);
-		goto out_variant_clear;
+		if (has_acpi_companion(dev)) {
+			host->generic_phy = NULL;
+		} else {
+			err = PTR_ERR(host->generic_phy);
+			dev_err(dev, "%s: PHY get failed %d\n", __func__, err);
+			goto out_variant_clear;
+		}
 	}
 
 	err = ufs_qcom_bus_register(host);
@@ -1680,6 +1688,14 @@ static const struct of_device_id ufs_qcom_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ufs_qcom_of_match);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id ufs_qcom_acpi_match[] = {
+	{ "QCOM24A5" },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, ufs_qcom_acpi_match);
+#endif
+
 static const struct dev_pm_ops ufs_qcom_pm_ops = {
 	.suspend	= ufshcd_pltfrm_suspend,
 	.resume		= ufshcd_pltfrm_resume,
@@ -1696,6 +1712,7 @@ static struct platform_driver ufs_qcom_pltform = {
 		.name	= "ufshcd-qcom",
 		.pm	= &ufs_qcom_pm_ops,
 		.of_match_table = of_match_ptr(ufs_qcom_of_match),
+		.acpi_match_table = ACPI_PTR(ufs_qcom_acpi_match),
 	},
 };
 module_platform_driver(ufs_qcom_pltform);
-- 
2.17.1

