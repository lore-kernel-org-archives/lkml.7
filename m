Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4672EC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194712077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlmEsoAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfCLWeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:34:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44895 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfCLWeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:34:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id a3so2841626pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 15:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0AseUfXAAtgM7xE37ALVmimobdOHrae++QaZmnVS3p0=;
        b=hlmEsoApvA/mPdl0iBW06MNbW54pe9uXKLI0ahcw+KfOFDqPsNwozyuf/2FhiVycfD
         knJ0Vxm7F0KP7fmIjk3HSFKX7vxKdbqVR/ncWSecT8LiNZj8ed3QWLFwKx4cNWGcvC9l
         U+r7VBADW1oe+7Q32r16t4eTIfTU/p6TXMKLGiJbf9dHzgUYXD/79078ZFmDbKAEotUk
         GY0aTSay4wBRp5nV4d/00Yon9XA6n8xKekA/Di4Nn6DeVujfOekkgZdqIS1BykhG95E1
         Wh/Sd0PNA2IlQP24StTYHp5SWr4M+KoUkYW35t9ukZTak76552zqkiyBUFTdIRHC23Lv
         3QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0AseUfXAAtgM7xE37ALVmimobdOHrae++QaZmnVS3p0=;
        b=qW+vGEc7mfvCYcNr4Wv4eRAsvCRRiCVXq1wm8mQ7L1ulmDIF6+bOgtjoE0jtFJIN0a
         LdpXoi36NehPeK6/exue9pboyNtPGxzF2r6P0Pifsj/QWlnO+PkzYNXJkASQ1rsY4+Up
         c/r4WoCUQ23IcKj6zNstQsoTcz5zlLPK3jILE3iY2Q1fjfJpuyT36O6x8P+8UGc/GSji
         IgCOeSIKxQ4DfTSHwZEJgH7xT/HZwNt922W0u1Eqx7XtnltgW9t756j5BJvB2FOSnimo
         iAHODFykECgUkdKF6DxM8Z5Qavxmeic/m8Kuli8l9Rj4sqzROEFLoBNVx91NkvYYijTI
         O1pg==
X-Gm-Message-State: APjAAAXaRsVe4PGsdzkiX8nSRmTp98Xm/qWG8/iNCRa/wzh+JVQhuU48
        qoaP9IHbT/m58QJJhw24Qk4=
X-Google-Smtp-Source: APXvYqw+oQJ4ndnWt7iHQgCj/cQPi1Rt1P8zv210NZF5fOTuQOXgHm6K3xRS+YSiomUIUFri8uU6TA==
X-Received: by 2002:a17:902:968b:: with SMTP id n11mr42163572plp.316.1552430054499;
        Tue, 12 Mar 2019 15:34:14 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::1:3203])
        by smtp.gmail.com with ESMTPSA id i13sm14680592pfo.106.2019.03.12.15.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 15:34:13 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 5/6] mm: flush memcg percpu stats and events before releasing
Date:   Tue, 12 Mar 2019 15:34:02 -0700
Message-Id: <20190312223404.28665-6-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312223404.28665-1-guro@fb.com>
References: <20190312223404.28665-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flush percpu stats and events data to corresponding before releasing
percpu memory.

Although per-cpu stats are never exactly precise, dropping them on
floor regularly may lead to an accumulation of an error. So, it's
safer to flush them before releasing.

To minimize the number of atomic updates, let's sum all stats/events
on all cpus locally, and then make a single update per entry.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/memcontrol.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1b5fe826d6d0..0f18bf2afea8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2119,6 +2119,56 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 	mutex_unlock(&percpu_charge_mutex);
 }
 
+/*
+ * Flush all per-cpu stats and events into atomics.
+ * Try to minimize the number of atomic writes by gathering data from
+ * all cpus locally, and then make one atomic update.
+ * No locking is required, because no one has an access to
+ * the offlined percpu data.
+ */
+static void memcg_flush_offline_percpu(struct mem_cgroup *memcg)
+{
+	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
+	struct lruvec_stat __percpu *lruvec_stat_cpu;
+	struct mem_cgroup_per_node *pn;
+	int cpu, i;
+	long x;
+
+	vmstats_percpu = memcg->vmstats_percpu_offlined;
+
+	for (i = 0; i < MEMCG_NR_STAT; i++) {
+		int nid;
+
+		x = 0;
+		for_each_possible_cpu(cpu)
+			x += per_cpu(vmstats_percpu->stat[i], cpu);
+		if (x)
+			atomic_long_add(x, &memcg->vmstats[i]);
+
+		if (i >= NR_VM_NODE_STAT_ITEMS)
+			continue;
+
+		for_each_node(nid) {
+			pn = mem_cgroup_nodeinfo(memcg, nid);
+			lruvec_stat_cpu = pn->lruvec_stat_cpu_offlined;
+
+			x = 0;
+			for_each_possible_cpu(cpu)
+				x += per_cpu(lruvec_stat_cpu->count[i], cpu);
+			if (x)
+				atomic_long_add(x, &pn->lruvec_stat[i]);
+		}
+	}
+
+	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
+		x = 0;
+		for_each_possible_cpu(cpu)
+			x += per_cpu(vmstats_percpu->events[i], cpu);
+		if (x)
+			atomic_long_add(x, &memcg->vmevents[i]);
+	}
+}
+
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
 	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
@@ -4618,6 +4668,8 @@ static void percpu_rcu_free(struct rcu_head *rcu)
 	struct mem_cgroup *memcg = container_of(rcu, struct mem_cgroup, rcu);
 	int node;
 
+	memcg_flush_offline_percpu(memcg);
+
 	for_each_node(node) {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
 
-- 
2.20.1

