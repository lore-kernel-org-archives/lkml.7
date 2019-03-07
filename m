Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6D0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4AE2147A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="os1d9NLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfCGXAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:00:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33361 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCGXAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:00:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id i19so12611006pfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 15:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQTP2I1IGTAHWCfjeZNx8sn2B6cnWOl+ZJBV9SuBK5k=;
        b=os1d9NLEH5YF0msLsK9q6RDbE3XUiJPCFohANPKSxtyy1x/weqPxw5h9t+FkSwtb+9
         saeQFtoUHoBKFJasOMziLWJlyrqai9AU7rUCxmaiyWN5dE7t1mi2fYabAXmOvFRwbK/v
         dH9lNacjzQFRf+ia+gZQGZm8ZmRvl3FRXnt9eYMPesZ5xe6i/oC+USIAcfXUri7eXDCV
         bMWVeR5OD3oIIWdgoP/mz2x/zWuhPgEhzIJ1NiBqqtmSMCpZpsWbCakalGsqdNT/htmf
         dE7pCH1s6pZXaYOsvVhNaz6SWXisByM0sEPp9jVJEFN7bbWPi0Urx7ssMWxDxyGmVT3X
         jPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQTP2I1IGTAHWCfjeZNx8sn2B6cnWOl+ZJBV9SuBK5k=;
        b=UtqVFykYIZ656AdwegDiULSopc+kLR7SaxR8yn0q8Wp1f/rkMOI7x3U/i5bmMRlcQB
         81Kbnbj3sINSdefb+iafuwDdtmZWsSBrSEJlnUOlJzyI/XpVLB9VBMXgtmgiRPGfXRLB
         ejeaKUY1Dd+LjHL6BcVS+lKbezhi3BQeIUHjh87n4pXRAg+X9bIueDdWkMnUH4ceYJoa
         BvvjAlA0l9Gb4jbD9VIB308L6ybVXn89NfFt0cU5ujrelGoHO0EVLy5Sukza7R9MGLle
         qnf8hekpRQt7eqt7bo68Iq0r3670rk7uWfIm1OwD14XTddnMBzRnZZnRnGXPMOOAC4LJ
         n+5g==
X-Gm-Message-State: APjAAAU92XAVbMvTIA4wcMufC8NOBClh4Vv7bx568cUg9c/C9XAU1MRB
        sNX+z0frI4DCQ8L5PmmzHiA=
X-Google-Smtp-Source: APXvYqzuaBCXJLZFV1Hn/0UeWiWtkt2B6OPUoPpFb7ChIAkLJsa7GOYp5MTkoZaxbfQmXh2nd3BiVA==
X-Received: by 2002:a63:4e1d:: with SMTP id c29mr13842615pgb.433.1551999640819;
        Thu, 07 Mar 2019 15:00:40 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::2:d18b])
        by smtp.gmail.com with ESMTPSA id i126sm11864806pfb.15.2019.03.07.15.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 15:00:40 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH 3/5] mm: release memcg percpu data prematurely
Date:   Thu,  7 Mar 2019 15:00:31 -0800
Message-Id: <20190307230033.31975-4-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307230033.31975-1-guro@fb.com>
References: <20190307230033.31975-1-guro@fb.com>
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
index 8f3cac02221a..8c55954e6f23 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4469,7 +4469,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
 	for_each_node(node)
 		free_mem_cgroup_per_node_info(memcg, node);
-	free_percpu(memcg->vmstats_percpu);
+	WARN_ON_ONCE(memcg->vmstats_percpu != NULL);
 	kfree(memcg);
 }
 
@@ -4612,6 +4612,26 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	return 0;
 }
 
+static void mem_cgroup_free_percpu(struct rcu_head *rcu)
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
+	call_rcu(&memcg->rcu, mem_cgroup_free_percpu);
+}
+
 static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
@@ -4638,6 +4658,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	drain_all_stock(memcg);
 
 	mem_cgroup_id_put(memcg);
+
+	mem_cgroup_offline_percpu(memcg);
 }
 
 static void mem_cgroup_css_released(struct cgroup_subsys_state *css)
-- 
2.20.1

