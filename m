Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3F0C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914CB20848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005911;
	bh=cugt3nrPnzCLUq7Te4RVjmhxVogJnL4KQ6oRYI5BSZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K5CvFv5bVLXb4CXLGdk4J8RvcE5g3/rHh42QATuiv9e+ch+2H2V1arEJhb3xpe/Q7
	 dreWEmMdUtX+Hyb6n5npTda/bk3FqvIXXgdiHbWnxCQ5AWiI4jA/nwYWw3/Fxu9iKn
	 Vft4EytBw5lCZVFFs2Kwt+EQdzDgD7semmvqzwYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgABW6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:58:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:56678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbgABWPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:15:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EB9522314;
        Thu,  2 Jan 2020 22:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003335;
        bh=cugt3nrPnzCLUq7Te4RVjmhxVogJnL4KQ6oRYI5BSZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8WSi/rlX2BtIdgx6kSJOUnujx0aATnUFMnTe7zQb5BTNE3tUSnZ25faKm4giflwd
         vYrLJenJ82iX+d9PpwZkRAxuF8DLSslIO9zdX8WTBW4vLeqEqud1m54spVzhcmDD7m
         o0rJV4kZHhuScgqT3nL8pQpJTk5Ay+G+VtxuhQsw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 092/191] scsi: ufs: Fix up auto hibern8 enablement
Date:   Thu,  2 Jan 2020 23:06:14 +0100
Message-Id: <20200102215839.783129982@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Can Guo <cang@codeaurora.org>

[ Upstream commit 71d848b8d97ec0f8e993d63cf9de6ac8b3f7c43d ]

Fix up possible unclocked register access to auto hibern8 register in
resume path and through sysfs entry. Meanwhile, enable auto hibern8 only
after device is fully initialized in probe path.

Link: https://lore.kernel.org/r/1573798172-20534-4-git-send-email-cang@codeaurora.org
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs-sysfs.c | 15 +++++++++------
 drivers/scsi/ufs/ufshcd.c    | 14 +++++++-------
 drivers/scsi/ufs/ufshcd.h    |  2 ++
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 969a36b15897..ad2abc96c0f1 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -126,13 +126,16 @@ static void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit)
 		return;
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (hba->ahit == ahit)
-		goto out_unlock;
-	hba->ahit = ahit;
-	if (!pm_runtime_suspended(hba->dev))
-		ufshcd_writel(hba, hba->ahit, REG_AUTO_HIBERNATE_IDLE_TIMER);
-out_unlock:
+	if (hba->ahit != ahit)
+		hba->ahit = ahit;
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	if (!pm_runtime_suspended(hba->dev)) {
+		pm_runtime_get_sync(hba->dev);
+		ufshcd_hold(hba, false);
+		ufshcd_auto_hibern8_enable(hba);
+		ufshcd_release(hba);
+		pm_runtime_put(hba->dev);
+	}
 }
 
 /* Convert Auto-Hibernate Idle Timer register value to microseconds */
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 0036dcffc4a9..25a6a25b17a2 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3950,7 +3950,7 @@ static int ufshcd_uic_hibern8_exit(struct ufs_hba *hba)
 	return ret;
 }
 
-static void ufshcd_auto_hibern8_enable(struct ufs_hba *hba)
+void ufshcd_auto_hibern8_enable(struct ufs_hba *hba)
 {
 	unsigned long flags;
 
@@ -6890,9 +6890,6 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 	/* UniPro link is active now */
 	ufshcd_set_link_active(hba);
 
-	/* Enable Auto-Hibernate if configured */
-	ufshcd_auto_hibern8_enable(hba);
-
 	ret = ufshcd_verify_dev_init(hba);
 	if (ret)
 		goto out;
@@ -6943,6 +6940,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 	/* set the state as operational after switching to desired gear */
 	hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;
 
+	/* Enable Auto-Hibernate if configured */
+	ufshcd_auto_hibern8_enable(hba);
+
 	/*
 	 * If we are in error handling context or in power management callbacks
 	 * context, no need to scan the host
@@ -7959,12 +7959,12 @@ static int ufshcd_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	if (hba->clk_scaling.is_allowed)
 		ufshcd_resume_clkscaling(hba);
 
-	/* Schedule clock gating in case of no access to UFS device yet */
-	ufshcd_release(hba);
-
 	/* Enable Auto-Hibernate if configured */
 	ufshcd_auto_hibern8_enable(hba);
 
+	/* Schedule clock gating in case of no access to UFS device yet */
+	ufshcd_release(hba);
+
 	goto out;
 
 set_old_link_state:
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index c94cfda52829..52c9676a1242 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -916,6 +916,8 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 	enum flag_idn idn, bool *flag_res);
 
+void ufshcd_auto_hibern8_enable(struct ufs_hba *hba);
+
 #define SD_ASCII_STD true
 #define SD_RAW false
 int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
-- 
2.20.1



