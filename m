Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F55C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 04:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2D220B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 04:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="YmlVAUAu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="EJp7Hwxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfDGExo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 00:53:44 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59556 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbfDGExo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 00:53:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9D3878EE0ED;
        Sat,  6 Apr 2019 21:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1554612823;
        bh=8q0B5rHIaaw5WP7hpB5H54e6X9+WYMja3vOth+w2/aU=;
        h=Subject:From:To:Cc:Date:From;
        b=YmlVAUAuPo5jsuPTZ2ky79Wohqa8hBEEteEQuEEdopw6iSmiPr/sPf0JIqbv8gfue
         yr202LCd9UiTSk2ZFtomi19u0lhD6S3gaL/gZe12AyFTR/0o8bUn00V4L0WtrnR7MS
         lWX6r+qwHupXRubopH+jSjHdhRKrvpRODcZFlz3c=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ET93CTA_svQs; Sat,  6 Apr 2019 21:53:43 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4843D8EE0CF;
        Sat,  6 Apr 2019 21:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1554612822;
        bh=8q0B5rHIaaw5WP7hpB5H54e6X9+WYMja3vOth+w2/aU=;
        h=Subject:From:To:Cc:Date:From;
        b=EJp7HwxdhjSGwngCcum/M/0V/YDisZPKz7+lvPD7ajknAKULY4VvE1wmTwO3M3g5E
         4ZJiW9VvJBrdYGq3N1q+xawUyPkBIWYiS/TCAMeBSwJvk0FWmjGFkew/0iUNt8V61o
         JOF+S8tyY8/jnIg4GtcFbiEwMf67KVAHnIj74HFQ=
Message-ID: <1554612821.5053.22.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.1-rc3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 06 Apr 2019 21:53:41 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

five small fixes.  Four in three drivers: qedi, lpfc and storvsc.  The
final one is labelled core, but merely adds a dh rdac entry for Lenovo
systems.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Colin Ian King (1):
      scsi: qedi: remove declaration of nvm_image from stack

James Smart (1):
      scsi: lpfc: Fix missing wakeups on abort threads

Michael Kelley (2):
      scsi: storvsc: Reduce default ring buffer size to 128 Kbytes
      scsi: storvsc: Fix calculation of sub-channel count

Xose Vazquez Perez (1):
      scsi: core: add new RDAC LENOVO/DE_Series device

With diffstat:

 drivers/scsi/lpfc/lpfc_scsi.c |  7 +++----
 drivers/scsi/qedi/qedi_main.c |  7 ++-----
 drivers/scsi/scsi_devinfo.c   |  1 +
 drivers/scsi/scsi_dh.c        |  1 +
 drivers/scsi/storvsc_drv.c    | 15 ++++++++++++---
 5 files changed, 19 insertions(+), 12 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index c98f264f1d83..a497b2c0cb79 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -3878,10 +3878,9 @@ lpfc_scsi_cmd_iocb_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pIocbIn,
 	 * wake up the thread.
 	 */
 	spin_lock(&lpfc_cmd->buf_lock);
-	if (unlikely(lpfc_cmd->cur_iocbq.iocb_flag & LPFC_DRIVER_ABORTED)) {
-		lpfc_cmd->cur_iocbq.iocb_flag &= ~LPFC_DRIVER_ABORTED;
-		if (lpfc_cmd->waitq)
-			wake_up(lpfc_cmd->waitq);
+	lpfc_cmd->cur_iocbq.iocb_flag &= ~LPFC_DRIVER_ABORTED;
+	if (lpfc_cmd->waitq) {
+		wake_up(lpfc_cmd->waitq);
 		lpfc_cmd->waitq = NULL;
 	}
 	spin_unlock(&lpfc_cmd->buf_lock);
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index e74a62448ba4..e5db9a9954dc 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1392,10 +1392,8 @@ static void qedi_free_nvm_iscsi_cfg(struct qedi_ctx *qedi)
 
 static int qedi_alloc_nvm_iscsi_cfg(struct qedi_ctx *qedi)
 {
-	struct qedi_nvm_iscsi_image nvm_image;
-
 	qedi->iscsi_image = dma_alloc_coherent(&qedi->pdev->dev,
-					       sizeof(nvm_image),
+					       sizeof(struct qedi_nvm_iscsi_image),
 					       &qedi->nvm_buf_dma, GFP_KERNEL);
 	if (!qedi->iscsi_image) {
 		QEDI_ERR(&qedi->dbg_ctx, "Could not allocate NVM BUF.\n");
@@ -2236,14 +2234,13 @@ static void qedi_boot_release(void *data)
 static int qedi_get_boot_info(struct qedi_ctx *qedi)
 {
 	int ret = 1;
-	struct qedi_nvm_iscsi_image nvm_image;
 
 	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_INFO,
 		  "Get NVM iSCSI CFG image\n");
 	ret = qedi_ops->common->nvm_get_image(qedi->cdev,
 					      QED_NVM_IMAGE_ISCSI_CFG,
 					      (char *)qedi->iscsi_image,
-					      sizeof(nvm_image));
+					      sizeof(struct qedi_nvm_iscsi_image));
 	if (ret)
 		QEDI_ERR(&qedi->dbg_ctx,
 			 "Could not get NVM image. ret = %d\n", ret);
diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index c4cbfd07b916..a08ff3bd6310 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -238,6 +238,7 @@ static struct {
 	{"NETAPP", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
 	{"LSI", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
 	{"ENGENIO", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
+	{"LENOVO", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
 	{"SMSC", "USB 2 HS-CF", NULL, BLIST_SPARSELUN | BLIST_INQUIRY_36},
 	{"SONY", "CD-ROM CDU-8001", NULL, BLIST_BORKEN},
 	{"SONY", "TSL", NULL, BLIST_FORCELUN},		/* DDS3 & DDS4 autoloaders */
diff --git a/drivers/scsi/scsi_dh.c b/drivers/scsi/scsi_dh.c
index 5a58cbf3a75d..c14006ac98f9 100644
--- a/drivers/scsi/scsi_dh.c
+++ b/drivers/scsi/scsi_dh.c
@@ -75,6 +75,7 @@ static const struct scsi_dh_blist scsi_dh_blist[] = {
 	{"NETAPP", "INF-01-00",		"rdac", },
 	{"LSI", "INF-01-00",		"rdac", },
 	{"ENGENIO", "INF-01-00",	"rdac", },
+	{"LENOVO", "DE_Series",		"rdac", },
 	{NULL, NULL,			NULL },
 };
 
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 84380bae20f1..8472de1007ff 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -385,7 +385,7 @@ enum storvsc_request_type {
  * This is the end of Protocol specific defines.
  */
 
-static int storvsc_ringbuffer_size = (256 * PAGE_SIZE);
+static int storvsc_ringbuffer_size = (128 * 1024);
 static u32 max_outstanding_req_per_channel;
 
 static int storvsc_vcpus_per_sub_channel = 4;
@@ -668,13 +668,22 @@ static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
 {
 	struct device *dev = &device->device;
 	struct storvsc_device *stor_device;
-	int num_cpus = num_online_cpus();
 	int num_sc;
 	struct storvsc_cmd_request *request;
 	struct vstor_packet *vstor_packet;
 	int ret, t;
 
-	num_sc = ((max_chns > num_cpus) ? num_cpus : max_chns);
+	/*
+	 * If the number of CPUs is artificially restricted, such as
+	 * with maxcpus=1 on the kernel boot line, Hyper-V could offer
+	 * sub-channels >= the number of CPUs. These sub-channels
+	 * should not be created. The primary channel is already created
+	 * and assigned to one CPU, so check against # CPUs - 1.
+	 */
+	num_sc = min((int)(num_online_cpus() - 1), max_chns);
+	if (!num_sc)
+		return;
+
 	stor_device = get_out_stor_device(device);
 	if (!stor_device)
 		return;
