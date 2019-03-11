Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1540FC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E049D217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334289;
	bh=PvDL5hfdTo39+081iHzkelRzGH/4i9a2+4eP8jFCCv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TwGg/heVGqdy3AnngXv4W+B9sc7ebxm9YIQCAjKGCBuBqt5Z9vKECfk3OglbYv9QP
	 FfcFq0pFUhEMpffWnIlJuGU1XmnQRuPzbE/khRZHMMqyBXyy44JFzmAkYnX+kUMd4A
	 F4pytiyRt1pB7YrLM1CXhqg+uAn+XGGr/qO8n84c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfCKT6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:58:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728521AbfCKT6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:58:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ACAA2084F;
        Mon, 11 Mar 2019 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334282;
        bh=PvDL5hfdTo39+081iHzkelRzGH/4i9a2+4eP8jFCCv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tqzFM3PxPRKFZ/5BwC0Lahcl49AXKVUkZk0bdiUCFf6ak/wSQp5LjcZDoRo/6w8ad
         GsbbI5h3PMNX4KpTQ4toDZ8VpjVNzJRRKyiYdIaaf1qsylNnPQG7U0FqtBUaNxmlnI
         OAxG6WijGYVRXQQQFIWJ3I7Ck4rk6J2Ky25a8rqA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Zhao <yuzhao@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.19 34/44] mm/gup: fix gup_pmd_range() for dax
Date:   Mon, 11 Mar 2019 15:56:50 -0400
Message-Id: <20190311195700.138462-34-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Zhao <yuzhao@google.com>

[ Upstream commit 414fd080d125408cb15d04ff4907e1dd8145c8c7 ]

For dax pmd, pmd_trans_huge() returns false but pmd_huge() returns true
on x86.  So the function works as long as hugetlb is configured.
However, dax doesn't depend on hugetlb.

Link: http://lkml.kernel.org/r/20190111034033.601-1-yuzhao@google.com
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1abc8b4afff6..0a5374e6e82d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1649,7 +1649,8 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 		if (!pmd_present(pmd))
 			return 0;
 
-		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd))) {
+		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
+			     pmd_devmap(pmd))) {
 			/*
 			 * NUMA hinting faults need to be handled in the GUP
 			 * slowpath for accounting purposes and so that they
-- 
2.19.1

