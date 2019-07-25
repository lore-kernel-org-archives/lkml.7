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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07DDC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33FC22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJBS9eBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfGYSoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:44:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41454 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYSoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:44:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so13123912pgg.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 11:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p7anoNZvbE1SmPE7vSkzLr+EkemuOAJ6vumDZVqMY6I=;
        b=tJBS9eBYwj5uFnvpYiOFMVcvakA/gNlpWBLT8ABmrbAMIlcvS5T5oRS5m3dKEQ25Bl
         8AusFNV4/jIOLj3fBavzY82wfCx5RoXf+dE20Nnnt0xXpvKquTSMiItJLWgEOoXsjt7Y
         ehfj3CQf43o371r/d1vAi+eeSeWV++2ZZLt+1LdWwluIeWLw4/IzgQy0a4pGLmLGhYiP
         IwGkgvsELiIEgxhha6sbuvNuy18XtzADZ4I90Aa5Rn1QRu8q7RPpr/KsyDRof+JXMBOT
         J1XUbuzl4K3hgKDfOEBKjMXC1MSMvMyfGeUljO6JpN+OJqdSyd/zp5ddzuqhZmKN42C2
         kfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7anoNZvbE1SmPE7vSkzLr+EkemuOAJ6vumDZVqMY6I=;
        b=MfKBuccB5xCnRiqZo+1RxnLtRTRsjD9MbUF8s7LK8764cwnF5ZjNaw/xOfn2hx4bWn
         UvHTfTGZ+DDD5g/v/N4s3fIxahqbYzbRlTd22AZ1mpDj7iBH4CZRjRhCAabJr3k8BMGS
         JuN/uq8aktfIiKasATD8FoT5536+OEf9FsCF9SaJvqYkyuX/RNBE1C6Ftmc9Atl1NKDS
         7y1FBBZdyfLA+Dl+Bitl1Vsp3x7m3nC3myvB2w6wGCQyEELa5ncjPbvTUypEuiG5JEBx
         W2ynOF3Nb1cuBm/SeRPux5viY5FpZCASHr5RhciJ4l43VpQw24vM77AiIEzT98q2eIL2
         xonA==
X-Gm-Message-State: APjAAAUveRbn8CJo6rZ1pP+5JA1JcGB7tlAL8LP+D9ZoDGwSvwG10cAq
        0QhvxoDqQ9P73Bu8u0iYC/c=
X-Google-Smtp-Source: APXvYqwZbtVPZxFGTdpe3wuAozXuab4sqkGSpbGjI1Hce0XSqcULaSlK3GMHEQ89iHU3g+UWizUZYQ==
X-Received: by 2002:a62:1444:: with SMTP id 65mr17795430pfu.145.1564080293985;
        Thu, 25 Jul 2019 11:44:53 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:624:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id w3sm43818257pgl.31.2019.07.25.11.44.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 11:44:53 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        cai@lca.pw, aryabinin@virtuozzo.com, osalvador@suse.de,
        rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 10/10] mm/vmscan: use unsigned int for "kswapd_order" in struct pglist_data
Date:   Fri, 26 Jul 2019 02:42:53 +0800
Message-Id: <20190725184253.21160-11-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725184253.21160-1-lpf.vector@gmail.com>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because "kswapd_order" will never be negative, so just make it
unsigned int. And modify wakeup_kswapd(), kswapd_try_to_sleep()
and trace_mm_vmscan_kswapd_wake() accordingly.

Besides, make "order" unsigned int in two related trace functions.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 include/linux/mmzone.h            |  4 ++--
 include/trace/events/compaction.h | 10 +++++-----
 include/trace/events/vmscan.h     |  4 ++--
 mm/vmscan.c                       |  6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 60bebdf47661..1196ed0cee67 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -717,7 +717,7 @@ typedef struct pglist_data {
 	wait_queue_head_t pfmemalloc_wait;
 	struct task_struct *kswapd;	/* Protected by
 					   mem_hotplug_begin/end() */
-	int kswapd_order;
+	unsigned int kswapd_order;
 	enum zone_type kswapd_classzone_idx;
 
 	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
@@ -802,7 +802,7 @@ static inline bool pgdat_is_empty(pg_data_t *pgdat)
 #include <linux/memory_hotplug.h>
 
 void build_all_zonelists(pg_data_t *pgdat);
-void wakeup_kswapd(struct zone *zone, gfp_t gfp_mask, int order,
+void wakeup_kswapd(struct zone *zone, gfp_t gfp_mask, unsigned int order,
 		   enum zone_type classzone_idx);
 bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			 int classzone_idx, unsigned int alloc_flags,
diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index f83ba40f9614..34a9fac3b4d6 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -314,13 +314,13 @@ TRACE_EVENT(mm_compaction_kcompactd_sleep,
 
 DECLARE_EVENT_CLASS(kcompactd_wake_template,
 
-	TP_PROTO(int nid, int order, enum zone_type classzone_idx),
+	TP_PROTO(int nid, unsigned int order, enum zone_type classzone_idx),
 
 	TP_ARGS(nid, order, classzone_idx),
 
 	TP_STRUCT__entry(
 		__field(int, nid)
-		__field(int, order)
+		__field(unsigned int, order)
 		__field(enum zone_type, classzone_idx)
 	),
 
@@ -330,7 +330,7 @@ DECLARE_EVENT_CLASS(kcompactd_wake_template,
 		__entry->classzone_idx = classzone_idx;
 	),
 
-	TP_printk("nid=%d order=%d classzone_idx=%-8s",
+	TP_printk("nid=%d order=%u classzone_idx=%-8s",
 		__entry->nid,
 		__entry->order,
 		__print_symbolic(__entry->classzone_idx, ZONE_TYPE))
@@ -338,14 +338,14 @@ DECLARE_EVENT_CLASS(kcompactd_wake_template,
 
 DEFINE_EVENT(kcompactd_wake_template, mm_compaction_wakeup_kcompactd,
 
-	TP_PROTO(int nid, int order, enum zone_type classzone_idx),
+	TP_PROTO(int nid, unsigned int order, enum zone_type classzone_idx),
 
 	TP_ARGS(nid, order, classzone_idx)
 );
 
 DEFINE_EVENT(kcompactd_wake_template, mm_compaction_kcompactd_wake,
 
-	TP_PROTO(int nid, int order, enum zone_type classzone_idx),
+	TP_PROTO(int nid, unsigned int order, enum zone_type classzone_idx),
 
 	TP_ARGS(nid, order, classzone_idx)
 );
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index c37e2280e6dd..13c214f3750b 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -74,7 +74,7 @@ TRACE_EVENT(mm_vmscan_kswapd_wake,
 
 TRACE_EVENT(mm_vmscan_wakeup_kswapd,
 
-	TP_PROTO(int nid, int zid, int order, gfp_t gfp_flags),
+	TP_PROTO(int nid, int zid, unsigned int order, gfp_t gfp_flags),
 
 	TP_ARGS(nid, zid, order, gfp_flags),
 
@@ -92,7 +92,7 @@ TRACE_EVENT(mm_vmscan_wakeup_kswapd,
 		__entry->gfp_flags	= gfp_flags;
 	),
 
-	TP_printk("nid=%d order=%d gfp_flags=%s",
+	TP_printk("nid=%d order=%u gfp_flags=%s",
 		__entry->nid,
 		__entry->order,
 		show_gfp_flags(__entry->gfp_flags))
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f4fd02ae233e..9d98a2e5f736 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3781,8 +3781,8 @@ static enum zone_type kswapd_classzone_idx(pg_data_t *pgdat,
 	return pgdat->kswapd_classzone_idx;
 }
 
-static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
-				unsigned int classzone_idx)
+static void kswapd_try_to_sleep(pg_data_t *pgdat, unsigned int alloc_order,
+			unsigned int reclaim_order, unsigned int classzone_idx)
 {
 	long remaining = 0;
 	DEFINE_WAIT(wait);
@@ -3956,7 +3956,7 @@ static int kswapd(void *p)
  * has failed or is not needed, still wake up kcompactd if only compaction is
  * needed.
  */
-void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
+void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, unsigned int order,
 		   enum zone_type classzone_idx)
 {
 	pg_data_t *pgdat;
-- 
2.21.0

