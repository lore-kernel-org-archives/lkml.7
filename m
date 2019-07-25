Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B590C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F602190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ry2zmLqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfGYSnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:43:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46732 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfGYSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:43:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id c3so54123pfa.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 11:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OxsBtkR8V6+s0OkCC+Hu7HIqYT8kxjr7WRYhfDwWQac=;
        b=ry2zmLqy2lsaOf19QbIYeTpO253PbKl4qzCc1S9mFX+H9n3B+/+5u83D1qe5RePhVE
         TOyPjcoM92ICenSmuv7isTDBNg2TZUX4CZ8vOcuARZ9WvJ5OLO7oE9lip/0QLEmYnyo7
         MpXJTJPjkL2/X2ge8PyV40QreWCZaWZDFQIAy7f+Zb9QR2NiEGbLtQSchU5EFKj7uktJ
         eR3tbUXE5U30f/r8yHwKI2Yth+uYH+Bpn3aWc8EQzx2JVNnRkCZmnpyBvEMr6BHvQOIY
         kEjVrQWbskaEntYS6HGUzlzdlG473FUzeVUnyks1SV5C6E6xKjIzV6Kkh6/5Ps6ytE8c
         A7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OxsBtkR8V6+s0OkCC+Hu7HIqYT8kxjr7WRYhfDwWQac=;
        b=Oh7Zn3Hkypy2SL5ci0teiHOlY032X1exxDpKKawtlVJ85BHH+X6SlFb0lDkqQL1YC0
         gjykwDLAOIOJo2wZPA7ICia8vg+Gk4W2+Lk8cfSmQwUvznMz8QSK3CML5ZXrszHc1+Sg
         sxECeQLiGc1CAVvS1bjtpr0AxEkNtgvuGbgbzAwSVKFq2m+SS2uWh8tgeGwBMaz3VuPv
         5TpSLPcDhQQbat4oop9n3GrwAJYuk1AXGFR9wufpH9xDTuxdoS00C8JZ8prxwvnoTdka
         mMpAL4aebOXxtfPh7k6gEhJllQumB7x59FD1wWf5gG8515NiCvFYqiNyliqnB42VNjSA
         BbYQ==
X-Gm-Message-State: APjAAAUeSjDwpzO1JalYPaV3q3rJwKDMsR8oJ2Uv2HyDkk9q7/7qf1rP
        bCTUjtT2AQ9fIMouHFm1KAY=
X-Google-Smtp-Source: APXvYqx/qV8WrsVV5Jeo7kC8964Q2Z2pSXahBIrPoXsoo219HEPPNsilSeBuWsKIQejpQYkJR+GM7g==
X-Received: by 2002:a62:3347:: with SMTP id z68mr18528585pfz.174.1564080219029;
        Thu, 25 Jul 2019 11:43:39 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:624:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id w3sm43818257pgl.31.2019.07.25.11.43.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 11:43:38 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        cai@lca.pw, aryabinin@virtuozzo.com, osalvador@suse.de,
        rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 01/10] mm/page_alloc: use unsigned int for "order" in should_compact_retry()
Date:   Fri, 26 Jul 2019 02:42:44 +0800
Message-Id: <20190725184253.21160-2-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725184253.21160-1-lpf.vector@gmail.com>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like another should_compact_retry(), use unsigned int for "order".
And modify trace_compact_retry() accordingly.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 include/trace/events/oom.h | 6 +++---
 mm/page_alloc.c            | 7 +++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 26a11e4a2c36..b7fa989349c7 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -154,7 +154,7 @@ TRACE_EVENT(skip_task_reaping,
 #ifdef CONFIG_COMPACTION
 TRACE_EVENT(compact_retry,
 
-	TP_PROTO(int order,
+	TP_PROTO(unsigned int order,
 		enum compact_priority priority,
 		enum compact_result result,
 		int retries,
@@ -164,7 +164,7 @@ TRACE_EVENT(compact_retry,
 	TP_ARGS(order, priority, result, retries, max_retries, ret),
 
 	TP_STRUCT__entry(
-		__field(	int, order)
+		__field(unsigned int, order)
 		__field(	int, priority)
 		__field(	int, result)
 		__field(	int, retries)
@@ -181,7 +181,7 @@ TRACE_EVENT(compact_retry,
 		__entry->ret = ret;
 	),
 
-	TP_printk("order=%d priority=%s compaction_result=%s retries=%d max_retries=%d should_retry=%d",
+	TP_printk("order=%u priority=%s compaction_result=%s retries=%d max_retries=%d should_retry=%d",
 			__entry->order,
 			__print_symbolic(__entry->priority, COMPACTION_PRIORITY),
 			__print_symbolic(__entry->result, COMPACTION_FEEDBACK),
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 272c6de1bf4e..75c18f4fd66a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3940,10 +3940,9 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 }
 
 static inline bool
-should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
-		     enum compact_result compact_result,
-		     enum compact_priority *compact_priority,
-		     int *compaction_retries)
+should_compact_retry(struct alloc_context *ac, unsigned int order,
+	int alloc_flags, enum compact_result compact_result,
+	enum compact_priority *compact_priority, int *compaction_retries)
 {
 	int max_retries = MAX_COMPACT_RETRIES;
 	int min_priority;
-- 
2.21.0

