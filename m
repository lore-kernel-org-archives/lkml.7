Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E6BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8850020748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKByRLLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfL2RSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:18:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34893 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfL2RSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:18:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so30791003wro.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 09:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UpAAM2b/CHxiQB2DKqtmYm7Ykwi1N1qoZH/PqNBnd0M=;
        b=kKByRLLeTxDEtefoUtYPo+bv2p7yrg7SMUW7f9wl3KwyH0gxef+t1lLW8datm3Wiek
         qRiwagBG3bZga91dBBAfuflOVhuBydqjACD/CQEnSormnRdq3KJ30C4GKCyVQS8q4xaG
         1vmbcigVjB/5cqzfnJI/8MolKFc1jYxgKtI8oaJ2Xz5EjeEAf2k9ffsohfvhu96eQen/
         V9kofUswMYY1SLqn2ME3lafET3eeip2vTipN1ojwnBrlrfP5KmzTKF1L2DiByq4J+Col
         1SgZuZd4N+4Ni4YjwGE6ciA4t16DnW5sTim2jRcUZfGWtAU1N1LhPlSNQwfe59L/5UYA
         e1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UpAAM2b/CHxiQB2DKqtmYm7Ykwi1N1qoZH/PqNBnd0M=;
        b=W+xY0pdl2BISOWIL3VKxv63nW+3eBNk+Sa1gOxJGVQyoySSlH/9IF2ERuzzqtgKVKJ
         hGsiPOKsnwfaZituRRb/YkZjT7Opt4DodhOr3WMQEW7omrJS16UfR6O5ns7i6fW6omFF
         lWyv7DHMhoNk+ZeCKXnvuy7WY5yjn9RQnZAj7q+YJbx5wN2VGmMk4K0g/YKzSXkZCEx5
         ghSC2k5zdQKdlqG8bdB55Z2R/pnmAFEq4Nv0PnO8+oSu6fCoDm3wzFGKG+uxnWeCNmgM
         anQewWXz1u4ghq894cWfKFLKWBC+9M8xuS4qGzM6gLrxmojmplPLsNllh4Ehlsn7o/VT
         Sa2A==
X-Gm-Message-State: APjAAAX2KgaFJ8l1NBAYIG4MM9lLefMgj+RZySmA9ulLkuH39KrQwoqr
        hplSjvJ6kNw9J3JD/kkGiYM=
X-Google-Smtp-Source: APXvYqxebkAwR4SZWD9SHctUHC0BOZEgOG9lGQzYSFXGWzTN+t6ZKRbGNIejNjDCIi0A5RxQU2CKKQ==
X-Received: by 2002:adf:82e7:: with SMTP id 94mr62731339wrc.60.1577639925992;
        Sun, 29 Dec 2019 09:18:45 -0800 (PST)
Received: from archlinux-laptop.lan (5.205.6.51.dyn.plus.net. [51.6.205.5])
        by smtp.gmail.com with ESMTPSA id o7sm17734006wmh.11.2019.12.29.09.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 09:18:45 -0800 (PST)
From:   rhysperry111 <rhysperry111@gmail.com>
To:     arnd@arndb.de
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Rhys Perry <rhysperry111@gmail.com>
Subject: [PATCH] Added AU6625 to list of supported PCI_IDs in drivers/misc/cardreader/alcor_pci.c
Date:   Sun, 29 Dec 2019 17:18:24 +0000
Message-Id: <20191229171824.10308-1-rhysperry111@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rhys Perry <rhysperry111@gmail.com>

I have added the AU6625 PCI_ID to the list of supported IDs:
alcor_pci.c
// Added au6625s ID to the array of supported devices
alcor_pci.h
// Added entry to define the PCI ID

Made it fit in with the already submitted code:
alcor_pci.c
// Added config entry to that matches the one for au6601

From general usage there seems to be no problems.

Signed-off-by: Rhys Perry <rhysperry111@gmail.com>
---
 drivers/misc/cardreader/alcor_pci.c | 8 +++++++-
 include/linux/alcor_pci.h           | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
index 259fe1dfe..cd402c891 100644
--- a/drivers/misc/cardreader/alcor_pci.c
+++ b/drivers/misc/cardreader/alcor_pci.c
@@ -38,12 +38,18 @@ static const struct alcor_dev_cfg au6621_cfg = {
 	.dma = 1,
 };
 
+static const struct alcor_dev_cfg au6625_cfg = {
+	.dma = 0,
+};
+
 static const struct pci_device_id pci_ids[] = {
 	{ PCI_DEVICE(PCI_ID_ALCOR_MICRO, PCI_ID_AU6601),
 		.driver_data = (kernel_ulong_t)&alcor_cfg },
 	{ PCI_DEVICE(PCI_ID_ALCOR_MICRO, PCI_ID_AU6621),
 		.driver_data = (kernel_ulong_t)&au6621_cfg },
-	{ },
+	{ PCI_DEVICE(PCI_ID_ALCOR_MICRO, PCI_ID_AU6625),
+		.driver_data = (kernel_ulong_t)&au6625_cfg },
+	{},
 };
 MODULE_DEVICE_TABLE(pci, pci_ids);
 
diff --git a/include/linux/alcor_pci.h b/include/linux/alcor_pci.h
index 4416df597..8274ed525 100644
--- a/include/linux/alcor_pci.h
+++ b/include/linux/alcor_pci.h
@@ -17,6 +17,7 @@
 #define PCI_ID_ALCOR_MICRO			0x1AEA
 #define PCI_ID_AU6601				0x6601
 #define PCI_ID_AU6621				0x6621
+#define PCI_ID_AU6625				0x6625
 
 #define MHZ_TO_HZ(freq)				((freq) * 1000 * 1000)
 
-- 
2.24.1

