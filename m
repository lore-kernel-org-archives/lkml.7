Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECFDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B012173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412901;
	bh=X+sgWuEzyB0G/Lz1u2Z4bxbknIgiOYcVvQ4GbMYRTjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YTl8Iv/Wos9KiDXQ2rFYzcuB34dDbQWAY6noPqaE0N09sRkwGooynvEz2tqWnyzE+
	 dQt5jP+rv3CAFSDQo62iillwzeRD1uXjG9dM81CSN494uRt2hY0JDQG6Fh5YMjDaaP
	 6zi1UMFrhq9/hK6V32/G2BTz4060BhyVmEVBdXgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfCLRsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbfCLRPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:03 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D478C21850;
        Tue, 12 Mar 2019 17:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410901;
        bh=X+sgWuEzyB0G/Lz1u2Z4bxbknIgiOYcVvQ4GbMYRTjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M1wt2XepCB05Cosexli5RT5B3IQDrqgNgBKMt507fG0Uy+dic2PbdkCYxC1oVAKx9
         XLQ3LNYgr85rk3q+OOX8IKD9pi6CJHq7SJjYBDT2ZIw/uSW4S7FuIYX9mPsKyDLSAs
         tkKo106gPHWE/WF9g21XGrAa1yf67z3xCxDNsJ3w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Xiong <wenxiong@us.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 115/149] nvme: lock NS list changes while handling command effects
Date:   Tue, 12 Mar 2019 10:08:53 -0700
Message-Id: <20190312170359.124779056@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index e0d2b7473901..2cdb3032ca0f 100644
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
@@ -3292,6 +3295,7 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
 
+	mutex_lock(&ctrl->scan_lock);
 	nn = le32_to_cpu(id->nn);
 	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
 	    !(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)) {
@@ -3300,6 +3304,7 @@ static void nvme_scan_work(struct work_struct *work)
 	}
 	nvme_scan_ns_sequential(ctrl, nn);
 out_free_id:
+	mutex_unlock(&ctrl->scan_lock);
 	kfree(id);
 	down_write(&ctrl->namespaces_rwsem);
 	list_sort(NULL, &ctrl->namespaces, ns_cmp);
@@ -3535,6 +3540,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	ctrl->state = NVME_CTRL_NEW;
 	spin_lock_init(&ctrl->lock);
+	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
 	init_rwsem(&ctrl->namespaces_rwsem);
 	ctrl->dev = dev;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 60220de2db52..e82cdaec81c9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -148,6 +148,7 @@ struct nvme_ctrl {
 	enum nvme_ctrl_state state;
 	bool identified;
 	spinlock_t lock;
+	struct mutex scan_lock;
 	const struct nvme_ctrl_ops *ops;
 	struct request_queue *admin_q;
 	struct request_queue *connect_q;
-- 
2.19.1



