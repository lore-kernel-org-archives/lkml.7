Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93649C76198
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AB72190F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="C4FclbtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfGVJnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:43:42 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:35528 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728021AbfGVJnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:43:41 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jul 2019 05:43:40 EDT
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 8EF252E1251;
        Mon, 22 Jul 2019 12:36:09 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id piK2rewsgT-a8Nmo53U;
        Mon, 22 Jul 2019 12:36:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1563788169; bh=DL5UzA+B5XRB4qh0F2iWC5P1iVbcg0/rElIhEVtbXfg=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=C4FclbtDQ5b7smwavzXfTwnAGBDtyvoKz3qJxF/M76PisgHI1mGKIvG4cGohU069H
         I+8pkq99Gy18EG8atUE+4MtHJf7ZK+4vWOcIFCuhSSGHIaGhFtECkYzI0ajGXe82Ox
         ixtwBZaI7SGYRKn+koCY2zzBmM5SBCVGXhL8BdLI=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:38b3:1cdf:ad1a:1fe1])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id tCVKM0ss34-a8I48tMX;
        Mon, 22 Jul 2019 12:36:08 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 1/2] mm/filemap: don't initiate writeback if mapping has no
 dirty pages
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Mon, 22 Jul 2019 12:36:08 +0300
Message-ID: <156378816804.1087.8607636317907921438.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions like filemap_write_and_wait_range() should do nothing if inode
has no dirty pages or pages currently under writeback. But they anyway
construct struct writeback_control and this does some atomic operations
if CONFIG_CGROUP_WRITEBACK=y - on fast path it locks inode->i_lock and
updates state of writeback ownership, on slow path might be more work.
Current this path is safely avoided only when inode mapping has no pages.

For example generic_file_read_iter() calls filemap_write_and_wait_range()
at each O_DIRECT read - pretty hot path.

This patch skips starting new writeback if mapping has no dirty tags set.
If writeback is already in progress filemap_write_and_wait_range() will
wait for it.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/filemap.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d0cf700bf201..d9572593e5c7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -408,7 +408,8 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 		.range_end = end,
 	};
 
-	if (!mapping_cap_writeback_dirty(mapping))
+	if (!mapping_cap_writeback_dirty(mapping) ||
+	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
 		return 0;
 
 	wbc_attach_fdatawrite_inode(&wbc, mapping->host);

