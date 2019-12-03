Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EF8C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F34F2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413161;
	bh=vrTu9F5jC4RL5sr9hqkoyrHflN/833s3zkjY/EcRUUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wo31jnKY/xga+oAG2wMpSKn6X9/0/05Tc91OIf+AXvFhiNPsalg6+j4eVSqLlwHKd
	 MDFAa7r8zP6hqq/mU1j65FsKLzzGgR8pS7l16HnssbKjgrdTlGjmMIF5uPRtNEkpSt
	 v2wYnHNm9tlnjjXNAteuDDcw/hLfb4SIaH/1lH5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfLCWp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:45:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728971AbfLCWp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:45:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C59720656;
        Tue,  3 Dec 2019 22:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413156;
        bh=vrTu9F5jC4RL5sr9hqkoyrHflN/833s3zkjY/EcRUUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rAa1MW81SFHQfsO6cuTn2mXooLt6sdMyBMwHp25dP+v5BvPO/v69/Xd3AUdfw6T4I
         fUjSimCHRW/wng4UkaRrppXN79z3XMvyPjPLDt06KtSYD9rHE2StkoImLjhdhBTcWw
         yc3SH8ml1uUr4Ikjdujk3ZsrzJoq1K6l603nvypI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 020/321] idr: Fix idr_alloc_u32 on 32-bit systems
Date:   Tue,  3 Dec 2019 23:31:26 +0100
Message-Id: <20191203223428.170816737@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
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
index bc03ecc4dfd2f..e5cab5c4e3830 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -2172,7 +2172,7 @@ void __rcu **idr_get_free(struct radix_tree_root *root,
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



