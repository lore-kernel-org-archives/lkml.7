Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FADFC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A0121850
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354841;
	bh=Nt/j/Quy+7hqRj6CUCAC/l4/pPFaooAS5ODSYfQ2Llc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IoP8E9ZD6ilvoHZP/PZjaHcwuL/PLurLqtxfBpkpw6C0bFbe7gZetnxa76APHMkXm
	 jEoBRVxkyCmLqMBCuUH9AM0nFayJGL57Yx+h3jmtkgIzXKqMpBfru17VJ4+mcjKtZn
	 gAlJAbuy4jdgnJlk6aC7WBoaoUu/3WQgZTPWppiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfKJDAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:00:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729272AbfKJC4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:56:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D20F22475;
        Sun, 10 Nov 2019 02:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354059;
        bh=Nt/j/Quy+7hqRj6CUCAC/l4/pPFaooAS5ODSYfQ2Llc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OoO8kcXoL/soJAOgkhvOc/n7UqLQAYvjx3Nj4NZYCeg4s/z/pkK6mTh5caofChQi6
         VhoxCY9MO1QXKMjzzl2UqJ4Y/yEoMZFOvtoTbBGa8im4lIDcbJcOQfyhDJhyq/A9UI
         4WDQmjhHajlGxVAtO16R0jLgbtFtI9QCFBJvxqyE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhong jiang <zhongjiang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 068/109] misc: genwqe: should return proper error value.
Date:   Sat,  9 Nov 2019 21:45:00 -0500
Message-Id: <20191110024541.31567-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024541.31567-1-sashal@kernel.org>
References: <20191110024541.31567-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>

[ Upstream commit 02241995b004faa7d9ff628e97f24056190853f8 ]

The function should return -EFAULT when copy_from_user fails. Even
though the caller does not distinguish them. but we should keep backward
compatibility.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/genwqe/card_utils.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/genwqe/card_utils.c b/drivers/misc/genwqe/card_utils.c
index cb12409851575..f55e6e822bea4 100644
--- a/drivers/misc/genwqe/card_utils.c
+++ b/drivers/misc/genwqe/card_utils.c
@@ -298,7 +298,7 @@ static int genwqe_sgl_size(int num_pages)
 int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
 			  void __user *user_addr, size_t user_size)
 {
-	int rc;
+	int ret = -ENOMEM;
 	struct pci_dev *pci_dev = cd->pci_dev;
 
 	sgl->fpage_offs = offset_in_page((unsigned long)user_addr);
@@ -317,7 +317,7 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
 	if (get_order(sgl->sgl_size) > MAX_ORDER) {
 		dev_err(&pci_dev->dev,
 			"[%s] err: too much memory requested!\n", __func__);
-		return -ENOMEM;
+		return ret;
 	}
 
 	sgl->sgl = __genwqe_alloc_consistent(cd, sgl->sgl_size,
@@ -325,7 +325,7 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
 	if (sgl->sgl == NULL) {
 		dev_err(&pci_dev->dev,
 			"[%s] err: no memory available!\n", __func__);
-		return -ENOMEM;
+		return ret;
 	}
 
 	/* Only use buffering on incomplete pages */
@@ -338,7 +338,7 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
 		/* Sync with user memory */
 		if (copy_from_user(sgl->fpage + sgl->fpage_offs,
 				   user_addr, sgl->fpage_size)) {
-			rc = -EFAULT;
+			ret = -EFAULT;
 			goto err_out;
 		}
 	}
@@ -351,7 +351,7 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
 		/* Sync with user memory */
 		if (copy_from_user(sgl->lpage, user_addr + user_size -
 				   sgl->lpage_size, sgl->lpage_size)) {
-			rc = -EFAULT;
+			ret = -EFAULT;
 			goto err_out2;
 		}
 	}
@@ -373,7 +373,8 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
 	sgl->sgl = NULL;
 	sgl->sgl_dma_addr = 0;
 	sgl->sgl_size = 0;
-	return -ENOMEM;
+
+	return ret;
 }
 
 int genwqe_setup_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
-- 
2.20.1

