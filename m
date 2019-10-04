Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDF1C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE91215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390368AbfJDQG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:06:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:19328 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390140AbfJDQGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:06:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 09:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="204360824"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga002.jf.intel.com with ESMTP; 04 Oct 2019 09:06:53 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        jglisse@redhat.com, mike.kravetz@oracle.com, riel@surriel.com,
        khlebnikov@yandex-team.ru
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] mm/rmap.c: reuse mergeable anon_vma as parent when fork
Date:   Sat,  5 Oct 2019 00:06:32 +0800
Message-Id: <20191004160632.30251-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
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

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/rmap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index d9a23bb773bf..12f6c3d7fd9d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -262,6 +262,17 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
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
+	if (pprev && pprev->anon_vma == src->anon_vma)
+		dst->anon_vma = prev->anon_vma;
 
 	list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
 		struct anon_vma *anon_vma;
-- 
2.17.1

