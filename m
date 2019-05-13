Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87258C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E58021473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557770389;
	bh=a9uAbRK5/5m9t0FDgwu6d4iu88MwycDfsnjmPpV6+Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=SWq7IqNQHNMQ5hliqTMJKc9BuLRLO5haRrJu/rVPnC/zFVYRakbKXV0NcQLp7zmhn
	 iJJPceRqEHhY2qg9RUlhaGIKYrow6kkk1hKEbZ1fs8hbmsikzSVHtCeTT3m4GuPaGn
	 y1hLv1VWA+OMc4OlOwanIaRmxVxFEvCBLHFRHA1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732183AbfEMR7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:59:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38204 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732167AbfEMR7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:59:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so7149475pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=Z71GcKSEW2yozRMqKRKdCmHVIZSDcnANBFWNGtvu1ok=;
        b=oVjN6mPSIATPA9EbQ1SbCu2VSUnGk8a25O+1p/Ew0caEhAE4nw47ZNXsceUdC6taqM
         WWlVQ5HsjdtMkbtToFLCmPEzu1GwvBCHqx/wlF85EmA5KwK0wtUSCbqnMj3RLQf0WNMI
         xXEOh4G8HlEyYNbxC7CWXM5KYzjO3b9EGlFZ8AtQzSdGUmCzAcxjtndOF/IWaMbPoSFv
         qdy93c7pLldnMwOEU0848wbeD0VOV0hb+v14UnNlE7sfNS+xS0ZeRBdvEZxCcAEnhxHL
         hWKC+NZPvxc4sg2xKXhraYquKs3NRotOSv3aJr+TJanv65sUXMpTnmiRAWzpRriQFlve
         YFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=Z71GcKSEW2yozRMqKRKdCmHVIZSDcnANBFWNGtvu1ok=;
        b=gZ5ethLErBUwLaODyD6/fPyKc69m7JD4lxXTP/wTZO2d83WS991lwT5Zbb+OR+VbST
         Pnce1h2eVCjUo1wlwkOs6O1DQxrNGxN/jAIZIFkCOWZ6Ri7GWCDIEBqBYx0JpOEGiUI6
         cxX4yaePmEIJaLUB/SNkzxHLEvRoHGtvV39bJr1o3ibvM6sQYWhjCA/4gXt2ppwINs5k
         thI+ibOwxqdy7GKQg+w2TiuqfWoKL70oBX4itWFjM9b4cwPZDY1roh2G4t0fWUrTVv25
         Dx2sY5vk3QDWS648qcXutQiNg/kUau9oidTDtCcskMg6E6yl3dzgG7CD7wK8IBk+ewe+
         bDeQ==
X-Gm-Message-State: APjAAAUMzKx06CJjAGZ1LYVCqxQuwMiuzs+gOo7LONrAzJ01EjNp4RmZ
        ZohVzYxfVr5AGkBgNffzRua6IGmk
X-Google-Smtp-Source: APXvYqxsvFjy9YTAKDVrYl9I+B44WO3rG59F+2zy64Lc0MQMAZaLFx0RBfG862DjK0oUJz75gbj9hQ==
X-Received: by 2002:a63:1344:: with SMTP id 4mr32641949pgt.448.1557770383896;
        Mon, 13 May 2019 10:59:43 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:43 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 19/19] perf/x86/intel/rapl: Cosmetic rename internal variables in response to multi-die/pkg support
Date:   Mon, 13 May 2019 13:59:03 -0400
Message-Id: <0ddb97e121397d37933233da303556141814fa47.1557769318.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
References: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Syntax update only -- no logical or functional change.

In response to the new multi-die/package changes, update variable names
to use "die" terminology, instead of "pkg".

For previous platforms which doesn't have multi-die, "die" is identical
as "pkg".

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/events/intel/rapl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 6f5331271563..3992b0e65a55 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -148,7 +148,7 @@ struct rapl_pmu {
 
 struct rapl_pmus {
 	struct pmu		pmu;
-	unsigned int		maxpkg;
+	unsigned int		maxdie;
 	struct rapl_pmu		*pmus[];
 };
 
@@ -161,13 +161,13 @@ static u64 rapl_timer_ms;
 
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
-	unsigned int pkgid = topology_logical_die_id(cpu);
+	unsigned int dieid = topology_logical_die_id(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
 	 * existent mappings in the topology map.
 	 */
-	return pkgid < rapl_pmus->maxpkg ? rapl_pmus->pmus[pkgid] : NULL;
+	return dieid < rapl_pmus->maxdie ? rapl_pmus->pmus[dieid] : NULL;
 }
 
 static inline u64 rapl_read_counter(struct perf_event *event)
@@ -668,22 +668,22 @@ static void cleanup_rapl_pmus(void)
 {
 	int i;
 
-	for (i = 0; i < rapl_pmus->maxpkg; i++)
+	for (i = 0; i < rapl_pmus->maxdie; i++)
 		kfree(rapl_pmus->pmus[i]);
 	kfree(rapl_pmus);
 }
 
 static int __init init_rapl_pmus(void)
 {
-	int maxpkg = topology_max_packages() * topology_max_die_per_package();
+	int maxdie = topology_max_packages() * topology_max_die_per_package();
 	size_t size;
 
-	size = sizeof(*rapl_pmus) + maxpkg * sizeof(struct rapl_pmu *);
+	size = sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
 	rapl_pmus = kzalloc(size, GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
 
-	rapl_pmus->maxpkg		= maxpkg;
+	rapl_pmus->maxdie		= maxdie;
 	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
 	rapl_pmus->pmu.task_ctx_nr	= perf_invalid_context;
 	rapl_pmus->pmu.event_init	= rapl_pmu_event_init;
-- 
2.18.0-rc0

