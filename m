Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B9CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9688E2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asrjgDHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfCAGYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:24:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47024 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfCAGYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:24:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so10919122pfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 22:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8tvRd6fIqSB+oUvP7zx+obfq/b3yUnFPtsGhX5I/8tw=;
        b=asrjgDHDlJesfSEO0PZMELjUGD4bdP7kiKSmL1/IlWEuQYl7vKWFdaHPqyMLBr7JTX
         sCxcXmN78/Mpiqfi2DjyKNRhWeZQwUjyQVD65NZXt7dA4tpywWw2Bhb+yGL9eHrIWXbO
         q6SjGtyjsAfMtyt9PqoW1kvKNmT7HKL426jxB8ZTNeGTf+5x6rDPGENTk8gaBMe4zEj9
         b/PxHVXOZNAyDeAErykyLnG86/iZAnD0t8xHLOhk9OaDgYLnMIBm1ai7AnaaLGx6CDwB
         E361LRqpeyeoZm4f29Z/xLgfKRu2qHrS862UyP5FgrPWH5I/kb4Kml+W95TA6OVDrmy9
         TwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8tvRd6fIqSB+oUvP7zx+obfq/b3yUnFPtsGhX5I/8tw=;
        b=Oh3sCr93M+cyx4+abuYIxKaprBdrlQYjwaNF47gjeNsgjoJJWB50uLkeIaNNH36jy5
         h7weqdhnfj3YdGhFN3wxz9NsXeXeX8NZssLzS8oEN0BTK9boYKu2mRdeONf2h0cAOW65
         c/L3ZzmQrm3Xy6IAOV9Vq6gdotzLEzR/ACfSB2EjC+HxJM9AalyFNooTWbJ03daoSJbC
         VOsjOroSRVEF8iJNMWQMFolkm075HMPWxM56jRCyFtB+cGPSfrFgJDxnfVJHwBeMeewM
         iYq3t/IB2Zz7nAtJg8k+hcmSU2wN8lb3U9o14xtRbXYfX+Y4bzTkLvWAuN/1vKn+tkz8
         GXKg==
X-Gm-Message-State: APjAAAV7UWouk5HBFMG/AI9NQEKaNkKElBCSGozHWR+lmSJfgjtOc793
        dgpvbSNDwN5lwFUd/tDlDH49GCZwxUg=
X-Google-Smtp-Source: APXvYqwfRMjnThftvGhj6v3EH0/e+xZfINP3JV7v+UgAMwVJCin7+8dVBCj9cpygYWDcbJ1bU35+8w==
X-Received: by 2002:a63:dc54:: with SMTP id f20mr3331481pgj.410.1551421489294;
        Thu, 28 Feb 2019 22:24:49 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x8sm42023713pfe.1.2019.02.28.22.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 22:24:48 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     vbabka@suse.cz, mhocko@suse.com, jrdr.linux@gmail.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2] mm: vmscan: add tracepoints for node reclaim
Date:   Fri,  1 Mar 2019 14:24:11 +0800
Message-Id: <1551421452-5385-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the page alloc fast path, it may do node reclaim, which may cause
latency spike.
We should add tracepoint for this event, and also measure the latency
it causes.

So bellow two tracepoints are introduced,
	mm_vmscan_node_reclaim_begin
	mm_vmscan_node_reclaim_end

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/vmscan.h | 32 ++++++++++++++++++++++++++++++++
 mm/vmscan.c                   |  6 ++++++
 2 files changed, 38 insertions(+)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index a1cb913..c1ddf28 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -465,6 +465,38 @@
 		__entry->ratio,
 		show_reclaim_flags(__entry->reclaim_flags))
 );
+
+TRACE_EVENT(mm_vmscan_node_reclaim_begin,
+
+	TP_PROTO(int nid, int order, gfp_t gfp_flags),
+
+	TP_ARGS(nid, order, gfp_flags),
+
+	TP_STRUCT__entry(
+		__field(int, nid)
+		__field(int, order)
+		__field(gfp_t, gfp_flags)
+	),
+
+	TP_fast_assign(
+		__entry->nid = nid;
+		__entry->order = order;
+		__entry->gfp_flags = gfp_flags;
+	),
+
+	TP_printk("nid=%d order=%d gfp_flags=%s",
+		__entry->nid,
+		__entry->order,
+		show_gfp_flags(__entry->gfp_flags))
+);
+
+DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_node_reclaim_end,
+
+	TP_PROTO(unsigned long nr_reclaimed),
+
+	TP_ARGS(nr_reclaimed)
+);
+
 #endif /* _TRACE_VMSCAN_H */
 
 /* This part must be outside protection */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ac4806f..2bee5d1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4241,6 +4241,9 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 		.reclaim_idx = gfp_zone(gfp_mask),
 	};
 
+	trace_mm_vmscan_node_reclaim_begin(pgdat->node_id, order,
+					   sc.gfp_mask);
+
 	cond_resched();
 	fs_reclaim_acquire(sc.gfp_mask);
 	/*
@@ -4267,6 +4270,9 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 	current->flags &= ~PF_SWAPWRITE;
 	memalloc_noreclaim_restore(noreclaim_flag);
 	fs_reclaim_release(sc.gfp_mask);
+
+	trace_mm_vmscan_node_reclaim_end(sc.nr_reclaimed);
+
 	return sc.nr_reclaimed >= nr_pages;
 }
 
-- 
1.8.3.1

