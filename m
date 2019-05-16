Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBB2C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBE820675
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sC/WkwjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfEPOiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:38:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41957 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfEPOiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:38:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id f12so1725258plt.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bGUs/J4ZxiFyXk4eO3sDQIKqJUCedWLILRfaUclL2/Y=;
        b=sC/WkwjR33PZUVed7uP7L9zMFVBpTQrUdiTlN8agMzjuO+T1b/d6Z8AQmbArPZFyyF
         IkCQUx/uJDqg2pbTwchBp73TkJoTpCBQprp1YaEF9pnnhclOcBKlh0+ggoifk8jg9PxH
         cvoB1nj4X3QnncMn7h6udxygwNGlVk1hSTDqGxTBajqvUOTyjrjSUSeRFMf7emsl9sep
         J9fBu2UUW/NMx7ZHA9E7kiVTGQJ8M1ypJ21+idAesU7YGDEOj2yM/WCuCl3pvqHijslU
         Mgl9sOGZSiOeVO3+HeqmxEGp/MhM32oeutTByAdfjHHJ7litDyImYWZpKaOYc1FlF5mB
         Zk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bGUs/J4ZxiFyXk4eO3sDQIKqJUCedWLILRfaUclL2/Y=;
        b=FhSy8vMN68mrQyORq/2nPosZ5DLbDszYtd7gZ6u1BbQIJ9NUc1rTydTep/l11qcG+3
         bsXG0C8bxDHUGGag79hYGrMzd8EZS/pEA0fZn4EHrP9ugruQ0A08ZtCqLKlVxBo6/f3x
         xVP6dBx1EcTwu3GT4NDxeeh6+SRN6xPIackdkwbTstOcELRrfQZT9t9lr6v4nx0q2bIK
         adKW5MHGOzp8+gnM1p2E7zfwO3HDrUfa2rY22WEajX7pCCiuWd7lOyRuwlBXTIfArFh9
         k92c3s7j3wffPuQEm921gzB54dTWKJQ0JCRtAEG/DTZJpbzBAXsFk16yWQi4joMzCaMM
         R0HA==
X-Gm-Message-State: APjAAAVszRqCnoojikS4vXGUc538is1AKpcK04YCeLruWy71v3jk1CjR
        daBEwYdgREcg19l5rU0p7cE=
X-Google-Smtp-Source: APXvYqwf9a1Ye6NROYyk9Mq1T9g5S0miA9+zUN1G3gjzMbPGvw/UISiMl8y446GVEfYEF/vRs/PHVw==
X-Received: by 2002:a17:902:f208:: with SMTP id gn8mr51429880plb.312.1558017530250;
        Thu, 16 May 2019 07:38:50 -0700 (PDT)
Received: from hydra-Latitude-E5440.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id e78sm13954579pfh.134.2019.05.16.07.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 07:38:49 -0700 (PDT)
From:   parna.naveenkumar@gmail.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Subject: [PATCH] char: misc: Move EXPORT_SYMBOL immediately next to the functions/varibles
Date:   Thu, 16 May 2019 20:08:32 +0530
Message-Id: <20190516143832.15856-1-parna.naveenkumar@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>

According to checkpatch: EXPORT_SYMBOL(foo); should immediately follow its
function/variable.

This patch fixes the following checkpatch.pl issues in drivers/char/misc.c:
WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable

Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
---
 drivers/char/misc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 53cfe574d8d4..f6a147427029 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -226,6 +226,7 @@ int misc_register(struct miscdevice *misc)
 	mutex_unlock(&misc_mtx);
 	return err;
 }
+EXPORT_SYMBOL(misc_register);
 
 /**
  *	misc_deregister - unregister a miscellaneous device
@@ -249,8 +250,6 @@ void misc_deregister(struct miscdevice *misc)
 		clear_bit(i, misc_minors);
 	mutex_unlock(&misc_mtx);
 }
-
-EXPORT_SYMBOL(misc_register);
 EXPORT_SYMBOL(misc_deregister);
 
 static char *misc_devnode(struct device *dev, umode_t *mode)
-- 
2.17.1

