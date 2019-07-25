Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A247BC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B27822C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyZA8GwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfGYSoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:44:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43142 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYSo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:44:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so23190674pfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 11:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cSpp6Nuo51h9S4IQ0r6ZMWrFSMbu5tBaK4Gt2EEXwJY=;
        b=DyZA8GwFGugFPNtlb6hWQqdevFK/xcnOR1T7j4zqKSmueRWnvAGKZ0TdyG/ILXydMP
         QaU8fhvkVZuTxAypDDsTHwTjK8tk8Nny7LbDvofi1XkmE2WvdMeRs8CC628qrXpWlgFc
         mUdAzbj+Ayk8SxOiM2a3sSsK0gRsqtVFcRLHA7eLN/WE+xniQdjex/IEdmAwQMCP2oqU
         GrWuxTFPGidJ5KWv1Iu0N2QHh7uIWNiJvmDCK6BJmuVmaGFfWakftJPHqNe9T4h6MivC
         GFpAEtR2f0Mq0zscxlhOKj/ci7H3xrWIY1Ai83IKPF2oxCEK/sbjFL5hHouF9Q/GkQHD
         TW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cSpp6Nuo51h9S4IQ0r6ZMWrFSMbu5tBaK4Gt2EEXwJY=;
        b=N1jJ8BrO8gjUQW3Std5uw7IgMiNpfJ8I5Cdgx5E7BoBOmRI1XUaE1x2fUbIqg1nMq4
         09xgdKdCtzz1m0bbXUTzQh2f9dIIKd2oCDncGSRUJckIGKemDaij0DJwwyXMgpy93Nih
         yO6/I9v+I4SOODLQZG289i+eh66+hj1l+1plAZ4NrG8PqCYefDCL+fXMJNhkqdpPmG5N
         FDcT2L8tR/le2XeSTDlvyNBek/faWJwpGDEi2S6wZqmRKdqmT+8UYABjp8tVx3mNv7vW
         iO8+TrYiVvbREsrUohPzSzN92Yub3mhFiox/XRhx8im/MTCL9Mpo2DE8NET+46TlvImr
         CTNA==
X-Gm-Message-State: APjAAAXm7K7oaRANIy3exy2CShiuqlk9C5+Mw0gR2+1SeL1MCNkVQ/Pk
        Y8A/Ra8H1iE+diXmIG2VOPw=
X-Google-Smtp-Source: APXvYqy9vQL6e+v//sfsxpH4SLF2FPA0wZMNMcxumuKmThjZf3GrZIKXbXgaGk5WSR6ilxCI3gSWhA==
X-Received: by 2002:a63:4846:: with SMTP id x6mr51416449pgk.332.1564080269118;
        Thu, 25 Jul 2019 11:44:29 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:624:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id w3sm43818257pgl.31.2019.07.25.11.44.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 11:44:28 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        cai@lca.pw, aryabinin@virtuozzo.com, osalvador@suse.de,
        rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 07/10] trace/events/compaction: make "order" unsigned int
Date:   Fri, 26 Jul 2019 02:42:50 +0800
Message-Id: <20190725184253.21160-8-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725184253.21160-1-lpf.vector@gmail.com>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the same type as "compact_control->order".

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 include/trace/events/compaction.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index e5bf6ee4e814..1e1e74f6d128 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -170,14 +170,14 @@ TRACE_EVENT(mm_compaction_end,
 TRACE_EVENT(mm_compaction_try_to_compact_pages,
 
 	TP_PROTO(
-		int order,
+		unsigned int order,
 		gfp_t gfp_mask,
 		int prio),
 
 	TP_ARGS(order, gfp_mask, prio),
 
 	TP_STRUCT__entry(
-		__field(int, order)
+		__field(unsigned int, order)
 		__field(gfp_t, gfp_mask)
 		__field(int, prio)
 	),
@@ -188,7 +188,7 @@ TRACE_EVENT(mm_compaction_try_to_compact_pages,
 		__entry->prio = prio;
 	),
 
-	TP_printk("order=%d gfp_mask=%s priority=%d",
+	TP_printk("order=%u gfp_mask=%s priority=%d",
 		__entry->order,
 		show_gfp_flags(__entry->gfp_mask),
 		__entry->prio)
@@ -197,7 +197,7 @@ TRACE_EVENT(mm_compaction_try_to_compact_pages,
 DECLARE_EVENT_CLASS(mm_compaction_suitable_template,
 
 	TP_PROTO(struct zone *zone,
-		int order,
+		unsigned int order,
 		int ret),
 
 	TP_ARGS(zone, order, ret),
@@ -205,7 +205,7 @@ DECLARE_EVENT_CLASS(mm_compaction_suitable_template,
 	TP_STRUCT__entry(
 		__field(int, nid)
 		__field(enum zone_type, idx)
-		__field(int, order)
+		__field(unsigned int, order)
 		__field(int, ret)
 	),
 
@@ -216,7 +216,7 @@ DECLARE_EVENT_CLASS(mm_compaction_suitable_template,
 		__entry->ret = ret;
 	),
 
-	TP_printk("node=%d zone=%-8s order=%d ret=%s",
+	TP_printk("node=%d zone=%-8s order=%u ret=%s",
 		__entry->nid,
 		__print_symbolic(__entry->idx, ZONE_TYPE),
 		__entry->order,
@@ -226,7 +226,7 @@ DECLARE_EVENT_CLASS(mm_compaction_suitable_template,
 DEFINE_EVENT(mm_compaction_suitable_template, mm_compaction_finished,
 
 	TP_PROTO(struct zone *zone,
-		int order,
+		unsigned int order,
 		int ret),
 
 	TP_ARGS(zone, order, ret)
@@ -235,7 +235,7 @@ DEFINE_EVENT(mm_compaction_suitable_template, mm_compaction_finished,
 DEFINE_EVENT(mm_compaction_suitable_template, mm_compaction_suitable,
 
 	TP_PROTO(struct zone *zone,
-		int order,
+		unsigned int order,
 		int ret),
 
 	TP_ARGS(zone, order, ret)
-- 
2.21.0

