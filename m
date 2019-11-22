Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B1AC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A95A20708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421599;
	bh=6yocqwmT1R9PbCLWfIRomMKgZoo1uKcOq6TLIs/TVFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xLiOr3xeEuDuzQQYPLehAVL6TW48LbUX3SBz0gBt6ReDWxWbopK1QPqE1dv1WKCM1
	 uySUMu56cdTMUJhvZLwsOWyDrHTIX4VzapvOERpN/9qtOMm7LB4RbMUYiybXQ6V731
	 PWWqmJNKqfoK9AsiS6ZpSzm1rf15Y03LCOj6gQUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfKVLT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:19:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbfKVKqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:46:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06C67205C9;
        Fri, 22 Nov 2019 10:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419591;
        bh=6yocqwmT1R9PbCLWfIRomMKgZoo1uKcOq6TLIs/TVFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rUUjX9yjoY/VqxmOBjx1ru+mqkndN7rv1gsTAjXodFyMDs2M8S3m+MTZ8x489yp0m
         NjlRGKYaEgwjsfYuYc+ITqU3kI3PbrhG7xEMp7ZbphJm+thkx3dJ5GZg+Mhx4XJ7/Z
         XzXWbt067uVid4nARUy2VXU+bqKVscYYzBBUnri0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhong jiang <zhongjiang@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 121/222] misc: genwqe: should return proper error value.
Date:   Fri, 22 Nov 2019 11:27:41 +0100
Message-Id: <20191122100911.844134552@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index b642b4fd731b6..95584bffa4eaf 100644
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



