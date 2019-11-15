Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB36EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C5320728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKOGwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:52:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbfKOGwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:52:09 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B10AEAB3986D6239ACFC;
        Fri, 15 Nov 2019 14:36:03 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 15 Nov 2019
 14:35:53 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <richardw.yang@linux.intel.com>,
        <sfr@canb.auug.org.au>, <rppt@linux.ibm.com>, <jannh@google.com>,
        <steve.capper@arm.com>, <catalin.marinas@arm.com>,
        <aarcange@redhat.com>, <chenjianhong2@huawei.com>,
        <walken@google.com>, <dave.hansen@linux.intel.com>,
        <tiny.windzz@gmail.com>
CC:     <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: get rid of odd jump label in find_mergeable_anon_vma
Date:   Fri, 15 Nov 2019 14:36:08 +0800
Message-ID: <1573799768-15650-1-git-send-email-linmiaohe@huawei.com>
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

The odd jump label try_prev and none is not really need
in func find_mergeable_anon_vma, eliminate them to
improve readability.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/mmap.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4d4db76a07da..ab980d468a10 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1276,25 +1276,21 @@ static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old, struct vm_
  */
 struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
 {
-	struct anon_vma *anon_vma;
+	struct anon_vma *anon_vma = NULL;
 	struct vm_area_struct *near;
 
 	near = vma->vm_next;
-	if (!near)
-		goto try_prev;
-
-	anon_vma = reusable_anon_vma(near, vma, near);
+	if (near)
+		anon_vma = reusable_anon_vma(near, vma, near);
 	if (anon_vma)
 		return anon_vma;
-try_prev:
-	near = vma->vm_prev;
-	if (!near)
-		goto none;
 
-	anon_vma = reusable_anon_vma(near, near, vma);
+	near = vma->vm_prev;
+	if (near)
+		anon_vma = reusable_anon_vma(near, near, vma);
 	if (anon_vma)
 		return anon_vma;
-none:
+
 	/*
 	 * There's no absolute need to look only at touching neighbours:
 	 * we could search further afield for "compatible" anon_vmas.
-- 
2.19.1

