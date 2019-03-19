Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE22C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D7E2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="qbVGCqa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCSDrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:47:39 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:55684 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCSDrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:47:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id A71E7B3D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 03:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z8ILAJVBFXIe for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 22:47:37 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 6C925B08
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 22:47:37 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id a184so11224408itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3nLLt/A8ybSn982aAYZjuJ3zBQyVjKcmWSDELvsFnGQ=;
        b=qbVGCqa+tlKfnbOPsFZN2MGsq1TijkrizcuUd0Aq7AoWgKNXVTaIzvoEAPTwA/W5Hn
         MVS1xbn6b7DamDkNbKGfMpalvtUWNJQM/Ud6zdxOneGpkgode7q4buSQxOoso+BJgkhH
         y81u0uafZy7zBp0z3gyGkJSHXluVThjiHh8GZQBX1TZri4aUhlDZY/hXcn6muZOuInaA
         h+fI2H/kZ8tPAgiGnNAPeiWXPD/u0FtD6E5Ga9y8HUZwhnbtP6f5MShyNWq8lajiw2Xw
         PChA90HEaXOf76KJJAYknDMMcMM6TrZgyuByIHSVsQ+vAo4Fp17MNH4xVZ5ZWLgaK0q0
         /XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3nLLt/A8ybSn982aAYZjuJ3zBQyVjKcmWSDELvsFnGQ=;
        b=NNndrBZU+lo7CHqNNh253K3+a3Rt9gYw0+s0zvJj7fJ0OMLtS34PuDHIP9ulPfw9K8
         xe0gY95NQLMfghpx2dpGSpTUfMJ4qjbrrCNMkVJgS+cxajIMx+hgqmP5kAXTAhoKUfKJ
         TbCln6oZFtfIECLMRLdVHjKDADBxBsvmcHxVTWOC2fIVnyTWbcW6peYmI5SP5FrT/rnQ
         rgoPC9H7dTGB6HYbnT2GvaCVmL1840AW+QaU4QgCWIf8nsjyoj5bStgzefK24vUhpr0N
         7erMOIvLI74JTAmcCPUEgSb8YGCEzQLGw2GF/yFoRYIDy0G7vFceqBMXwenYukHYwXr7
         5VMA==
X-Gm-Message-State: APjAAAU16X0uy75f1qGedi8kT+cfKjCWKSbS7xs2Xww/w5XgwPPqRNQo
        k1ZukajuDpXpessCEGLKJ9M4Ba0/IJd7NyVa02DQiZsXwAD/64FZBPU/Sa091anoSLgbr+T9NXo
        AvGGnwJNoHiZ3aKEG0lLkDimJ1gQ6
X-Received: by 2002:a05:6638:258:: with SMTP id w24mr182269jaq.85.1552967257088;
        Mon, 18 Mar 2019 20:47:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz522tyQQ5BSuaEAwytCXNwKLi+M01+I5q4/e2bniXvACaFGJ/3odDzGCDQScvAbAGmzCiKbA==
X-Received: by 2002:a05:6638:258:: with SMTP id w24mr182257jaq.85.1552967256897;
        Mon, 18 Mar 2019 20:47:36 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id z11sm5121980iom.73.2019.03.18.20.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 20:47:36 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Sharabi <ohad.sharabi@wdc.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ufs: Check for return value of create_singlethread_workqueue
Date:   Mon, 18 Mar 2019 22:47:28 -0500
Message-Id: <20190319034732.19559-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case create_singlethread_workqueue fails in ufshcd_init_scaling, the
patch returns the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/scsi/ufs/ufshcd.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index e040f9dd9ff3..e822f8eb0601 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1748,12 +1748,12 @@ static ssize_t ufshcd_clkgate_enable_store(struct device *dev,
 	return count;
 }
 
-static void ufshcd_init_clk_scaling(struct ufs_hba *hba)
+static int ufshcd_init_clk_scaling(struct ufs_hba *hba)
 {
 	char wq_name[sizeof("ufs_clkscaling_00")];
 
 	if (!ufshcd_is_clkscaling_supported(hba))
-		return;
+		return 0;
 
 	INIT_WORK(&hba->clk_scaling.suspend_work,
 		  ufshcd_clk_scaling_suspend_work);
@@ -1763,8 +1763,11 @@ static void ufshcd_init_clk_scaling(struct ufs_hba *hba)
 	snprintf(wq_name, sizeof(wq_name), "ufs_clkscaling_%d",
 		 hba->host->host_no);
 	hba->clk_scaling.workq = create_singlethread_workqueue(wq_name);
+	if (!hba->clk_scaling.workq)
+		return -ENOMEM;
 
 	ufshcd_clkscaling_init_sysfs(hba);
+	return 0;
 }
 
 static void ufshcd_exit_clk_scaling(struct ufs_hba *hba)
@@ -8256,7 +8259,9 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 
 	ufshcd_init_clk_gating(hba);
 
-	ufshcd_init_clk_scaling(hba);
+	err = ufshcd_init_clk_scaling(hba);
+	if (err)
+		goto exit_scaling;
 
 	/*
 	 * In order to avoid any spurious interrupt immediately after
@@ -8332,8 +8337,9 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 
 out_remove_scsi_host:
 	scsi_remove_host(hba->host);
-exit_gating:
+exit_scaling:
 	ufshcd_exit_clk_scaling(hba);
+exit_gating:
 	ufshcd_exit_clk_gating(hba);
 out_disable:
 	hba->is_irq_enabled = false;
-- 
2.17.1

