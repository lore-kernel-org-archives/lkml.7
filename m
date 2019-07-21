Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C537DC76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 12:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C492085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 12:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfGUMvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 08:51:04 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:27701 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGUMvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 08:51:04 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d34 with ME
        id fQr0200024n7eLC03Qr03l; Sun, 21 Jul 2019 14:51:01 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2019 14:51:01 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     hare@suse.de, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] scsi: fcoe: fix a typo
Date:   Sun, 21 Jul 2019 14:50:39 +0200
Message-Id: <20190721125039.13268-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#define relative to FCOE CTLR start with FCOE_CTLR, except
FCOE_CTRL_SOL_TOV.

This is likely a typo and CTRL should be CTLR here as well.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 2 +-
 include/scsi/libfcoe.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 0d7770d07405..5aaa3298de6f 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -1019,7 +1019,7 @@ static void fcoe_ctlr_recv_adv(struct fcoe_ctlr *fip, struct sk_buff *skb)
 {
 	struct fcoe_fcf *fcf;
 	struct fcoe_fcf new;
-	unsigned long sol_tov = msecs_to_jiffies(FCOE_CTRL_SOL_TOV);
+	unsigned long sol_tov = msecs_to_jiffies(FCOE_CTLR_SOL_TOV);
 	int first = 0;
 	int mtu_valid;
 	int found = 0;
diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
index c50fb297e265..dc14b52577f7 100644
--- a/include/scsi/libfcoe.h
+++ b/include/scsi/libfcoe.h
@@ -31,7 +31,7 @@
  * FIP tunable parameters.
  */
 #define FCOE_CTLR_START_DELAY	2000	/* mS after first adv. to choose FCF */
-#define FCOE_CTRL_SOL_TOV	2000	/* min. solicitation interval (mS) */
+#define FCOE_CTLR_SOL_TOV	2000	/* min. solicitation interval (mS) */
 #define FCOE_CTLR_FCF_LIMIT	20	/* max. number of FCF entries */
 #define FCOE_CTLR_VN2VN_LOGIN_LIMIT 3	/* max. VN2VN rport login retries */
 
-- 
2.20.1

