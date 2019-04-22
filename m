Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DEAC10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9A920833
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDVCOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 22:14:52 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:34222 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbfDVCOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 22:14:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TPtroFq_1555899288;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TPtroFq_1555899288)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Apr 2019 10:14:48 +0800
Subject: [RFC PATCH 4/5] numa: introduce numa balancer infrastructure
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
Message-ID: <42f47daa-22bb-3c93-9939-1514eb3bbda4@linux.alibaba.com>
Date:   Mon, 22 Apr 2019 10:14:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have the way to estimate and adjust numa preferred node for each
memcg, next problem is how to use them.

Usually one will bind workloads with cpuset.cpus, combined with cpuset.mems
or maybe better the memory policy to achieve numa bonus, however in complicated
scenery like combined type of workloads or cpushare way of isolation, this
kind of administration could make one crazy, what we need is a way to gain
numa bonus automatically, maybe not maximum but as much as possible.

This patch introduced basic API for kernel module to do numa adjustment,
later coming the numa balancer module to use them and try to gain numa bonus
as much as possible, automatically.

API including:
  * numa preferred control
  * memcg callback hook
  * memcg per-node page number acquire

Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---
 include/linux/memcontrol.h |  26 ++++++++++++
 mm/memcontrol.c            | 101 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0fd5eeb27c4f..7456b862d5a9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -200,6 +200,11 @@ struct memcg_stat_numa {
 	u64 exectime;
 };

+struct memcg_callback {
+	void (*init)(struct mem_cgroup *memcg);
+	void (*exit)(struct mem_cgroup *memcg);
+};
+
 #endif
 #if defined(CONFIG_SMP)
 struct memcg_padding {
@@ -337,6 +342,8 @@ struct mem_cgroup {
 	struct memcg_stat_numa __percpu *stat_numa;
 	s64 numa_preferred;
 	struct mutex numa_mutex;
+	void *numa_private;
+	struct list_head numa_list;
 #endif

 	struct mem_cgroup_per_node *nodeinfo[0];
@@ -851,6 +858,10 @@ extern void memcg_stat_numa_update(struct task_struct *p);
 extern int memcg_migrate_prep(int target_nid, int page_nid);
 extern int memcg_preferred_nid(struct task_struct *p, gfp_t gfp);
 extern struct page *alloc_page_numa_preferred(gfp_t gfp, unsigned int order);
+extern int register_memcg_callback(void *cb);
+extern int unregister_memcg_callback(void *cb);
+extern void config_numa_preferred(struct mem_cgroup *memcg, int nid);
+extern u64 memcg_numa_pages(struct mem_cgroup *memcg, int nid, u32 mask);
 #else
 static inline void memcg_stat_numa_update(struct task_struct *p)
 {
@@ -868,6 +879,21 @@ static inline struct page *alloc_page_numa_preferred(gfp_t gfp,
 {
 	return NULL;
 }
+static inline int register_memcg_callback(void *cb)
+{
+	return -EINVAL;
+}
+static inline int unregister_memcg_callback(void *cb)
+{
+	return -EINVAL;
+}
+static inline void config_numa_preferred(struct mem_cgroup *memcg, int nid)
+{
+}
+static inline u64 memcg_numa_pages(struct mem_cgroup *memcg, int nid, u32 mask)
+{
+	return 0;
+}
 #endif

 #else /* CONFIG_MEMCG */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f1cb1e726430..dc232ecc904f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3525,6 +3525,102 @@ struct page *alloc_page_numa_preferred(gfp_t gfp, unsigned int order)
 	return __alloc_pages_node(pnid, gfp, order);
 }

+static struct memcg_callback *memcg_cb;
+
+static LIST_HEAD(memcg_cb_list);
+static DEFINE_MUTEX(memcg_cb_mutex);
+
+int register_memcg_callback(void *cb)
+{
+	int ret = 0;
+
+	mutex_lock(&memcg_cb_mutex);
+	if (memcg_cb || !cb) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	memcg_cb = (struct memcg_callback *)cb;
+	if (memcg_cb->init) {
+		struct mem_cgroup *memcg;
+
+		list_for_each_entry(memcg, &memcg_cb_list, numa_list)
+			memcg_cb->init(memcg);
+	}
+
+out:
+	mutex_unlock(&memcg_cb_mutex);
+	return ret;
+}
+EXPORT_SYMBOL(register_memcg_callback);
+
+int unregister_memcg_callback(void *cb)
+{
+	int ret = 0;
+
+	mutex_lock(&memcg_cb_mutex);
+	if (!memcg_cb || memcg_cb != cb) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (memcg_cb->exit) {
+		struct mem_cgroup *memcg;
+
+		list_for_each_entry(memcg, &memcg_cb_list, numa_list)
+			memcg_cb->exit(memcg);
+	}
+	memcg_cb = NULL;
+
+out:
+	mutex_unlock(&memcg_cb_mutex);
+	return ret;
+}
+EXPORT_SYMBOL(unregister_memcg_callback);
+
+void config_numa_preferred(struct mem_cgroup *memcg, int nid)
+{
+	mutex_lock(&memcg->numa_mutex);
+	memcg->numa_preferred = nid;
+	mutex_unlock(&memcg->numa_mutex);
+}
+EXPORT_SYMBOL(config_numa_preferred);
+
+u64 memcg_numa_pages(struct mem_cgroup *memcg, int nid, u32 mask)
+{
+	if (nid == NUMA_NO_NODE)
+		return mem_cgroup_nr_lru_pages(memcg, mask);
+	else
+		return mem_cgroup_node_nr_lru_pages(memcg, nid, mask);
+}
+EXPORT_SYMBOL(memcg_numa_pages);
+
+static void memcg_online_callback(struct mem_cgroup *memcg)
+{
+	mutex_lock(&memcg_cb_mutex);
+	list_add_tail(&memcg->numa_list, &memcg_cb_list);
+	if (memcg_cb && memcg_cb->init)
+		memcg_cb->init(memcg);
+	mutex_unlock(&memcg_cb_mutex);
+}
+
+static void memcg_offline_callback(struct mem_cgroup *memcg)
+{
+	mutex_lock(&memcg_cb_mutex);
+	if (memcg_cb && memcg_cb->exit)
+		memcg_cb->exit(memcg);
+	list_del_init(&memcg->numa_list);
+	mutex_unlock(&memcg_cb_mutex);
+}
+
+#else
+
+static void memcg_online_callback(struct mem_cgroup *memcg)
+{}
+
+static void memcg_offline_callback(struct mem_cgroup *memcg)
+{}
+
 #endif

 /* Universal VM events cgroup1 shows, original sort order */
@@ -4719,6 +4815,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
+
+	memcg_online_callback(memcg);
+
 	return 0;
 }

@@ -4727,6 +4826,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 	struct mem_cgroup_event *event, *tmp;

+	memcg_offline_callback(memcg);
+
 	/*
 	 * Unregister events and notify userspace.
 	 * Notify userspace about cgroup removing only after rmdir of cgroup
-- 
2.14.4.44.g2045bb6

