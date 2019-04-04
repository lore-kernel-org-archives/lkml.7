Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A8AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA5B20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvfoo7sH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfDDXZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 19:25:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40532 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbfDDXZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 19:25:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so1937681plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 16:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pCFplwOQ1V6syt22TVMFsi+FnnScCeTibsJISzGk2dA=;
        b=Cvfoo7sHaJhH/VYUIV20JualJXCcNJn+l/NnoArIyNqahMemKh7mA4XjmlJ7AAfVX/
         51t0VtZ+K8iWVNX2ewUtE6Cku83GQJRG6fowpe+nW0gFB6Lepjx03KDAEHNcm6doORFS
         4G7+wfw3pkZiDGT3YqYoGCGwPrH3PoOM2g+Dnk2FmOiSpvu/U0Z6T745mM1XEsKUt8vO
         NXFY7NnCXTiZwmcdA8Ytwamgmk5N3/qSLltDBtaeo4wgAoe8VYcHmD46XjA7M8xPttcl
         s8cN07OulOJDBQDTlY/JjRqKutmh+IklN9gxMC7PHFy2pCJlcXGwN5r4DXm8DCST/W81
         jmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pCFplwOQ1V6syt22TVMFsi+FnnScCeTibsJISzGk2dA=;
        b=tUcmE4kTm96VTgm2RWNA6APOEZcHnSPJZ+Wr71KODYxnH7gqNWxC2r0LFE64nAmOBX
         I0uUZrFFZaGK7ObXNYw8ARxeD/IAZJBvJFSa6UcjSysMSQuqOZ7RFxBCDIFDSIUJXYkU
         EwghSgD/AoYi7FS+Sn5wxEG0qWjU1FaMwwxVCLTJ763SmRshiIhZ+7svKzrDW6ivtAfX
         wxmf8UXz5ZfMPawEcd1LGesWPUOz8iAsS70dfszDtSqvYrPkfUlV2pd4VBWkekqsoHvK
         /wVtcS0wfWKOtqt2qeXnHGnulnwF3a30pqhr9o6HATUxt1r98bDMwb2dyQ+Q8VBrQJcG
         gNag==
X-Gm-Message-State: APjAAAUyZuWMs16Pd4pfELfjeQaFvpPm313A9+NwWnVrqu/lIqJzKqUP
        /AJAkC+4OPMDSF87ySudHnE=
X-Google-Smtp-Source: APXvYqw9XN565FHAlKSSX9Le67yexrv1sMt2Q2LohH1ZbLbz368n8fLg9PjlxXgtC2+jSNxNG7ibzw==
X-Received: by 2002:a17:902:e110:: with SMTP id cc16mr9406903plb.147.1554420350860;
        Thu, 04 Apr 2019 16:25:50 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id e23sm28750036pfd.11.2019.04.04.16.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 16:25:50 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH 1/2] arm64: perf: Group common ARMv8 v3 PMU events in a macro
Date:   Thu,  4 Apr 2019 16:25:44 -0700
Message-Id: <20190404232545.2627-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404232545.2627-1-f.fainelli@gmail.com>
References: <20190404232545.2627-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding processor specific attributes, group the ARMv8
PMU v3 common events into a macro that can be re-used to fill up an
array of attributes.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/kernel/perf_event.c | 123 +++++++++++++++++----------------
 1 file changed, 63 insertions(+), 60 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 4addb38bc250..2d30922692b1 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -234,67 +234,70 @@ ARMV8_EVENT_ATTR(sample_feed, ARMV8_SPE_PERFCTR_SAMPLE_FEED);
 ARMV8_EVENT_ATTR(sample_filtrate, ARMV8_SPE_PERFCTR_SAMPLE_FILTRATE);
 ARMV8_EVENT_ATTR(sample_collision, ARMV8_SPE_PERFCTR_SAMPLE_COLLISION);
 
+#define ARMV8_PMUV3_EVENT_ATTRS					\
+	&armv8_event_attr_sw_incr.attr.attr,			\
+	&armv8_event_attr_l1i_cache_refill.attr.attr,		\
+	&armv8_event_attr_l1i_tlb_refill.attr.attr,		\
+	&armv8_event_attr_l1d_cache_refill.attr.attr,		\
+	&armv8_event_attr_l1d_cache.attr.attr,			\
+	&armv8_event_attr_l1d_tlb_refill.attr.attr,		\
+	&armv8_event_attr_ld_retired.attr.attr,			\
+	&armv8_event_attr_st_retired.attr.attr,			\
+	&armv8_event_attr_inst_retired.attr.attr,		\
+	&armv8_event_attr_exc_taken.attr.attr,			\
+	&armv8_event_attr_exc_return.attr.attr,			\
+	&armv8_event_attr_cid_write_retired.attr.attr,		\
+	&armv8_event_attr_pc_write_retired.attr.attr,		\
+	&armv8_event_attr_br_immed_retired.attr.attr,		\
+	&armv8_event_attr_br_return_retired.attr.attr,		\
+	&armv8_event_attr_unaligned_ldst_retired.attr.attr,	\
+	&armv8_event_attr_br_mis_pred.attr.attr,		\
+	&armv8_event_attr_cpu_cycles.attr.attr,			\
+	&armv8_event_attr_br_pred.attr.attr,			\
+	&armv8_event_attr_mem_access.attr.attr,			\
+	&armv8_event_attr_l1i_cache.attr.attr,			\
+	&armv8_event_attr_l1d_cache_wb.attr.attr,		\
+	&armv8_event_attr_l2d_cache.attr.attr,			\
+	&armv8_event_attr_l2d_cache_refill.attr.attr,		\
+	&armv8_event_attr_l2d_cache_wb.attr.attr,		\
+	&armv8_event_attr_bus_access.attr.attr,			\
+	&armv8_event_attr_memory_error.attr.attr,		\
+	&armv8_event_attr_inst_spec.attr.attr,			\
+	&armv8_event_attr_ttbr_write_retired.attr.attr,		\
+	&armv8_event_attr_bus_cycles.attr.attr,			\
+	&armv8_event_attr_l1d_cache_allocate.attr.attr,		\
+	&armv8_event_attr_l2d_cache_allocate.attr.attr,		\
+	&armv8_event_attr_br_retired.attr.attr,			\
+	&armv8_event_attr_br_mis_pred_retired.attr.attr,	\
+	&armv8_event_attr_stall_frontend.attr.attr,		\
+	&armv8_event_attr_stall_backend.attr.attr,		\
+	&armv8_event_attr_l1d_tlb.attr.attr,			\
+	&armv8_event_attr_l1i_tlb.attr.attr,			\
+	&armv8_event_attr_l2i_cache.attr.attr,			\
+	&armv8_event_attr_l2i_cache_refill.attr.attr,		\
+	&armv8_event_attr_l3d_cache_allocate.attr.attr,		\
+	&armv8_event_attr_l3d_cache_refill.attr.attr,		\
+	&armv8_event_attr_l3d_cache.attr.attr,			\
+	&armv8_event_attr_l3d_cache_wb.attr.attr,		\
+	&armv8_event_attr_l2d_tlb_refill.attr.attr,		\
+	&armv8_event_attr_l2i_tlb_refill.attr.attr,		\
+	&armv8_event_attr_l2d_tlb.attr.attr,			\
+	&armv8_event_attr_l2i_tlb.attr.attr,			\
+	&armv8_event_attr_remote_access.attr.attr,		\
+	&armv8_event_attr_ll_cache.attr.attr,			\
+	&armv8_event_attr_ll_cache_miss.attr.attr,		\
+	&armv8_event_attr_dtlb_walk.attr.attr,			\
+	&armv8_event_attr_itlb_walk.attr.attr,			\
+	&armv8_event_attr_ll_cache_rd.attr.attr,		\
+	&armv8_event_attr_ll_cache_miss_rd.attr.attr,		\
+	&armv8_event_attr_remote_access_rd.attr.attr,		\
+	&armv8_event_attr_sample_pop.attr.attr,			\
+	&armv8_event_attr_sample_feed.attr.attr,		\
+	&armv8_event_attr_sample_filtrate.attr.attr,		\
+	&armv8_event_attr_sample_collision.attr.attr,		\
+
 static struct attribute *armv8_pmuv3_event_attrs[] = {
-	&armv8_event_attr_sw_incr.attr.attr,
-	&armv8_event_attr_l1i_cache_refill.attr.attr,
-	&armv8_event_attr_l1i_tlb_refill.attr.attr,
-	&armv8_event_attr_l1d_cache_refill.attr.attr,
-	&armv8_event_attr_l1d_cache.attr.attr,
-	&armv8_event_attr_l1d_tlb_refill.attr.attr,
-	&armv8_event_attr_ld_retired.attr.attr,
-	&armv8_event_attr_st_retired.attr.attr,
-	&armv8_event_attr_inst_retired.attr.attr,
-	&armv8_event_attr_exc_taken.attr.attr,
-	&armv8_event_attr_exc_return.attr.attr,
-	&armv8_event_attr_cid_write_retired.attr.attr,
-	&armv8_event_attr_pc_write_retired.attr.attr,
-	&armv8_event_attr_br_immed_retired.attr.attr,
-	&armv8_event_attr_br_return_retired.attr.attr,
-	&armv8_event_attr_unaligned_ldst_retired.attr.attr,
-	&armv8_event_attr_br_mis_pred.attr.attr,
-	&armv8_event_attr_cpu_cycles.attr.attr,
-	&armv8_event_attr_br_pred.attr.attr,
-	&armv8_event_attr_mem_access.attr.attr,
-	&armv8_event_attr_l1i_cache.attr.attr,
-	&armv8_event_attr_l1d_cache_wb.attr.attr,
-	&armv8_event_attr_l2d_cache.attr.attr,
-	&armv8_event_attr_l2d_cache_refill.attr.attr,
-	&armv8_event_attr_l2d_cache_wb.attr.attr,
-	&armv8_event_attr_bus_access.attr.attr,
-	&armv8_event_attr_memory_error.attr.attr,
-	&armv8_event_attr_inst_spec.attr.attr,
-	&armv8_event_attr_ttbr_write_retired.attr.attr,
-	&armv8_event_attr_bus_cycles.attr.attr,
-	&armv8_event_attr_l1d_cache_allocate.attr.attr,
-	&armv8_event_attr_l2d_cache_allocate.attr.attr,
-	&armv8_event_attr_br_retired.attr.attr,
-	&armv8_event_attr_br_mis_pred_retired.attr.attr,
-	&armv8_event_attr_stall_frontend.attr.attr,
-	&armv8_event_attr_stall_backend.attr.attr,
-	&armv8_event_attr_l1d_tlb.attr.attr,
-	&armv8_event_attr_l1i_tlb.attr.attr,
-	&armv8_event_attr_l2i_cache.attr.attr,
-	&armv8_event_attr_l2i_cache_refill.attr.attr,
-	&armv8_event_attr_l3d_cache_allocate.attr.attr,
-	&armv8_event_attr_l3d_cache_refill.attr.attr,
-	&armv8_event_attr_l3d_cache.attr.attr,
-	&armv8_event_attr_l3d_cache_wb.attr.attr,
-	&armv8_event_attr_l2d_tlb_refill.attr.attr,
-	&armv8_event_attr_l2i_tlb_refill.attr.attr,
-	&armv8_event_attr_l2d_tlb.attr.attr,
-	&armv8_event_attr_l2i_tlb.attr.attr,
-	&armv8_event_attr_remote_access.attr.attr,
-	&armv8_event_attr_ll_cache.attr.attr,
-	&armv8_event_attr_ll_cache_miss.attr.attr,
-	&armv8_event_attr_dtlb_walk.attr.attr,
-	&armv8_event_attr_itlb_walk.attr.attr,
-	&armv8_event_attr_ll_cache_rd.attr.attr,
-	&armv8_event_attr_ll_cache_miss_rd.attr.attr,
-	&armv8_event_attr_remote_access_rd.attr.attr,
-	&armv8_event_attr_sample_pop.attr.attr,
-	&armv8_event_attr_sample_feed.attr.attr,
-	&armv8_event_attr_sample_filtrate.attr.attr,
-	&armv8_event_attr_sample_collision.attr.attr,
+	ARMV8_PMUV3_EVENT_ATTRS
 	NULL,
 };
 
-- 
2.17.1

