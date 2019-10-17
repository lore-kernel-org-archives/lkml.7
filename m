Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C12EFA3730
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6887820663
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404448AbfJQJgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:36:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:26991 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728150AbfJQJgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:36:00 -0400
X-UUID: 15178ac1fc394488bdb40d713119e40e-20191017
X-UUID: 15178ac1fc394488bdb40d713119e40e-20191017
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 424564879; Thu, 17 Oct 2019 17:35:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 17 Oct 2019 17:35:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 17 Oct 2019 17:35:53 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] mm: fix outdated comment in page_get_anon_vma()
Date:   Thu, 17 Oct 2019 17:35:54 +0800
Message-ID: <20191017093554.22562-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace DESTROY_BY_RCU with SLAB_TYPESAFE_BY_RCU because
SLAB_DESTROY_BY_RCU has been renamed to SLAB_TYPESAFE_BY_RCU by
commit 5f0d5a3ae7cf ("mm: Rename SLAB_DESTROY_BY_RCU to
SLAB_TYPESAFE_BY_RCU")

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 mm/rmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index d9a23bb773bf..bdb20f2bbe9f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -457,9 +457,10 @@ void __init anon_vma_init(void)
  * chain and verify that the page in question is indeed mapped in it
  * [ something equivalent to page_mapped_in_vma() ].
  *
- * Since anon_vma's slab is DESTROY_BY_RCU and we know from page_remove_rmap()
- * that the anon_vma pointer from page->mapping is valid if there is a
- * mapcount, we can dereference the anon_vma after observing those.
+ * Since anon_vma's slab is SLAB_TYPESAFE_BY_RCU and we know from
+ * page_remove_rmap() that the anon_vma pointer from page->mapping is valid
+ * if there is a mapcount, we can dereference the anon_vma after observing
+ * those.
  */
 struct anon_vma *page_get_anon_vma(struct page *page)
 {
-- 
2.18.0

