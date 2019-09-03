Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F9EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E20620578
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzlV5Y3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfICJCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:02:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38827 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfICJCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:02:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id w11so7632031plp.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 02:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=chnLX+5iIXcwerLGQG9r+UVsc2Dbf/r7ciZlTZZfaxM=;
        b=nzlV5Y3ji7qQ0aAndFBX5AaqDKpuKabFvVCc2+JWUeR0DvTI/MXKGdOLH8Ql5T/hgS
         lNEmiQe4o4BrzoQYcE5uuj3Dg8dHGuX/hgCrZVf5CY75MdLKSiIPNqBKqlt29LeH8bT0
         O20tFPUKCy9eVRv1VuOGoxXaIaIcssf1/KZK9qx4CZ/a/qfVAf6ZmYA6xbwvuGfKZrPO
         J6pF0DCANQxOgY2H5GH1Oa9mt8gUfoxhbLNFCIU4VhEM8ASs6N25TqY8BhAvcK5URf42
         35KDxmJkrdkMQgmIg+v8lZVnjMgLGvfs0vJHrRuObPIcp57jmlRIInu1DmG4glAqB39q
         JWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=chnLX+5iIXcwerLGQG9r+UVsc2Dbf/r7ciZlTZZfaxM=;
        b=gN/ol8dXFow/cOVweIjwNr4Dtlt7RV7HeW21WY26WldNWjLgM5+NYzoASZLGJDyinc
         yYe2vkfrziTAMTKuJUZd9sHbnJF6y4sge0vdIO29xze2fmpssMWVldSl3QfTBUtya/WM
         P8fi2Bf8BPIbKR4dOhPJzqza44JaECJ5Ia6LNrg3gwfs+C168Lwi6RmGji2ux+cBbAhC
         HmufBHXL0Vg8xb2X0fzAkav2/vXNtFeC2Qk5UpTmKRucJD1Ga6JLDupthG50XNfDoFij
         U0AJTjN4WQ1eKOJt+LRdSibrubvh3VBrTPF2m68zdLEIHbdRiRvlB1ErFFAKmuVSC1Yb
         8+zA==
X-Gm-Message-State: APjAAAWyKZ/cDSHlT9TlQubsBvuRBgNAtHN8LpFZpxPnVme6LhPwjfo4
        SnBbLxkYBRCQiYyhu2Lf1HbAumtFnp0=
X-Google-Smtp-Source: APXvYqy8Pc0k7syw8RXECdN/xfVnPbwOUeriVOkp53FTg2gIUnD9q4L18wUCp7YK8hytic/PDTXaYw==
X-Received: by 2002:a17:902:2f03:: with SMTP id s3mr22591562plb.333.1567501372125;
        Tue, 03 Sep 2019 02:02:52 -0700 (PDT)
Received: from MeraComputer ([117.220.112.100])
        by smtp.gmail.com with ESMTPSA id c15sm4278215pfi.172.2019.09.03.02.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 02:02:51 -0700 (PDT)
Date:   Tue, 3 Sep 2019 14:32:40 +0530
From:   Prakhar Sinha <prakharsinha2808@gmail.com>
To:     gregkh@linuxfoundation.org, tobias.niessen@stud.uni-hannover.de,
        kim.jamie.bradley@gmail.com, pakki001@umn.edu,
        sabrina-gaube@web.de, nishkadg.linux@gmail.com,
        qader.aymen@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: Modified nested if blocks.
Message-ID: <20190903090240.GA6104@MeraComputer>
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

