Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD38C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE8A2190C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126176;
	bh=6oyKyFALcDz9CC6y/KO0ETwSyk88ev/kYQixsFUMZYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LlV3NO4CeXHv+tmzIRzkAmdlf8ZJ1eNHncMdnmHYQnWKphbCzEe8Au4905LaOSEPt
	 zEylK3Qd2tRDkOlK+6IoJDGz9JQd8ta6OLGCw5I3GZpgTFlKtpGqcL+KV9YgcZqzV8
	 vxbc3wr1lfjtloowiZ/TNwHxPZCPoGfNbwFmSTYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbfDXRQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388376AbfDXRQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:16:11 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66AC121909;
        Wed, 24 Apr 2019 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126171;
        bh=6oyKyFALcDz9CC6y/KO0ETwSyk88ev/kYQixsFUMZYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SlOlt9y3wJ8EtL/COpJhJwAGAalI4lBaTmnh1EgsdEO3icDDwFYpuJ7kOmbZ7m2BM
         VcGNrzx2AtKLe1wG5KCmboQDBVcd0NqgR1BddfQtXyQNq4Zdf7tCboUqPIG5uvWnBl
         SFyINkN2guEPK7OJVaT5KbU8HHu/4zaHXSjRYqyA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Laura Abbott <labbott@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 016/168] mm/cma.c: cma_declare_contiguous: correct err handling
Date:   Wed, 24 Apr 2019 19:07:40 +0200
Message-Id: <20190424170924.514269719@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0d3bd18a5efd66097ef58622b898d3139790aa9d ]

In case cma_init_reserved_mem failed, need to free the memblock
allocated by memblock_reserve or memblock_alloc_range.

Quote Catalin's comments:
  https://lkml.org/lkml/2019/2/26/482

Kmemleak is supposed to work with the memblock_{alloc,free} pair and it
ignores the memblock_reserve() as a memblock_alloc() implementation
detail. It is, however, tolerant to memblock_free() being called on
a sub-range or just a different range from a previous memblock_alloc().
So the original patch looks fine to me. FWIW:

Link: http://lkml.kernel.org/r/20190227144631.16708-1-peng.fan@nxp.com
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/cma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index 43f4a122e969..f0d91aca5a4c 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -339,12 +339,14 @@ int __init cma_declare_contiguous(phys_addr_t base,
 
 	ret = cma_init_reserved_mem(base, size, order_per_bit, res_cma);
 	if (ret)
-		goto err;
+		goto free_mem;
 
 	pr_info("Reserved %ld MiB at %pa\n", (unsigned long)size / SZ_1M,
 		&base);
 	return 0;
 
+free_mem:
+	memblock_free(base, size);
 err:
 	pr_err("Failed to reserve %ld MiB\n", (unsigned long)size / SZ_1M);
 	return ret;
-- 
2.19.1



