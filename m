Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A359CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27DD2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfJ3NL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:11:28 -0400
Received: from smtp2.axis.com ([195.60.68.18]:21213 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfJ3NL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:11:28 -0400
IronPort-SDR: 4yyDR3sJFKrKPKpLcaUxoo9d9+Pa0Ek0erNLQarTDt+8/VKUKoAxoJCgSezeapCwfUIGpDd1iN
 4QjHBoj3+5egc0nG5FUaM5YNEYdj0KlEdYCA3Ms8u1oRauTzxovDOLJVdG3RGhg79S1qUEri7+
 Uin78f580QoK6o98KzsmYYqyIeDnwu1P2zl82et/DWYeC2jAoAcg7k/1Cx2kM2GvQ4A5kVVtQY
 fGTSJ2CwXNfFRh3rwyxqaD1WUUzm6T7ZkwDMKWZFw/i9V2j/NBIIInkg2XuJWQ9GRUr1K/Axmp
 qPE=
X-IronPort-AV: E=Sophos;i="5.68,247,1569276000"; 
   d="scan'208";a="1923405"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     akpm@linux-foundation.org
Cc:     osalvador@suse.de, mhocko@suse.com, pasha.tatashin@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH] mm/sparse: Consistently do not zero memmap
Date:   Wed, 30 Oct 2019 14:11:22 +0100
Message-Id: <20191030131122.8256-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparsemem without VMEMMAP has two allocation paths to allocate the
memory needed for its memmap (done in sparse_mem_map_populate()).

In one allocation path (sparse_buffer_alloc() succeeds), the memory is
not zeroed (since it was previously allocated with
memblock_alloc_try_nid_raw()).

In the other allocation path (sparse_buffer_alloc() fails and
sparse_mem_map_populate() falls back to memblock_alloc_try_nid()), the
memory is zeroed.

AFAICS this difference does not appear to be on purpose.  If the code is
supposed to work with non-initialized memory (__init_single_page() takes
care of zeroing the struct pages which are actually used), we should
consistently not zero the memory, to avoid masking bugs.

(I noticed this because on my ARM64 platform, with 1 GiB of memory the
 first [and only] section is allocated from the zeroing path while with
 2 GiB of memory the first 1 GiB section is allocated from the
 non-zeroing path.)

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 mm/sparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index f6891c1992b1..01e467adc219 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -458,7 +458,7 @@ struct page __init *__populate_section_memmap(unsigned long pfn,
 	if (map)
 		return map;
 
-	map = memblock_alloc_try_nid(size,
+	map = memblock_alloc_try_nid_raw(size,
 					  PAGE_SIZE, addr,
 					  MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 	if (!map)
-- 
2.20.0

