Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFAFC31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 11:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C668421841
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 11:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfFOLRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 07:17:15 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46956 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbfFOLRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 07:17:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TUENDtX_1560597424;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0TUENDtX_1560597424)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 15 Jun 2019 19:17:11 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] memcg: Ignore unprotected parent in mem_cgroup_protected()
Date:   Sat, 15 Jun 2019 19:17:04 +0800
Message-Id: <20190615111704.63901-1-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently memory.min|low implementation requires the whole
hierarchy has the settings, otherwise the protection will
be broken.

Our hierarchy is kind of like(memory.min value in brackets),

               root
                |
             docker(0)
              /    \
         c1(max)   c2(0)

Note that "docker" doesn't set memory.min. When kswapd runs,
mem_cgroup_protected() returns "0" emin for "c1" due to "0"
@parent_emin of "docker", as a result "c1" gets reclaimed.

But it's hard to maintain parent's "memory.min" when there're
uncertain protected children because only some important types
of containers need the protection.  Further, control tasks
belonging to parent constantly reproduce trivial memory which
should not be protected at all.  It makes sense to ignore
unprotected parent in this scenario to achieve the flexibility.

In order not to break previous hierarchical behaviour, only
ignore the parent when there's no protected ancestor upwards
the hierarchy.

Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 include/linux/page_counter.h |  2 ++
 mm/memcontrol.c              |  5 +++++
 mm/page_counter.c            | 24 ++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index bab7e57f659b..aed7ed28b458 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -55,6 +55,8 @@ bool page_counter_try_charge(struct page_counter *counter,
 void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages);
 void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages);
 void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages);
+bool page_counter_has_min(struct page_counter *counter);
+bool page_counter_has_low(struct page_counter *counter);
 int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages);
 int page_counter_memparse(const char *buf, const char *max,
 			  unsigned long *nr_pages);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ca0bc6e6be13..f1dfa651f55d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5917,6 +5917,8 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	if (parent == root)
 		goto exit;
 
+	if (!page_counter_has_min(&parent->memory))
+		goto elow;
 	parent_emin = READ_ONCE(parent->memory.emin);
 	emin = min(emin, parent_emin);
 	if (emin && parent_emin) {
@@ -5931,6 +5933,9 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 				   siblings_min_usage);
 	}
 
+elow:
+	if (!page_counter_has_low(&parent->memory))
+		goto exit;
 	parent_elow = READ_ONCE(parent->memory.elow);
 	elow = min(elow, parent_elow);
 	if (elow && parent_elow) {
diff --git a/mm/page_counter.c b/mm/page_counter.c
index de31470655f6..8c668eae2af5 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -202,6 +202,30 @@ int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
 	}
 }
 
+bool page_counter_has_min(struct page_counter *counter)
+{
+	struct page_counter *c;
+
+	for (c = counter; c; c = c->parent) {
+		if (counter->min)
+			return true;
+	}
+
+	return false;
+}
+
+bool page_counter_has_low(struct page_counter *counter)
+{
+	struct page_counter *c;
+
+	for (c = counter; c; c = c->parent) {
+		if (counter->low)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * page_counter_set_min - set the amount of protected memory
  * @counter: counter
-- 
2.14.4.44.g2045bb6

