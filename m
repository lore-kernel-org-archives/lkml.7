Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE68C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209B320863
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482477;
	bh=vJW6LQs0JXd5WSJAwFOH6N0Stfj8RtMRcw+ztX7ByVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NU6HAgAEc2rQtsaGch3cTMwVCQLf/l/jhy4WS6yQ1Eq5BvzSRRmnQpJg8nhtxEnAX
	 eBdObcK7D5lnhNY9XGXt4h9ZFnQsLCxnJUBDC0W1e6nrOSng3jlJd6+0A+0C4GET2I
	 1DUOAtP33obC8rRX2t4r6FWUqePNK4cIOFlK2ZWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfLDSBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:01:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729513AbfLDSBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:01:12 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9DDB20659;
        Wed,  4 Dec 2019 18:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482472;
        bh=vJW6LQs0JXd5WSJAwFOH6N0Stfj8RtMRcw+ztX7ByVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KobLCTPutUWgaLV52i8Rdia0P8kpxUjjtcUHDnmjKVlneb/eDkA2jnUcR5gIilx2d
         GZ/FqqSYkv9Hkaguvox2DNsuEEoVsPhGyl+/2xAzMkZouHCvF/jWbvqPiY5OYUM84o
         S3dCn6/7F0MLemjvW0QbkMIYuQMdsFPya4ZyOe3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 010/209] idr: Fix idr_alloc_u32 on 32-bit systems
Date:   Wed,  4 Dec 2019 18:53:42 +0100
Message-Id: <20191204175322.287481892@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
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
index d172f0341b807..ff00c816266b1 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -2184,7 +2184,7 @@ void __rcu **idr_get_free_cmn(struct radix_tree_root *root,
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



