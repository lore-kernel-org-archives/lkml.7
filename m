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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC1DC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5520218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjZOttVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfGCQ3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:29:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36779 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCQ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:29:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so1531661plt.3;
        Wed, 03 Jul 2019 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Sx51BEU96kLzOqHMh+2nDWJWJOKqGwfS67NtG6OObZs=;
        b=sjZOttVShHaH3btE2OF+Uil8M3AW/3VldRboShe2e6NBoVCsZWTYwsqF5lL6wIbB+1
         5lqXqOFcy+j/LCk+5N+C5I+feeUgILfrEAGjQ1KzY2cFvAYH62vh95mzlJuZiCZpUHpM
         yNF9LQ8M91/McsFXbzjU6u3lmRaZq8xfwarKPBXtLtg1LBlA08O6+XmxsyIMf5ckaOGb
         0OACN6sgAeWCKIaxbwRIep2GKfvmmnlZ7bGQ13N2UBGhtM+Ss6HPmDFmmENR8cySSKoy
         ix4ICWKy6RxEPCW+siRoduvHEReFBwHpg7FwvpKhDoBpum3QSpBQU8BQRGQuhu9t11yz
         FaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sx51BEU96kLzOqHMh+2nDWJWJOKqGwfS67NtG6OObZs=;
        b=Z0+bwi0dgvQyAiI92Zwzk81Nlhnt+u3RItM9jVPwwywIAD2jiXI6hMbsL45BQeM9I8
         XsnEr/WPBD1AxQuJE0S7m7uaP6UxRUwziSF+YAvXH7d2KCbF2YlvjClXCg8z0XC8ZlFh
         1QP/EuJMkl7A3oC5OeMBEpWCXbW5we3T3WseRZqyJXCpDBTFtinHonXJewdkL97Ol88Q
         XnDK2BVYFRBDjRitipiEWddkXLMjAs8Zwl8QkhJ88l0j2j7nyNgbS5BOtNM9j7gInVUB
         2py5zJUTspYGonx9m7SQnYpTTSSj06dC3y9TuUvD0l/0+eOmGFaorh9+3MoKiRQ/suPb
         DIEA==
X-Gm-Message-State: APjAAAVgO0lz1pmxTKHviIDSnuu03+Jn6jhy/2KwKYAAAl6xwBLTsb2k
        0HoK1vO6aY3xkz1D8d7i9jQ=
X-Google-Smtp-Source: APXvYqx0QZFK4KAjWCf/IdegUuL5GcA9T4IH3Va+O37A95xl3lDF9/ZIf5UewCKjRL+tR3ooICNTpQ==
X-Received: by 2002:a17:902:4c88:: with SMTP id b8mr44884570ple.29.1562171354064;
        Wed, 03 Jul 2019 09:29:14 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id i9sm7814851pgo.46.2019.07.03.09.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:29:13 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 14/35] message/fusion: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:29:06 +0800
Message-Id: <20190703162906.32507-1-huangfq.daxian@gmail.com>
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

