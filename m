Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82072C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE80217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558638906;
	bh=qqtzSOErxlsiyQ+y/Ki7LFxgaKu2TqUXZ3UHTW02tIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wiivSCE5yj+aSH80ZxffrMbh8YMbbk8FTC9ayNqlzxz9u0v3oA9UQX4JMOZ97rggy
	 XwgoGXdnOr5YFBN0/QeRGkJVuXpL7OZVmBpajXVc67O9YW0tsFL5cL4+B1ZugCr7H7
	 lozigC82ezm/Uk7geiXtUI/RCn+yOFSDZl4D4NSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbfEWTPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388854AbfEWTPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:15:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FDF1217D7;
        Thu, 23 May 2019 19:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638902;
        bh=qqtzSOErxlsiyQ+y/Ki7LFxgaKu2TqUXZ3UHTW02tIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aQmJJvw6RTQmqVnRhZN+pp0gsm/2eLdAwd/wFGd/0z0JUMQneWoZ40Ubwyn+8LF3c
         ebWYG1iDRO9zLNBa09ijFVXhHjv1Dcx/3zc6ANoDgIEHFyuuH9ayJS2hffsq3df8ZL
         GlvbMFb4pGkxOtPPSZED2EvMaT8kIwHJrzHCiRGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Tao <houtao1@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 023/114] brd: re-enable __GFP_HIGHMEM in brd_insert_page()
Date:   Thu, 23 May 2019 21:05:22 +0200
Message-Id: <20190523181733.976451550@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

commit f6b50160a06d4a0d6a3999ab0c5aec4f52dba248 upstream.

__GFP_HIGHMEM is disabled if dax is enabled on brd, however
dax support for brd has been removed since commit (7a862fbbdec6
"brd: remove dax support"), so restore __GFP_HIGHMEM in
brd_insert_page().

Also remove the no longer applicable comments about DAX and highmem.

Cc: stable@vger.kernel.org
Fixes: 7a862fbbdec6 ("brd: remove dax support")
Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/brd.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -96,13 +96,8 @@ static struct page *brd_insert_page(stru
 	/*
 	 * Must use NOIO because we don't want to recurse back into the
 	 * block or filesystem layers from page reclaim.
-	 *
-	 * Cannot support DAX and highmem, because our ->direct_access
-	 * routine for DAX must return memory that is always addressable.
-	 * If DAX was reworked to use pfns and kmap throughout, this
-	 * restriction might be able to be lifted.
 	 */
-	gfp_flags = GFP_NOIO | __GFP_ZERO;
+	gfp_flags = GFP_NOIO | __GFP_ZERO | __GFP_HIGHMEM;
 	page = alloc_page(gfp_flags);
 	if (!page)
 		return NULL;


