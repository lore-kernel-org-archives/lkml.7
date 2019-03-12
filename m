Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E805BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B51217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gw9+V7Aw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfCLWeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:34:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44893 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfCLWeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:34:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id a3so2841569pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 15:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WITBUxeGSIQmxb1SdGnY+GHNprTyqfSQ+9QDULNZwIA=;
        b=gw9+V7AwT9BhELUS3izGcpK1i9cnVisDnS7huiwO0ueQQsRqDBRQcs9no5AD+mhOyZ
         exFVmMPw2TSbuSfU8RXhszBVIq2IRNjzA4mtCnLvggeTueonNHnhfmfvwJ+wWdMmuxif
         yfx6/r60CWxsOd4dvu0akIYSbexXfK9B4teuwUDLfkU5M1U/dIBlf6sk6I6RmOwOBDVZ
         ja8lbvLfjJk5bfajgTjeRrYumvVtsEtu3PLcP5IKHOiElvMZD5ehmsZ2yc5wfpWM81N6
         2TH47iyF59ke+rxd5q+hAEHm1suK/m//n0NPrp9baJtPSctDOiPqvetpX4V/0zHsad1W
         E3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WITBUxeGSIQmxb1SdGnY+GHNprTyqfSQ+9QDULNZwIA=;
        b=k/aKD5/abXra2kqrEXF1ewBVAdITweJOLQ62XD20YD/tqYWc5jK+2KzpXyFJXyvy90
         pjr5s3wPkdQ+oOpLnPYz702W9DytTMJ6RiYq1C5UdyuWdopVpd960umOpkpp+8NaiEU6
         Rj3HcTCxYKy36BEA7bJHD7XnulIOMxZSu2O++Ol6eEHbR73n8B70xUTuapVx+KeOrL2p
         hVV7l6dglsZ30zWB9k+X3F5AheBNcFxcJu+qdE5xfWxfbqxOmef+Nh9OXMnRBh8Kuhm9
         vGX0ZDp57Et6QQMbvOQv3B2KHpV75ieV35NcgOSCvHoKVUTNcnRJryOfKLDODQE7fzDu
         3ywg==
X-Gm-Message-State: APjAAAXWpC05jJuz3W+D1zmaK2a+6M8Xuz/NpW4SgF6i8FYSDz2yGni4
        XmtaRHXksBHRxfQ4UWZB79DKqHXhhsM=
X-Google-Smtp-Source: APXvYqwOCTEzdCd46KHhbLhv+IK8K9xe2Y6ShvmFeW2wxLpyyyNkLKjIUagfAk+pvoSIv5NI7DyUlg==
X-Received: by 2002:a63:7e0e:: with SMTP id z14mr37330494pgc.436.1552430052235;
        Tue, 12 Mar 2019 15:34:12 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::1:3203])
        by smtp.gmail.com with ESMTPSA id i13sm14680592pfo.106.2019.03.12.15.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 15:34:11 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 3/6] mm: release memcg percpu data prematurely
Date:   Tue, 12 Mar 2019 15:34:00 -0700
Message-Id: <20190312223404.28665-4-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312223404.28665-1-guro@fb.com>
References: <20190312223404.28665-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reduce the memory footprint of a dying memory cgroup, let's
release massive percpu data (vmstats_percpu) as early as possible,
and use atomic counterparts instead.

A dying cgroup can remain in the dying state for quite a long
time, being pinned in memory by any reference. For example,
if a page mlocked by some other cgroup, is charged to the dying
cgroup, it won't go away until the page will be released.

A dying memory cgroup can have some memory activity (e.g. dirty
pages can be flushed after cgroup removal), but in general it's
not expected to be very active in comparison to living cgroups.

So reducing the memory footprint by releasing percpu data
and switching over to atomics seems to be a good trade off.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h |  4 ++++
 mm/memcontrol.c            | 24 +++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 8ac04632002a..569337514230 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -275,6 +275,10 @@ struct mem_cgroup {
 
 	/* memory.stat */
 	struct memcg_vmstats_percpu __rcu /* __percpu */ *vmstats_percpu;
+	struct memcg_vmstats_percpu __percpu *vmstats_percpu_offlined;
+
+	/* used to release non-used percpu memory */
+	struct rcu_head rcu;
 
 	MEMCG_PADDING(_pad2_);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5ef4098f3f8d..efd5bc131a38 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4470,7 +4470,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
 	for_each_node(node)
 		free_mem_cgroup_per_node_info(memcg, node);
-	free_percpu(memcg->vmstats_percpu);
+	WARN_ON_ONCE(memcg->vmstats_percpu != NULL);
 	kfree(memcg);
 }
 
@@ -4613,6 +4613,26 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	return 0;
 }
 
+static void percpu_rcu_free(struct rcu_head *rcu)
+{
+	struct mem_cgroup *memcg = container_of(rcu, struct mem_cgroup, rcu);
+
+	free_percpu(memcg->vmstats_percpu_offlined);
+	WARN_ON_ONCE(memcg->vmstats_percpu);
+
+	css_put(&memcg->css);
+}
+
+static void mem_cgroup_offline_percpu(struct mem_cgroup *memcg)
+{
+	memcg->vmstats_percpu_offlined = (struct memcg_vmstats_percpu __percpu*)
+		rcu_dereference(memcg->vmstats_percpu);
+	rcu_assign_pointer(memcg->vmstats_percpu, NULL);
+
+	css_get(&memcg->css);
+	call_rcu(&memcg->rcu, percpu_rcu_free);
+}
+
 static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
@@ -4639,6 +4659,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	drain_all_stock(memcg);
 
 	mem_cgroup_id_put(memcg);
+
+	mem_cgroup_offline_percpu(memcg);
 }
 
 static void mem_cgroup_css_released(struct cgroup_subsys_state *css)
-- 
2.20.1

