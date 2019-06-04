Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C782C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4620206C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559690963;
	bh=J3nyFuGnEa5w2fuQA0OpQgebd1UylOzzEaeNayGHIyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OHxFKx/2XU+v/BV8PU4JqloHjYs81ACrVN3S2bbumDZ4ajf3svwEwS1B4Kt2HmJyb
	 /j2Oql2blTxT1ZUoCDUwUNdm3sI1ZEwW3557qM6qYPBYVN/XIxb2RAODweecRtywhT
	 e1gsPv26P3GDuRP/MrSOSid6+gCr6iaszlwfbzn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfFDXYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfFDXYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:24:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B1B6206C1;
        Tue,  4 Jun 2019 23:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690646;
        bh=J3nyFuGnEa5w2fuQA0OpQgebd1UylOzzEaeNayGHIyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wmVCElgy28AG/sluSgVecHD8XAo8DDdQCvXlbSCiX9+f7/G25hvde7srQAiLYS2hZ
         leusTIfdtPbqkgh56IbN+hMIE5rpdgc2ej4zKTykyPQ+ByuTAjG2XB0s5em+VecyuJ
         OzWjJV9bBvaTZxItLkgof7Ydqy+3RqDA5CaxkUgw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 19/36] nvme: merge nvme_ns_ioctl into nvme_ioctl
Date:   Tue,  4 Jun 2019 19:23:14 -0400
Message-Id: <20190604232333.7185-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232333.7185-1-sashal@kernel.org>
References: <20190604232333.7185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 90ec611adcf20b96d0c2b7166497d53e4301a57f ]

Merge the two functions to make future changes a little easier.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 47 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1cdfea3c094a..82f5f1d030d4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1298,32 +1298,11 @@ static void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx)
 		srcu_read_unlock(&head->srcu, idx);
 }
 
-static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned cmd, unsigned long arg)
-{
-	switch (cmd) {
-	case NVME_IOCTL_ID:
-		force_successful_syscall_return();
-		return ns->head->ns_id;
-	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ns->ctrl, NULL, (void __user *)arg);
-	case NVME_IOCTL_IO_CMD:
-		return nvme_user_cmd(ns->ctrl, ns, (void __user *)arg);
-	case NVME_IOCTL_SUBMIT_IO:
-		return nvme_submit_io(ns, (void __user *)arg);
-	default:
-		if (ns->ndev)
-			return nvme_nvm_ioctl(ns, cmd, arg);
-		if (is_sed_ioctl(cmd))
-			return sed_ioctl(ns->ctrl->opal_dev, cmd,
-					 (void __user *) arg);
-		return -ENOTTY;
-	}
-}
-
 static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns_head *head = NULL;
+	void __user *argp = (void __user *)arg;
 	struct nvme_ns *ns;
 	int srcu_idx, ret;
 
@@ -1331,7 +1310,29 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	if (unlikely(!ns))
 		return -EWOULDBLOCK;
 
-	ret = nvme_ns_ioctl(ns, cmd, arg);
+	switch (cmd) {
+	case NVME_IOCTL_ID:
+		force_successful_syscall_return();
+		ret = ns->head->ns_id;
+		break;
+	case NVME_IOCTL_ADMIN_CMD:
+		ret = nvme_user_cmd(ns->ctrl, NULL, argp);
+		break;
+	case NVME_IOCTL_IO_CMD:
+		ret = nvme_user_cmd(ns->ctrl, ns, argp);
+		break;
+	case NVME_IOCTL_SUBMIT_IO:
+		ret = nvme_submit_io(ns, argp);
+		break;
+	default:
+		if (ns->ndev)
+			ret = nvme_nvm_ioctl(ns, cmd, arg);
+		else if (is_sed_ioctl(cmd))
+			ret = sed_ioctl(ns->ctrl->opal_dev, cmd, argp);
+		else
+			ret = -ENOTTY;
+	}
+
 	nvme_put_ns_from_disk(head, srcu_idx);
 	return ret;
 }
-- 
2.20.1

