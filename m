Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9DDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B969520850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255936;
	bh=0aOZ4VlaHQcdtX1Hsb28Q4fN0uDst76Z4m5xp2AWuhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AJNb8wQYc1nmdqI7bfSICtRox7wlAs+4JbYK4p/IGlX5i1/ea8KL/Qma2PH9Z55cO
	 T2WYyyqlpvJGjEiAU7NwtyRsh597lqMQ6MoX90GqpW+kFkRWs08H6JJ7rUSYx13mwi
	 5Zu0sa68FsmQkcsgbJ7+qo6JPa3QzS72EB3bC2qA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387901AbfCVL6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387681AbfCVL6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:58:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A2462195D;
        Fri, 22 Mar 2019 11:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255930;
        bh=0aOZ4VlaHQcdtX1Hsb28Q4fN0uDst76Z4m5xp2AWuhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZrx90znNjjb9jh1bb9Xb29MPIUh7G/Ok4KlXtrL+wrm5iC7m3W2/TGEM9UyGulru
         m5tBw3mBga4xoXOqCspAMtuxUBweHjZsqG+5tUOsUnyjyXIaXiWDRJ2li/VAF9Zv1n
         lgjn+Gl1Eqh+qaZWdNroHlsYuS0vo/mHA5jhkxGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bill Kuzeja <william.kuzeja@stratus.com>,
        Giridhar Malavali <gmalavali@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 058/280] scsi: qla2xxx: Fix panic from use after free in qla2x00_async_tm_cmd
Date:   Fri, 22 Mar 2019 12:13:31 +0100
Message-Id: <20190322111309.531693685@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 388a49959ee4e4e99f160241d9599efa62cd4299 ]

In qla2x00_async_tm_cmd, we reference off sp after it has been freed.  This
caused a panic on a system running a slub debug kernel. Since fcport is
passed in anyways, just use that instead.

Signed-off-by: Bill Kuzeja <william.kuzeja@stratus.com>
Acked-by: Giridhar Malavali <gmalavali@marvell.com>
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 5352c9bbcaf7..2271a2cd29d2 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1719,13 +1719,13 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint32_t lun,
 
 		/* Issue Marker IOCB */
 		qla2x00_marker(vha, vha->hw->req_q_map[0],
-		    vha->hw->rsp_q_map[0], sp->fcport->loop_id, lun,
+		    vha->hw->rsp_q_map[0], fcport->loop_id, lun,
 		    flags == TCF_LUN_RESET ? MK_SYNC_ID_LUN : MK_SYNC_ID);
 	}
 
 done_free_sp:
 	sp->free(sp);
-	sp->fcport->flags &= ~FCF_ASYNC_SENT;
+	fcport->flags &= ~FCF_ASYNC_SENT;
 done:
 	return rval;
 }
-- 
2.19.1



