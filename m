Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594BCC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAE420873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="0zJyKpG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfJOIKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:10:03 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:45518 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728295AbfJOIKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:10:03 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id C88662E129A;
        Tue, 15 Oct 2019 11:09:59 +0300 (MSK)
Received: from iva4-c987840161f8.qloud-c.yandex.net (iva4-c987840161f8.qloud-c.yandex.net [2a02:6b8:c0c:3da5:0:640:c987:8401])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id nfkXVoMT4l-9xq84ZVX;
        Tue, 15 Oct 2019 11:09:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1571126999; bh=uBM99g9Ux3Kxexvrq/r6f01uJx9JtYqNm8Mfn0xVlC8=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=0zJyKpG7DWT6yZkKFLtLlBCDanDEvWtoPV22gBVytDfdFHCGcDN3cNYokg3xrx23a
         yV8iYJy6AziG4UYARUNuT4xWygPrhyB4XnTvju8yRj7eTLGBh/BrKL4wgr485tWZK/
         B1IZEXSXS1tFGgk3Jhtgz1t5/D9VbJfk5tJKB1mc=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by iva4-c987840161f8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id xXgS5w1Urj-9xNiLTXE;
        Tue, 15 Oct 2019 11:09:59 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] mm/memcontrol: update lruvec counters in
 mem_cgroup_move_account
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Tue, 15 Oct 2019 11:09:59 +0300
Message-ID: <157112699975.7360.1062614888388489788.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mapped, dirty and writeback pages are also counted in per-lruvec stats.
These counters needs update when page is moved between cgroups.

Fixes: 00f3ca2c2d66 ("mm: memcontrol: per-lruvec stats infrastructure")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/memcontrol.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bdac56009a38..363106578876 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5420,6 +5420,8 @@ static int mem_cgroup_move_account(struct page *page,
 				   struct mem_cgroup *from,
 				   struct mem_cgroup *to)
 {
+	struct lruvec *from_vec, *to_vec;
+	struct pglist_data *pgdat;
 	unsigned long flags;
 	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
 	int ret;
@@ -5443,11 +5445,15 @@ static int mem_cgroup_move_account(struct page *page,
 
 	anon = PageAnon(page);
 
+	pgdat = page_pgdat(page);
+	from_vec = mem_cgroup_lruvec(pgdat, from);
+	to_vec = mem_cgroup_lruvec(pgdat, to);
+
 	spin_lock_irqsave(&from->move_lock, flags);
 
 	if (!anon && page_mapped(page)) {
-		__mod_memcg_state(from, NR_FILE_MAPPED, -nr_pages);
-		__mod_memcg_state(to, NR_FILE_MAPPED, nr_pages);
+		__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
+		__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
 	}
 
 	/*
@@ -5459,14 +5465,14 @@ static int mem_cgroup_move_account(struct page *page,
 		struct address_space *mapping = page_mapping(page);
 
 		if (mapping_cap_account_dirty(mapping)) {
-			__mod_memcg_state(from, NR_FILE_DIRTY, -nr_pages);
-			__mod_memcg_state(to, NR_FILE_DIRTY, nr_pages);
+			__mod_lruvec_state(from_vec, NR_FILE_DIRTY, -nr_pages);
+			__mod_lruvec_state(to_vec, NR_FILE_DIRTY, nr_pages);
 		}
 	}
 
 	if (PageWriteback(page)) {
-		__mod_memcg_state(from, NR_WRITEBACK, -nr_pages);
-		__mod_memcg_state(to, NR_WRITEBACK, nr_pages);
+		__mod_lruvec_state(from_vec, NR_WRITEBACK, -nr_pages);
+		__mod_lruvec_state(to_vec, NR_WRITEBACK, nr_pages);
 	}
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE

