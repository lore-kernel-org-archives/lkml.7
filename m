Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750EFC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E67E22CE4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148706;
	bh=tTGj7TxV+qZskt12DE672FS4M46Bp/vOTZu0gwHaCJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Snx/Vm0pOM7CPTy8U8m3YcBmC+YYFtrKSXmUwfUd4t68TGobOdHmnSt5759NkUNvA
	 jBfWVDtQia4kI246fdf9nJuyHBP83o9oK2DgpHgalSHzhnEgvzhwSFNqz2B019B2/U
	 DYIhMo8so6jWKJWeZ/m3RgWqAqqn4CD+8bame2ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388504AbfGZNpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388487AbfGZNpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:45:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 627FA22CC2;
        Fri, 26 Jul 2019 13:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148701;
        bh=tTGj7TxV+qZskt12DE672FS4M46Bp/vOTZu0gwHaCJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BlCXobIu8+RczhbEEY7jpHStrKYS6/h19C8/SFl4LBMq98IciOZGv5aojBtYEK5/v
         uHcOkcv2I1WlCAPbGZ/dg99qy1IGtGPPexZYGFp+YOjA0uBcRNXS4j6x51WKLAGwUC
         1bpAYUHJJDGwn+uREgTzJ08uz68YsKDdzBu3HASc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Doug Berger <opendmb@gmail.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Yue Hu <huyue2@yulong.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Laura Abbott <labbott@redhat.com>, Peng Fan <peng.fan@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.9 19/30] mm/cma.c: fail if fixed declaration can't be honored
Date:   Fri, 26 Jul 2019 09:44:21 -0400
Message-Id: <20190726134432.12993-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134432.12993-1-sashal@kernel.org>
References: <20190726134432.12993-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit c633324e311243586675e732249339685e5d6faa ]

The description of cma_declare_contiguous() indicates that if the
'fixed' argument is true the reserved contiguous area must be exactly at
the address of the 'base' argument.

However, the function currently allows the 'base', 'size', and 'limit'
arguments to be silently adjusted to meet alignment constraints.  This
commit enforces the documented behavior through explicit checks that
return an error if the region does not fit within a specified region.

Link: http://lkml.kernel.org/r/1561422051-16142-1-git-send-email-opendmb@gmail.com
Fixes: 5ea3b1b2f8ad ("cma: add placement specifier for "cma=" kernel parameter")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Michal Nazarewicz <mina86@mina86.com>
Cc: Yue Hu <huyue2@yulong.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/cma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 4ea0f32761c1..7cb569a188c4 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -268,6 +268,12 @@ int __init cma_declare_contiguous(phys_addr_t base,
 	 */
 	alignment = max(alignment,  (phys_addr_t)PAGE_SIZE <<
 			  max_t(unsigned long, MAX_ORDER - 1, pageblock_order));
+	if (fixed && base & (alignment - 1)) {
+		ret = -EINVAL;
+		pr_err("Region at %pa must be aligned to %pa bytes\n",
+			&base, &alignment);
+		goto err;
+	}
 	base = ALIGN(base, alignment);
 	size = ALIGN(size, alignment);
 	limit &= ~(alignment - 1);
@@ -298,6 +304,13 @@ int __init cma_declare_contiguous(phys_addr_t base,
 	if (limit == 0 || limit > memblock_end)
 		limit = memblock_end;
 
+	if (base + size > limit) {
+		ret = -EINVAL;
+		pr_err("Size (%pa) of region at %pa exceeds limit (%pa)\n",
+			&size, &base, &limit);
+		goto err;
+	}
+
 	/* Reserve memory */
 	if (fixed) {
 		if (memblock_is_region_reserved(base, size) ||
-- 
2.20.1

