Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6537EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336A721916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255250;
	bh=ZslOR+m9ipWUaaUOmJ17jV6RAYlV8pRm8aDCuIQVfls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xc0LC+sHg8V0RPePNp21fBjPY5XK6QXcLRnM9Y7xfRgWaf1r4b1WHiCAvHfxtXS3d
	 qlfNOU56ebXr5WMBIdcs1A/du8C8+XgoKpvqJwzRVb/AOIr3qXK9r58VgKPARPD1TI
	 9jB/7+5GQBHlAOAOBaoCCFS37SqZ88hIYJzQatqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbfCVLr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732174AbfCVLrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:47:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4344B2075E;
        Fri, 22 Mar 2019 11:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255242;
        bh=ZslOR+m9ipWUaaUOmJ17jV6RAYlV8pRm8aDCuIQVfls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQIK3eCLnX9GgCqKeSKpY9l0C9+R6kIEzNTBH4V/JfW7gzgsfNAw2KDMsJyme2iQ5
         XnAlXczjSi8QC70dbB4HwwqwBdcs80Yc1JcDlGx+bPJHyk2MB4Q66AU+NDAu+xmnFf
         yoKRkjcERqCwtroVN/xO7AcTFEZRDLLkMhr2+C4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Michal Hocko <mhocko@kernel.org>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Yang Shi <yang.shi@linaro.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 030/183] Revert "mm: use early_pfn_to_nid in page_ext_init"
Date:   Fri, 22 Mar 2019 12:14:18 +0100
Message-Id: <20190322111243.920688875@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2f1ee0913ce58efe7f18fbd518bd54c598559b89 ]

This reverts commit fe53ca54270a ("mm: use early_pfn_to_nid in
page_ext_init").

When booting a system with "page_owner=on",

start_kernel
  page_ext_init
    invoke_init_callbacks
      init_section_page_ext
        init_page_owner
          init_early_allocated_pages
            init_zones_in_node
              init_pages_in_zone
                lookup_page_ext
                  page_to_nid

The issue here is that page_to_nid() will not work since some page flags
have no node information until later in page_alloc_init_late() due to
DEFERRED_STRUCT_PAGE_INIT.  Hence, it could trigger an out-of-bounds
access with an invalid nid.

  UBSAN: Undefined behaviour in ./include/linux/mm.h:1104:50
  index 7 is out of range for type 'zone [5]'

Also, kernel will panic since flags were poisoned earlier with,

CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_NODE_NOT_IN_PAGE_FLAGS=n

start_kernel
  setup_arch
    pagetable_init
      paging_init
        sparse_init
          sparse_init_nid
            memblock_alloc_try_nid_raw

It did not handle it well in init_pages_in_zone() which ends up calling
page_to_nid().

  page:ffffea0004200000 is uninitialized and poisoned
  raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
  raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
  page_owner info is not active (free page?)
  kernel BUG at include/linux/mm.h:990!
  RIP: 0010:init_page_owner+0x486/0x520

This means that assumptions behind commit fe53ca54270a ("mm: use
early_pfn_to_nid in page_ext_init") are incomplete.  Therefore, revert
the commit for now.  A proper way to move the page_owner initialization
to sooner is to hook into memmap initialization.

Link: http://lkml.kernel.org/r/20190115202812.75820-1-cai@lca.pw
Signed-off-by: Qian Cai <cai@lca.pw>
Acked-by: Michal Hocko <mhocko@kernel.org>
Cc: Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Yang Shi <yang.shi@linaro.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/main.c   | 3 ++-
 mm/page_ext.c | 4 +---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/init/main.c b/init/main.c
index c4a45145e102..3d3d79c5a232 100644
--- a/init/main.c
+++ b/init/main.c
@@ -663,7 +663,6 @@ asmlinkage __visible void __init start_kernel(void)
 		initrd_start = 0;
 	}
 #endif
-	page_ext_init();
 	kmemleak_init();
 	debug_objects_mem_init();
 	setup_per_cpu_pageset();
@@ -1069,6 +1068,8 @@ static noinline void __init kernel_init_freeable(void)
 	sched_init_smp();
 
 	page_alloc_init_late();
+	/* Initialize page ext after all struct pages are initialized. */
+	page_ext_init();
 
 	do_basic_setup();
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 2c16216c29b6..2c44f5b78435 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -396,10 +396,8 @@ void __init page_ext_init(void)
 			 * We know some arch can have a nodes layout such as
 			 * -------------pfn-------------->
 			 * N0 | N1 | N2 | N0 | N1 | N2|....
-			 *
-			 * Take into account DEFERRED_STRUCT_PAGE_INIT.
 			 */
-			if (early_pfn_to_nid(pfn) != nid)
+			if (pfn_to_nid(pfn) != nid)
 				continue;
 			if (init_section_page_ext(pfn, nid))
 				goto oom;
-- 
2.19.1



