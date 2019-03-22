Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C77FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2A721917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254808;
	bh=bU5E9If603RbzKrUlDpZfdqbqCdlii1J4/2vxjhf+D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cgfg+TPSOMUJeCujd+xq6EATUls1j3uRmYU5/rl5KA5TaVJ7A00GUv+ZGRhvmv0t1
	 H2arcG7vzAqAbYUzDE5ez//tboTCt4AV5IhzJUUSOEIz51n1dG+Lvsdb5wL20rIPmj
	 qrztZte1zVFXA2UYMAN4EBmb7wlFNOyoACIKh1X8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbfCVLkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729265AbfCVLkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:40:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A2D821B24;
        Fri, 22 Mar 2019 11:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254802;
        bh=bU5E9If603RbzKrUlDpZfdqbqCdlii1J4/2vxjhf+D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvLnkKEsVx0YM3e1959OApb0+dME773qnK25HABruK3pLUBIhsoiaX7Us2lVE0/Qx
         zrYYvZuRoxpvoCDjM9PRGsqHviQS1I1utRl8QZULCAFw3RJmxYWRij+wjIXzho/n1U
         kJi3ZD7OsxxvvAB0QIT1WuaD2N0vDgYSpFt5jKFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Jan Kara <jack@suse.cz>,
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
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 016/118] mm/gup: fix gup_pmd_range() for dax
Date:   Fri, 22 Mar 2019 12:14:48 +0100
Message-Id: <20190322111217.134589619@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d71da7216c6e..99c2f10188c0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1423,7 +1423,8 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 		if (pmd_none(pmd))
 			return 0;
 
-		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd))) {
+		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
+			     pmd_devmap(pmd))) {
 			/*
 			 * NUMA hinting faults need to be handled in the GUP
 			 * slowpath for accounting purposes and so that they
-- 
2.19.1



