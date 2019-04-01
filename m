Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A0FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B355520856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139375;
	bh=LSrU1hhl2bvY4QjfwcmskCaDdGsX5kWruaQBSfIY/ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JLXusWG8tndDat+W6llD9Jf/fZsqV1jtPt8fAGn/STDW9FdAhumd3Ewyf8JYyzHrz
	 ZtR4eNC8iFW/GNuu5wtjJQAesZBNe2jnzAHXjo8CMbI/SxWdKam7GOAinZ1FHsaFNV
	 lcC6cvo30HQPHZl8H7P5HsqcpzaQ85zjTRnj6OMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbfDARWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731591AbfDARWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:22:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42B58206C0;
        Mon,  1 Apr 2019 17:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139371;
        bh=LSrU1hhl2bvY4QjfwcmskCaDdGsX5kWruaQBSfIY/ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u/UMcqmfcf62fU01+8b3HdwkcSQI9jtLFLA6jM+RtpiVyEWacVNMWwjNCPgRzcO35
         U9P3vA1ThwBtlTC0gFv7moqumwx24ei86NC22v4K9BOFeUlKkr5cV18FOcT8Y4Frvi
         PUe5pvzE+1evw7rZdcBgQoOm861UYzmDv+ojuOjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 057/107] btrfs: remove WARN_ON in log_dir_items
Date:   Mon,  1 Apr 2019 19:02:12 +0200
Message-Id: <20190401170050.958157155@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

commit 2cc8334270e281815c3850c3adea363c51f21e0d upstream.

When Filipe added the recursive directory logging stuff in
2f2ff0ee5e430 ("Btrfs: fix metadata inconsistencies after directory
fsync") he specifically didn't take the directory i_mutex for the
children directories that we need to log because of lockdep.  This is
generally fine, but can lead to this WARN_ON() tripping if we happen to
run delayed deletion's in between our first search and our second search
of dir_item/dir_indexes for this directory.  We expect this to happen,
so the WARN_ON() isn't necessary.  Drop the WARN_ON() and add a comment
so we know why this case can happen.

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3422,9 +3422,16 @@ static noinline int log_dir_items(struct
 	}
 	btrfs_release_path(path);
 
-	/* find the first key from this transaction again */
+	/*
+	 * Find the first key from this transaction again.  See the note for
+	 * log_new_dir_dentries, if we're logging a directory recursively we
+	 * won't be holding its i_mutex, which means we can modify the directory
+	 * while we're logging it.  If we remove an entry between our first
+	 * search and this search we'll not find the key again and can just
+	 * bail.
+	 */
 	ret = btrfs_search_slot(NULL, root, &min_key, path, 0, 0);
-	if (WARN_ON(ret != 0))
+	if (ret != 0)
 		goto done;
 
 	/*


