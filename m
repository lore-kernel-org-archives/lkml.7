Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F797C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E6720674
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498050;
	bh=ZZD3P9bX6jJOAa0xFQLXVAuNjTf37Uhk8BgWgKMRGgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tDQVTrAfzoRYKgbsoWkUeS4h/0LEgYhAfGGl8TT/TDHmdoKA1sOPlio9+wFqje4so
	 FiEpoiWKbp94U83KWkSyNw2lBvB5klb+UgT0Z3Nw7/HcC8FRIaMp5sKzLZDRwC7idd
	 5jUwUVMQKXx8ZDoMTg1RIGTcSBpZ3aor0WOWMGYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfKKSr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:47:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730103AbfKKSrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:47:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B13B204FD;
        Mon, 11 Nov 2019 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498042;
        bh=ZZD3P9bX6jJOAa0xFQLXVAuNjTf37Uhk8BgWgKMRGgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/mtzFXUIPLYGfKv3tplIrYu4L/dTSj8aRXBxarGWfARpFgSK0vWSERj4JtT70rXH
         HOjLsGPKrk6N2HNGTbMigvmTUCLxi65ooVtvQHiDOtyTrw+mrpROUddufy9KDvaQR3
         J9C4cXGJ+NLqKo6vVnn+fvmy3ci3L0uM1e7vnSSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 124/125] mm/filemap.c: dont initiate writeback if mapping has no dirty pages
Date:   Mon, 11 Nov 2019 19:29:23 +0100
Message-Id: <20191111181456.247399096@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

commit c3aab9a0bd91b696a852169479b7db1ece6cbf8c upstream.

Functions like filemap_write_and_wait_range() should do nothing if inode
has no dirty pages or pages currently under writeback.  But they anyway
construct struct writeback_control and this does some atomic operations if
CONFIG_CGROUP_WRITEBACK=y - on fast path it locks inode->i_lock and
updates state of writeback ownership, on slow path might be more work.
Current this path is safely avoided only when inode mapping has no pages.

For example generic_file_read_iter() calls filemap_write_and_wait_range()
at each O_DIRECT read - pretty hot path.

This patch skips starting new writeback if mapping has no dirty tags set.
If writeback is already in progress filemap_write_and_wait_range() will
wait for it.

Link: http://lkml.kernel.org/r/156378816804.1087.8607636317907921438.stgit@buzz
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/filemap.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -438,7 +438,8 @@ int __filemap_fdatawrite_range(struct ad
 		.range_end = end,
 	};
 
-	if (!mapping_cap_writeback_dirty(mapping))
+	if (!mapping_cap_writeback_dirty(mapping) ||
+	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
 		return 0;
 
 	wbc_attach_fdatawrite_inode(&wbc, mapping->host);


