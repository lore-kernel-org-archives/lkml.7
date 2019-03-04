Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874A8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE3C20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfCDTjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:39:36 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:60275 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfCDTjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:39:36 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MmlfS-1hQpyw2Gta-00jpZd; Mon, 04 Mar 2019 20:39:20 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] scsi: lpfc: fix unused variable warning
Date:   Mon,  4 Mar 2019 20:39:08 +0100
Message-Id: <20190304193917.702601-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3lcS5bnwBIBaf3xIyea8qigY2ujMKZ20fLudKb61gEv7aOxvrZm
 C6m6nFc82uZDEfN1Xdk1lKh8ZMwWkW9vB9GUv7cs2z1qQnRGWpZTN286tagmA+TSFXhMUo7
 XkWE/uznmgaY6av5XYrlrzNyRTP13x++yyJg7iQtGwoB53FhyAM3QBsYRIPWUX5mQu/ApJx
 fmpty0vrZiI481WgHWrbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/B0WMM4Rr1k=:TqhyD+ZpXGpSJ9dzO/e9h9
 srhrIjMrVwptC8hKdSsyZVAN6zLPgMLTA7BhslS293HmfFu31Jirq0qSbHyxL5+7sSqPHV5jG
 Za/wJmxg+7F/tr07ABVitwTpy4xKLTIXzqYHMoYZEEBxANm2bGuO7U3U+auWvqNBmq0SIUXtr
 u2lLRtv5LX8aupMcV5ZRIL6jzT3vA+zTdaovU+SKTsuteF5+ZzaUqjfJ/IJePau9w/xySD7cX
 kG44vzwG7ZdgeaR/Og58RTKuKn1ILVVgPkReot9XgS63XSZGUuI4ovs76c2/7ne5TKy3DpJEu
 nxZNTCPwh8lRB8f0AbE8oydhvNAzUncDiSKEviawfLe+wSL1UyK/P5G2RlUvleEDsTXw2cC+G
 OGErLrh2nGfgJNflhRZzNehSPRiCr+SWNkUfKhzcxGsHM2fWeXISMJv6K0gppok3yKRtu4L6p
 wZtAvv/KKxZjxS1nkMXVB5kS+ecb+u2P+82kxNUc68C9AelkJy6CgW8greYezYGxQiP5bj1Op
 6sbjJQa0ORFxxyM0rFrD94TwvbX5U5VxnxZeHSg/wvJXX55Rpsid/2YQU7IxAF4v5mB2Q2Ee6
 IYC+ZGvwUiARODxYdaAbbhyX+adejjXzzGHiM9q/kOhjAJ+WvPuLqLW0xCoKKI6GktyVdMtyQ
 kki47v8a45cPJUuraIR/rycClQXLfxJKPEF3/RzAn0JySFt5L+udKmUsMLdolVy7szS7gCV9q
 RSVBCgMXytBtoHzaMo/x9fri3mLtXOHJ5D5ITA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced 'cpu' variable is only used inside of an optional
block, so we get a warning without CONFIG_SCSI_LPFC_DEBUG_FS:

drivers/scsi/lpfc/lpfc_nvme.c: In function 'lpfc_nvme_io_cmd_wqe_cmpl':
drivers/scsi/lpfc/lpfc_nvme.c:968:30: error: unused variable 'cpu' [-Werror=unused-variable]
  uint32_t code, status, idx, cpu;

Move the declaration into the same block to avoid the warning.

Fixes: 63df6d637e33 ("scsi: lpfc: Adapt cpucheck debugfs logic to Hardware Queues")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 72cb8ad9027b..d16ca413110d 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -965,7 +965,7 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 	struct lpfc_nodelist *ndlp;
 	struct lpfc_nvme_fcpreq_priv *freqpriv;
 	struct lpfc_nvme_lport *lport;
-	uint32_t code, status, idx, cpu;
+	uint32_t code, status, idx;
 	uint16_t cid, sqhd, data;
 	uint32_t *ptr;
 
@@ -1139,6 +1139,7 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 		lpfc_nvme_ktime(phba, lpfc_ncmd);
 	}
 	if (phba->cpucheck_on & LPFC_CHECK_NVME_IO) {
+		uint32_t cpu;
 		idx = lpfc_ncmd->cur_iocbq.hba_wqidx;
 		cpu = smp_processor_id();
 		if (cpu < LPFC_CHECK_CPU_CNT) {
-- 
2.20.0

