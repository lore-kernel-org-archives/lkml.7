Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F14C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6F22146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CCuKjSrw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Na9n01Ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfCTJuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:50:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50938 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbfCTJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:50:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E1DC361231; Wed, 20 Mar 2019 09:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075400;
        bh=xLWp2CA62FmdAwyYbFoeoX+SuUcf//mCdkLIsuQ6ygY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCuKjSrwUfnkFluHZKV6LFRQOu48tD/Qijxdv/mFLtEHr1lu8GZrpzMYPggS5jt07
         eVzR0fIkLi+UySaodL05M60/j/OoHjCA52WrchIapjDH+Hbo7oD340Dia2MCaoyVrK
         NsmGsLtnp5e2BPHbOzAExz/RP6NvKcQB/xpgLWOg=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6511611BE;
        Wed, 20 Mar 2019 09:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075399;
        bh=xLWp2CA62FmdAwyYbFoeoX+SuUcf//mCdkLIsuQ6ygY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Na9n01Ied7Ip0EVp98ZckL0Hy43nQJ6lo/UvC1uSVAmWg+jdtE69C53+FEP/QAzGK
         NnfESvLHC1nVF6gs2BOnbXL7m2YRGAOaJdN8W8y+O7nB0Cr1KNUpbRTIVLHrHKnytE
         B/EVV4yJsbkl1c8rgo+bvhVunKEnbOGZjnqbiu7o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6511611BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
        swboyd@chromium.org, ulf.hansson@linaro.org,
        viresh.kumar@linaro.org, dianders@chromium.org, rafael@kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC v2 06/11] scsi: ufs: Add support to manage multiple power domains in ufshcd-pltfrm
Date:   Wed, 20 Mar 2019 15:19:13 +0530
Message-Id: <20190320094918.20234-7-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320094918.20234-1-rnayak@codeaurora.org>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some UFS devices need to manage multiple powerdomains. Add support for
it as part of the ufshcd-pltfrm driver.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd-pltfrm.c | 52 +++++++++++++++++++++++++++++++-
 drivers/scsi/ufs/ufshcd.h        |  3 ++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index 238a79f21e74..ce33eb8b7510 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -34,6 +34,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 
@@ -289,6 +290,43 @@ static void ufshcd_init_lanes_per_dir(struct ufs_hba *hba)
 	}
 }
 
+static int ufshcd_attach_pds(struct device *dev, struct ufs_hba *hba, int num_pds)
+{
+	int i, ret;
+
+	hba->virt_devs = devm_kzalloc(dev, sizeof(struct device *) * num_pds,
+				      GFP_KERNEL);
+	if (!hba->virt_devs)
+		return -ENOMEM;
+
+	hba->num_virt_devs = num_pds;
+	for (i = 0; i < num_pds; i++) {
+		hba->virt_devs[i] = dev_pm_domain_attach_by_id(dev, i);
+		if (IS_ERR(hba->virt_devs[i])) {
+			ret = PTR_ERR(hba->virt_devs[i]);
+			goto unroll_attach;
+		}
+		device_link_add(dev,hba->virt_devs[i], DL_FLAG_RPM_ACTIVE |
+				DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
+	}
+
+	return ret;
+
+unroll_attach:
+	for (i--; i >= 0; i--)
+		dev_pm_domain_detach(hba->virt_devs[i], false);
+
+	return ret;
+}
+
+static void ufshcd_detach_pds(struct ufs_hba *hba)
+{
+	int i;
+
+	for (i = 0; i < hba->num_virt_devs; i++)
+		dev_pm_domain_detach(hba->virt_devs[i], false);
+}
+
 /**
  * ufshcd_pltfrm_init - probe routine of the driver
  * @pdev: pointer to Platform device handle
@@ -302,7 +340,7 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 	struct ufs_hba *hba;
 	void __iomem *mmio_base;
 	struct resource *mem_res;
-	int irq, err;
+	int irq, err, num_pds;
 	struct device *dev = &pdev->dev;
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -340,6 +378,16 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 		goto dealloc_host;
 	}
 
+	num_pds = of_count_phandle_with_args(dev->of_node, "power-domains",
+					     "#power-domain-cells");
+	if (num_pds > 1) {
+		err = ufshcd_attach_pds(&pdev->dev, hba, num_pds);
+		if (err) {
+			dev_err(&pdev->dev, "%s: attach of power domains failed %d\n",
+				__func__, err);
+			goto dealloc_host;
+		}
+	}
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
@@ -358,6 +406,8 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 	return 0;
 
 out_disable_rpm:
+	if (num_pds > 1)
+		ufshcd_detach_pds(hba);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index ecfa898b9ccc..bca1e008f506 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -517,6 +517,9 @@ struct ufs_hba {
 
 	struct Scsi_Host *host;
 	struct device *dev;
+	struct device **virt_devs;
+	u8 num_virt_devs;
+
 	/*
 	 * This field is to keep a reference to "scsi_device" corresponding to
 	 * "UFS device" W-LU.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

