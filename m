Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C065FC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9402D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfI3M3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:29:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:53834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730444AbfI3M3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:29:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8F55B01F;
        Mon, 30 Sep 2019 12:29:28 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Qian Cai <cai@lca.pw>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v2 0/3] followups to debug_pagealloc improvements through page_owner
Date:   Mon, 30 Sep 2019 14:29:13 +0200
Message-Id: <20190930122916.14969-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1 [3]:

- Kirill suggested further decoupling of freeing stack capture from KASAN and
  debug_pagealloc. Also the stackdepot handle is now only allocated in page_ext
  when actually used (it was simpler than I initially thought). As that was a
  large change, I've dropped Reviewed-by from Andrey Ryabinin.
- More minor changes suggested by Kirill.

These are followups to [1] which made it to Linus meanwhile. Patches 1 and 3
are based on Kirill's review, patch 2 on KASAN request [2]. It would be nice
if all of this made it to 5.4 with [1] already there (or at least Patch 1).

[1] https://lore.kernel.org/linux-mm/20190820131828.22684-1-vbabka@suse.cz/
[2] https://lore.kernel.org/linux-arm-kernel/20190911083921.4158-1-walter-zh.wu@mediatek.com/
[3] https://lore.kernel.org/r/20190925143056.25853-1-vbabka%40suse.cz

Vlastimil Babka (3):
  mm, page_owner: fix off-by-one error in __set_page_owner_handle()
  mm, page_owner: decouple freeing stack trace from debug_pagealloc
  mm, page_owner: rename flag indicating that page is allocated

 .../admin-guide/kernel-parameters.txt         |   8 ++
 Documentation/dev-tools/kasan.rst             |   3 +
 include/linux/page_ext.h                      |  10 +-
 include/linux/page_owner.h                    |   1 +
 mm/page_ext.c                                 |  24 ++--
 mm/page_owner.c                               | 117 ++++++++++++------
 6 files changed, 109 insertions(+), 54 deletions(-)

-- 
2.23.0

