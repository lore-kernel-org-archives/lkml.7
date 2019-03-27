Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A48C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA1120651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711855;
	bh=xfPjTZbl0guBHbXrcyWt9wkOWvjJdbxsx62YRpHf9ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AV8fvYyI+iszz1Cwxps9vuVZkbEJgENVBVmVcsHaO2pCY14+MFPvrYkngfGqME/6P
	 R43xYxBOCt+7076u6bA4yunE8RM9XyneuU049E0UtZtS2Dt3onXXe1sj1yXTYhXvCr
	 cYjc5EyL2dlno9G8/hJcg+0qniYCcEmJEj3EGwsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403892AbfC0SXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391524AbfC0SXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:23:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5553C2063F;
        Wed, 27 Mar 2019 18:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711017;
        bh=xfPjTZbl0guBHbXrcyWt9wkOWvjJdbxsx62YRpHf9ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lhQGtHRG9WIxZZJiiS/XrOZzo9iLllM+FNSvFo2TAaitEoMfLTMbpIqS6xwPAD4+a
         sxTnmPuBHmUYIb4VCkcZQjScT/Lo6mG01bzdKB0Oq/ylZUfpfHqMLM0EOLIYEzSuxP
         7Jc1Okzg9XN+Ew7+Putt4Kaw9Y6NUMcW0dubqE6w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>, Laura Abbott <labbott@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.4 08/63] mm/cma.c: cma_declare_contiguous: correct err handling
Date:   Wed, 27 Mar 2019 14:22:28 -0400
Message-Id: <20190327182323.18577-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182323.18577-1-sashal@kernel.org>
References: <20190327182323.18577-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

