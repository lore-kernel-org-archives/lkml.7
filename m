Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E41C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA6F206D3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfLRA4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:56:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:39383 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLRA4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:56:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 16:56:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600"; 
   d="scan'208";a="212751442"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 17 Dec 2019 16:56:09 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, david@redhat.com, cai@lca.pw
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v2] mm: remove dead code totalram_pages_set()
Date:   Wed, 18 Dec 2019 08:55:43 +0800
Message-Id: <20191218005543.24146-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one uses totalram_pages_set(), just remove it.

Fixes: ca79b0c211af ("mm: convert totalram_pages and totalhigh_pages
variables to atomic")

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>

---
v2: fix typo and points which commit introduce it.
---
 include/linux/mm.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 74232b28949b..4cf023c4c6b3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -70,11 +70,6 @@ static inline void totalram_pages_add(long count)
 	atomic_long_add(count, &_totalram_pages);
 }
 
-static inline void totalram_pages_set(long val)
-{
-	atomic_long_set(&_totalram_pages, val);
-}
-
 extern void * high_memory;
 extern int page_cluster;
 
-- 
2.17.1

