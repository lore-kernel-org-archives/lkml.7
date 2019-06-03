Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80705C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0F32816A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfFCLt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:49:26 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:44226 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbfFCLt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:49:26 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jun 2019 07:49:24 EDT
Received: from h2730561.stratoserver.net (h2730561.stratoserver.net [85.214.29.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 90CDA1F41F;
        Mon,  3 Jun 2019 13:44:11 +0200 (CEST)
From:   =?UTF-8?q?Tobias=20Nie=C3=9Fen?= 
        <tobias.niessen@stud.uni-hannover.de>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de,
        =?UTF-8?q?Tobias=20Nie=C3=9Fen?= 
        <tobias.niessen@stud.uni-hannover.de>,
        Sabrina Gaube <sabrina-gaube@web.de>
Subject: [PATCH] Improve code style in drivers/staging/rts5208
Date:   Mon,  3 Jun 2019 13:43:50 +0200
Message-Id: <20190603114350.32242-1-tobias.niessen@stud.uni-hannover.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes to sd.c and xd.c slightly improve the code style and
reduce the overall line length.

Signed-off-by: Tobias Nießen <tobias.niessen@stud.uni-hannover.de>
Signed-off-by: Sabrina Gaube <sabrina-gaube@web.de>
---
 drivers/staging/rts5208/sd.c | 23 +++++++++++------------
 drivers/staging/rts5208/xd.c |  8 ++++----
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index c256a2398651..d654a698142f 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -4512,20 +4512,19 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			sd_lock_state, sd_card->sd_lock_status);
 		if (sd_lock_state ^ (sd_card->sd_lock_status & SD_LOCKED)) {
 			sd_card->sd_lock_notify = 1;
-			if (sd_lock_state) {
-				if (sd_card->sd_lock_status & SD_LOCK_1BIT_MODE) {
-					sd_card->sd_lock_status |= (
-						SD_UNLOCK_POW_ON | SD_SDR_RST);
-					if (CHK_SD(sd_card)) {
-						retval = reset_sd(chip);
-						if (retval != STATUS_SUCCESS) {
-							sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
-							goto sd_execute_write_cmd_failed;
-						}
+			if (sd_lock_state &&
+			    (sd_card->sd_lock_status & SD_LOCK_1BIT_MODE)) {
+				sd_card->sd_lock_status |= (
+					SD_UNLOCK_POW_ON | SD_SDR_RST);
+				if (CHK_SD(sd_card)) {
+					retval = reset_sd(chip);
+					if (retval != STATUS_SUCCESS) {
+						sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
+						goto sd_execute_write_cmd_failed;
 					}
-
-					sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
 				}
+
+				sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
 			}
 		}
 	}
diff --git a/drivers/staging/rts5208/xd.c b/drivers/staging/rts5208/xd.c
index c5ee04ecd1c9..f3dc96a4c59d 100644
--- a/drivers/staging/rts5208/xd.c
+++ b/drivers/staging/rts5208/xd.c
@@ -1155,10 +1155,10 @@ static int xd_copy_page(struct rtsx_chip *chip, u32 old_blk, u32 new_blk,
 					return STATUS_FAIL;
 				}
 
-				if (((reg & (XD_ECC1_ERROR | XD_ECC1_UNCORRECTABLE)) ==
-						(XD_ECC1_ERROR | XD_ECC1_UNCORRECTABLE)) ||
-					((reg & (XD_ECC2_ERROR | XD_ECC2_UNCORRECTABLE)) ==
-						(XD_ECC2_ERROR | XD_ECC2_UNCORRECTABLE))) {
+				if (((reg & XD_ECC1_ERROR) &&
+				     (reg & XD_ECC1_UNCORRECTABLE)) ||
+				    ((reg & XD_ECC2_ERROR) &&
+				     (reg & XD_ECC2_UNCORRECTABLE))) {
 					rtsx_write_register(chip,
 							    XD_PAGE_STATUS,
 							    0xFF,
-- 
2.17.0

