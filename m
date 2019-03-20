Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFC8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCAA21925
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfCTUbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:31:44 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.31]:29446 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbfCTUbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:31:44 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 10C5911D5E3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:31:44 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 6hsGhhhrd2PzO6hsGh2HNh; Wed, 20 Mar 2019 15:31:44 -0500
X-Authority-Reason: nr=8
Received: from [189.250.104.39] (port=37774 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1h6hsC-003xLg-BB; Wed, 20 Mar 2019 15:31:42 -0500
Date:   Wed, 20 Mar 2019 15:31:39 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] scsi: mptscsih: Mark expected switch fall-throughs
Message-ID: <20190320203139.GA18369@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.104.39
X-Source-L: No
X-Exim-ID: 1h6hsC-003xLg-BB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.104.39]:37774
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 66
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/message/fusion/mptscsih.c: In function ‘mptscsih_io_done’:
drivers/message/fusion/mptscsih.c:741:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if ( ioc->bus_type == SAS ) {
       ^
drivers/message/fusion/mptscsih.c:790:3: note: here
   case MPI_IOCSTATUS_SCSI_TASK_TERMINATED: /* 0x0048 */
   ^~~~
drivers/message/fusion/mptscsih.c:884:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
    scsi_set_resid(sc, 0);
    ^~~~~~~~~~~~~~~~~~~~~
drivers/message/fusion/mptscsih.c:885:3: note: here
   case MPI_IOCSTATUS_SCSI_RECOVERED_ERROR: /* 0x0040 */
   ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/message/fusion/mptscsih.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/mptscsih.c
index 587b5daf74b4..f0737c57ed5f 100644
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -786,6 +786,7 @@ mptscsih_io_done(MPT_ADAPTER *ioc, MPT_FRAME_HDR *mf, MPT_FRAME_HDR *mr)
 			/*
 			 * Allow non-SAS & non-NEXUS_LOSS to drop into below code
 			 */
+			/* Fall through */
 
 		case MPI_IOCSTATUS_SCSI_TASK_TERMINATED:	/* 0x0048 */
 			/* Linux handles an unsolicited DID_RESET better
@@ -882,6 +883,7 @@ mptscsih_io_done(MPT_ADAPTER *ioc, MPT_FRAME_HDR *mf, MPT_FRAME_HDR *mr)
 
 		case MPI_IOCSTATUS_SCSI_DATA_OVERRUN:		/* 0x0044 */
 			scsi_set_resid(sc, 0);
+			/* Fall through */
 		case MPI_IOCSTATUS_SCSI_RECOVERED_ERROR:	/* 0x0040 */
 		case MPI_IOCSTATUS_SUCCESS:			/* 0x0000 */
 			sc->result = (DID_OK << 16) | scsi_status;
-- 
2.21.0

