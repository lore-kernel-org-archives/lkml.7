Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2C5C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 04:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DBC2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 04:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWvQL6bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfEQEfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 00:35:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35607 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfEQEfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 00:35:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id g5so2731281plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 21:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bGUs/J4ZxiFyXk4eO3sDQIKqJUCedWLILRfaUclL2/Y=;
        b=bWvQL6bf1g203ieybEm5gqii/yhOQOb0PrxOGUOLcOxuX16thmEggVoPT/aBK+1Xm2
         dRz+qSxJlV/8DeMD+y5tuxgQVRVuSN0RWglsn4Tg0dVdpSdfXC+Hmceq42pCvbRrKbl4
         7mE65zVoAbGjv1X8Bv82LtQFOQF02Bo6NeDbJpFsF2c3k4bnccc/aI75NeUSM4DKaiZ4
         54TIk4PRSCnRzKpY4hnOh/HvGcLqD+z/DFKogLsVZ7oSVTuY9j3zLLDjflrXkh9GZm+T
         WKOgvIbXYcXTwYwbFQS5omAxM2M9dhG8YacyEQQjSaeSIIxQVLt8PKRc1kdCkMb2Guij
         DRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bGUs/J4ZxiFyXk4eO3sDQIKqJUCedWLILRfaUclL2/Y=;
        b=cmn/ZDLS5FKnXSECZv2hKdzeDv8klcwD6dND4DIxxahHu9PLcYd75wqWQXt3IoWmB4
         e/s9TW0nYO2ETR/0LGCrBFWO9sK5/J4dYvy3O+4B1Sap0GCc9JMwuX3cJnaOdcra4wmN
         1NuyfBP7/ZaHjQYYEnI1O0XBtrcvZF52GU5X/giBVCH19yL5oZACJNgG4upOmmCMptN3
         S+rFU1J8aEiktJmjPMvZd0kATDPsPCO1pxbwRMolit4byww0OPsZ3GPKFmvvXQNTCayH
         EWOr5fg6gsFLit2+UFo3ljPG8M7KXTPSPQTKQe92cpF8NNwPHR897CmyE2ssr0AEBG/D
         VUDQ==
X-Gm-Message-State: APjAAAU22qa2KjrXQ5Q7lpu0bzV1EVG7Pk1UZsuvSI9r3xjrlG2yeDHQ
        IJtahcYQFxkE+bHEvvNFI14=
X-Google-Smtp-Source: APXvYqzGdmA6xko75Qd58TNLmrefu51n1SKVPPcV0qzHkbG042z8JICWrqMeoE4f0oh5XNePl96z3A==
X-Received: by 2002:a17:902:8c8c:: with SMTP id t12mr54960640plo.116.1558067743367;
        Thu, 16 May 2019 21:35:43 -0700 (PDT)
Received: from hydra-Latitude-E5440.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id l1sm7744523pgp.9.2019.05.16.21.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 21:35:42 -0700 (PDT)
From:   parna.naveenkumar@gmail.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Subject: [PATCH] char: misc: Move EXPORT_SYMBOL immediately next to the functions/varibles
Date:   Fri, 17 May 2019 10:04:55 +0530
Message-Id: <20190517043455.19907-1-parna.naveenkumar@gmail.com>
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

