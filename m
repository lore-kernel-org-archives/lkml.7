Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF23C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB722082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520449;
	bh=qC2dGsy8YPSNHCGZduahSOXJzmMdZKrBI2F3JvshQok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kSSbYVZF4fRN7UhYgi1qqUeHBh9ExMpnWy7mRPtaaWgAAeC1GSFw7xvQbvcGk77Dy
	 I5pAoILUuyKchoZQBP1KDt2V3vYDMbJCfinfmKGT7YXaZbEcdeHf9c7q1ZlIdecreM
	 ru3GQeRNfJvR/1aMAfdwmC5ysOQhXuDmHWd89Ems=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbfLPSUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:20:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732131AbfLPSUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:20:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DC522082E;
        Mon, 16 Dec 2019 18:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520443;
        bh=qC2dGsy8YPSNHCGZduahSOXJzmMdZKrBI2F3JvshQok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uR2EAa5729BGWVaNHqPNbgU492yVKEOcqWANFxn5FIqhyo0g1lEW1ui8erpjiF6xd
         1GjsHMCB3NsMKeINdurqXctkFIe+FzeCSt3RlYTlZF/3cPQ7vKhVOFrCIJz/Tl1gsb
         Njrai6Vh9fxwMgqOfYDCLi2PqdVUQdZl1YvhQEfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 157/177] Revert "scsi: qla2xxx: Fix memory leak when sending I/O fails"
Date:   Mon, 16 Dec 2019 18:50:13 +0100
Message-Id: <20191216174848.732122292@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin K. Petersen <martin.petersen@oracle.com>

[ Upstream commit 5a993e507ee65a28eca6690ee11868555c4ca46b ]

This reverts commit 2f856d4e8c23f5ad5221f8da4a2f22d090627f19.

This patch was found to introduce a double free regression. The issue
it originally attempted to address was fixed in patch
f45bca8c5052 ("scsi: qla2xxx: Fix double scsi_done for abort path").

Link: https://lore.kernel.org/r/4BDE2B95-835F-43BE-A32C-2629D7E03E0A@marvell.com
Requested-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 0bbc6a82470a5..06037e3c78549 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -909,8 +909,6 @@ qla2xxx_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 
 qc24_host_busy_free_sp:
 	sp->free(sp);
-	CMD_SP(cmd) = NULL;
-	qla2x00_rel_sp(sp);
 
 qc24_target_busy:
 	return SCSI_MLQUEUE_TARGET_BUSY;
@@ -994,8 +992,6 @@ qla2xxx_mqueuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd,
 
 qc24_host_busy_free_sp:
 	sp->free(sp);
-	CMD_SP(cmd) = NULL;
-	qla2xxx_rel_qpair_sp(sp->qpair, sp);
 
 qc24_target_busy:
 	return SCSI_MLQUEUE_TARGET_BUSY;
-- 
2.20.1



