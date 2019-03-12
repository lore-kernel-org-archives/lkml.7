Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC800C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCC62087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414228;
	bh=jJeNMKTuDTLfXurOL/94bvBvR6YBEHhn9HlMjxYQ3Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ozPWlYK9x62w2w+nY1mIyFLll2xf+bW1S89neMs3yUGFS2mHwqXfj5VY1cnJwTWby
	 gJKnZL2XBd7AnPB76HWEms+God3yCOwwwD5kVHtpXubAvQkJ8r17pcGea5DxSrqbY3
	 sAnSttTqqYsbH+O4zIS/90TJVRnP4QF7c3BgtEx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfCLSKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbfCLRLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:55 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C3DE214AE;
        Tue, 12 Mar 2019 17:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410714;
        bh=jJeNMKTuDTLfXurOL/94bvBvR6YBEHhn9HlMjxYQ3Zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jv4qo2Nkb/30LSOcOxjnox6PFRyD0tEwK5pPT4SWDGFkyT6RZV6ly/rSeFXu950At
         1OifZS04aOhDn+Of7KtUBJOMofQDz7EiVx/M1FFFoeLOmquv3uAlpMPXxEJu9eSyul
         YGfdowQv7iJ82LNMi8gctgy16ySr261r86UfTvn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 028/171] iomap: get/put the page in iomap_page_create/release()
Date:   Tue, 12 Mar 2019 10:06:48 -0700
Message-Id: <20190312170350.383589064@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8e47a457321ca1a74ad194ab5dcbca764bc70731 ]

migrate_page_move_mapping() expects pages with private data set to have
a page_count elevated by 1.  This is what used to happen for xfs through
the buffer_heads code before the switch to iomap in commit 82cb14175e7d
("xfs: add support for sub-pagesize writeback without buffer_heads").
Not having the count elevated causes move_pages() to fail on memory
mapped files coming from xfs.

Make iomap compatible with the migrate_page_move_mapping() assumption by
elevating the page count as part of iomap_page_create() and lowering it
in iomap_page_release().

It causes the move_pages() syscall to misbehave on memory mapped files
from xfs.  It does not not move any pages, which I suppose is "just" a
perf issue, but it also ends up returning a positive number which is out
of spec for the syscall.  Talking to Michal Hocko, it sounds like
returning positive numbers might be a necessary update to move_pages()
anyway though.

Fixes: 82cb14175e7d ("xfs: add support for sub-pagesize writeback without buffer_heads")
Signed-off-by: Piotr Jaroszynski <pjaroszynski@nvidia.com>
[hch: actually get/put the page iomap_migrate_page() to make it work
      properly]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/iomap.c b/fs/iomap.c
index ce837d962d47..7793e9e42ad5 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -116,6 +116,12 @@ iomap_page_create(struct inode *inode, struct page *page)
 	atomic_set(&iop->read_count, 0);
 	atomic_set(&iop->write_count, 0);
 	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
+
+	/*
+	 * migrate_page_move_mapping() assumes that pages with private data have
+	 * their count elevated by 1.
+	 */
+	get_page(page);
 	set_page_private(page, (unsigned long)iop);
 	SetPagePrivate(page);
 	return iop;
@@ -132,6 +138,7 @@ iomap_page_release(struct page *page)
 	WARN_ON_ONCE(atomic_read(&iop->write_count));
 	ClearPagePrivate(page);
 	set_page_private(page, 0);
+	put_page(page);
 	kfree(iop);
 }
 
@@ -569,8 +576,10 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 
 	if (page_has_private(page)) {
 		ClearPagePrivate(page);
+		get_page(newpage);
 		set_page_private(newpage, page_private(page));
 		set_page_private(page, 0);
+		put_page(page);
 		SetPagePrivate(newpage);
 	}
 
-- 
2.19.1



