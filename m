Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D7EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE39D21823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142483;
	bh=Pa2DiUzIt5+WJpajolX0XfJiLPV7WRel0zK4pP7B+9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FfJvLeyT0aRYlt3vxrM7kwkI0CP0Gg39dTolUoI6YtUVD49GJx0QRHUT6bUZnUMrU
	 YJ6FZ7kwik5VHohgVGEpnw6SVTL90yCzaeVgOHd2GJYWUQrPKE3ACGE05rwACHRYoD
	 J7rWA4mXrwCyDX34LEsQlhi5yd7IqLpb+cIfUlfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfKSFsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:48:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731298AbfKSFr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:47:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EE6221939;
        Tue, 19 Nov 2019 05:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142476;
        bh=Pa2DiUzIt5+WJpajolX0XfJiLPV7WRel0zK4pP7B+9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AR7pTajYigN0W+i0R6s9UiVX3VSJ7exYUu2e/2fjuXv/dVMVPvaxAdnpNO92q40EV
         FBo4WqPuzGGe93aYgUgC5b74smyCiPtYdfc3nP43ILfSepQLI+KYeXHczTCoHhYdbt
         gPOp2fCsh3lE/dhpZTNBmSC/A8lIE79bYooUHf48=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 095/239] scsi: qla2xxx: Fix iIDMA error
Date:   Tue, 19 Nov 2019 06:18:15 +0100
Message-Id: <20191119051321.928479375@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quinn Tran <quinn.tran@cavium.com>

[ Upstream commit 8d9bf0a9a268f7ca0b811d6e6a1fc783afa5c746 ]

When switch responds with error for Get Port Speed Command (GPSC), driver
should not proceed with telling FW about the speed of the remote port.

Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_gs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 2a19ec0660cbb..1088038e6a418 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3033,7 +3033,7 @@ static void qla24xx_async_gpsc_sp_done(void *s, int res)
 			ql_dbg(ql_dbg_disc, vha, 0x2019,
 			    "GPSC command unsupported, disabling query.\n");
 			ha->flags.gpsc_supported = 0;
-			res = QLA_SUCCESS;
+			goto done;
 		}
 	} else {
 		switch (be16_to_cpu(ct_rsp->rsp.gpsc.speed)) {
@@ -3066,13 +3066,13 @@ static void qla24xx_async_gpsc_sp_done(void *s, int res)
 		    be16_to_cpu(ct_rsp->rsp.gpsc.speeds),
 		    be16_to_cpu(ct_rsp->rsp.gpsc.speed));
 	}
-done:
 	memset(&ea, 0, sizeof(ea));
 	ea.event = FCME_GPSC_DONE;
 	ea.rc = res;
 	ea.fcport = fcport;
 	qla2x00_fcport_event_handler(vha, &ea);
 
+done:
 	sp->free(sp);
 }
 
-- 
2.20.1



