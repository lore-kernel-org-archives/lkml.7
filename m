Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1259FC2D0C7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71AE2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079902;
	bh=cFlcOaw/qeAJPWdJSsqw24Ge7bVtfzcVX8YUgBDsENU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L4thgtL/5ZWlxFhs1yvIzJYsvnYkXzQuqjttR/PVTni1Trb12EiMX4nxO8mPKRI/W
	 rXfRlOlFCKo3l4s2/oDxubE9yDHawMWsCq3xIMT9zqkwkD2rbEKaR6H38BWo4ejXBq
	 CmkvB0V66/LMFEPYqbROj3Os7Z3HVLjppnzbqYLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfLKPOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:14:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731477AbfLKPNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:13:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F14172467D;
        Wed, 11 Dec 2019 15:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077220;
        bh=cFlcOaw/qeAJPWdJSsqw24Ge7bVtfzcVX8YUgBDsENU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cx0Fm+0xFhx0u8MmnffK3wrj9vAeY2TtbACdhsbRxsTz1so6QVBwTwM/qE1F+Y7Va
         y/jnMo3suLJdxioMb8EKRE8bU2X7DVAugqXwjYKBNgnClr+xI2CBuk3VnuRU8OK8rm
         zH04YPDDKQE0pLcZXAypg7WYUIPskT7JcvKVoun8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Omer Shpigelman <oshpigelman@habana.ai>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 100/134] habanalabs: skip VA block list update in reset flow
Date:   Wed, 11 Dec 2019 10:11:16 -0500
Message-Id: <20191211151150.19073-100-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

[ Upstream commit 71c5e55e7c077fa17c42fbda91a8d14322825c44 ]

Reduce context close time by skipping the VA block free list update in
order to avoid hard reset with open contexts.
Reset with open contexts can potentially lead to a kernel crash as the
generic pool of the MMU hops is destroyed while it is not empty because
some unmap operations are not done.
The commit affect mainly when running on simulator.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/memory.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 365fb0cb8dfff..22566b75ca50c 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -965,17 +965,19 @@ init_page_pack_err:
  *
  * @ctx                 : current context
  * @vaddr               : device virtual address to unmap
+ * @ctx_free            : true if in context free flow, false otherwise.
  *
  * This function does the following:
  * - Unmap the physical pages related to the given virtual address
  * - return the device virtual block to the virtual block list
  */
-static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr)
+static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr, bool ctx_free)
 {
 	struct hl_device *hdev = ctx->hdev;
 	struct hl_vm_phys_pg_pack *phys_pg_pack = NULL;
 	struct hl_vm_hash_node *hnode = NULL;
 	struct hl_userptr *userptr = NULL;
+	struct hl_va_range *va_range;
 	enum vm_type_t *vm_type;
 	u64 next_vaddr, i;
 	u32 page_size;
@@ -1003,6 +1005,7 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr)
 
 	if (*vm_type == VM_TYPE_USERPTR) {
 		is_userptr = true;
+		va_range = &ctx->host_va_range;
 		userptr = hnode->ptr;
 		rc = init_phys_pg_pack_from_userptr(ctx, userptr,
 				&phys_pg_pack);
@@ -1014,6 +1017,7 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr)
 		}
 	} else if (*vm_type == VM_TYPE_PHYS_PACK) {
 		is_userptr = false;
+		va_range = &ctx->dram_va_range;
 		phys_pg_pack = hnode->ptr;
 	} else {
 		dev_warn(hdev->dev,
@@ -1052,12 +1056,18 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr)
 
 	mutex_unlock(&ctx->mmu_lock);
 
-	if (add_va_block(hdev,
-			is_userptr ? &ctx->host_va_range : &ctx->dram_va_range,
-			vaddr,
-			vaddr + phys_pg_pack->total_size - 1))
-		dev_warn(hdev->dev, "add va block failed for vaddr: 0x%llx\n",
-				vaddr);
+	/*
+	 * No point in maintaining the free VA block list if the context is
+	 * closing as the list will be freed anyway
+	 */
+	if (!ctx_free) {
+		rc = add_va_block(hdev, va_range, vaddr,
+					vaddr + phys_pg_pack->total_size - 1);
+		if (rc)
+			dev_warn(hdev->dev,
+					"add va block failed for vaddr: 0x%llx\n",
+					vaddr);
+	}
 
 	atomic_dec(&phys_pg_pack->mapping_cnt);
 	kfree(hnode);
@@ -1189,8 +1199,8 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 		break;
 
 	case HL_MEM_OP_UNMAP:
-		rc = unmap_device_va(ctx,
-				args->in.unmap.device_virt_addr);
+		rc = unmap_device_va(ctx, args->in.unmap.device_virt_addr,
+					false);
 		break;
 
 	default:
@@ -1620,7 +1630,7 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 		dev_dbg(hdev->dev,
 			"hl_mem_hash_node of vaddr 0x%llx of asid %d is still alive\n",
 			hnode->vaddr, ctx->asid);
-		unmap_device_va(ctx, hnode->vaddr);
+		unmap_device_va(ctx, hnode->vaddr, true);
 	}
 
 	spin_lock(&vm->idr_lock);
-- 
2.20.1

