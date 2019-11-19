Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC1BC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD280206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143703;
	bh=uTKsTivW0RpecLbaYmvvG3ITNtocrjUSNEeJ/vh93D8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sSYYImI4lqRurO6t0Yjy/CXFRJ0YDUH81vHBzDzoXxm4+9IBwRt0y9kO+cdkoeY9y
	 JhfYFnapcx/eRWxo/YPTpMkm3zkKClbhv6wB+697FYPhe4NcJOmQEunh1cFXrh3k6q
	 y8wzqvLf+QGE+zXqcDut/0xTbg4jZsDlyCKAYCcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfKSFbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:31:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbfKSFbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:31:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DF6B222DC;
        Tue, 19 Nov 2019 05:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141465;
        bh=uTKsTivW0RpecLbaYmvvG3ITNtocrjUSNEeJ/vh93D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MEQfAo9GDvkU0uNA1QzCqwNkH2olp3IMG0LFUjZv6w/LdGvIWk8nid/wZtqQRS5DC
         orj5FicgyiW03iOMsLMU6nR/r9xXbcaycOOQJ5fbawKONvVZWZLKa8dHErkRi6ky9R
         HrGqx+DyRJBrxd187rhnstrkUvd/Lgc8fPpa4c4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 169/422] scsi: qla2xxx: Fix iIDMA error
Date:   Tue, 19 Nov 2019 06:16:06 +0100
Message-Id: <20191119051409.370383818@linuxfoundation.org>
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
index 34ff4bbc8de10..d611cf722244c 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3277,7 +3277,7 @@ static void qla24xx_async_gpsc_sp_done(void *s, int res)
 			ql_dbg(ql_dbg_disc, vha, 0x2019,
 			    "GPSC command unsupported, disabling query.\n");
 			ha->flags.gpsc_supported = 0;
-			res = QLA_SUCCESS;
+			goto done;
 		}
 	} else {
 		switch (be16_to_cpu(ct_rsp->rsp.gpsc.speed)) {
@@ -3310,7 +3310,6 @@ static void qla24xx_async_gpsc_sp_done(void *s, int res)
 		    be16_to_cpu(ct_rsp->rsp.gpsc.speeds),
 		    be16_to_cpu(ct_rsp->rsp.gpsc.speed));
 	}
-done:
 	memset(&ea, 0, sizeof(ea));
 	ea.event = FCME_GPSC_DONE;
 	ea.rc = res;
@@ -3318,6 +3317,7 @@ done:
 	ea.sp = sp;
 	qla2x00_fcport_event_handler(vha, &ea);
 
+done:
 	sp->free(sp);
 }
 
-- 
2.20.1



