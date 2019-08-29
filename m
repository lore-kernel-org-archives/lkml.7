Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0929DC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C062053B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567076039;
	bh=YqMqhnwmFGwqeoBJvsqjLVHMarwz2//zk8On24MIYAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EakEsz8QP6n26IYHLCKA70XyPGqRwvbxUHIsldZNeZpK2Y5VR7IcmFAzK2H3RrbTT
	 bI5k+DJuNkYPuCITIlzzK1tSe0PjVfaWRV1vRFUKY+aQNqyA/1UZrRx4oyVbL47wLx
	 6QkRwI2ENb6JDbILSKwbdQJDeB8LWQe5gUtRu26Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfH2Kxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:53:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728158AbfH2Kuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:50:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3BB8233FF;
        Thu, 29 Aug 2019 10:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567075838;
        bh=YqMqhnwmFGwqeoBJvsqjLVHMarwz2//zk8On24MIYAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZCwK/vU4C5cBxFRB7AJY6KbDAT2jP+f+gS5N1kcmtRpGmB2l/WW133JyXTTOvnGy
         BRdd6jBVVFvft5zzzNUu3SQsMLZ+O8qRlKQmBdqY+MMPGPBz72+HG8+hKq7XQEUxB5
         6xKWggXd12UJAI79VIFW0C6db5aqBdkgL/vMQ5DE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 25/29] nvme-fc: use separate work queue to avoid warning
Date:   Thu, 29 Aug 2019 06:50:05 -0400
Message-Id: <20190829105009.2265-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829105009.2265-1-sashal@kernel.org>
References: <20190829105009.2265-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 8730c1ddb69bdeeb10c1f613a4e15e95862b1981 ]

When tearing down a controller the following warning is issued:

WARNING: CPU: 0 PID: 30681 at ../kernel/workqueue.c:2418 check_flush_dependency

This happens as the err_work workqueue item is scheduled on the
system workqueue (which has WQ_MEM_RECLAIM not set), but is flushed
from a workqueue which has WQ_MEM_RECLAIM set.

Fix this by providing an FC-NVMe specific workqueue.

Fixes: 4cff280a5fcc ("nvme-fc: resolve io failures during connect")
Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 67dec8860bf3c..1f5aa8d4712b3 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -206,7 +206,7 @@ static LIST_HEAD(nvme_fc_lport_list);
 static DEFINE_IDA(nvme_fc_local_port_cnt);
 static DEFINE_IDA(nvme_fc_ctrl_cnt);
 
-
+static struct workqueue_struct *nvme_fc_wq;
 
 /*
  * These items are short-term. They will eventually be moved into
@@ -2053,7 +2053,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	 */
 	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
 		active = atomic_xchg(&ctrl->err_work_active, 1);
-		if (!active && !schedule_work(&ctrl->err_work)) {
+		if (!active && !queue_work(nvme_fc_wq, &ctrl->err_work)) {
 			atomic_set(&ctrl->err_work_active, 0);
 			WARN_ON(1);
 		}
@@ -3321,6 +3321,10 @@ static int __init nvme_fc_init_module(void)
 {
 	int ret;
 
+	nvme_fc_wq = alloc_workqueue("nvme_fc_wq", WQ_MEM_RECLAIM, 0);
+	if (!nvme_fc_wq)
+		return -ENOMEM;
+
 	/*
 	 * NOTE:
 	 * It is expected that in the future the kernel will combine
@@ -3338,7 +3342,7 @@ static int __init nvme_fc_init_module(void)
 	fc_class = class_create(THIS_MODULE, "fc");
 	if (IS_ERR(fc_class)) {
 		pr_err("couldn't register class fc\n");
-		return PTR_ERR(fc_class);
+		goto out_destroy_wq;
 	}
 
 	/*
@@ -3362,6 +3366,9 @@ out_destroy_device:
 	device_destroy(fc_class, MKDEV(0, 0));
 out_destroy_class:
 	class_destroy(fc_class);
+out_destroy_wq:
+	destroy_workqueue(nvme_fc_wq);
+
 	return ret;
 }
 
@@ -3378,6 +3385,7 @@ static void __exit nvme_fc_exit_module(void)
 
 	device_destroy(fc_class, MKDEV(0, 0));
 	class_destroy(fc_class);
+	destroy_workqueue(nvme_fc_wq);
 }
 
 module_init(nvme_fc_init_module);
-- 
2.20.1

