Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2511BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E544E2133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="uNeajQ0V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="st5240RR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfDDCLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:11:39 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39403 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726436AbfDDCJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:09:46 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 73C3222205;
        Wed,  3 Apr 2019 22:01:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 22:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm3; bh=lg2BrG+7fYw7q
        7Cq2sx/23jUXOHpzN8JkKb4HEWmLsw=; b=uNeajQ0VmyZrTaaKNxl7RQ6fUnbft
        HfoH4ce85/rJbvEi+CBqtoLJtqZyFMMlQlEStmcyVUcAjrVglB+yyZbiZo24q6L1
        KQTQUHeJA/wzXfBDhYRXZADV2wN6UPVYjXI9yvcURTE1qn/I5n2NROOjS6/nSgu+
        qgzKPIJPVf0AYKvnce2HOqcQthA7gXL29ObEO/J8kn9BELEPsJvj2KWK/4ep7r3h
        CEzAUvxtYO8JHjbO5FCasFxIzZA2cogG/bxz2DRpBkl3Z98GlFRJcgVpmCI07J2m
        rLBju+P4I7ACY3XmHB9i6Bf0ene5A+R9Efnra7Kbpt9ygm978Hgrf9BYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=lg2BrG+7fYw7q7Cq2sx/23jUXOHpzN8JkKb4HEWmLsw=; b=st5240RR
        dYFUN5ooCSyxrStwKafWNdgADoCKkzOnri6niAKYhRbzjvvmOB2n/IGnbhzs3Rdr
        BzFAI7LWFHIaSfd4C1wnUYKAjfCRjYPSiZr2T6l9a7AtPuvd/Wc+c5iMwLi5TJ/8
        3FbeCLHf8/+YCi+Kfq1+meQ1qMQncoTqjUr8eUBhYnfyqSRN0L83PwDnahGfVrFj
        KSS9R6Ebdc5Mdjz2oGrlKUfR8yTa+AhU22GyAFAn4nyUwKKrB5i+U9yExQRb5ejx
        F5jr4MpsizRiOzgjGUqu/7yx/HlMEc4xbZbbXQP/Yi+lhMx+dIKT+/fKyeaumUic
        8C4Nqe6TaDtLzQ==
X-ME-Sender: <xms:cWWlXBJ0tCYwW-CZHqsy9eb_wxV2t7i_AxDMY_94c6klTDuw7SFErQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeggdehudculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddt
    necuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucfkph
    epvdduiedrvddvkedrudduvddrvddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdr
    higrnhesshgvnhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgepge
X-ME-Proxy: <xmx:cWWlXInlS4YJ2bJx51uJAd8I58Np6Ahz-dcbJLO_el5beZXwMbQBIw>
    <xmx:cWWlXNPkwE5lW_JHQ2LQQXofcZZo96Llcy8IpEWPEyLBld69ibXTJw>
    <xmx:cWWlXG3mZ92JiwiFjpcEorcWW-t13CG1O-QxHfgjuRVGovID_i3XKg>
    <xmx:cWWlXEj2kykTJDNHdPnEC8mfx94DmUfX1OKWJxg_MBpkICnTIxJIKg>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 64B1610393;
        Wed,  3 Apr 2019 22:01:19 -0400 (EDT)
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
Subject: [RFC PATCH 05/25] mm: migrate: Add vm.accel_page_copy in sysfs to control page copy acceleration.
Date:   Wed,  3 Apr 2019 19:00:26 -0700
Message-Id: <20190404020046.32741-6-zi.yan@sent.com>
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

Since base page migration did not gain any speedup from
multi-threaded methods, we only accelerate the huge page case.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 kernel/sysctl.c | 11 +++++++++++
 mm/migrate.c    |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e5da394..3d8490e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -101,6 +101,8 @@
 
 #if defined(CONFIG_SYSCTL)
 
+extern int accel_page_copy;
+
 /* External variables not in a header file. */
 extern int suid_dumpable;
 #ifdef CONFIG_COREDUMP
@@ -1430,6 +1432,15 @@ static struct ctl_table vm_table[] = {
 		.extra2			= &one,
 	},
 #endif
+	{
+		.procname	= "accel_page_copy",
+		.data		= &accel_page_copy,
+		.maxlen		= sizeof(accel_page_copy),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
 	 {
 		.procname	= "hugetlb_shm_group",
 		.data		= &sysctl_hugetlb_shm_group,
diff --git a/mm/migrate.c b/mm/migrate.c
index dd6ccbe..8a344e2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -55,6 +55,8 @@
 
 #include "internal.h"
 
+int accel_page_copy = 1;
+
 /*
  * migrate_prep() needs to be called before we start compiling a list of pages
  * to be migrated using isolate_lru_page(). If scheduling work on other CPUs is
@@ -589,6 +591,10 @@ static void copy_huge_page(struct page *dst, struct page *src,
 		nr_pages = hpage_nr_pages(src);
 	}
 
+	/* Try to accelerate page migration if it is not specified in mode  */
+	if (accel_page_copy)
+		mode |= MIGRATE_MT;
+
 	if (mode & MIGRATE_MT)
 		rc = copy_page_multithread(dst, src, nr_pages);
 
-- 
2.7.4

