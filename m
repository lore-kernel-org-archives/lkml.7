Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD5DC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CB520863
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfCBXGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 18:06:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39154 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCBXGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 18:06:43 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h0DiH-00017h-BP; Sat, 02 Mar 2019 23:06:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Faisal Latif <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] RDMA/nes: remove redundant check on udata
Date:   Sat,  2 Mar 2019 23:06:36 +0000
Message-Id: <20190302230637.8624-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The non-null check on udata is redundant as this check was performed
just a few statements earlier and the check is always true as udata
must be non-null at this point. Remove redundant the check on udata
and the redundant else part that can never be executed.

Detected by CoverityScan, CID#1477317 ("Logically dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/nes/nes_verbs.c | 73 +++++++++++++--------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
index 828e4af3f951..526092d435df 100644
--- a/drivers/infiniband/hw/nes/nes_verbs.c
+++ b/drivers/infiniband/hw/nes/nes_verbs.c
@@ -1039,53 +1039,48 @@ static struct ib_qp *nes_create_qp(struct ib_pd *ibpd,
 				}
 				if (req.user_qp_buffer)
 					nesqp->nesuqp_addr = req.user_qp_buffer;
-				if (udata) {
-					nesqp->user_mode = 1;
-					if (virt_wqs) {
-						err = 1;
-						list_for_each_entry(nespbl, &nes_ucontext->qp_reg_mem_list, list) {
-							if (nespbl->user_base == (unsigned long )req.user_wqe_buffers) {
-								list_del(&nespbl->list);
-								err = 0;
-								nes_debug(NES_DBG_QP, "Found PBL for virtual QP. nespbl=%p. user_base=0x%lx\n",
-									  nespbl, nespbl->user_base);
-								break;
-							}
-						}
-						if (err) {
-							nes_debug(NES_DBG_QP, "Didn't Find PBL for virtual QP. address = %llx.\n",
-								  (long long unsigned int)req.user_wqe_buffers);
-							nes_free_resource(nesadapter, nesadapter->allocated_qps, qp_num);
-							kfree(nesqp->allocated_buffer);
-							return ERR_PTR(-EFAULT);
+
+				nesqp->user_mode = 1;
+				if (virt_wqs) {
+					err = 1;
+					list_for_each_entry(nespbl, &nes_ucontext->qp_reg_mem_list, list) {
+						if (nespbl->user_base == (unsigned long )req.user_wqe_buffers) {
+							list_del(&nespbl->list);
+							err = 0;
+							nes_debug(NES_DBG_QP, "Found PBL for virtual QP. nespbl=%p. user_base=0x%lx\n",
+								  nespbl, nespbl->user_base);
+							break;
 						}
 					}
-
-					nesqp->mmap_sq_db_index =
-						find_next_zero_bit(nes_ucontext->allocated_wqs,
-								   NES_MAX_USER_WQ_REGIONS, nes_ucontext->first_free_wq);
-					/* nes_debug(NES_DBG_QP, "find_first_zero_biton wqs returned %u\n",
-							nespd->mmap_db_index); */
-					if (nesqp->mmap_sq_db_index >= NES_MAX_USER_WQ_REGIONS) {
-						nes_debug(NES_DBG_QP,
-							  "db index > max user regions, failing create QP\n");
+					if (err) {
+						nes_debug(NES_DBG_QP, "Didn't Find PBL for virtual QP. address = %llx.\n",
+							  (long long unsigned int)req.user_wqe_buffers);
 						nes_free_resource(nesadapter, nesadapter->allocated_qps, qp_num);
-						if (virt_wqs) {
-							pci_free_consistent(nesdev->pcidev, nespbl->pbl_size, nespbl->pbl_vbase,
-									    nespbl->pbl_pbase);
-							kfree(nespbl);
-						}
 						kfree(nesqp->allocated_buffer);
-						return ERR_PTR(-ENOMEM);
+						return ERR_PTR(-EFAULT);
 					}
-					set_bit(nesqp->mmap_sq_db_index, nes_ucontext->allocated_wqs);
-					nes_ucontext->mmap_nesqp[nesqp->mmap_sq_db_index] = nesqp;
-					nes_ucontext->first_free_wq = nesqp->mmap_sq_db_index + 1;
-				} else {
+				}
+
+				nesqp->mmap_sq_db_index =
+					find_next_zero_bit(nes_ucontext->allocated_wqs,
+							   NES_MAX_USER_WQ_REGIONS, nes_ucontext->first_free_wq);
+				/* nes_debug(NES_DBG_QP, "find_first_zero_biton wqs returned %u\n",
+						nespd->mmap_db_index); */
+				if (nesqp->mmap_sq_db_index >= NES_MAX_USER_WQ_REGIONS) {
+					nes_debug(NES_DBG_QP,
+						  "db index > max user regions, failing create QP\n");
 					nes_free_resource(nesadapter, nesadapter->allocated_qps, qp_num);
+					if (virt_wqs) {
+						pci_free_consistent(nesdev->pcidev, nespbl->pbl_size, nespbl->pbl_vbase,
+								    nespbl->pbl_pbase);
+						kfree(nespbl);
+					}
 					kfree(nesqp->allocated_buffer);
-					return ERR_PTR(-EFAULT);
+					return ERR_PTR(-ENOMEM);
 				}
+				set_bit(nesqp->mmap_sq_db_index, nes_ucontext->allocated_wqs);
+				nes_ucontext->mmap_nesqp[nesqp->mmap_sq_db_index] = nesqp;
+				nes_ucontext->first_free_wq = nesqp->mmap_sq_db_index + 1;
 			}
 			err = (!virt_wqs) ? nes_setup_mmap_qp(nesqp, nesvnic, sq_size, rq_size) :
 					nes_setup_virt_qp(nesqp, nespbl, nesvnic, sq_size, rq_size);
-- 
2.20.1

