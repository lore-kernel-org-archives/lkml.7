Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46ACC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD8020880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkO3tnsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfDOOfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:35:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36340 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfDOOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:35:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so15921322ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=R9w+lMwydrd2rJKc+1WsBBJ4B//vBgjsNkW4w0MLHmI=;
        b=fkO3tnsSlRF4IDHqEQeatH8BUZb6khtcjEJEZ4skWfchv5LeLjkdJuXGINT5BX1QF4
         yb5E6H8rzn+Vy7mHnhJgIh/oBHpWmo4w5xMqWP9X/nIhY4lkROlIh7EGdFzeeEdSxr+L
         pVrK0C1ltAEdxaIFE1XD7P8FP/xsA2oUteVPfqkOvqVkqzA1JFiRsrMmclLheklDTF41
         B7hwiaoaXohAK7gNYQIAezECKvqFwJAKBOMtLXnZCrJkaU5DJ/g5VmF2YS1Njzdw5vyz
         vyIy766Zo0OCLKZ5Etlxiw4m6sudLIMZDl26cAWFFo1xmVMc5UnFd4dOGcHbrjrMsEVW
         TS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R9w+lMwydrd2rJKc+1WsBBJ4B//vBgjsNkW4w0MLHmI=;
        b=kJOCs4xr3lTxSJ87+Nr0UVcOsgl4Xcf0YoMywf5DgxAhwUdopvTtzJ6GBlXRcqr3Ly
         VwYMcdZM6U1ZYbJi6+9s5gb5JA/D8c/aIRQyGSoN5IAXRPh0996YqwQkLMhAA2sCkvGw
         Pnl/mC3RnrHkckwyZ2Dnx+11fQcwfVoqmRCFV1Ej/DVL/L0J+sA9Xf3D6NEegoOJ3l+Q
         IKWKQFaBgz95f5QsbeIXJDoDztjy1kGORn8psg1POgACal8dmYaRsgg7GTvMBfg+rXAP
         Ld+zhycZdeO/xGylZEpd4HrOJ6uMRZC70eaOdV9lIwSSTnT8Cv3dUudmoaOvOYJuAo/a
         +CPQ==
X-Gm-Message-State: APjAAAUL8l0skWbTIey2BVGRQZT8pA4OsJy8z+U5gkrmv2hy3gScYuq4
        J4c6gun8Q7bDYzw5HHfPSe4=
X-Google-Smtp-Source: APXvYqzCsIHTWOCNAP5pBD8G/bdKY35KsGrnzkarBbfyZRd2R/KADyrIF+aOlcxYn1uYkhw8wXufIw==
X-Received: by 2002:a05:651c:d0:: with SMTP id 16mr39853730ljr.150.1555338912513;
        Mon, 15 Apr 2019 07:35:12 -0700 (PDT)
Received: from localhost.localdomain (46-243-146.internethome.cytanet.com.cy. [46.199.243.146])
        by smtp.gmail.com with ESMTPSA id g26sm759568lfh.32.2019.04.15.07.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 07:35:11 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     benh@kernel.crashing.org
Cc:     gustavo@embeddedor.com, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: fsi: This patch fix the following checkpatch warning.
Date:   Mon, 15 Apr 2019 17:35:04 +0300
Message-Id: <1555338904-11183-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Documentation/timers/timers-howto.txt Msleep < 20ms can sleep for
up to 20ms. so use usleep_range.

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/fsi/fsi-master-ast-cf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 04d10ea..60eccc7 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -588,7 +588,7 @@ static int fsi_master_acf_xfer(struct fsi_master_acf *master, uint8_t slave,
 		dev_dbg(master->dev, "ECRC retry %d\n", retries);
 
 		/* Pace it a bit before retry */
-		msleep(1);
+		usleep_range(1000, 2000);
 	}
 
 	return rc;
@@ -690,9 +690,9 @@ static int fsi_master_acf_break(struct fsi_master *_master, int link)
 static void reset_cf(struct fsi_master_acf *master)
 {
 	regmap_write(master->scu, SCU_COPRO_CTRL, SCU_COPRO_RESET);
-	usleep_range(20,20);
+	usleep_range(15, 20);
 	regmap_write(master->scu, SCU_COPRO_CTRL, 0);
-	usleep_range(20,20);
+	usleep_range(15, 20);
 }
 
 static void start_cf(struct fsi_master_acf *master)
@@ -913,7 +913,7 @@ static int copro_enable_sw_irq(struct fsi_master_acf *master)
 		val = ioread32(master->cvic + CVIC_EN_REG);
 		if (val & 2)
 			break;
-		msleep(1);
+		usleep_range(1000, 2000);
 	}
 	if (!(val & 2)) {
 		dev_err(master->dev, "Failed to enable coprocessor interrupt !\n");
@@ -970,7 +970,7 @@ static int fsi_master_acf_setup(struct fsi_master_acf *master)
 		val = ioread8(master->sram + CF_STARTED);
 		if (val)
 			break;
-		msleep(1);
+		usleep_range(1000, 2000);
 	}
 	if (!val) {
 		dev_err(master->dev, "Coprocessor startup timeout !\n");
-- 
2.7.4

