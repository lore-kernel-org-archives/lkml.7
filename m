Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB22C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DAA2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504573;
	bh=WXStNE+A0hOhZFnpfm+WbnYTeAPEF8BMGMrdEHJJtUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lby3ZcOzwVcKb2VhxShX5Td3v48kljXXxAZ4HqKjj/nasEhipRuhY+ir28jK2Ea01
	 M5MqaZH2oHiFT8TTddEhaXSDCELucAf9VAt5jXKeQx+wZowYfTxN915eIB1VH88vfP
	 7rnQPTaeftjjVA6EC6qWBcNpZ0yuZea//HhYbUTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfCMTQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbfCMTQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:16:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99A03217F5;
        Wed, 13 Mar 2019 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504567;
        bh=WXStNE+A0hOhZFnpfm+WbnYTeAPEF8BMGMrdEHJJtUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hOMwU4olg5/X/A86zXSsWZhuv3JKhD/WQ8tIgx50SwiUQfn08P7TGIjGDC0TMAsjC
         e/mOFZm9wuy+/a3tjmbzm1FQnj4HGHUwjtSmgZVxB0nEFcXGhLLqbSfdOwX4/3fFfT
         9X8xZodhW18skmY0zvaEilvk820EAXGFAWZPPqoA=
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
Subject: [PATCH AUTOSEL 4.14 21/33] kasan, slab: fix conflicts with CONFIG_HARDENED_USERCOPY
Date:   Wed, 13 Mar 2019 15:14:54 -0400
Message-Id: <20190313191506.159677-21-sashal@kernel.org>
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

[ Upstream commit 219667c23c68eb3dbc0d5662b9246f28477fe529 ]

Similarly to commit 96fedce27e13 ("kasan: make tag based mode work with
CONFIG_HARDENED_USERCOPY"), we need to reset pointer tags in
__check_heap_object() in mm/slab.c before doing any pointer math.

Link: http://lkml.kernel.org/r/9a5c0f958db10e69df5ff9f2b997866b56b7effc.1550602886.git.andreyknvl@google.com
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
 mm/slab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
index 09df506ae830..409631e49295 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4415,6 +4415,8 @@ const char *__check_heap_object(const void *ptr, unsigned long n,
 	unsigned int objnr;
 	unsigned long offset;
 
+	ptr = kasan_reset_tag(ptr);
+
 	/* Find and validate object. */
 	cachep = page->slab_cache;
 	objnr = obj_to_index(cachep, page, (void *)ptr);
-- 
2.19.1

