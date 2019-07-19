Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAD0C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00EC621873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jm92/4wr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfGSQFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:05:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39525 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfGSQFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:05:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so31487134qtu.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 09:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QX8HUwETHmgClrdVMMacFDbEPwSj/LtQ21OBFsZ0vfE=;
        b=jm92/4wrMSrnxIQoCH5IhUNAsDm3PRsCn/KlChBUOtFv7kUdOrBuIwqaJPY9FZRrAx
         iEiSSLXtgmjePbfiwbGCk4/dsNaAaTNFou0BcZGSOY0XwfTGMLdse9dnek9eEPi4a35E
         8pnbStnAWKD4lXMjIf6vAUcnvbMYE3eTXzqLGiA6eOtVIX36ECXJ6e5gZ9flbHl7NJ1d
         S3Gh66DL2Xx0okHrO2KhdJBAcVq5t8YfCSFxizkxksNBenKgvfGUHhDFVxO1A/P+GiJL
         uXQZJOLSlbnI6rc933o+ozi7fXNXuxNTnnrEGduXFKLgDkxn+wrWRO/GibdwFesnxByg
         Lvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QX8HUwETHmgClrdVMMacFDbEPwSj/LtQ21OBFsZ0vfE=;
        b=XOrXMzF0WKtD0Ywp3hY4vyFcna9KBcIMNzKqO6jV2yL8vJANmr+sfB5lk+jXcfiRFP
         MPI5pFJ1wDhcyyySp+tDrWKOjjNqFT7NW16s2BjKUwyYI08VaKwCxD5sZ+AZbjiFy3ab
         8rke5oqI7ABzw4pKgHu8iZwmMzmNeiqYqOYntepQlZy51dF6mEr5ZazQARSTxTRzeMeU
         ZLOgCXRTDQVPSuf2ELIOFot483+XQE+zY7kuGYgH02Qh5BXOdd0gxa7zgCf3G3eSZoEO
         2s9aM9GzAZcf6liceDztkPODmEyWDPdmpcS2+XAg9+9lPTLaMGvmX2NFtfDkPFe0NA+a
         C5gw==
X-Gm-Message-State: APjAAAVshiX+hhmXLPcY60Lt/AdoF6CfA8KAcM9K1xsZvlQ+qGc7OqZ3
        r1aEZXQFZBTbdJMXpSSqdv3jvQ==
X-Google-Smtp-Source: APXvYqx3tRQaGx/UTyhaFk/r7Ia1qektQloYbfJjrx66Zor3nMdP+hMd5IYcN7V+t4iqlnOtbLkqgQ==
X-Received: by 2002:ac8:27db:: with SMTP id x27mr39618326qtx.4.1563552337330;
        Fri, 19 Jul 2019 09:05:37 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a6sm14058238qkd.135.2019.07.19.09.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 09:05:36 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     valentin.schneider@arm.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v3] sched/core: silence a warning in sched_init()
Date:   Fri, 19 Jul 2019 12:05:16 -0400
Message-Id: <1563552316-23391-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling a kernel with both FAIR_GROUP_SCHED=n and RT_GROUP_SCHED=n
will generate a compiler warning,

kernel/sched/core.c: In function 'sched_init':
kernel/sched/core.c:5906:32: warning: variable 'ptr' set but not used
[-Wunused-but-set-variable]
  unsigned long alloc_size = 0, ptr;
                                ^~~
Silence it by adding a check in a if statement to actually use it.

Signed-off-by: Qian Cai <cai@lca.pw>
---

v3: Use a different approach to see if Peter will like it.
v2: Incorporate the feedback from Valentin.

 kernel/sched/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..ae36a1e5b2e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6371,7 +6371,8 @@ int in_sched_functions(unsigned long addr)
 
 void __init sched_init(void)
 {
-	unsigned long alloc_size = 0, ptr;
+	unsigned long alloc_size = 0;
+	unsigned long ptr = 0;
 	int i;
 
 	wait_bit_init();
@@ -6382,7 +6383,8 @@ void __init sched_init(void)
 #ifdef CONFIG_RT_GROUP_SCHED
 	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
 #endif
-	if (alloc_size) {
+	/* Avoid a -Wunused-but-set-variable warning. */
+	if (alloc_size && !ptr) {
 		ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
1.8.3.1

