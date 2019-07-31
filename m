Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC12C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD23220679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfGaWtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:49:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55159 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfGaWtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:49:55 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hsxPq-000199-TB; Wed, 31 Jul 2019 22:49:51 +0000
From:   Colin King <colin.king@canonical.com>
To:     Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: snic: remove redundant assignment to variable ret
Date:   Wed, 31 Jul 2019 23:49:50 +0100
Message-Id: <20190731224950.16818-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable ret is being assigned with a value that is never read as
there is return statement immediately afterwards.  The assignment
is redundant and hence can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/snic/snic_disc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/snic/snic_disc.c b/drivers/scsi/snic/snic_disc.c
index e9ccfb97773f..d89c75991323 100644
--- a/drivers/scsi/snic/snic_disc.c
+++ b/drivers/scsi/snic/snic_disc.c
@@ -261,8 +261,6 @@ snic_tgt_create(struct snic *snic, struct snic_tgt_id *tgtid)
 	tgt = kzalloc(sizeof(*tgt), GFP_KERNEL);
 	if (!tgt) {
 		SNIC_HOST_ERR(snic->shost, "Failure to allocate snic_tgt.\n");
-		ret = -ENOMEM;
-
 		return tgt;
 	}
 
-- 
2.20.1

