Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3A3C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F098206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138876;
	bh=BWZHSDq+fteNM14pWLBv+L9HmWzg6Kx9g7A4YrbVTwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R6BZae7wPMYXkfTlrjS/t/JtJsGsZd8NWem38SdbdtUJQS1bfvmYQFAfX9cTCZpQd
	 2iDK6UM7s/hT5dc6ENAve2F3JfdpxTXDIxy/RnjINh5D1AY9yOqm+HQgksuuFF3TY6
	 rAPGuWg4nQx1zdkTNTYn2Bw43KN9xoMzp1m1WDaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbfDAROe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728813AbfDAROc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:14:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E3F521473;
        Mon,  1 Apr 2019 17:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138871;
        bh=BWZHSDq+fteNM14pWLBv+L9HmWzg6Kx9g7A4YrbVTwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qpknGuLkfRChwEDyvNFMPZPhZayG5VrsSWiaUtYjNgv4tncKPZXco+ph1zrJ1Bbv5
         oGHJa8y2jkfoDtDSIHVHiKQH/HtSQGhdnkT4jk/6ZuRPIUp7nGis5dSSazvmYJhL3r
         k9E5H3NhcP/fcsIPIxqcs/XdBw7FCjvhrA+GVJLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 046/134] btrfs: remove WARN_ON in log_dir_items
Date:   Mon,  1 Apr 2019 19:01:22 +0200
Message-Id: <20190401170048.899722291@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3532,9 +3532,16 @@ static noinline int log_dir_items(struct
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


