Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D41C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 01:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B8A2166E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 01:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfFIB0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 21:26:44 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59942 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfFIB0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 21:26:44 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id BB01E27ACC; Sat,  8 Jun 2019 21:26:42 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Michael Schmitz" <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Message-Id: <6cf0ec0a917ddfcf39ea8c697c8d8f7d663e9db3.1560043151.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1560043151.git.fthain@telegraphics.com.au>
References: <cover.1560043151.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 1/7] Revert "scsi: ncr5380: Increase register polling
 limit"
Date:   Sun, 09 Jun 2019 11:19:11 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 4822827a69d7cd3bc5a07b7637484ebd2cf88db6.

The purpose of that commit was to suppress a timeout warning message
which appeared to be caused by target latency. But suppressing the warning
is undesirable as the warning may indicate a messed up transfer count.

Another problem with that commit is that 15 ms is too long to keep
interrupts disabled as interrupt latency can cause system clock drift
and other problems.

Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 4822827a69d7 ("scsi: ncr5380: Increase register polling limit")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/NCR5380.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/NCR5380.h b/drivers/scsi/NCR5380.h
index efca509b92b0..5935fd6d1a05 100644
--- a/drivers/scsi/NCR5380.h
+++ b/drivers/scsi/NCR5380.h
@@ -235,7 +235,7 @@ struct NCR5380_cmd {
 #define NCR5380_PIO_CHUNK_SIZE		256
 
 /* Time limit (ms) to poll registers when IRQs are disabled, e.g. during PDMA */
-#define NCR5380_REG_POLL_TIME		15
+#define NCR5380_REG_POLL_TIME		10
 
 static inline struct scsi_cmnd *NCR5380_to_scmd(struct NCR5380_cmd *ncmd_ptr)
 {
-- 
2.21.0

