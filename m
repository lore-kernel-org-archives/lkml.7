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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBFBC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AFF2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EH58ZxTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfGCQaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:30:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42344 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfGCQaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:30:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so1509438plb.9;
        Wed, 03 Jul 2019 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2zWvMdzA/V9RyhmUcmhxRuOGTZVdTb4bDJ/gtFYjG8w=;
        b=EH58ZxTTDW/gvWq+rRCkWLUjidFoA+hvkhdhLqyvRmIDziAlIzaUfd7TdKSZnaWLKO
         xoV7NSefQySIIFqsIH+MvTCOLf2ZLAXjOG7O2bw7LZC4JMKAzh16Icy3vBJD3ZOTtn6j
         XDSaMKSnhcP2hHeF/glVyoPgNTpBmEc+sfP/wHI2MeDMGhhPj0c2h2U0UeSDnSYz4I6z
         Ug0wwmTv5bqWuo0hfXCw2JdzvulmlaTVcYuMLDwEhrle1CKoYyMcgLg+jdWbpNUxD8Fx
         3+qv6q9uqXeYkH6bEBhH73Y6rvVymohaOZoIK78hODQcEW7KmCTaFpvQ/rNZe60ciBf5
         p0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2zWvMdzA/V9RyhmUcmhxRuOGTZVdTb4bDJ/gtFYjG8w=;
        b=ozisrdeMFRo85HWDQ43A8NX8k8BWqvkaiFKnWbmyuc7UQtVhIVNX2W75KmDrwhtWyG
         CExOUF+QllWO0gEK6XVbGG81xt/6qX32m7HZJfs+5YdPSXbWtOyiOE2hk7xjICq55q2m
         PVQwc0fW4j7Rzm0ZtiIfraqWgTH00Mw05XGGaZfcrVZZBoZkaHro5gb2XbO2JVr+1Ikk
         ULFJcG3KIVJIvz884N7QiTdj309H/F3LTRxgJPXePawiR4x/eeVbPsdNQq5mVjszFegC
         Hh5a6M7JPt3aVcb3qJenNCAX+cTtEexHZsEzHgjIBY/wETZ4eFuqDU/v0x7M4PR+BLSg
         UQ3w==
X-Gm-Message-State: APjAAAVcMW8EVrXJFbFbaKGs/hHk5lgYLLniwyJ6AibMOtuDCJCzwvb9
        bVvHejUyObtM/KYfe6onBho=
X-Google-Smtp-Source: APXvYqyaQVg2V0LNXQ+367v5bLDi2dS1KGUjL/rC6yn1x5xvwLQPlYKuQGJ2mAnjFyAz5HGMk49fmA==
X-Received: by 2002:a17:902:124:: with SMTP id 33mr44436846plb.145.1562171419914;
        Wed, 03 Jul 2019 09:30:19 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id b16sm1245055pfo.54.2019.07.03.09.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:30:19 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Hannes Reinecke <hare@suse.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 22/35] scsi/aic7xxx: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:30:10 +0800
Message-Id: <20190703163010.364-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

 drivers/scsi/aic7xxx/aic79xx_core.c | 3 +--
 drivers/scsi/aic7xxx/aic7xxx_core.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index 7e5044bf05c0..f4bc88c50dcd 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -9442,10 +9442,9 @@ ahd_loadseq(struct ahd_softc *ahd)
 	if (cs_count != 0) {
 
 		cs_count *= sizeof(struct cs);
-		ahd->critical_sections = kmalloc(cs_count, GFP_ATOMIC);
+		ahd->critical_sections = kmemdup(cs_table, cs_count, GFP_ATOMIC);
 		if (ahd->critical_sections == NULL)
 			panic("ahd_loadseq: Could not malloc");
-		memcpy(ahd->critical_sections, cs_table, cs_count);
 	}
 	ahd_outb(ahd, SEQCTL0, PERRORDIS|FAILDIS|FASTMODE);
 
diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index a9d40d3b90ef..7ea4e45309ff 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -6907,10 +6907,9 @@ ahc_loadseq(struct ahc_softc *ahc)
 	if (cs_count != 0) {
 
 		cs_count *= sizeof(struct cs);
-		ahc->critical_sections = kmalloc(cs_count, GFP_ATOMIC);
+		ahc->critical_sections = kmemdup(cs_table, cs_count, GFP_ATOMIC);
 		if (ahc->critical_sections == NULL)
 			panic("ahc_loadseq: Could not malloc");
-		memcpy(ahc->critical_sections, cs_table, cs_count);
 	}
 	ahc_outb(ahc, SEQCTL, PERRORDIS|FAILDIS|FASTMODE);
 
-- 
2.11.0

