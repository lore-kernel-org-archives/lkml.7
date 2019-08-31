Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D735C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 07:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE54E2342E
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 07:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c013Ad8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfHaHlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 03:41:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33466 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfHaHlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 03:41:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id go14so4365512plb.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 00:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=chnLX+5iIXcwerLGQG9r+UVsc2Dbf/r7ciZlTZZfaxM=;
        b=c013Ad8yHXrmAwiNw5iVbA4XJlDGivjPRePYXI9dNS61w7oMN8cyokGOXoxgcrbI47
         IbuGqLmCdrf5V9lLG0hfIO74OpBCRGSRw7KkNSPhODI8Y6ewmE00fLkCFOKa3T2Hqa82
         /k7guerGe0N2XcMInzfYqd7frtmcRGRRJ1Cca3DwwA6md1SLuCKYhCwT0VjzGVsA6jMt
         eKn6WkSy0KrJ9Crgzs3kDmfSs0iC0roIqUkeQtBUZyirAm4YrAIyVBCCm2yjmanhH6wQ
         k20EwuJ2JCFCYiefeygA3J3cu6f9L2Ci6bKxYN8e2SHss7LRpTmUdgVfajS2RK9bN4in
         fFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=chnLX+5iIXcwerLGQG9r+UVsc2Dbf/r7ciZlTZZfaxM=;
        b=erIdL+rnvi9tDuusqxcZzu+SIBJ+IsinwFW7WUL5KDOfsQnt7AgpEtPWf5NNiwdT3x
         XX9beitvcn8tLJwg81Psa4NcRc1/WPNgz6H6qRTpSy+MV2Czg7YkSux5G2vdYiWgJZ3e
         2lCSUlzpkAgWp2WJT+vXRpW/MwdrzdbQ1Rp7rYrtVWQs0s9mk7TVmZ+22s/rrLP5QFhy
         Tn9O3jAElJkNqYpkIBjzCrWhlxBB56TC0jzJUSAzfqC/0q0xPk20XGdhgdukUW0JIuzi
         iEDc1w3eVWkQHNonjJLJR/9WAAUAmywXUqzcRA6gKwFytcS9wr2yclfYK5w8mfLxMro0
         Njog==
X-Gm-Message-State: APjAAAW2eWhAzt8D/EnxZXNtFpJjlg7SAZd+jjmA84GP/yGUmxt0fShs
        TFR4xPjKhgFdxOmi1avjUeg=
X-Google-Smtp-Source: APXvYqwjFvvwezds47QrplR/PAzW94gzq1A5Vm/569IXQmNEszQ7QBsL9KdmlrszNriNG33UAQsV8A==
X-Received: by 2002:a17:902:d24:: with SMTP id 33mr19860676plu.133.1567237266794;
        Sat, 31 Aug 2019 00:41:06 -0700 (PDT)
Received: from MeraComputer ([117.220.112.100])
        by smtp.gmail.com with ESMTPSA id q132sm1526341pfq.16.2019.08.31.00.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 00:41:05 -0700 (PDT)
Date:   Sat, 31 Aug 2019 13:10:55 +0530
From:   Prakhar Sinha <prakharsinha2808@gmail.com>
To:     gregkh@linuxfoundation.org, tobias.niessen@stud.uni-hannover.de,
        kim.jamie.bradley@gmail.com, pakki001@umn.edu,
        sabrina-gaube@web.de, nishkadg.linux@gmail.com,
        qader.aymen@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: Fixed checkpatch warning.
Message-ID: <20190831074055.GA10177@MeraComputer>
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
+                                               sd_card->sd_lock_status &=
~(SD_UNLOCK_POW_ON | SD_SDR_RST);

WARNING: line over 80 characters
4518: FILE: drivers/staging/rts5208/sd.c:4518:
+                                               goto
sd_execute_write_cmd_failed;

WARNING: line over 80 characters
4522: FILE: drivers/staging/rts5208/sd.c:4522:
+                               sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON |
SD_SDR_RST);

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

