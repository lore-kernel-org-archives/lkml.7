Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DDEC4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A60021479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y06Mp6xa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392840AbfIJOdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:33:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40071 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbfIJOdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:33:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so11634260pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CN84UWkaCrFsbXjQU8HPx5pvSQFtml/KKbG+22M3OVM=;
        b=Y06Mp6xalqbIZd2E44S3rfqWm1jFSkoc5uA1b76edCbsR84TQErKfKr/3ay/JHij9L
         hZIKfbmSEAnRtGJYEi1orXDlKnAiILkOgw4iDQBOZmNjsKdndZXUqrA/LL4IKT4gKx9x
         yTzoxp8G2TXSaovBGSI+4ztWzE2bJG7M5hetwOPgwVZ3cgLrmBrL4+afTEfJr1Y8mzuP
         L43lz3nKlhgIE/ADw8gNUOvcCpxGAhbrxFrY8mk5ko7nEcU1JUPjjUYk23X2VbK7qbmr
         apTSwjN+LqXu5f7XlUy5q5ZpGKH9Ceyvnxy4CiA4OvMaYOCCyp4VjloF+Xbys/1C8LFi
         qQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CN84UWkaCrFsbXjQU8HPx5pvSQFtml/KKbG+22M3OVM=;
        b=oebEcacpyNC9RhgjGGany8x4/Y9jWHjQmovYA8dhBIIZhyIjFXrI0a5h2tUPXPa1gf
         yuSODFtk59Z2r5QPuzRm6ixQcNYWkVnS9Mnglhm1PK1eS6VfVunAVH/cgFnHxI6Fh7xv
         oTcbTl9QZ9nQ/CMywwKZ1Wh7+BMTjiDtQnpiBl8mX+RLCsaPWHyunZ76K9wm7XvG8Cmv
         QCXFgyOSx6pwG4ie/rsF7X2k8sQLxH7oJ/ub+Vv/PdQFWCFMdDaxyO2LwsTUxNcD/IG7
         yQV8TPcPIe2OqBadZVVb34r3MJYt9Y+lBi7opbS5Sf+9a1fhycwEY5JAYc3DDYyf374o
         e/Pg==
X-Gm-Message-State: APjAAAVJyi990BZxml0yCfGVnmm2Pdk8S9Q4/DEOU4uD5TSCkDh74NYv
        DwgJzyDwBC7CU4NFFrYK7LOl4s/Mi4Hzeg==
X-Google-Smtp-Source: APXvYqwNw5Y+LPBxQT+YX1tu1j96Tyi9S5wtJ6UtzVHiuAKJ1F9l14tA/t5kJT/7X12fRcJ+Ktr4tg==
X-Received: by 2002:a63:6c46:: with SMTP id h67mr28835208pgc.248.1568126029049;
        Tue, 10 Sep 2019 07:33:49 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id k5sm28386813pfp.109.2019.09.10.07.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 07:33:48 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3] ftrace: simplify ftrace hash lookup code in clear_func_from_hash()
Date:   Tue, 10 Sep 2019 22:33:36 +0800
Message-Id: <20190910143336.13472-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ftrace_lookup_ip() will check empty hash table. So we don't
need extra check outside.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v3: only keep the change in function clear_func_from_hash().
v2: fix incorrect code remove.
---
 kernel/trace/ftrace.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9821a3374e9..c4cc048eb594 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6036,11 +6036,7 @@ clear_func_from_hash(struct ftrace_init_func *func, struct ftrace_hash *hash)
 {
 	struct ftrace_func_entry *entry;
 
-	if (ftrace_hash_empty(hash))
-		return;
-
-	entry = __ftrace_lookup_ip(hash, func->ip);
-
+	entry = ftrace_lookup_ip(hash, func->ip);
 	/*
 	 * Do not allow this rec to match again.
 	 * Yeah, it may waste some memory, but will be removed
-- 
2.20.1

