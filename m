Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E14C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E172064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552335039;
	bh=96fweznMXPE/vh0EMoHo+TkT1UGQCGtN3rh9Yv7tpSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o1u2yt0INYz32+JVw6At+aKc9Jsf1ObpomRfnbOF1uvZKYLmQ1Bb+uWL2BNbPDBgk
	 SkKODe3u7TQP5hhnsCh68SawzGXqfEzfsM40jg/r0UPxeMDOaQpG1cX787Ye6gVaEk
	 BaRGgYLl9t6ICs1ytIiHTBJ3vWes1/faLF4ynu0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfCKT4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728688AbfCKT42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:56:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEC30217D9;
        Mon, 11 Mar 2019 19:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334187;
        bh=96fweznMXPE/vh0EMoHo+TkT1UGQCGtN3rh9Yv7tpSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Leoz/kHgmSSe5RpF1YxH3yBxxFzWIXP/BguDUFaqDMXvEd8opesJkwh/sSACwEMrC
         OURQ7EAW4kYKWbawdjRelpXz1HOpSQG8ndLfra6oRnarIxyjOqmVbelhKIHTp1BGx9
         lMqo6WbVfiSy7Qa7tdUUwYARmtmrznMtAHzbIWBw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Yang Shi <yang.shi@linaro.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.20 38/52] Revert "mm: use early_pfn_to_nid in page_ext_init"
Date:   Mon, 11 Mar 2019 15:55:02 -0400
Message-Id: <20190311195516.137772-38-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

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
index ee147103ba1b..5def2b073b9c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -695,7 +695,6 @@ asmlinkage __visible void __init start_kernel(void)
 		initrd_start = 0;
 	}
 #endif
-	page_ext_init();
 	kmemleak_init();
 	debug_objects_mem_init();
 	setup_per_cpu_pageset();
@@ -1147,6 +1146,8 @@ static noinline void __init kernel_init_freeable(void)
 	sched_init_smp();
 
 	page_alloc_init_late();
+	/* Initialize page ext after all struct pages are initialized. */
+	page_ext_init();
 
 	do_basic_setup();
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index ae44f7adbe07..8c78b8d45117 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -398,10 +398,8 @@ void __init page_ext_init(void)
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

