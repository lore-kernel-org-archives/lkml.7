Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B513C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 08:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E722183F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 08:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfCaIwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 04:52:23 -0400
Received: from smtprz14.163.net ([106.3.154.247]:1999 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfCaIwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 04:52:22 -0400
Received: from 172.25.16.147 (unknown [172.25.16.147])
        by freemail01.tom.com (Postfix) with ESMTP id DBC461C85649
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 16:52:20 +0800 (CST)
Received: from 172.25.16.90 (HELO smtp.tom.com) ([172.25.16.90])
          by localhost (TOM SMTP Server) with SMTP ID -2139362967
          for <linux-kernel@vger.kernel.org>;
          Sun, 31 Mar 2019 16:52:20 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail01.tom.com (Postfix) with ESMTP id 45D8D1C854B2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 16:52:19 +0800 (CST)
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id 429901001863
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 16:52:19 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r4FX7NCFoFyx for <linux-kernel@vger.kernel.org>;
        Sun, 31 Mar 2019 16:52:18 +0800 (CST)
Received: from localhost (unknown [222.209.17.169])
        by antispam1.tom.com (Postfix) with ESMTPA id 002D6100178D;
        Sun, 31 Mar 2019 16:52:17 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, liuxiang_1999@126.com,
        Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] slub: update the comment about slab frozen
Date:   Sun, 31 Mar 2019 16:52:05 +0800
Message-Id: <1554022325-11305-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now frozen slab can only be on the per cpu partial list.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 mm/slub.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index dc77776..9e2f220 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -58,10 +58,11 @@
  *	D. page->frozen		-> frozen state
  *
  *   If a slab is frozen then it is exempt from list management. It is not
- *   on any list. The processor that froze the slab is the one who can
- *   perform list operations on the page. Other processors may put objects
- *   onto the freelist but the processor that froze the slab is the only
- *   one that can retrieve the objects from the page's freelist.
+ *   on any list except per cpu partial list. The processor that froze the
+ *   slab is the one who can perform list operations on the page. Other
+ *   processors may put objects onto the freelist but the processor that
+ *   froze the slab is the only one that can retrieve the objects from the
+ *   page's freelist.
  *
  *   The list_lock protects the partial and full list on each node and
  *   the partial slab counter. If taken then no new slabs may be added or
-- 
1.9.1

