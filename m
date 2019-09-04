Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4014C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4762186A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4YK1Gs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfIDNFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:05:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39104 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbfIDNFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:05:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so11225693pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 06:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qk0OuOrMg5tOAzN4rz02JAWnOMG6qE8NiffpgXWoJIA=;
        b=N4YK1Gs2/2Z5emAWr4rJ6LlOxnQIH/unOWSowk+HvjjBI420gcZERK249bDAeb3iQZ
         qhloqYi6Evcw8E6l2PHMJMkjYXJ0IgTIkxxVYG1bl5JhspLW5beXsOBpYB/cTm4mdhxv
         KujH3nGRXzNVcjeNXxE8If5Xs2mQlgL7uhfaKqw/uhQvyOdQAKG0Pxhaq13E1FroDukE
         8/JVfclzHgbNMCMyPys4IsLG56WLWFLUg4t9jv7gIkiI35IC9RDBpwGxrRgIeLxHZ55k
         GaAAKaZPEPJBEjoC9YLo2JMb3n98QpYnnHdYND4fMtXBS+AwE0vlqvy2zkOcWLHyHV1Z
         TyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qk0OuOrMg5tOAzN4rz02JAWnOMG6qE8NiffpgXWoJIA=;
        b=pw5EmW8zz7WdFmVZKXmmiGTgEYaks3V9bIGrZqVSsqFeVvwlkwigf6L2FeHQE0EHhd
         POSL8DouUnvlU/k3yBw+lqKMrm2m1rk9W6ZZYzLfZOCcTuJdtYhavJyCI+/WpyMbH8so
         giRJYredrP+Z/UIZ7yx2kxygG/VfU3jK3XmmWcebrKisIy14Ge/HIe5lrzQXiO8x2Kal
         xO4TlABWj9b3W5lpaycdDDUypB9qVbviG4BTnKL4lJqNFbA90IhdanKIxFWc63EqlkQE
         XRUr3TKno1tFB9zgh218f3dBRa4VePiCBL/KsxooTYMbxS8NIaFdl6YJuevToD58/xz0
         5i1Q==
X-Gm-Message-State: APjAAAUF7krt7powGLhSgoSx1Dm8QQQ18Y5D3Qmbf0KA4aFbKcsGzaiT
        15qaAhKg0Kd4LH/RKv6PI5I=
X-Google-Smtp-Source: APXvYqyr1WQwei2qjMxwIDgD3cmeL28e2tXbuoEH2pJa/xjAC5DFJbtgv41/0opqn3xvXL7seEGsvQ==
X-Received: by 2002:a65:621a:: with SMTP id d26mr28659658pgv.153.1567602337098;
        Wed, 04 Sep 2019 06:05:37 -0700 (PDT)
Received: from MeraComputer ([117.220.112.100])
        by smtp.gmail.com with ESMTPSA id h12sm26159377pgr.8.2019.09.04.06.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 06:05:36 -0700 (PDT)
Date:   Wed, 4 Sep 2019 18:35:23 +0530
From:   Prakhar Sinha <prakharsinha2808@gmail.com>
To:     gregkh@linuxfoundation.org, tobias.niessen@stud.uni-hannover.de,
        kim.jamie.bradley@gmail.com, pakki001@umn.edu,
        sabrina-gaube@web.de, nishkadg.linux@gmail.com,
        qader.aymen@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: Fix 80 char warning by re-structuring
 if-blocks.
Message-ID: <20190904130523.GA17126@MeraComputer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch solves the following checkpatch.pl's messages in
drivers/staging/rts5208/sd.c

WARNING: line over 80 characters
4517: FILE: drivers/staging/rts5208/sd.c:4517:
+                                               sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);

WARNING: line over 80 characters
4518: FILE: drivers/staging/rts5208/sd.c:4518:
+                                               goto sd_execute_write_cmd_failed;

WARNING: line over 80 characters
4522: FILE: drivers/staging/rts5208/sd.c:4522:
+                               sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);

Signed-off-by: Prakhar Sinha <prakharsinha2808@gmail.com>
---
 drivers/staging/rts5208/sd.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index a06045344301..7d6f2c56e740 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -4505,22 +4505,20 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 		dev_dbg(rtsx_dev(chip), "sd_lock_state = 0x%x, sd_card->sd_lock_status = 0x%x\n",
 			sd_lock_state, sd_card->sd_lock_status);
-		if (sd_lock_state ^ (sd_card->sd_lock_status & SD_LOCKED)) {
+		if (sd_lock_state ^ (sd_card->sd_lock_status & SD_LOCKED))
 			sd_card->sd_lock_notify = 1;
-			if (sd_lock_state &&
-			    (sd_card->sd_lock_status & SD_LOCK_1BIT_MODE)) {
-				sd_card->sd_lock_status |= (
-					SD_UNLOCK_POW_ON | SD_SDR_RST);
-				if (CHK_SD(sd_card)) {
-					retval = reset_sd(chip);
-					if (retval != STATUS_SUCCESS) {
-						sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
-						goto sd_execute_write_cmd_failed;
-					}
-				}
-
-				sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
+		if ((sd_lock_state & !(sd_card->sd_lock_status & SD_LOCKED)) &&
+		    (sd_card->sd_lock_status & SD_LOCK_1BIT_MODE)) {
+			sd_card->sd_lock_status |= (SD_UNLOCK_POW_ON |
+						    SD_SDR_RST);
+			if (CHK_SD(sd_card) &&
+			    reset_sd(chip) != STATUS_SUCCESS) {
+				sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON |
+							     SD_SDR_RST);
+				goto sd_execute_write_cmd_failed;
 			}
+			sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON |
+						     SD_SDR_RST);
 		}
 	}
 
-- 
2.20.1

