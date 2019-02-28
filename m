Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A673C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297BE2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366664;
	bh=pp7JlUdwWqSxYELwskQMJYN7Da+U+THlB0BMDadb4KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XwrAtFxkvyB8kLl/TeavE86EcJheQi2ac1Jr45xTNrzcynrvZEnMi5xlaMaNGDTcF
	 tqOj0L/r0G7TZacAInXnNPh9IBdZn0pUCqDQIcWpOuqx7JtDwTw4r2MBU82CPhqVdi
	 HmJsCPHICybZEKljc52ZqoH34iK3oT34fqT1c7p0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbfB1PLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:11:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:43824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387823AbfB1PK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:10:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA46B218AE;
        Thu, 28 Feb 2019 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366656;
        bh=pp7JlUdwWqSxYELwskQMJYN7Da+U+THlB0BMDadb4KI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ikE7XR5urt7nXujP+wOlVmQ7dAx7TSY2shNycWGHNLutJh0KTf1bWysPi+ZIQk3BQ
         8etPrhXmin6dlAbaj1SPxL9ubVIr55uI2DRakoXnoid1RaevV0sxqvyPmH4XEUmqeO
         vBRjIvlUKgsAdXEfUoK/vAWfNrffGI89r0cbrSnQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 75/81] nvme: lock NS list changes while handling command effects
Date:   Thu, 28 Feb 2019 10:08:07 -0500
Message-Id: <20190228150813.10256-75-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <keith.busch@intel.com>

[ Upstream commit e7ad43c3eda6a1690c4c3c341f95dc1c6898da83 ]

If a controller supports the NS Change Notification, the namespace
scan_work is automatically triggered after attaching a new namespace.

Occasionally the namespace scan_work may append the new namespace to the
list before the admin command effects handling is completed. The effects
handling unfreezes namespaces, but if it unfreezes the newly attached
namespace, its request_queue freeze depth will be off and we'll hit the
warning in blk_mq_unfreeze_queue().

On the next namespace add, we will fail to freeze that queue due to the
previous bad accounting and deadlock waiting for frozen.

Fix that by preventing scan work from altering the namespace list while
command effects handling needs to pair freeze with unfreeze.

Reported-by: Wen Xiong <wenxiong@us.ibm.com>
Tested-by: Wen Xiong <wenxiong@us.ibm.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 8 +++++++-
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5f9a5ef939696..21d7b646c73df 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1182,6 +1182,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	 * effects say only one namespace is affected.
 	 */
 	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
+		mutex_lock(&ctrl->scan_lock);
 		nvme_start_freeze(ctrl);
 		nvme_wait_freeze(ctrl);
 	}
@@ -1210,8 +1211,10 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 	 */
 	if (effects & NVME_CMD_EFFECTS_LBCC)
 		nvme_update_formats(ctrl);
-	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK))
+	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
 		nvme_unfreeze(ctrl);
+		mutex_unlock(&ctrl->scan_lock);
+	}
 	if (effects & NVME_CMD_EFFECTS_CCC)
 		nvme_init_identify(ctrl);
 	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
@@ -3300,6 +3303,7 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
 
+	mutex_lock(&ctrl->scan_lock);
 	nn = le32_to_cpu(id->nn);
 	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
 	    !(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)) {
@@ -3308,6 +3312,7 @@ static void nvme_scan_work(struct work_struct *work)
 	}
 	nvme_scan_ns_sequential(ctrl, nn);
 out_free_id:
+	mutex_unlock(&ctrl->scan_lock);
 	kfree(id);
 	down_write(&ctrl->namespaces_rwsem);
 	list_sort(NULL, &ctrl->namespaces, ns_cmp);
@@ -3550,6 +3555,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	ctrl->state = NVME_CTRL_NEW;
 	spin_lock_init(&ctrl->lock);
+	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
 	init_rwsem(&ctrl->namespaces_rwsem);
 	ctrl->dev = dev;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6ffa99a10a60b..5274881f91417 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -153,6 +153,7 @@ struct nvme_ctrl {
 	enum nvme_ctrl_state state;
 	bool identified;
 	spinlock_t lock;
+	struct mutex scan_lock;
 	const struct nvme_ctrl_ops *ops;
 	struct request_queue *admin_q;
 	struct request_queue *connect_q;
-- 
2.19.1

