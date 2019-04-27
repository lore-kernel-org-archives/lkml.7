Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD0BC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EE2206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfD0PT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:19:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34102 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727657AbfD0PPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:37 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP37-0000z6-BY; Sat, 27 Apr 2019 16:15:33 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2j-0004TU-Ki; Sat, 27 Apr 2019 16:15:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.612415753@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 073/202] scsi: bnx2fc: Fix error handling in probe()
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit b2d3492fc591b1fb46b81d79ca1fc44cac6ae0ae upstream.

There are two issues here.  First if cmgr->hba is not set early enough then
it leads to a NULL dereference.  Second if we don't completely initialize
cmgr->io_bdt_pool[] then we end up dereferencing uninitialized pointers.

Fixes: 853e2bd2103a ("[SCSI] bnx2fc: Broadcom FCoE offload driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[bwh: Backorted to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/bnx2fc/bnx2fc_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
@@ -271,6 +271,7 @@ struct bnx2fc_cmd_mgr *bnx2fc_cmd_mgr_al
 		return NULL;
 	}
 
+	cmgr->hba = hba;
 	cmgr->free_list = kzalloc(sizeof(*cmgr->free_list) *
 				  arr_sz, GFP_KERNEL);
 	if (!cmgr->free_list) {
@@ -287,7 +288,6 @@ struct bnx2fc_cmd_mgr *bnx2fc_cmd_mgr_al
 		goto mem_err;
 	}
 
-	cmgr->hba = hba;
 	cmgr->cmds = (struct bnx2fc_cmd **)(cmgr + 1);
 
 	for (i = 0; i < arr_sz; i++)  {
@@ -326,7 +326,7 @@ struct bnx2fc_cmd_mgr *bnx2fc_cmd_mgr_al
 
 	/* Allocate pool of io_bdts - one for each bnx2fc_cmd */
 	mem_size = num_ios * sizeof(struct io_bdt *);
-	cmgr->io_bdt_pool = kmalloc(mem_size, GFP_KERNEL);
+	cmgr->io_bdt_pool = kzalloc(mem_size, GFP_KERNEL);
 	if (!cmgr->io_bdt_pool) {
 		printk(KERN_ERR PFX "failed to alloc io_bdt_pool\n");
 		goto mem_err;

