Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E8DC3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693FD22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfIDG5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:57:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:63038 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726045AbfIDG5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:57:42 -0400
X-UUID: 0f275d29c86d4783ab7c06ab9ad722f7-20190904
X-UUID: 0f275d29c86d4783ab7c06ab9ad722f7-20190904
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 879257244; Wed, 04 Sep 2019 14:57:38 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Sep 2019 14:57:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Sep 2019 14:57:36 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH 2/2] mm/page_owner: determine the last stack state of page with CONFIG_KASAN_DUMP_PAGE=y
Date:   Wed, 4 Sep 2019 14:57:36 +0800
Message-ID: <20190904065736.20736-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enable CONFIG_KASAN_DUMP_PAGE, then page_owner will record last stack,
So we need to know the last stack is allocation or free state.

Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
---
 mm/page_owner.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index addcbb2ae4e4..2756adca250e 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -418,6 +418,12 @@ void __dump_page_owner(struct page *page)
 	nr_entries = stack_depot_fetch(handle, &entries);
 	pr_alert("page allocated via order %u, migratetype %s, gfp_mask %#x(%pGg)\n",
 		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask);
+#ifdef CONFIG_KASAN_DUMP_PAGE
+	if ((unsigned long)page->flags & PAGE_FLAGS_CHECK_AT_PREP)
+		pr_info("Allocation stack of page:\n");
+	else
+		pr_info("Free stack of page:\n");
+#endif
 	stack_trace_print(entries, nr_entries, 0);
 
 	if (page_owner->last_migrate_reason != -1)
-- 
2.18.0

