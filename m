Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B81C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F02D20661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="IWUw2wOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLCTbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 14:31:13 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:60060 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfLCTbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:31:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 5DA303F40C;
        Tue,  3 Dec 2019 20:31:10 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=IWUw2wOu;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GszfSkUBF-df; Tue,  3 Dec 2019 20:31:09 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id A4D303F32A;
        Tue,  3 Dec 2019 20:31:08 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 089943624F0;
        Tue,  3 Dec 2019 20:31:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1575401468; bh=/7/9dHn0758DXVRpByBE3suS6EMBPMa3AZ/s9f6Z6zs=;
        h=From:To:Cc:Subject:Date:From;
        b=IWUw2wOuOW1jkYMfOxmqV6aoPv44z4kscF7BE7ZbNI56R1SMvAYnSqgW5TRZ0Gojc
         qyWhEmeOJp7rtRASElV/EXZiM19YU4hPwhNshv+phLOagICH6JlDrcrO3oymMLjuXL
         PJOpmD+Q31CMW/4/QlEEml8oQjQfKmeXrd++jprQ=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        pv-drivers@vmware.com
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Vishal Bhakta <vbhakta@vmware.com>, Jim Gill <jgill@vmware.com>
Subject: [PATCH RESEND 1/2] scsi: vmw_pvscsi: Fix swiotlb operation
Date:   Tue,  3 Dec 2019 20:30:51 +0100
Message-Id: <20191203193052.7583-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

With swiotlb, the first byte of the sense buffer may in some cases be
uninitialized since we use DMA_FROM_DEVICE, and the device incorrectly
doesn't clear it. In those cases, clear it after DMA unmapping.

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Suggested-by: Vishal Bhakta <vbhakta@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Acked-by: Jim Gill <jgill@vmware.com>
---
 drivers/scsi/vmw_pvscsi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index 70008816c91f..8a09d184a320 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -402,6 +402,17 @@ static int pvscsi_map_buffers(struct pvscsi_adapter *adapter,
 	return 0;
 }
 
+/*
+ * The device incorrectly doesn't clear the first byte of the sense
+ * buffer in some cases. We have to do it ourselves.
+ * Otherwise we run into trouble when SWIOTLB is forced.
+ */
+static void pvscsi_patch_sense(struct scsi_cmnd *cmd)
+{
+	if (cmd->sense_buffer)
+		cmd->sense_buffer[0] = 0;
+}
+
 static void pvscsi_unmap_buffers(const struct pvscsi_adapter *adapter,
 				 struct pvscsi_ctx *ctx)
 {
@@ -544,6 +555,8 @@ static void pvscsi_complete_request(struct pvscsi_adapter *adapter,
 	cmd = ctx->cmd;
 	abort_cmp = ctx->abort_cmp;
 	pvscsi_unmap_buffers(adapter, ctx);
+	if (sdstat != SAM_STAT_CHECK_CONDITION)
+		pvscsi_patch_sense(cmd);
 	pvscsi_release_context(adapter, ctx);
 	if (abort_cmp) {
 		/*
@@ -873,6 +886,7 @@ static void pvscsi_reset_all(struct pvscsi_adapter *adapter)
 			scmd_printk(KERN_ERR, cmd,
 				    "Forced reset on cmd %p\n", cmd);
 			pvscsi_unmap_buffers(adapter, ctx);
+			pvscsi_patch_sense(cmd);
 			pvscsi_release_context(adapter, ctx);
 			cmd->result = (DID_RESET << 16);
 			cmd->scsi_done(cmd);
-- 
2.21.0

