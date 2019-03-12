Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4855C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834652147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414142;
	bh=6IjYvanktMPAMhW6mOZqmSUSgvXjXMDODY+rTM1Wi+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aBlnOT+fuUvMvbub7DCyGMpoDkN3s48iVPQ+hP6TxrMsTuXbjNBdc21SCQKIsrU5f
	 3u2of84gU2EZfsvVFtADdAyLJ9c9uRyyjj8hp9i8j3dWrS1y1hW8JVaEENLFVunmfM
	 zaNUAZq3wypDtcNV68slxdtrbwCuEyWk1FQjz2iI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfCLSJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbfCLRMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:09 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7FA7206DF;
        Tue, 12 Mar 2019 17:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410729;
        bh=6IjYvanktMPAMhW6mOZqmSUSgvXjXMDODY+rTM1Wi+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=po1y72X5ucYCFQfWKEckTYOND1BYKnuofKklfWH7iQU9fVStJpQJi1sCc8VWmGEB/
         0caCVv5K8IY5QP9BGIa9mrYSYBkOWncoESIYBnAuHc7xV1dNmI00CTXa1u/ZWu54ya
         lRrfsMHv9CaZqi7ODa4ZOYPxgf0yK9HZf2LyqFwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 048/171] scsi: bnx2fc: Fix error handling in probe()
Date:   Tue, 12 Mar 2019 10:07:08 -0700
Message-Id: <20190312170352.266950963@linuxfoundation.org>
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

[ Upstream commit b2d3492fc591b1fb46b81d79ca1fc44cac6ae0ae ]

There are two issues here.  First if cmgr->hba is not set early enough then
it leads to a NULL dereference.  Second if we don't completely initialize
cmgr->io_bdt_pool[] then we end up dereferencing uninitialized pointers.

Fixes: 853e2bd2103a ("[SCSI] bnx2fc: Broadcom FCoE offload driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/bnx2fc/bnx2fc_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_io.c b/drivers/scsi/bnx2fc/bnx2fc_io.c
index 350257c13a5b..bc9f2a2365f4 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
@@ -240,6 +240,7 @@ struct bnx2fc_cmd_mgr *bnx2fc_cmd_mgr_alloc(struct bnx2fc_hba *hba)
 		return NULL;
 	}
 
+	cmgr->hba = hba;
 	cmgr->free_list = kcalloc(arr_sz, sizeof(*cmgr->free_list),
 				  GFP_KERNEL);
 	if (!cmgr->free_list) {
@@ -256,7 +257,6 @@ struct bnx2fc_cmd_mgr *bnx2fc_cmd_mgr_alloc(struct bnx2fc_hba *hba)
 		goto mem_err;
 	}
 
-	cmgr->hba = hba;
 	cmgr->cmds = (struct bnx2fc_cmd **)(cmgr + 1);
 
 	for (i = 0; i < arr_sz; i++)  {
@@ -295,7 +295,7 @@ struct bnx2fc_cmd_mgr *bnx2fc_cmd_mgr_alloc(struct bnx2fc_hba *hba)
 
 	/* Allocate pool of io_bdts - one for each bnx2fc_cmd */
 	mem_size = num_ios * sizeof(struct io_bdt *);
-	cmgr->io_bdt_pool = kmalloc(mem_size, GFP_KERNEL);
+	cmgr->io_bdt_pool = kzalloc(mem_size, GFP_KERNEL);
 	if (!cmgr->io_bdt_pool) {
 		printk(KERN_ERR PFX "failed to alloc io_bdt_pool\n");
 		goto mem_err;
-- 
2.19.1



