Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AB1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CD520811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KnFYCLJW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QNhzKf7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfCHIbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:31:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35688 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfCHIbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:31:36 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5EF6D60386; Fri,  8 Mar 2019 08:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552033895;
        bh=b8MtlD+7/yGM3Lr8HhhhyH/yYBErhCRMJVXsCSAyx0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KnFYCLJWnb5yFdO0Why/MTY2vTdUWsC3oVCO0wIaCDgYLM48Z2ZZzbbeEXQQWbpxu
         g0NaTPBJ1VZ3RZjjPPBMffDr/Gju9wiKBrNt6/h5RJCRXbPtMebwnl5Gcw/cAkCe2j
         Cr+ra7iQs1GZmqM5XY9Khz3Z6mJ3h9VpWeysVkMk=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E29260386;
        Fri,  8 Mar 2019 08:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552033894;
        bh=b8MtlD+7/yGM3Lr8HhhhyH/yYBErhCRMJVXsCSAyx0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QNhzKf7I8Heq3AHUlsH//wjoQhlUbA+Ecg+liLAO3Jg0XGCuxW2ZeUwgVcy95wplX
         /y0pL43n8wjWlYOO5aTDBViJ4ClX95iGURJa8M2QxmZ30LTr/lAUggmglmZ3Q4kfU2
         iSPXc3ehtHELBWMBcjSHjnKYE4OYCuQFw+S4BU50=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E29260386
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     vinholikatti@gmail.com, alim.akhtar@samsung.com,
        pedrom.Sousa@synopsys.com
Cc:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 2/3] scsi: ufs: Add error checks for pm_runtime_get_sync()
Date:   Fri,  8 Mar 2019 14:00:52 +0530
Message-Id: <20190308083053.30631-3-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190308083053.30631-1-rnayak@codeaurora.org>
References: <20190308083053.30631-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an error check for pm_runtime_get_sync(), ignoring this can
hide issues with the runtime pm handling in the driver.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 2ddf24466a62..060dc38cc582 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -8357,7 +8357,10 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	}
 
 	/* Hold auto suspend until async scan completes */
-	pm_runtime_get_sync(dev);
+	err = pm_runtime_get_sync(dev);
+	if (err < 0)
+		goto out_remove_scsi_host;
+
 	atomic_set(&hba->scsi_block_reqs_cnt, 0);
 	/*
 	 * We are assuming that device wasn't put in sleep/power-down
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

