Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1F4C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5F020643
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963653;
	bh=R6FlOzbHHLkeznm9ddwVfXII6th+bXF9D10xHpzjA28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nt32SlWxZ2no8HaZ0rzDb+2sX6FhenuJsNsLpMv1jpsM5mse7beyqIXn+Q4oR1+EF
	 c9kkd4nlQOTiGIOE1ILTCKEwA9jXCKyWN+c6ZYnpldsKvgho/6cLufUYUQhSifYyyJ
	 DNGuNzfuYIPT6ZJObamjkMRa8B5SXjbacU/4UEAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfDVToL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729362AbfDVToH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA2B221901;
        Mon, 22 Apr 2019 19:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962246;
        bh=R6FlOzbHHLkeznm9ddwVfXII6th+bXF9D10xHpzjA28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=stPBqwU+eaxMiHS4b2jyX1iH6qWE12bQncb+w6t4bWQ4Bs1b22cc2FiYQ/JDGN7+4
         sLYp10u+/qOvOSQNVv5k2is7hjhqKUnMJuq7wyXODQMz1j8lC/K68fBLQQY96s8Oey
         V9kGZ8ioycE+6+snasj0aiS9/o2Yf5neCUd0+7QI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 62/98] scsi: mpt3sas: Fix kernel panic during expander reset
Date:   Mon, 22 Apr 2019 15:41:29 -0400
Message-Id: <20190422194205.10404-62-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>

[ Upstream commit c2fe742ff6e77c5b4fe4ad273191ddf28fdea25e ]

During expander reset handling, the driver invokes kernel function
scsi_host_find_tag() to obtain outstanding requests associated with the
scsi host managed by the driver. Driver loops from tag value zero to hba
queue depth to obtain the outstanding scmds. But when blk-mq is enabled,
the block layer may return stale entry for one or more requests. This may
lead to kernel panic if the returned value is inaccessible or the memory
pointed by the returned value is reused.

Reference of upstream discussion:

	https://patchwork.kernel.org/patch/10734933/

Instead of calling scsi_host_find_tag() API for each and every smid (smid
is tag +1) from one to shost->can_queue, now driver will call this API (to
obtain the outstanding scmd) only for those smid's which are outstanding at
the driver level.

Driver will determine whether this smid is outstanding at driver level by
looking into it's corresponding MPI request frame, if its MPI request frame
is empty, then it means that this smid is free and does not need to call
scsi_host_find_tag() for it.  By doing this, driver will invoke
scsi_host_find_tag() for only those tags which are outstanding at the
driver level.

Driver will check whether particular MPI request frame is empty or not by
looking into the "DevHandle" field. If this field is zero then it means
that this MPI request is empty. For active MPI request DevHandle must be
non-zero.

Also driver will memset the MPI request frame once the corresponding scmd
is processed (i.e. just before calling
scmd->done function).

Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c  |  6 ++++++
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 0a6cb8f0680c..c39f88100f31 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3281,12 +3281,18 @@ mpt3sas_base_free_smid(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 
 	if (smid < ioc->hi_priority_smid) {
 		struct scsiio_tracker *st;
+		void *request;
 
 		st = _get_st_from_smid(ioc, smid);
 		if (!st) {
 			_base_recovery_check(ioc);
 			return;
 		}
+
+		/* Clear MPI request frame */
+		request = mpt3sas_base_get_msg_frame(ioc, smid);
+		memset(request, 0, ioc->request_sz);
+
 		mpt3sas_base_clear_st(ioc, st);
 		_base_recovery_check(ioc);
 		return;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 6be39dc27103..6173c211a5e5 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -1462,11 +1462,23 @@ mpt3sas_scsih_scsi_lookup_get(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 {
 	struct scsi_cmnd *scmd = NULL;
 	struct scsiio_tracker *st;
+	Mpi25SCSIIORequest_t *mpi_request;
 
 	if (smid > 0  &&
 	    smid <= ioc->scsiio_depth - INTERNAL_SCSIIO_CMDS_COUNT) {
 		u32 unique_tag = smid - 1;
 
+		mpi_request = mpt3sas_base_get_msg_frame(ioc, smid);
+
+		/*
+		 * If SCSI IO request is outstanding at driver level then
+		 * DevHandle filed must be non-zero. If DevHandle is zero
+		 * then it means that this smid is free at driver level,
+		 * so return NULL.
+		 */
+		if (!mpi_request->DevHandle)
+			return scmd;
+
 		scmd = scsi_host_find_tag(ioc->shost, unique_tag);
 		if (scmd) {
 			st = scsi_cmd_priv(scmd);
-- 
2.19.1

