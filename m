Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FC6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF4C21873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259465;
	bh=R2UQqGWMXwEV+kt57MVWRbQkcL9Snf1MJvE4i5WbqUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n/xBgia1VyhxjG5Aaj+uquzynEFc6VUI0WiTPcsiNC5MT/u1tOTz+IZV59cNq/FA8
	 /aE3cY/Mf8yNRed/jZU7QAT+sz2XsIcmoKQDLwwZIu783itKqd/XSkuo4Q8dbuEzK1
	 /XndDjbF3BKUbNAMXN7L27r7q78esy8UeueaHaqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbfCVM5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731617AbfCVLr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:47:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C55D21916;
        Fri, 22 Mar 2019 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255245;
        bh=R2UQqGWMXwEV+kt57MVWRbQkcL9Snf1MJvE4i5WbqUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYhMbwdizj9/H3ozsVdIXbRoKf78GJCB2MWH5WdtuwAyWaYcfcO8FJKaySxsDLfyG
         ZlhQFEfQO89tmQH1TwRh9BBq07IfaPV6noBWLZpcmohydg6KgfYTrFvaDg9k8IAXC/
         6m2bvsmRm9zw2KmN08revi3Fe3ioBU8Vl2MgMMhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 031/183] mm: page_alloc: fix ref bias in page_frag_alloc() for 1-byte allocs
Date:   Fri, 22 Mar 2019 12:14:19 +0100
Message-Id: <20190322111243.983193738@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2c2ade81741c66082f8211f0b96cf509cc4c0218 ]

The basic idea behind ->pagecnt_bias is: If we pre-allocate the maximum
number of references that we might need to create in the fastpath later,
the bump-allocation fastpath only has to modify the non-atomic bias value
that tracks the number of extra references we hold instead of the atomic
refcount. The maximum number of allocations we can serve (under the
assumption that no allocation is made with size 0) is nc->size, so that's
the bias used.

However, even when all memory in the allocation has been given away, a
reference to the page is still held; and in the `offset < 0` slowpath, the
page may be reused if everyone else has dropped their references.
This means that the necessary number of references is actually
`nc->size+1`.

Luckily, from a quick grep, it looks like the only path that can call
page_frag_alloc(fragsz=1) is TAP with the IFF_NAPI_FRAGS flag, which
requires CAP_NET_ADMIN in the init namespace and is only intended to be
used for kernel testing and fuzzing.

To test for this issue, put a `WARN_ON(page_ref_count(page) == 0)` in the
`offset < 0` path, below the virt_to_page() call, and then repeatedly call
writev() on a TAP device with IFF_TAP|IFF_NO_PI|IFF_NAPI_FRAGS|IFF_NAPI,
with a vector consisting of 15 elements containing 1 byte each.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a2f365f40433..40075c1946b3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4325,11 +4325,11 @@ refill:
 		/* Even if we own the page, we do not use atomic_set().
 		 * This would break get_page_unless_zero() users.
 		 */
-		page_ref_add(page, size - 1);
+		page_ref_add(page, size);
 
 		/* reset page count bias and offset to start of new frag */
 		nc->pfmemalloc = page_is_pfmemalloc(page);
-		nc->pagecnt_bias = size;
+		nc->pagecnt_bias = size + 1;
 		nc->offset = size;
 	}
 
@@ -4345,10 +4345,10 @@ refill:
 		size = nc->size;
 #endif
 		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, size);
+		set_page_count(page, size + 1);
 
 		/* reset page count bias and offset to start of new frag */
-		nc->pagecnt_bias = size;
+		nc->pagecnt_bias = size + 1;
 		offset = size - fragsz;
 	}
 
-- 
2.19.1



