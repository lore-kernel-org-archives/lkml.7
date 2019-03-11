Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C91C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4982064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334725;
	bh=/iERYPKb8IgX8b6MUHvfM5zqGZG/K2jaz4lnEbsWOS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NzbeUJGO7fxI6OihKQTzRsoG7QrGYJd236TlmEJ7goIADYibOwF87Zw6YhLRTEfvf
	 YfsdY49Cyi0pXCohOloD4sM3p5qltm4FEf35uPbchPt3wdiJ+EkjnFtJmHqC3v/194
	 XCrf5lgZqf4LejWrSnM6UNAS2uIJ2gOrb2lYheos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfCKUFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbfCKT6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:58:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8411217D4;
        Mon, 11 Mar 2019 19:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334287;
        bh=/iERYPKb8IgX8b6MUHvfM5zqGZG/K2jaz4lnEbsWOS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTWDQgkqZOwZFhMZ/9X8XAP9NvqE54KUhOTLnRqEfhfkUug9+t8At7Ccdtw1ZCnm8
         eEJsGAXQqsQNOzHM3yAI5oiG4Z5eocEi10ee6jVX3nQJYOE91c95XWth62yJ09bIBG
         1rdjQqMjCURx+96CYNT87t+q/LyiuoZDs+Fpnmtw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bill Kuzeja <William.Kuzeja@stratus.com>,
        Bill Kuzeja <william.kuzeja@stratus.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 36/44] scsi: qla2xxx: Fix panic from use after free in qla2x00_async_tm_cmd
Date:   Mon, 11 Mar 2019 15:56:52 -0400
Message-Id: <20190311195700.138462-36-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bill Kuzeja <William.Kuzeja@stratus.com>

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

