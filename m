Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BC3C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FAF2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfFUTil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 15:38:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfFUTik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:38:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74EA23082E21;
        Fri, 21 Jun 2019 19:38:40 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F5D419C59;
        Fri, 21 Jun 2019 19:38:35 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] drivers/base/memory.c: Fix "mm/memory_hotplug: Move and simplify walk_memory_blocks()"
Date:   Fri, 21 Jun 2019 21:38:34 +0200
Message-Id: <20190621193834.21730-1-david@redhat.com>
In-Reply-To: <1561130120.5154.47.camel@lca.pw>
References: <1561130120.5154.47.camel@lca.pw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 21 Jun 2019 19:38:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The start and the size are 0 for online nodes without any memory. Avoid
the underflow, resulting in a very long loop and soft lockups.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-mm@kvack.org
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

@Andrew, Stephen - sorry for the noise *again*. Feel feel to either apply
this patch or drop the respective patches for now.

---
 drivers/base/memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 972c5336bebf..7595a4f0068f 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -868,6 +868,9 @@ int walk_memory_blocks(unsigned long start, unsigned long size,
 	unsigned long block_id;
 	int ret = 0;
 
+	if (!size)
+		return 0;
+
 	for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
 		mem = find_memory_block_by_id(block_id);
 		if (!mem)
-- 
2.21.0

