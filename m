Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E43BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5836207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412852;
	bh=/qMwCBjS5OxIf9Vf7TWIcYvIx/qWc11hFZuyuHJAh88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pB1ifM4SaLOTs97tt09mlyjrjIEaJ4euD0uKDB6lzF47S+0EWF3XJXaAHkV6juAh5
	 j/tCjjnoTqmWIlEyvxQC8uX+I7dIhheZ5qbwB0Kmenfi2Sgf2RFCxkklzVu36hWACM
	 OTh8qPU+HJHkRgDXriVrLO2SKjf1zo64PZB6y7cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfLCWku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:40:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbfLCWkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:40:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 519D12084F;
        Tue,  3 Dec 2019 22:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412846;
        bh=/qMwCBjS5OxIf9Vf7TWIcYvIx/qWc11hFZuyuHJAh88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4GFW+rA22G/0533d+yYSaTRtsHjl41hXn5TDO1+M36kkBnLRSsEVaxdfyikve+SB
         YvITYCz5Uth9X7PQUl8t7yi0eV1sHkIU1OrrcLPnbdmKiYsaYPuxIDRT86SdBxU9q7
         dptoakK+hIeWxxr6tBZhTr2FLnPh32aiA+YnCyTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 038/135] idr: Fix idr_alloc_u32 on 32-bit systems
Date:   Tue,  3 Dec 2019 23:34:38 +0100
Message-Id: <20191203213013.806415298@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox (Oracle) <willy@infradead.org>

[ Upstream commit b7e9728f3d7fc5c5c8508d99f1675212af5cfd49 ]

Attempting to allocate an entry at 0xffffffff when one is already
present would succeed in allocating one at 2^32, which would confuse
everything.  Return -ENOSPC in this case, as expected.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/radix-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 18c1dfbb17654..c8fa1d2745302 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1529,7 +1529,7 @@ void __rcu **idr_get_free(struct radix_tree_root *root,
 			offset = radix_tree_find_next_bit(node, IDR_FREE,
 							offset + 1);
 			start = next_index(start, node, offset);
-			if (start > max)
+			if (start > max || start == 0)
 				return ERR_PTR(-ENOSPC);
 			while (offset == RADIX_TREE_MAP_SIZE) {
 				offset = node->offset + 1;
-- 
2.20.1



