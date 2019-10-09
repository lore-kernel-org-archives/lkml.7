Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84738ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F70C21920
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570642261;
	bh=N0zoL5YhrO/1NDUD4wR1V+S0xXE5d5+U9/T9JZWM2ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oufeeoxhbNDNSzUO84PN4OQ5NFnAI6LAb9D9zIzTzT9s1YPh266P3lUGfY3iDn71X
	 AG8DOufLa61HME4agNPikXLx3seZgjN0mPNCRyOBdW+jIiCh170k2HNCUfa/D2cR1q
	 GXAJx3UDI7o9gR43q/OR00S6JUgdIgszWj3AquRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbfJIRYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732003AbfJIRX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:23:57 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03C3F21D7C;
        Wed,  9 Oct 2019 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641837;
        bh=N0zoL5YhrO/1NDUD4wR1V+S0xXE5d5+U9/T9JZWM2ZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yY4g+Ltr/tg7qG92fTx/EMK0JvQ7gNUSF1HOz3ttRFblDwMMJsTRf4i68n6RcrZiZ
         hEE2NxilxYaSmZ0nimC2d6l5cNnGGcQrMVeLH007eLzZP2uOsQagB+hAh9R+qUbPL8
         Zi21xNGGIOy7qrZx3KDEuBzn9MBIG0/BZ1uxx9xo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 13/68] scsi: qla2xxx: Fix N2N link up fail
Date:   Wed,  9 Oct 2019 13:04:52 -0400
Message-Id: <20191009170547.32204-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170547.32204-1-sashal@kernel.org>
References: <20191009170547.32204-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

[ Upstream commit f3f1938bb673b1b5ad182c4608f5f8a24921eea3 ]

During link up/bounce, qla driver would do command flush as part of
cleanup.  In this case, the flush can intefere with FW state.  This patch
allows FW to be in control of link up.

Link: https://lore.kernel.org/r/20190912180918.6436-7-hmadhani@marvell.com
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 2 ++
 drivers/scsi/qla2xxx/qla_os.c  | 6 ++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index aadff0124f39f..abfb9c800ce28 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -3905,6 +3905,7 @@ qla24xx_report_id_acquisition(scsi_qla_host_t *vha,
 				fcport->dm_login_expire = jiffies + 2*HZ;
 				fcport->scan_state = QLA_FCPORT_FOUND;
 				fcport->n2n_flag = 1;
+				fcport->keep_nport_handle = 1;
 				if (vha->flags.nvme_enabled)
 					fcport->fc4f_nvme = 1;
 
@@ -4050,6 +4051,7 @@ qla24xx_report_id_acquisition(scsi_qla_host_t *vha,
 			fcport->login_retry = vha->hw->login_retry_count;
 			fcport->plogi_nack_done_deadline = jiffies + HZ;
 			fcport->scan_state = QLA_FCPORT_FOUND;
+			fcport->keep_nport_handle = 1;
 			fcport->n2n_flag = 1;
 			fcport->d_id.b.domain =
 				rptid_entry->u.f2.remote_nport_id[2];
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 12d5f50646fba..2835afbd2edc7 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5150,11 +5150,9 @@ void qla24xx_create_new_sess(struct scsi_qla_host *vha, struct qla_work_evt *e)
 			if (dfcp)
 				qlt_schedule_sess_for_deletion(tfcp);
 
-
-			if (N2N_TOPO(vha->hw))
-				fcport->flags &= ~FCF_FABRIC_DEVICE;
-
 			if (N2N_TOPO(vha->hw)) {
+				fcport->flags &= ~FCF_FABRIC_DEVICE;
+				fcport->keep_nport_handle = 1;
 				if (vha->flags.nvme_enabled) {
 					fcport->fc4f_nvme = 1;
 					fcport->n2n_flag = 1;
-- 
2.20.1

