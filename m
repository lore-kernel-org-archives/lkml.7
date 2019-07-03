Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC98C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0B0218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQcna9PT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfGCNPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:15:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46815 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCNPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:15:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so1222543pls.13;
        Wed, 03 Jul 2019 06:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LDQEYa+SYRPSXa6Z0KLZW9PBv8GE8Q8lsLimzp9JewE=;
        b=nQcna9PTESD3RoynbhwHnSnUmp5C5172N/oEukmKxN4f2z/XThQtuh/onzbIz2hPQ4
         KqlBuOrjS1QHbMggUh0QpljV/f9lD206sVyTfMJosviVDX0o+50RyZ7LxuSkNSr24lyX
         W9BkpOWwH8WTqY1ljJQGKkc9yFsOts73Gg3PfUEe/4bB1eDr7VFhNpX0gpBSx57GncxH
         KrYj9Xy1/9ytaFKRSW53JGXd132Th3yTKTk8FoFxhFpWmDhmexvHj0TaV513OE0yL8lY
         PfqHTy+SV7ViVb9XsCA6a3F3a/ISHybOKNk62GMvG0Y8Jt8pAPUX9/3d6o/IzFyRmurB
         qQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LDQEYa+SYRPSXa6Z0KLZW9PBv8GE8Q8lsLimzp9JewE=;
        b=Tx/tRuFdP/bervDf/60Axds/wM6IVqyUkOZGq1Sa3N6piEqrKuiubclW6krxygiFZi
         4PW8SwKHEHeqlC+UXv65Zek5f2MQ+6liu7NYh45tGR72cPB5Sg0CmkQT/uXOz1WJNd8l
         u1pmHeg4/8yxe9byK0Tf+ManZVGjwOJSxJl3qizXCUDgBbWe3G6xRQOupCIVa8bNocWV
         rSyHFXXWBmZjURPxI1I9CLB8DEMwCbtLdjnfKSuoU+IX89SKxn+Cnoe2LOMAe0xn+cTu
         TUAcG7QiGxl8zzD7UEMy/d7/9M1Ob/K4IdGYsogbDx0MtMvjockHcZ9kFYCqEH6iV/1H
         FGeg==
X-Gm-Message-State: APjAAAXTT5XmGl0Vwmh3UyCIBgQNG/K8TBbgqMnCVIJvCAC7ygfQwFRv
        jd3Ep2lgYiW/MF0bM4nIzpY=
X-Google-Smtp-Source: APXvYqzbEbGSd38TnKedTO7iV+o3OuKmTVu4X5miAXlN4my9KxRt6PNKYskMAzIqkFz39V0iJCsyjg==
X-Received: by 2002:a17:902:722:: with SMTP id 31mr41709199pli.163.1562159750070;
        Wed, 03 Jul 2019 06:15:50 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id h62sm5716627pgc.54.2019.07.03.06.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:15:49 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 13/30] message/fusion: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:15:39 +0800
Message-Id: <20190703131539.25270-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/message/fusion/mptbase.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index d8882b0a1338..e0c57cecddd3 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -6001,13 +6001,12 @@ mpt_findImVolumes(MPT_ADAPTER *ioc)
 	if (mpt_config(ioc, &cfg) != 0)
 		goto out;
 
-	mem = kmalloc(iocpage2sz, GFP_KERNEL);
+	mem = kmemdup((u8 *)pIoc2, iocpage2sz, GFP_KERNEL);
 	if (!mem) {
 		rc = -ENOMEM;
 		goto out;
 	}
 
-	memcpy(mem, (u8 *)pIoc2, iocpage2sz);
 	ioc->raid_data.pIocPg2 = (IOCPage2_t *) mem;
 
 	mpt_read_ioc_pg_3(ioc);
-- 
2.11.0

