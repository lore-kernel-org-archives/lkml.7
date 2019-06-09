Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3B5C28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 01:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC5E2166E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 01:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfFIB1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 21:27:00 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59996 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfFIB0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 21:26:45 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 0D0C527ACE; Sat,  8 Jun 2019 21:26:43 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Michael Schmitz" <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <825f9cc5f8887f0d32274442ea7b21449b48f27c.1560043151.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1560043151.git.fthain@telegraphics.com.au>
References: <cover.1560043151.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 7/7] scsi: mac_scsi: Treat Last Byte Sent time-out as
 failure
Date:   Sun, 09 Jun 2019 11:19:11 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A system bus error during a PDMA send operation can result in bytes being
lost. Theoretically that could cause the target to remain in DATA OUT
phase and the initiator (expecting a phase change) would time-out waiting
for the Last Byte Sent flag. Should that happen, fail the transfer so the
core driver will stop using PDMA with this target.

Cc: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/mac_scsi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mac_scsi.c b/drivers/scsi/mac_scsi.c
index 8fbec1768bbf..658a719cfcba 100644
--- a/drivers/scsi/mac_scsi.c
+++ b/drivers/scsi/mac_scsi.c
@@ -360,9 +360,12 @@ static inline int macscsi_pwrite(struct NCR5380_hostdata *hostdata,
 		if (hostdata->pdma_residual == 0) {
 			if (NCR5380_poll_politely(hostdata, TARGET_COMMAND_REG,
 			                          TCR_LAST_BYTE_SENT,
-			                          TCR_LAST_BYTE_SENT, HZ / 64) < 0)
+			                          TCR_LAST_BYTE_SENT,
+			                          HZ / 64) < 0) {
 				scmd_printk(KERN_ERR, hostdata->connected,
 				            "%s: Last Byte Sent timeout\n", __func__);
+				result = -1;
+			}
 			goto out;
 		}
 
-- 
2.21.0

