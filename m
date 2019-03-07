Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50C7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B7320684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfCGVwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:52:22 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48994 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfCGVwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:52:22 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 60A8C22C02; Thu,  7 Mar 2019 16:52:19 -0500 (EST)
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Michael Schmitz" <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <4e853f171366e040818346def7fb043347670662.1551995342.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] scsi/NCR5380: Avoid compiler warning when
 -Wimplicit-fallthrough is enabled
Date:   Fri, 08 Mar 2019 08:49:02 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust comments accordingly.

Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/NCR5380.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 7fed9bb72784..fe0535affc14 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -1932,13 +1932,13 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 					if (!hostdata->connected)
 						return;
 
-					/* Fall through to reject message */
-
+					/* Reject message */
+					/* Fall through */
+				default:
 					/*
 					 * If we get something weird that we aren't expecting,
-					 * reject it.
+					 * log it.
 					 */
-				default:
 					if (tmp == EXTENDED_MESSAGE)
 						scmd_printk(KERN_INFO, cmd,
 						            "rejecting unknown extended message code %02x, length %d\n",
-- 
2.19.2

