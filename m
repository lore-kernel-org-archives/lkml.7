Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9498C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E95218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4CPjcvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfCAGY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:24:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39406 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfCAGY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:24:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id b65so7949006plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 22:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3DFH9A64SknMlWuqRsGigvNh6nJnuZv0yy/7Ja82OxA=;
        b=G4CPjcvBv4cz96reYJ+ifIifq5mmB4np63b07pIqN4y6UesrsXOq0jzUF/MYBJadvi
         hEAZEu55llp/C1lBvnk1YUtHke0g4y8HCDrMZsDERgJYfwqdqHZVCZMEJZlBLGtF24mD
         NyCgT50podPsi6kp4elYMWsY+uoLDGRnNREAb6Ag/TS99bp4YUr71/FGKMqJAXqjxXOV
         v7udUrPAmUFvANLomz6vyCu25jgknSuYZFBToN18wgpOnibjPpDbE93zHxQhSj63ssH3
         Rm4ry0ozA0KE5AcJFgF8wZNxi3MDscastGevcDIKdjYd3d/9VFe4JWiFziDvH2Qe4Xqh
         2h7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3DFH9A64SknMlWuqRsGigvNh6nJnuZv0yy/7Ja82OxA=;
        b=P5MhmPJOXVg6ri/2ZxJ+PMsm2M6G57CDMepOTjnUudYidGt/nfC7eWVEMIEhldMPRc
         UMQlOJh4/2ullJvTFEW5spMv2r2YUb4rlwkFk68p5XsxbQJYuEjl9SOjipbXV/qHGv8o
         R0d/nE838pACjYLxVNuCN/CnWki3EwexEST2uudNIfTlSucF6n9R5J2qE1bBkRX6SBAb
         qlUe4XxGOkNLEW020WoXKS65TmtSJX4YfjhRjy7q7hvU1gMTRngaxVGa8X43UrdR1Eem
         8GAtCmSo7Fvh+AwFy0ToQ31t7nFsIxRk9TcTf5BiwnLZcYLOJzX+8Oe+QJqWhgBNcwaG
         0Q4A==
X-Gm-Message-State: APjAAAVgUM0Uk5c41nKm+zPYIXUsmIdCAUay41I2n8PuQoHbgEWc37H5
        /3ppGY/eETfdIUeBIntCd/E=
X-Google-Smtp-Source: APXvYqwTKPRZ0kkuDyl80bl1AWb8Wpd4x33/ZE5wiUlE1M+q/SKLO2pyvL6/iz6iJGZ95CfHSFyEIw==
X-Received: by 2002:a17:902:788d:: with SMTP id q13mr3851492pll.154.1551421495329;
        Thu, 28 Feb 2019 22:24:55 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x8sm42023713pfe.1.2019.02.28.22.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 22:24:54 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     vbabka@suse.cz, mhocko@suse.com, jrdr.linux@gmail.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] mm: vmscan: drop may_writepage and classzone_idx from direct reclaim begin template
Date:   Fri,  1 Mar 2019 14:24:12 +0800
Message-Id: <1551421452-5385-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551421452-5385-1-git-send-email-laoar.shao@gmail.com>
References: <1551421452-5385-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three tracepoints using this template, which are
mm_vmscan_direct_reclaim_begin,
mm_vmscan_memcg_reclaim_begin,
mm_vmscan_memcg_softlimit_reclaim_begin.

Regarding mm_vmscan_direct_reclaim_begin,
sc.may_writepage is !laptop_mode, that's a static setting, and
reclaim_idx is derived from gfp_mask which is already show in this
tracepoint.

Regarding mm_vmscan_memcg_reclaim_begin,
may_writepage is !laptop_mode too, and reclaim_idx is (MAX_NR_ZONES-1),
which are both static value.

mm_vmscan_memcg_softlimit_reclaim_begin is the same with
mm_vmscan_memcg_reclaim_begin.

So we can drop them all.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/vmscan.h | 26 ++++++++++----------------
 mm/vmscan.c                   | 14 +++-----------
 2 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index a1cb913..153d90c 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -105,51 +105,45 @@
 
 DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
 
-	TP_PROTO(int order, int may_writepage, gfp_t gfp_flags, int classzone_idx),
+	TP_PROTO(int order, gfp_t gfp_flags),
 
-	TP_ARGS(order, may_writepage, gfp_flags, classzone_idx),
+	TP_ARGS(order, gfp_flags),
 
 	TP_STRUCT__entry(
 		__field(	int,	order		)
-		__field(	int,	may_writepage	)
 		__field(	gfp_t,	gfp_flags	)
-		__field(	int,	classzone_idx	)
 	),
 
 	TP_fast_assign(
 		__entry->order		= order;
-		__entry->may_writepage	= may_writepage;
 		__entry->gfp_flags	= gfp_flags;
-		__entry->classzone_idx	= classzone_idx;
 	),
 
-	TP_printk("order=%d may_writepage=%d gfp_flags=%s classzone_idx=%d",
+	TP_printk("order=%d gfp_flags=%s",
 		__entry->order,
-		__entry->may_writepage,
-		show_gfp_flags(__entry->gfp_flags),
-		__entry->classzone_idx)
+		show_gfp_flags(__entry->gfp_flags))
 );
 
 DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_direct_reclaim_begin,
 
-	TP_PROTO(int order, int may_writepage, gfp_t gfp_flags, int classzone_idx),
+	TP_PROTO(int order, gfp_t gfp_flags),
 
-	TP_ARGS(order, may_writepage, gfp_flags, classzone_idx)
+	TP_ARGS(order, gfp_flags)
 );
 
 #ifdef CONFIG_MEMCG
 DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_reclaim_begin,
 
-	TP_PROTO(int order, int may_writepage, gfp_t gfp_flags, int classzone_idx),
+	TP_PROTO(int order, gfp_t gfp_flags),
 
-	TP_ARGS(order, may_writepage, gfp_flags, classzone_idx)
+	TP_ARGS(order, gfp_flags)
 );
 
 DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_softlimit_reclaim_begin,
 
-	TP_PROTO(int order, int may_writepage, gfp_t gfp_flags, int classzone_idx),
+	TP_PROTO(int order, gfp_t gfp_flags),
 
-	TP_ARGS(order, may_writepage, gfp_flags, classzone_idx)
+	TP_ARGS(order, gfp_flags)
 );
 #endif /* CONFIG_MEMCG */
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ac4806f..cdc0305 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3304,10 +3304,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 	if (throttle_direct_reclaim(sc.gfp_mask, zonelist, nodemask))
 		return 1;
 
-	trace_mm_vmscan_direct_reclaim_begin(order,
-				sc.may_writepage,
-				sc.gfp_mask,
-				sc.reclaim_idx);
+	trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
 
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 
@@ -3338,9 +3335,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 			(GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK);
 
 	trace_mm_vmscan_memcg_softlimit_reclaim_begin(sc.order,
-						      sc.may_writepage,
-						      sc.gfp_mask,
-						      sc.reclaim_idx);
+						      sc.gfp_mask);
 
 	/*
 	 * NOTE: Although we can get the priority field, using it
@@ -3389,10 +3384,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 
 	zonelist = &NODE_DATA(nid)->node_zonelists[ZONELIST_FALLBACK];
 
-	trace_mm_vmscan_memcg_reclaim_begin(0,
-					    sc.may_writepage,
-					    sc.gfp_mask,
-					    sc.reclaim_idx);
+	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
 
 	psi_memstall_enter(&pflags);
 	noreclaim_flag = memalloc_noreclaim_save();
-- 
1.8.3.1

