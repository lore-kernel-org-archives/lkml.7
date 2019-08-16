Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E20EC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1026C2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfHPKCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 06:02:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9237 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726882AbfHPKCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:02:10 -0400
X-UUID: 0b041ddbb7cf48c9a475ca5cb00b09e1-20190816
X-UUID: 0b041ddbb7cf48c9a475ca5cb00b09e1-20190816
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 706142265; Fri, 16 Aug 2019 18:02:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 16 Aug 2019 18:02:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 16 Aug 2019 18:02:07 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Hugh Dickins <hughd@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] shmem: fix obsolete comment in shmem_getpage_gfp()
Date:   Fri, 16 Aug 2019 18:02:04 +0800
Message-ID: <20190816100204.9781-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "fault_mm" with "vmf" in code comment
because the commit cfda05267f7b ("userfaultfd: shmem: add userfaultfd
hook for shared memory faults") has changed the prototpye of
shmem_getpage_gfp() - pass vmf instead of fault_mm to the function.

Before:
static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
		struct page **pagep, enum sgp_type sgp,
		gfp_t gfp, struct mm_struct *fault_mm, int *fault_type);
After:
static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
		struct page **pagep, enum sgp_type sgp,
		gfp_t gfp, struct vm_area_struct *vma,
		struct vm_fault *vmf, vm_fault_t *fault_type);

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 2bed4761f279..fed9ebea316c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1719,7 +1719,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
  * vm. If we swap it in we mark it dirty since we also free the swap
  * entry since a page cannot live in both the swap and page cache.
  *
- * fault_mm and fault_type are only supplied by shmem_fault:
+ * vmf and fault_type are only supplied by shmem_fault:
  * otherwise they are NULL.
  */
 static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
-- 
2.18.0

