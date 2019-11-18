Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0CEC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A643206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKRMYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:24:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726464AbfKRMYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:24:09 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 485C4D65A578D96687A4;
        Mon, 18 Nov 2019 20:24:07 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 20:23:57 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <richardw.yang@linux.intel.com>,
        <sfr@canb.auug.org.au>, <rppt@linux.ibm.com>, <jannh@google.com>,
        <steve.capper@arm.com>, <catalin.marinas@arm.com>,
        <aarcange@redhat.com>, <walken@google.com>,
        <dave.hansen@linux.intel.com>, <tiny.windzz@gmail.com>,
        <jhubbard@nvidia.com>, <david@redhat.com>
CC:     <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] mm: get rid of odd jump labels in find_mergeable_anon_vma()
Date:   Mon, 18 Nov 2019 20:24:04 +0800
Message-ID: <1574079844-17493-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.18]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

The jump labels try_prev and none are not really needed
in find_mergeable_anon_vma(), eliminate them to improve
readability.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
-v2:
	Fix commit descriptions and further simplify the code
	as suggested by David Hildenbrand and John Hubbard.
-v3:
	Rewrite patch version info. Don't show this in commit log.
-v4:
	Get rid of var near completely as well.
---
 mm/mmap.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 91d5e097a4ed..4d93bda30eac 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1273,26 +1273,22 @@ static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old, struct vm_
  */
 struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
 {
-	struct anon_vma *anon_vma;
-	struct vm_area_struct *near;
-
-	near = vma->vm_next;
-	if (!near)
-		goto try_prev;
-
-	anon_vma = reusable_anon_vma(near, vma, near);
-	if (anon_vma)
-		return anon_vma;
-try_prev:
-	near = vma->vm_prev;
-	if (!near)
-		goto none;
-
-	anon_vma = reusable_anon_vma(near, near, vma);
-	if (anon_vma)
-		return anon_vma;
-none:
+	struct anon_vma *anon_vma = NULL;
+
+	/* Try next first. */
+	if (vma->vm_next) {
+		anon_vma = reusable_anon_vma(vma->vm_next, vma, vma->vm_next);
+		if (anon_vma)
+			return anon_vma;
+	}
+
+	/* Try prev next. */
+	if (vma->vm_prev)
+		anon_vma = reusable_anon_vma(vma->vm_prev, vma->vm_prev, vma);
+
 	/*
+	 * We might reach here with anon_vma == NULL if we can't find
+	 * any reusable anon_vma.
 	 * There's no absolute need to look only at touching neighbours:
 	 * we could search further afield for "compatible" anon_vmas.
 	 * But it would probably just be a waste of time searching,
@@ -1300,7 +1296,7 @@ struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
 	 * We're trying to allow mprotect remerging later on,
 	 * not trying to minimize memory used for anon_vmas.
 	 */
-	return NULL;
+	return anon_vma;
 }
 
 /*
-- 
2.21.GIT

