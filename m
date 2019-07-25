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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25F5C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65D52190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJzIWT6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfGYSoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:44:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43150 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfGYSoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:44:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so23190810pfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 11:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J873l7lCPa+QolPzlUg++nHCXxrMC4Fmw1tQXHj9o08=;
        b=RJzIWT6paD7ZJL2tpjW5Ma6HpOCKdfWeXRD2vnTwJZh2N+35UR5DKekXI88Xe4vBOw
         8HtjuDi5CyzP5RL/Fm5lwdn0QgqaPNHF0iFdRcrXtROUqOpmEHs9iscOO8hOcq/Qhx10
         Pr/mm8WfuwKrkXjn+Vg74jX0m5AbHzx84kAt7OjrEpYKMFFsSYKkGYrLolzlvoJ1TIWM
         rsNRywamFxX4lYOCgAWlTZ3qPWxgFXNW37iDXw35a3UdDrZqalhKYFYz0spQ17MO+it4
         Z26oHS5/0o9ysNwzjjtuPA5esNh4pG99SJI+BA6DPnPEog949quGyOohq9IhFJu7x2rA
         GjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J873l7lCPa+QolPzlUg++nHCXxrMC4Fmw1tQXHj9o08=;
        b=EBSrq+OtdosG9xnpRA86YHXF1melnvY5li/OORc1jJtJ9vE/17yTRWGtwXjCsDJ0ah
         w8aKE16EhsKKyqhqMpMPr19Ejk/sKTLR9aPcnI2vujneVFTG4X705AElcKtHcl7bI/X2
         +7T5DrGPQQcAq2tOcCG3H9Kl4L56LImfDyCg12rPl26sIn19JodXrnFhctZ3I4IwqQzN
         BrZNG/HeiNYw4ZhZq5cFHd04ZtRgaA0aWVFqUTP3Hz7DnjPVq1evq+arHNzjdwc2nnwq
         3MSKaD+YQTiAjos2j/UnTA8zzdQqiNMyMosusX4Ljss+/JeC09reUyVGEFsD+BOjObyT
         3vYQ==
X-Gm-Message-State: APjAAAVQ9/TsSOqL6HbQykmZyZpajcmFGdzbgGBU7YkVsPPd11GAHde/
        vrWQ1td7CJ1RXngPPRik1VQ=
X-Google-Smtp-Source: APXvYqwo1eTAvDaBp9lnIuBms8Io2Fugm1ugWOpWhcpk//Dd3/eCcG6T3EvxJjRQep96tUFWHAJ2cQ==
X-Received: by 2002:a63:1765:: with SMTP id 37mr18700674pgx.447.1564080277359;
        Thu, 25 Jul 2019 11:44:37 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:624:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id w3sm43818257pgl.31.2019.07.25.11.44.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 11:44:37 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        cai@lca.pw, aryabinin@virtuozzo.com, osalvador@suse.de,
        rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 08/10] mm/compaction: use unsigned int for "compact_order_failed" in struct zone
Date:   Fri, 26 Jul 2019 02:42:51 +0800
Message-Id: <20190725184253.21160-9-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725184253.21160-1-lpf.vector@gmail.com>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because "compact_order_failed" will never be negative, so just
make it unsigned int. And modify three related trace functions
accordingly.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 include/linux/compaction.h        | 12 ++++++------
 include/linux/mmzone.h            |  2 +-
 include/trace/events/compaction.h | 14 +++++++-------
 mm/compaction.c                   |  8 ++++----
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 0201dfa57d44..a8049d582265 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -99,11 +99,11 @@ extern void reset_isolation_suitable(pg_data_t *pgdat);
 extern enum compact_result compaction_suitable(struct zone *zone,
 	unsigned int order, unsigned int alloc_flags, int classzone_idx);
 
-extern void defer_compaction(struct zone *zone, int order);
-extern bool compaction_deferred(struct zone *zone, int order);
-extern void compaction_defer_reset(struct zone *zone, int order,
+extern void defer_compaction(struct zone *zone, unsigned int order);
+extern bool compaction_deferred(struct zone *zone, unsigned int order);
+extern void compaction_defer_reset(struct zone *zone, unsigned int order,
 				bool alloc_success);
-extern bool compaction_restarting(struct zone *zone, int order);
+extern bool compaction_restarting(struct zone *zone, unsigned int order);
 
 /* Compaction has made some progress and retrying makes sense */
 static inline bool compaction_made_progress(enum compact_result result)
@@ -188,11 +188,11 @@ static inline enum compact_result compaction_suitable(struct zone *zone,
 	return COMPACT_SKIPPED;
 }
 
-static inline void defer_compaction(struct zone *zone, int order)
+static inline void defer_compaction(struct zone *zone, unsigned int order)
 {
 }
 
-static inline bool compaction_deferred(struct zone *zone, int order)
+static inline bool compaction_deferred(struct zone *zone, unsigned int order)
 {
 	return true;
 }
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d77d717c620c..0947e7cb4214 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -545,7 +545,7 @@ struct zone {
 	 */
 	unsigned int		compact_considered;
 	unsigned int		compact_defer_shift;
-	int			compact_order_failed;
+	unsigned int		compact_order_failed;
 #endif
 
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index 1e1e74f6d128..f83ba40f9614 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -243,17 +243,17 @@ DEFINE_EVENT(mm_compaction_suitable_template, mm_compaction_suitable,
 
 DECLARE_EVENT_CLASS(mm_compaction_defer_template,
 
-	TP_PROTO(struct zone *zone, int order),
+	TP_PROTO(struct zone *zone, unsigned int order),
 
 	TP_ARGS(zone, order),
 
 	TP_STRUCT__entry(
 		__field(int, nid)
 		__field(enum zone_type, idx)
-		__field(int, order)
+		__field(unsigned int, order)
 		__field(unsigned int, considered)
 		__field(unsigned int, defer_shift)
-		__field(int, order_failed)
+		__field(unsigned int, order_failed)
 	),
 
 	TP_fast_assign(
@@ -265,7 +265,7 @@ DECLARE_EVENT_CLASS(mm_compaction_defer_template,
 		__entry->order_failed = zone->compact_order_failed;
 	),
 
-	TP_printk("node=%d zone=%-8s order=%d order_failed=%d consider=%u limit=%lu",
+	TP_printk("node=%d zone=%-8s order=%u order_failed=%u consider=%u limit=%lu",
 		__entry->nid,
 		__print_symbolic(__entry->idx, ZONE_TYPE),
 		__entry->order,
@@ -276,21 +276,21 @@ DECLARE_EVENT_CLASS(mm_compaction_defer_template,
 
 DEFINE_EVENT(mm_compaction_defer_template, mm_compaction_deferred,
 
-	TP_PROTO(struct zone *zone, int order),
+	TP_PROTO(struct zone *zone, unsigned int order),
 
 	TP_ARGS(zone, order)
 );
 
 DEFINE_EVENT(mm_compaction_defer_template, mm_compaction_defer_compaction,
 
-	TP_PROTO(struct zone *zone, int order),
+	TP_PROTO(struct zone *zone, unsigned int order),
 
 	TP_ARGS(zone, order)
 );
 
 DEFINE_EVENT(mm_compaction_defer_template, mm_compaction_defer_reset,
 
-	TP_PROTO(struct zone *zone, int order),
+	TP_PROTO(struct zone *zone, unsigned int order),
 
 	TP_ARGS(zone, order)
 );
diff --git a/mm/compaction.c b/mm/compaction.c
index ac5df82d46e0..aad638ad2cc6 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -139,7 +139,7 @@ EXPORT_SYMBOL(__ClearPageMovable);
  * allocation success. 1 << compact_defer_limit compactions are skipped up
  * to a limit of 1 << COMPACT_MAX_DEFER_SHIFT
  */
-void defer_compaction(struct zone *zone, int order)
+void defer_compaction(struct zone *zone, unsigned int order)
 {
 	zone->compact_considered = 0;
 	zone->compact_defer_shift++;
@@ -154,7 +154,7 @@ void defer_compaction(struct zone *zone, int order)
 }
 
 /* Returns true if compaction should be skipped this time */
-bool compaction_deferred(struct zone *zone, int order)
+bool compaction_deferred(struct zone *zone, unsigned int order)
 {
 	unsigned long defer_limit = 1UL << zone->compact_defer_shift;
 
@@ -178,7 +178,7 @@ bool compaction_deferred(struct zone *zone, int order)
  * which means an allocation either succeeded (alloc_success == true) or is
  * expected to succeed.
  */
-void compaction_defer_reset(struct zone *zone, int order,
+void compaction_defer_reset(struct zone *zone, unsigned int order,
 		bool alloc_success)
 {
 	if (alloc_success) {
@@ -192,7 +192,7 @@ void compaction_defer_reset(struct zone *zone, int order,
 }
 
 /* Returns true if restarting compaction after many failures */
-bool compaction_restarting(struct zone *zone, int order)
+bool compaction_restarting(struct zone *zone, unsigned int order)
 {
 	if (order < zone->compact_order_failed)
 		return false;
-- 
2.21.0

