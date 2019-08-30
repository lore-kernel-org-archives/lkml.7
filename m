Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E03AC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B9D2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfH3IKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 04:10:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45846 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfH3IKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:10:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i3bzb-0004jm-CD; Fri, 30 Aug 2019 08:10:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: remove redundant sd30_mode checks
Date:   Fri, 30 Aug 2019 09:10:47 +0100
Message-Id: <20190830081047.13630-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two hunks of code that check if sd30_mode is true however
an earlier check in an outer code block on sd30_mode being false means
that sd30_mode can never be true at these points so these checks are
redundant.  Remove the dead code.

Addresses-Coverity: ("Logically dead code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rts5208/sd.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index a06045344301..25c31496757e 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -2573,17 +2573,13 @@ static int reset_sd(struct rtsx_chip *chip)
 			retval = sd_sdr_tuning(chip);
 
 		if (retval != STATUS_SUCCESS) {
-			if (sd20_mode) {
+			retval = sd_init_power(chip);
+			if (retval != STATUS_SUCCESS)
 				goto status_fail;
-			} else {
-				retval = sd_init_power(chip);
-				if (retval != STATUS_SUCCESS)
-					goto status_fail;
 
-				try_sdio = false;
-				sd20_mode = true;
-				goto switch_fail;
-			}
+			try_sdio = false;
+			sd20_mode = true;
+			goto switch_fail;
 		}
 
 		sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
@@ -2598,17 +2594,13 @@ static int reset_sd(struct rtsx_chip *chip)
 		if (read_lba0) {
 			retval = sd_read_lba0(chip);
 			if (retval != STATUS_SUCCESS) {
-				if (sd20_mode) {
+				retval = sd_init_power(chip);
+				if (retval != STATUS_SUCCESS)
 					goto status_fail;
-				} else {
-					retval = sd_init_power(chip);
-					if (retval != STATUS_SUCCESS)
-						goto status_fail;
 
-					try_sdio = false;
-					sd20_mode = true;
-					goto switch_fail;
-				}
+				try_sdio = false;
+				sd20_mode = true;
+				goto switch_fail;
 			}
 		}
 	}
-- 
2.20.1

