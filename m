Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECA5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A078D2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688452;
	bh=7yvuclnoUdmlAE2cRhMoNNrr8gYW8SsJfD6MTIWxdH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lJQYIZb2wvSBtZnhkAsPkMaghIIapjRodIXhn94QpjNVI/uWDYUL85nBBXIPq3aqf
	 p3SMH7nmXXhanVLMboTkb035vp48Pn+tcpBK2+Mh+KAXpSmS6EqFiOaqSfNdo7vFs+
	 RXcwBbmAs1hvVHtkF1j38pUCo1IIPom8/lnk93gM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfCDIeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:34:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbfCDIeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:34:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED1EC21019;
        Mon,  4 Mar 2019 08:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688446;
        bh=7yvuclnoUdmlAE2cRhMoNNrr8gYW8SsJfD6MTIWxdH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDvyjKoFPtI8dIayzWXQNCI3xGHil5RG0OOVIq/+3Jt2PfamEsHKIcAYt/P4Sa41Z
         s9lNnwzkwrkISiVHvHF+UGq/2lY8wHvRHTsYWFLMpO95Ews8uZeqgtWYU7XH9LZpkb
         fm8pd2x1q+5p7becSQtNU7KmBYGoMXL2p1Ic0/p0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 46/88] scsi: lpfc: nvme: avoid hang / use-after-free when destroying localport
Date:   Mon,  4 Mar 2019 09:22:29 +0100
Message-Id: <20190304081632.381859601@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

[ Upstream commit 7961cba6f7d8215fa632df3d220e5154bb825249 ]

We cannot wait on a completion object in the lpfc_nvme_lport structure in
the _destroy_localport() code path because the NVMe/fc transport will free
that structure immediately after the .localport_delete() callback.  This
results in a use-after-free, and a hang if slub_debug=FZPU is enabled.

Fix this by putting the completion on the stack.

Signed-off-by: Ewan D. Milne <emilne@redhat.com>
Acked-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 16 +++++++++-------
 drivers/scsi/lpfc/lpfc_nvme.h |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index ba831def9301d..b6fe88de372a8 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -297,7 +297,8 @@ lpfc_nvme_localport_delete(struct nvme_fc_local_port *localport)
 			 lport);
 
 	/* release any threads waiting for the unreg to complete */
-	complete(&lport->lport_unreg_done);
+	if (lport->vport->localport)
+		complete(lport->lport_unreg_cmp);
 }
 
 /* lpfc_nvme_remoteport_delete
@@ -2547,7 +2548,8 @@ lpfc_nvme_create_localport(struct lpfc_vport *vport)
  */
 void
 lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
-			   struct lpfc_nvme_lport *lport)
+			   struct lpfc_nvme_lport *lport,
+			   struct completion *lport_unreg_cmp)
 {
 #if (IS_ENABLED(CONFIG_NVME_FC))
 	u32 wait_tmo;
@@ -2559,8 +2561,7 @@ lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
 	 */
 	wait_tmo = msecs_to_jiffies(LPFC_NVME_WAIT_TMO * 1000);
 	while (true) {
-		ret = wait_for_completion_timeout(&lport->lport_unreg_done,
-						  wait_tmo);
+		ret = wait_for_completion_timeout(lport_unreg_cmp, wait_tmo);
 		if (unlikely(!ret)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_IOERR,
 					 "6176 Lport %p Localport %p wait "
@@ -2594,12 +2595,12 @@ lpfc_nvme_destroy_localport(struct lpfc_vport *vport)
 	struct lpfc_nvme_lport *lport;
 	struct lpfc_nvme_ctrl_stat *cstat;
 	int ret;
+	DECLARE_COMPLETION_ONSTACK(lport_unreg_cmp);
 
 	if (vport->nvmei_support == 0)
 		return;
 
 	localport = vport->localport;
-	vport->localport = NULL;
 	lport = (struct lpfc_nvme_lport *)localport->private;
 	cstat = lport->cstat;
 
@@ -2610,13 +2611,14 @@ lpfc_nvme_destroy_localport(struct lpfc_vport *vport)
 	/* lport's rport list is clear.  Unregister
 	 * lport and release resources.
 	 */
-	init_completion(&lport->lport_unreg_done);
+	lport->lport_unreg_cmp = &lport_unreg_cmp;
 	ret = nvme_fc_unregister_localport(localport);
 
 	/* Wait for completion.  This either blocks
 	 * indefinitely or succeeds
 	 */
-	lpfc_nvme_lport_unreg_wait(vport, lport);
+	lpfc_nvme_lport_unreg_wait(vport, lport, &lport_unreg_cmp);
+	vport->localport = NULL;
 	kfree(cstat);
 
 	/* Regardless of the unregister upcall response, clear
diff --git a/drivers/scsi/lpfc/lpfc_nvme.h b/drivers/scsi/lpfc/lpfc_nvme.h
index cfd4719be25c3..b234d02989942 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -50,7 +50,7 @@ struct lpfc_nvme_ctrl_stat {
 /* Declare nvme-based local and remote port definitions. */
 struct lpfc_nvme_lport {
 	struct lpfc_vport *vport;
-	struct completion lport_unreg_done;
+	struct completion *lport_unreg_cmp;
 	/* Add stats counters here */
 	struct lpfc_nvme_ctrl_stat *cstat;
 	atomic_t fc4NvmeLsRequests;
-- 
2.19.1



