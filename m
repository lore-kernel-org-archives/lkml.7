Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BDEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63D02175B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413674;
	bh=0T1emm7mQBrnaGKqurFeEz9gj4zC4k9+L53L5pSrExk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=npRfyi4XE2HxUSkhcIOyReBEzfnacyB/IeT5b18I9wYR6OV7ImmAh866iN8KvKWjl
	 yc5bIRhRMdBo/3piPYoRNAUHOljGyeAVkttQ2CFuLI5EL3ICREbyupiskkxEZKVK4C
	 1YZimHbfrIzQUuf8fQql7T0OFDbW6xY5Ig11o7Cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfCLSBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbfCLRNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:14 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0343B2173C;
        Tue, 12 Mar 2019 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410794;
        bh=0T1emm7mQBrnaGKqurFeEz9gj4zC4k9+L53L5pSrExk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddaJ0yFa5hqgANOyJKPdIJhD5OdCzzNft0+4c4cIT+w5mnvs9a2C23Hp3bycKJikY
         N0Y14X8PzNFce7KfsNJVzvUdoV4ik6oDUOvgKiSmwOXi0CbD7ikY7uOG2nrbTV6s8a
         NS77bSXcglSNuhn1oJIXPTufBA806SHAI9hAQPFk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Xiong <wenxiong@us.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 139/171] nvme: lock NS list changes while handling command effects
Date:   Tue, 12 Mar 2019 10:08:39 -0700
Message-Id: <20190312170359.636858395@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 5f9a5ef93969..21d7b646c73d 100644
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
index 6ffa99a10a60..5274881f9141 100644
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



