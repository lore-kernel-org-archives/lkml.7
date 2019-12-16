Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9271C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8788E206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521757;
	bh=PjRTivSThzWAPtY8BdWGvjX8V2EKIO+0ggdCBxpSkCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rR4d3RVYFnGQA6G5+girZ9AKsEc5Yn8+D4b0AGuspoLK913BFETyeDFFTCkDZkLnX
	 yS0NBY+B4EcgOh8sEgO6ncJP3cGGPCyVXlZZ4BhOQDYmkDPb5N8Mi8ZIebsGuPOWT3
	 FbjraO24TbnaNPKGwZP3V0hVt5pKoBheVpmu7kdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfLPSAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbfLPSAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:00:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7617D206B7;
        Mon, 16 Dec 2019 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519211;
        bh=PjRTivSThzWAPtY8BdWGvjX8V2EKIO+0ggdCBxpSkCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQcM2WvMEkFzk8MIHbXs+8EVg22+9mrg4zFUkOI1vdfu2grN1jjhnunIrvN+pP1aH
         DqRFOSpIMOkkLojlsTiyenyC+Nu3VZW0nvIhCV9nKVFQ7OcTXt7xR8BYje+d3xYQiW
         5w6XyHm38AI/hccX15sFdb0G6LaNmwzYx8Dx6aBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Himanshu Madhani <hmadhani@marvell.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 242/267] scsi: qla2xxx: Always check the qla2x00_wait_for_hba_online() return value
Date:   Mon, 16 Dec 2019 18:49:28 +0100
Message-Id: <20191216174915.811245126@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit e6803efae5acd109fad9f2f07dab674563441a53 ]

This patch fixes several Coverity complaints about not always checking
the qla2x00_wait_for_hba_online() return value.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Himanshu Madhani <hmadhani@marvell.com>
Reviewed-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_attr.c   | 3 ++-
 drivers/scsi/qla2xxx/qla_target.c | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 1844c2f594605..656253285db9d 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -652,7 +652,8 @@ qla2x00_sysfs_write_reset(struct file *filp, struct kobject *kobj,
 			break;
 		} else {
 			/* Make sure FC side is not in reset */
-			qla2x00_wait_for_hba_online(vha);
+			WARN_ON_ONCE(qla2x00_wait_for_hba_online(vha) !=
+				     QLA_SUCCESS);
 
 			/* Issue MPI reset */
 			scsi_block_requests(vha->host);
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 2f5658554275c..69ed544d80ef0 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -6394,7 +6394,8 @@ qlt_enable_vha(struct scsi_qla_host *vha)
 	} else {
 		set_bit(ISP_ABORT_NEEDED, &base_vha->dpc_flags);
 		qla2xxx_wake_dpc(base_vha);
-		qla2x00_wait_for_hba_online(base_vha);
+		WARN_ON_ONCE(qla2x00_wait_for_hba_online(base_vha) !=
+			     QLA_SUCCESS);
 	}
 }
 EXPORT_SYMBOL(qlt_enable_vha);
@@ -6424,7 +6425,9 @@ static void qlt_disable_vha(struct scsi_qla_host *vha)
 
 	set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
 	qla2xxx_wake_dpc(vha);
-	qla2x00_wait_for_hba_online(vha);
+	if (qla2x00_wait_for_hba_online(vha) != QLA_SUCCESS)
+		ql_dbg(ql_dbg_tgt, vha, 0xe081,
+		       "qla2x00_wait_for_hba_online() failed\n");
 }
 
 /*
-- 
2.20.1



