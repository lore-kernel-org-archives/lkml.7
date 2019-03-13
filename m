Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5D2C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1EE20657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505238;
	bh=s3C2mx7yXbv4mU8348fOv48dtoqr2c405gNRPsTyfQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n1djuCwNEcfvBR+YhBCJghiHAOc4O1rzM5iQbQI7NhH8dJ/cmn8CJKJDZ4I885smg
	 wW3kUrlF6gi52Kaukx8MRhKBD2BzsFnTrIJ0POJcZ4luiFDbA6dNXdqN0v6BpDjAcJ
	 OXTfDmuO5SEBRTRqYdpVf6baG5bI1hefAPy5O+hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfCMTOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbfCMTOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:14:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E657B2173C;
        Wed, 13 Mar 2019 19:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504454;
        bh=s3C2mx7yXbv4mU8348fOv48dtoqr2c405gNRPsTyfQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mGjXz3hKOZC0SzipCQnZbi2LkBymaOXOm9xpsOlNIWu5EdXZmK/7hvqr+p8u5XAyt
         cGZjHflG1tMMnKL41xl4Y2qULenk8B6mDBuJnxXDf9CaSMOAXBRzVIgtXH8VnBaai3
         5C/mF6iN42JGsCamoLPHrvm/zgegi70NA+g48dKE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.19 31/48] kasan, slab: make freelist stored without tags
Date:   Wed, 13 Mar 2019 15:12:33 -0400
Message-Id: <20190313191250.158955-31-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191250.158955-1-sashal@kernel.org>
References: <20190313191250.158955-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

[ Upstream commit 51dedad06b5f6c3eea7ec1069631b1ef7796912a ]

Similarly to "kasan, slub: move kasan_poison_slab hook before
page_address", move kasan_poison_slab() before alloc_slabmgmt(), which
calls page_address(), to make page_address() return value to be
non-tagged.  This, combined with calling kasan_reset_tag() for off-slab
slab management object, leads to freelist being stored non-tagged.

Link: http://lkml.kernel.org/r/dfb53b44a4d00de3879a05a9f04c1f55e584f7a1.1550602886.git.andreyknvl@google.com
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Qian Cai <cai@lca.pw>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Evgeniy Stepanov <eugenis@google.com>
Cc: Kostya Serebryany <kcc@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slab.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index 813bd89c263b..52c0420e4f93 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2381,6 +2381,7 @@ static void *alloc_slabmgmt(struct kmem_cache *cachep,
 		/* Slab management obj is off-slab. */
 		freelist = kmem_cache_alloc_node(cachep->freelist_cache,
 					      local_flags, nodeid);
+		freelist = kasan_reset_tag(freelist);
 		if (!freelist)
 			return NULL;
 	} else {
@@ -2694,6 +2695,13 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
 
 	offset *= cachep->colour_off;
 
+	/*
+	 * Call kasan_poison_slab() before calling alloc_slabmgmt(), so
+	 * page_address() in the latter returns a non-tagged pointer,
+	 * as it should be for slab pages.
+	 */
+	kasan_poison_slab(page);
+
 	/* Get slab management. */
 	freelist = alloc_slabmgmt(cachep, page, offset,
 			local_flags & ~GFP_CONSTRAINT_MASK, page_node);
@@ -2702,7 +2710,6 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
 
 	slab_map_pages(cachep, page, freelist);
 
-	kasan_poison_slab(page);
 	cache_init_objs(cachep, page);
 
 	if (gfpflags_allow_blocking(local_flags))
-- 
2.19.1

