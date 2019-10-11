Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEEEECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417A920659
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfJKHYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 03:24:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:3767 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfJKHYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 03:24:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 00:24:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,283,1566889200"; 
   d="scan'208";a="219306373"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga004.fm.intel.com with ESMTP; 11 Oct 2019 00:24:01 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        jglisse@redhat.com, mike.kravetz@oracle.com, riel@surriel.com,
        khlebnikov@yandex-team.ru, cai@lca.pw, shakeelb@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v4 2/2] mm/rmap.c: reuse mergeable anon_vma as parent when fork
Date:   Fri, 11 Oct 2019 15:22:56 +0800
Message-Id: <20191011072256.16275-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011072256.16275-1-richardw.yang@linux.intel.com>
References: <20191011072256.16275-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function __anon_vma_prepare(), we will try to find anon_vma if it is
possible to reuse it. While on fork, the logic is different.

Since commit 5beb49305251 ("mm: change anon_vma linking to fix
multi-process server scalability issue"), function anon_vma_clone()
tries to allocate new anon_vma for child process. But the logic here
will allocate a new anon_vma for each vma, even in parent this vma
is mergeable and share the same anon_vma with its sibling. This may do
better for scalability issue, while it is not necessary to do so
especially after interval tree is used.

Commit 7a3ef208e662 ("mm: prevent endless growth of anon_vma hierarchy")
tries to reuse some anon_vma by counting child anon_vma and attached
vmas. While for those mergeable anon_vmas, we can just reuse it and not
necessary to go through the logic.

After this change, kernel build test reduces 20% anon_vma allocation.

Do the same kernel build test, it shows run time in sys reduced 11.6%.

Origin:

real    2m50.467s
user    17m52.002s
sys     1m51.953s

real    2m48.662s
user    17m55.464s
sys     1m50.553s

real    2m51.143s
user    17m59.687s
sys     1m53.600s

Patched:

real	2m39.933s
user	17m1.835s
sys	1m38.802s

real	2m39.321s
user	17m1.634s
sys	1m39.206s

real	2m39.575s
user	17m1.420s
sys	1m38.845s

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/rmap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index c34414567474..2c13e2bfd393 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -268,6 +268,19 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
 {
 	struct anon_vma_chain *avc, *pavc;
 	struct anon_vma *root = NULL;
+	struct vm_area_struct *prev = dst->vm_prev, *pprev = src->vm_prev;
+
+	/*
+	 * If parent share anon_vma with its vm_prev, keep this sharing in in
+	 * child.
+	 *
+	 * 1. Parent has vm_prev, which implies we have vm_prev.
+	 * 2. Parent and its vm_prev have the same anon_vma.
+	 */
+	if (!dst->anon_vma && src->anon_vma &&
+	    pprev && pprev->anon_vma == src->anon_vma)
+		dst->anon_vma = prev->anon_vma;
+
 
 	list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
 		struct anon_vma *anon_vma;
-- 
2.17.1

