Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5568EC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B552146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDD+JwIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfCMSkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:40:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44860 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfCMSkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:40:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id a3so1975355pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WITBUxeGSIQmxb1SdGnY+GHNprTyqfSQ+9QDULNZwIA=;
        b=hDD+JwIeip0gJspQJIlifBLo3RZkJBVwzeLhOJ71FgqywT6SXzvZP9DGDEs867pwdR
         WO8p8O0KNF1rt/jZhEK7qRkFmJuWonuupzsv25wmsIUlubrGq2+uI/WUOazBl55WoERs
         6UGSTlw8yD5nIom+ZJg9sOINX3RB3BWpRWxKCIaOMpU3i5NEQIlcg9w7rqfEpTjqevdR
         Ld2PdY9k3jCJEkbbVafk5rGX8TJUQ4ZkcPAQoycBwKqG3ienRmFTdSplpjS6WxomRczi
         beS9hglAoeVCRuUSVrSHU2CeKJUnBfeBNkiuJhuizLUdgu8x9wOBdrgC0POHx/euvdoo
         Zy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WITBUxeGSIQmxb1SdGnY+GHNprTyqfSQ+9QDULNZwIA=;
        b=lYMSYz/bHh75mlXFU6PC6khLz+lPpJSZXheDZJKUd3jqje37LjWc3rG7LD+yQsVCed
         P5MUaTB3CKPIYjF0mOwQjc3LrllInNcQrTT1I2/KPNcVKEXJWzh0WsS5hha3mcN+SKLl
         q3Saojy9UfHurRNxi45pfgiiAmIy9QmdBe+pSEBLpiSnPfsD6EzFP1OLzlsBT5X97Ixe
         xZjMjPED066nCqI0r/s8FmgOANkYI509C/CU6taRJUN+SIb9pMCtcYt7PyDH0PDw3zg2
         aNicudzfXp72pRC1CU5z9NoXnRDrzgjjPEvAQqUOQ8/+HBLdVHCLuOa60xWWrLUl1dsi
         ckTg==
X-Gm-Message-State: APjAAAWQJ9O1P48iQh+6U0EyyZ8V3L8H4bjbVrsvH/kFnyeNO/em2KYf
        CUfRQxKYykwpgPWgNeKd/M0dcB3HD/Q=
X-Google-Smtp-Source: APXvYqwpwjKd2OLLFUS/RUgUqKYXyrVqeFcG3DA+RFLUuCtoNO4f0ufr+hHUm2yNJIlTPoM2CaI/SQ==
X-Received: by 2002:a63:cd02:: with SMTP id i2mr41652810pgg.111.1552502404731;
        Wed, 13 Mar 2019 11:40:04 -0700 (PDT)
Received: from castle.hsd1.ca.comcast.net ([2603:3024:1704:3e00::d657])
        by smtp.gmail.com with ESMTPSA id i13sm15792562pgq.17.2019.03.13.11.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 11:40:03 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v3 3/6] mm: release memcg percpu data prematurely
Date:   Wed, 13 Mar 2019 11:39:50 -0700
Message-Id: <20190313183953.17854-4-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313183953.17854-1-guro@fb.com>
References: <20190313183953.17854-1-guro@fb.com>
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

