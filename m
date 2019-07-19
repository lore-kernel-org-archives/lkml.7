Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6103CC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5BF20873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510461;
	bh=2fRjPlFI+IC2gcVvwucsAE2Olid+tMqkjJzEkKVk00U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qTPQG3pHPRqvcyn2UWHBUS9wbI2fVtGoHEVkzDtrApIZbOzPgqTbiGkfhIwUBxujV
	 KA5CafU27uTf8x2t+66Xy6UAcNmimswKr+r/A1g6qyoLD48ItFj6qLIsirXvkNCWHb
	 sYofKuBhmlBJnGBczRoT2EUK4TvGlqQ6GA2MXUJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbfGSE1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732377AbfGSEGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:06:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BD72218B8;
        Fri, 19 Jul 2019 04:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509211;
        bh=2fRjPlFI+IC2gcVvwucsAE2Olid+tMqkjJzEkKVk00U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMkRRgg/f7BTXgHk4ESTEEVb+qog01H0XI1qXA6/9SiUJg6zJpqgvA97xAUQxoVKK
         uqQWoxjuOxO2QX09kTzMvlU6Yr33F2yLf3/iWofE3zntFj4q9IrqKprsLc6cEDEQ4k
         A9Jnwv/mkI0fZWR7RV+pGqP2EyZrJwfZbZU3yGFI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Robin Murphy <robin.murphy@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 5.1 129/141] mm/gup.c: mark undo_dev_pagemap as __maybe_unused
Date:   Fri, 19 Jul 2019 00:02:34 -0400
Message-Id: <20190719040246.15945-129-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 790c73690c2bbecb3f6f8becbdb11ddc9bcff8cc ]

Several mips builds generate the following build warning.

  mm/gup.c:1788:13: warning: 'undo_dev_pagemap' defined but not used

The function is declared unconditionally but only called from behind
various ifdefs. Mark it __maybe_unused.

Link: http://lkml.kernel.org/r/1562072523-22311-1-git-send-email-linux@roeck-us.net
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 91819b8ad9cc..60d759f4e4b5 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1545,7 +1545,8 @@ static inline pte_t gup_get_pte(pte_t *ptep)
 }
 #endif
 
-static void undo_dev_pagemap(int *nr, int nr_start, struct page **pages)
+static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
+					    struct page **pages)
 {
 	while ((*nr) - nr_start) {
 		struct page *page = pages[--(*nr)];
-- 
2.20.1

