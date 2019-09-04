Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5A6C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8140A23401
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="m3MD009m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbfIDNxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:53:17 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:59320 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbfIDNxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:53:16 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 4931F2E1AFB;
        Wed,  4 Sep 2019 16:53:13 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id g8uxin0UDo-rCWKDxqx;
        Wed, 04 Sep 2019 16:53:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1567605193; bh=Nk9h8il5OEPYVOEQt3XS8DDQ8EFzu/mVMbOut2gTstg=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=m3MD009msbTOFyJaC9thdsye5NnOnu3jYpUpiliIYoehZ9INDqRDGTHc3PrykUde1
         A1kZlWlicjI2ukKTsXo140gJH7cRyMvTLE4Q8k1CcgCTxV5pRLuHfI7gL5gy9OioCz
         LjXyuLHHJSpAWh38qPV2sxMPPqkkYM5ftDK9lUwA=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:c142:79c2:9d86:677a])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id pnctDuk8zu-rC78k0tw;
        Wed, 04 Sep 2019 16:53:12 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v1 2/7] mm/memcontrol: add mem_cgroup_recharge
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Wed, 04 Sep 2019 16:53:12 +0300
Message-ID: <156760519254.6560.3180815463616863318.stgit@buzz>
In-Reply-To: <156760509382.6560.17364256340940314860.stgit@buzz>
References: <156760509382.6560.17364256340940314860.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function tries to move page into other cgroup.
Caller must lock page and isolate it from LRU.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 include/linux/memcontrol.h |    9 +++++++++
 mm/memcontrol.c            |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 2cd4359cb38c..d94950584f60 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -352,6 +352,8 @@ void mem_cgroup_uncharge(struct page *page);
 void mem_cgroup_uncharge_list(struct list_head *page_list);
 
 void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
+int mem_cgroup_try_recharge(struct page *page, struct mm_struct *mm,
+			    gfp_t gfp_mask);
 
 static struct mem_cgroup_per_node *
 mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
@@ -857,6 +859,13 @@ static inline void mem_cgroup_migrate(struct page *old, struct page *new)
 {
 }
 
+static inline int mem_cgroup_try_recharge(struct page *page,
+					  struct mm_struct *mm,
+					  gfp_t gfp_mask)
+{
+	return 0;
+}
+
 static inline struct lruvec *mem_cgroup_lruvec(struct pglist_data *pgdat,
 				struct mem_cgroup *memcg)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 40ddc233e973..953a0bbb9f43 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6507,6 +6507,46 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	local_irq_restore(flags);
 }
 
+/*
+ * mem_cgroup_try_recharge - try to recharge page to mm's memcg.
+ *
+ * Page must be locked and isolated.
+ */
+int mem_cgroup_try_recharge(struct page *page, struct mm_struct *mm,
+			    gfp_t gfp_mask)
+{
+	struct mem_cgroup *from, *to;
+	int nr_pages;
+	int err = 0;
+
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_PAGE(PageLRU(page), page);
+
+	if (mem_cgroup_disabled())
+		return 0;
+
+	from = page->mem_cgroup;
+	to = get_mem_cgroup_from_mm(mm);
+
+	if (likely(from == to) || !from)
+		goto out;
+
+	nr_pages = hpage_nr_pages(page);
+	err = try_charge(to, gfp_mask, nr_pages);
+	if (err)
+		goto out;
+
+	err = mem_cgroup_move_account(page, nr_pages > 1, from, to);
+	if (err)
+		cancel_charge(to, nr_pages);
+	else
+		cancel_charge(from, nr_pages);
+out:
+	css_put(&to->css);
+
+	return err;
+}
+
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
 EXPORT_SYMBOL(memcg_sockets_enabled_key);
 

