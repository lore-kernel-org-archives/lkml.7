Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29DFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A672184D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504569;
	bh=2KjpwB7nzi6RD//1iTkLzYoTJ2ub1V62WjgveI0bRvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ai8dTaTO6P+HBEw8hDH1+3EtQg+sE4BgooO63Od1HlTfjev/twkf5VZLg1KunAXb+
	 oo+ED8tGTJ/O+AcQAddmSU7Q1wXXDEPcyCL4rVJwSWON5uY4YMmpg+wANLv7Uh0jYY
	 9kD9gs/KSPcl6whYdR3kAi8snu0RBMTZF32WhtGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfCMTQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:16:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728617AbfCMTQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:16:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95B062183F;
        Wed, 13 Mar 2019 19:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504561;
        bh=2KjpwB7nzi6RD//1iTkLzYoTJ2ub1V62WjgveI0bRvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Duprfr2wZO/XUzMahNPzCketBG5yH1upexlv0ys0HnojHJ9xCHRoLK6wzCrw9knWQ
         HHCeSAkMu9Whx0WXQz0mU0zZNBYjbxhtFeOmQ1sv5vtgvBA0tPsE5R8eD63VSwpCyy
         XGIrp9wWk5zpK1x4VCRJp+l8pCqWHGswiswGo5Iw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kostya Serebryany <kcc@google.com>,
        Pekka Enberg <penberg@kernel.org>, Qian Cai <cai@lca.pw>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.14 19/33] kasan, slub: move kasan_poison_slab hook before page_address
Date:   Wed, 13 Mar 2019 15:14:52 -0400
Message-Id: <20190313191506.159677-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191506.159677-1-sashal@kernel.org>
References: <20190313191506.159677-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

[ Upstream commit a71012242837fe5e67d8c999cfc357174ed5dba0 ]

With tag based KASAN page_address() looks at the page flags to see whether
the resulting pointer needs to have a tag set.  Since we don't want to set
a tag when page_address() is called on SLAB pages, we call
page_kasan_tag_reset() in kasan_poison_slab().  However in allocate_slab()
page_address() is called before kasan_poison_slab().  Fix it by changing
the order.

[andreyknvl@google.com: fix compilation error when CONFIG_SLUB_DEBUG=n]
  Link: http://lkml.kernel.org/r/ac27cc0bbaeb414ed77bcd6671a877cf3546d56e.1550066133.git.andreyknvl@google.com
Link: http://lkml.kernel.org/r/cd895d627465a3f1c712647072d17f10883be2a1.1549921721.git.andreyknvl@google.com
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Evgeniy Stepanov <eugenis@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Kostya Serebryany <kcc@google.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 220d42e592ef..f14ef59c9e57 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1087,6 +1087,16 @@ static void setup_object_debug(struct kmem_cache *s, struct page *page,
 	init_tracking(s, object);
 }
 
+static void setup_page_debug(struct kmem_cache *s, void *addr, int order)
+{
+	if (!(s->flags & SLAB_POISON))
+		return;
+
+	metadata_access_enable();
+	memset(addr, POISON_INUSE, PAGE_SIZE << order);
+	metadata_access_disable();
+}
+
 static inline int alloc_consistency_checks(struct kmem_cache *s,
 					struct page *page,
 					void *object, unsigned long addr)
@@ -1304,6 +1314,8 @@ unsigned long kmem_cache_flags(unsigned long object_size,
 #else /* !CONFIG_SLUB_DEBUG */
 static inline void setup_object_debug(struct kmem_cache *s,
 			struct page *page, void *object) {}
+static inline void setup_page_debug(struct kmem_cache *s,
+			void *addr, int order) {}
 
 static inline int alloc_debug_processing(struct kmem_cache *s,
 	struct page *page, void *object, unsigned long addr) { return 0; }
@@ -1599,12 +1611,11 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if (page_is_pfmemalloc(page))
 		SetPageSlabPfmemalloc(page);
 
-	start = page_address(page);
+	kasan_poison_slab(page);
 
-	if (unlikely(s->flags & SLAB_POISON))
-		memset(start, POISON_INUSE, PAGE_SIZE << order);
+	start = page_address(page);
 
-	kasan_poison_slab(page);
+	setup_page_debug(s, start, order);
 
 	shuffle = shuffle_freelist(s, page);
 
-- 
2.19.1

