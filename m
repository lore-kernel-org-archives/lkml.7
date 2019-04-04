Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE41C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E8220820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="uiRPlq6m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MyEaAGe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfDDCK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:10:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:32841 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726561AbfDDCJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:09:47 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6095422710;
        Wed,  3 Apr 2019 22:01:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 22:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm3; bh=3UekVlM57ISUT
        TW0lHTJU3YrdfYPvp3rAFH0aaIT5ag=; b=uiRPlq6mC9oXMnQB8WtxkGcQ0xCOf
        b7pGGA5rxoUR/W1l4alCIYJEymTCa8ogRidqOt//14B9/kwgDh7KNV1tDBvlj/kl
        hLStBwtyoswGRgSzMavZE4wASV2KjaPBgA+nLU2FAvuRQfZV+bHPgxk0GLw5lmYD
        jxQkgxNJNeB58nNLj7OtRyBjx8E2RlRBGivEIb/+KigepHrhmsSm7KZlE6qOFsZt
        tU99yhvHWv3AztL49xrP3e8IgTnrpXO3AAyC2YUd5z6jA0bxIbKBsABPAnNjrvFY
        gTMDhTxYWCKPVCpyVxtE2GZq36+2Tgk0eW0gTk4nOR/hFrN7Zo8MwUc/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=3UekVlM57ISUTTW0lHTJU3YrdfYPvp3rAFH0aaIT5ag=; b=MyEaAGe4
        6nOYVcgLm7Dnv4D9kfwxR4el7PgmlaH7vQjvG+tPatHJsI3xAPkNLbR7BtYveG/c
        6+muJpOgUMqIUvMKE8gjytzHGnEBQ+sdfi8rcp9AhOwc8JZjddR22gm52qp9xLsP
        wjGYGkNFVAKDlVLLalxRMCO8w2JAiMzYeMWpCgVihfnUP3+ve75nO0SawyavLK/g
        xhyxO1VhM2YadnHl9lkLwBEly6Mapb235uQS3Sfmt2gB7/xGTXnwLY4uQgBQMy9t
        itUHnRVMWx10CzCOp6vW54XgaDyggW8Dtx2jpaHNV9wZNmp5p3Xw9cQsZSn6PP8e
        UIsiQeAH+R6Kmg==
X-ME-Sender: <xms:i2WlXPifvyVwTTNfsv7n1GY6ZelcSbug0VQeuXzo0YgUAC4UyWE_rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeggdehudculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddt
    necuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucfkph
    epvdduiedrvddvkedrudduvddrvddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdr
    higrnhesshgvnhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgepudej
X-ME-Proxy: <xmx:i2WlXMNxmY3qsb5DXjucrDcxkSaZwvIQHKaAi1pfaZnzKqa4apFcUg>
    <xmx:i2WlXIkL7kyXtZnywnyWjEfgAaHy2Qf0cveZTDe0e30OQOWkLvRSFQ>
    <xmx:i2WlXLW020U8yC6ynYTYt59WIC-cz8t8z5XdDCngPS7GAAm6oFeyoQ>
    <xmx:i2WlXKl7Tc3-lPq9aHWAl-Yfw5rXmN3a1WXGpR47rklOp6fsfEYtdg>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 624C610393;
        Wed,  3 Apr 2019 22:01:45 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        Javier Cabezas <jcabezas@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 19/25] mempolicy: add MPOL_F_MEMCG flag, enforcing memcg memory limit.
Date:   Wed,  3 Apr 2019 19:00:40 -0700
Message-Id: <20190404020046.32741-20-zi.yan@sent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404020046.32741-1-zi.yan@sent.com>
References: <20190404020046.32741-1-zi.yan@sent.com>
Reply-To: ziy@nvidia.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

With MPOL_F_MEMCG set and MPOL_PREFERRED is used, we will enforce
the memory limit set in the corresponding memcg.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/uapi/linux/mempolicy.h |  3 ++-
 mm/mempolicy.c                 | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index eb6560e..a9d03e5 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -28,12 +28,13 @@ enum {
 /* Flags for set_mempolicy */
 #define MPOL_F_STATIC_NODES	(1 << 15)
 #define MPOL_F_RELATIVE_NODES	(1 << 14)
+#define MPOL_F_MEMCG		(1 << 13)
 
 /*
  * MPOL_MODE_FLAGS is the union of all possible optional mode flags passed to
  * either set_mempolicy() or mbind().
  */
-#define MPOL_MODE_FLAGS	(MPOL_F_STATIC_NODES | MPOL_F_RELATIVE_NODES)
+#define MPOL_MODE_FLAGS	(MPOL_F_STATIC_NODES | MPOL_F_RELATIVE_NODES | MPOL_F_MEMCG)
 
 /* Flags for get_mempolicy */
 #define MPOL_F_NODE	(1<<0)	/* return next IL mode instead of node mask */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index af171cc..0e30049 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2040,6 +2040,42 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		goto out;
 	}
 
+	if (pol->mode == MPOL_PREFERRED && (pol->flags & MPOL_F_MEMCG)) {
+		struct task_struct *p = current;
+		struct mem_cgroup *memcg = mem_cgroup_from_task(p);
+		int nid = pol->v.preferred_node;
+		unsigned long nr_memcg_node_size;
+		struct mm_struct *mm = get_task_mm(p);
+		unsigned long nr_pages = hugepage?HPAGE_PMD_NR:1;
+
+		if (!(memcg && mm)) {
+			if (mm)
+				mmput(mm);
+			goto use_other_policy;
+		}
+
+		/* skip preferred node if mm_manage is going on */
+		if (test_bit(MMF_MM_MANAGE, &mm->flags)) {
+			nid = next_memory_node(nid);
+			if (nid == MAX_NUMNODES)
+				nid = first_memory_node;
+		}
+		mmput(mm);
+
+		nr_memcg_node_size = memcg_max_size_node(memcg, nid);
+
+		while (nr_memcg_node_size != ULONG_MAX &&
+			   nr_memcg_node_size <= (memcg_size_node(memcg, nid) + nr_pages)) {
+			if ((nid = next_memory_node(nid)) == MAX_NUMNODES)
+				nid = first_memory_node;
+			nr_memcg_node_size = memcg_max_size_node(memcg, nid);
+		}
+
+		mpol_cond_put(pol);
+		page = __alloc_pages_node(nid, gfp | __GFP_THISNODE, order);
+		goto out;
+	}
+use_other_policy:
 	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
 		int hpage_node = node;
 
-- 
2.7.4

