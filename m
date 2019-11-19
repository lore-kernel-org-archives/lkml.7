Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE6DC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B7421939
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141482;
	bh=YTlxT0xhObld43kZ6Inn0eRYl+hSodKE+Pd8IjkbeNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=imOYH3xqzOW/qy3r7bxJVBX3Gqs5tUdP1lMdIFw/qP8idsLal4N37LP/1R3J46G5x
	 7651VVp16opN12o4AjuXNLLgBcgCKS3xYD4g5J/pfasmZ6fSdCFsY5Y7TGpdEmMahG
	 xnZJFJVlsmMA223HLt7/IJT44PSFBRdwlfXNAbTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfKSFbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:31:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729239AbfKSFbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:31:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2776121783;
        Tue, 19 Nov 2019 05:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141477;
        bh=YTlxT0xhObld43kZ6Inn0eRYl+hSodKE+Pd8IjkbeNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrF4i6A0mwfzdjukKIzFgohC1+jDLrKewGvMVT9tbnGbYzkOeSEP4DBaucqniy32L
         eIwSlOQJnGu+hvZQjCxx5HSC9EpV+PGJbRPU6NyrDfGqkyPk94cfgAMziwYZEnWF9P
         6Ql+ilaFu/txx72cQZkFFY25xU820fj1Nisks+fM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 173/422] scsi: qla2xxx: Increase abort timeout value
Date:   Tue, 19 Nov 2019 06:16:10 +0100
Message-Id: <20191119051409.638874617@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quinn Tran <quinn.tran@cavium.com>

[ Upstream commit 8bccfe0d21b5adbba6ec4fe1776160b80d09f78a ]

Abort IOCB request can take up to 40s or 2 ABTS timeout.  We will wait for
ABTS response for 20s. On a timeout, second ABTS can go out with another 20s
timeout. On 2nd ABTS timeout FW will automatically do Logout.

Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 733a55c09b1ca..8f502505aa796 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1789,7 +1789,8 @@ qla24xx_async_abort_cmd(srb_t *cmd_sp, bool wait)
 
 	abt_iocb->timeout = qla24xx_abort_iocb_timeout;
 	init_completion(&abt_iocb->u.abt.comp);
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha));
+	/* FW can send 2 x ABTS's timeout/20s */
+	qla2x00_init_timer(sp, 42);
 
 	abt_iocb->u.abt.cmd_hndl = cmd_sp->handle;
 	abt_iocb->u.abt.req_que_no = cpu_to_le16(cmd_sp->qpair->req->id);
-- 
2.20.1



