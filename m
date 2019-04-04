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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C62CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22562206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="jSVkSs1r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jtoOK51R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDDCOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:14:45 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42243 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbfDDCOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:14:45 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CC6CC22349;
        Wed,  3 Apr 2019 22:01:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 22:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm3; bh=g7J5EGJkF982n
        eBEIpQt+y8NYDKq8lV93wLGcNRGrUg=; b=jSVkSs1rwApArJJjueU/Y1eE6QFai
        I7aySDXdakm6FTGtVY90fGPEfYRnfabDBiMF/46y6vtkbaSWlBgx0GxQ0wpR6KzY
        lIWQ90i+kEMssaE275N1SF5NIc1GHAaDmNt3yfwxU1gmG/a5JXN3wUtCt9vzHhgO
        XABVtqqtZxdKHuhhMfmOEaTe6z19aflOYV1hulx4kIOZctp9cGSAPghX8q8+jAsQ
        o8DcQIvN5vH9WcEcAAedNRUGimVk7PHlR6Nze1kNehNbssIXhxuXgL51viGllNd6
        clTLSZt/H8zbnzmJ1n7GzBRpobSSlG+jarYPhgnlqV+dobnGbwUFexd7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=g7J5EGJkF982neBEIpQt+y8NYDKq8lV93wLGcNRGrUg=; b=jtoOK51R
        zy2Eaf8VRvQ6u4ssXI9X3RRF9upJUM1hxNW+RYxexrXDcxg9nx72SESIcFGVqo3J
        +A7Wdt+y3HlXgKYSqqncBSwe7XWDgWqSh+xQjHTvfIT57DMQmQXlWgbpn3wfeSXE
        Qc/aMkRJFYbm8/Se4Kx79aw2qkv0WUSdefLs4txlJRkgdvILfJvE8JYPGsZ/OsJJ
        Ei+0BiCbxjuD8bljF2XBRo7nBhGpBZkhipuAcTx7fP/ydO9fr/jJalTQEo1M8iGA
        tHAAnao64a8KcN/UTP/2cz3VMRhmoj1MzSj7r8/uAgsm18tHOWMryON6RHuaZbEw
        p062fZGSIw+npQ==
X-ME-Sender: <xms:dGWlXEEzEwqgUjBKG3CUWhZEvlpoKplSMKeX5pRZhwWc4h-YGkYytA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeggdehudculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddt
    necuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucfkph
    epvdduiedrvddvkedrudduvddrvddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdr
    higrnhesshgvnhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgepge
X-ME-Proxy: <xmx:dGWlXAiW-ETY4h78s2Ob9cSINpViXXwEqAwJJyuJEQuks_hozl2YpQ>
    <xmx:dGWlXE8nMG0G143LYy_pPyyN2Uv0LQIiWV8nH33n8ZgJ8eQhLuEZHQ>
    <xmx:dGWlXLLTNh2LVzzs18qek3AVYrbi9UJ2MFkmYQFRlDfKyFMRHvnLxg>
    <xmx:dGWlXPiqjjAy9qLyJU3F-ct5dJQky0qTST4K8DYaPzIej-TdOvqzAA>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id A6B321030F;
        Wed,  3 Apr 2019 22:01:21 -0400 (EDT)
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
Subject: [RFC PATCH 06/25] mm: migrate: Make the number of copy threads adjustable via sysctl.
Date:   Wed,  3 Apr 2019 19:00:27 -0700
Message-Id: <20190404020046.32741-7-zi.yan@sent.com>
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

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 kernel/sysctl.c | 9 +++++++++
 mm/copy_page.c  | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 3d8490e..0eae0b8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -102,6 +102,7 @@
 #if defined(CONFIG_SYSCTL)
 
 extern int accel_page_copy;
+extern unsigned int limit_mt_num;
 
 /* External variables not in a header file. */
 extern int suid_dumpable;
@@ -1441,6 +1442,14 @@ static struct ctl_table vm_table[] = {
 		.extra1		= &zero,
 		.extra2		= &one,
 	},
+	{
+		.procname	= "limit_mt_num",
+		.data		= &limit_mt_num,
+		.maxlen		= sizeof(limit_mt_num),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &zero,
+	},
 	 {
 		.procname	= "hugetlb_shm_group",
 		.data		= &sysctl_hugetlb_shm_group,
diff --git a/mm/copy_page.c b/mm/copy_page.c
index 9cf849c..6665e3d 100644
--- a/mm/copy_page.c
+++ b/mm/copy_page.c
@@ -23,7 +23,7 @@
 #include <linux/freezer.h>
 
 
-const unsigned int limit_mt_num = 4;
+unsigned int limit_mt_num = 4;
 
 /* ======================== multi-threaded copy page ======================== */
 
-- 
2.7.4

