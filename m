Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2995C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78FA20665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521592;
	bh=ofpkPgRD64aKZDqtCzJoHyY0Y2m1YOfn+kBsA8178j8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qgHD9gho7z4QAQCrZJuiKXPTrt1Nl5bUa5hxbFc6An7M78wmX1ts+0Fb8qA2yUW+/
	 zOMilpkBhoOwii9IMtAXtnVea1youo4DcbNT1W6SfMoJUM3+bXzrb4WzSAUpFoBkCY
	 EiuGg51ltOkQVmbsOoMxX9GtqGNzPkqAQbrT7t/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfLPSC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:02:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729411AbfLPSCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:02:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 126642072D;
        Mon, 16 Dec 2019 18:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519372;
        bh=ofpkPgRD64aKZDqtCzJoHyY0Y2m1YOfn+kBsA8178j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hbnOfwJQ5ish1Rz/hEQmQ6g3FLN9q2p1hiUdW0YDsFAA0RSdaGbw5W84uuEtUfNn2
         BUIyI8kdgnUCo1XiI3kaJhLSySkJ4cIc5gkhzhDbfBh5x26YJCk9j9aIpsW2QcZhIj
         GsNKbe/vQVRMtQORpO5KOjo6Vguf9iW30FscGBRA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 038/140] Btrfs: fix metadata space leak on fixup worker failure to set range as delalloc
Date:   Mon, 16 Dec 2019 18:48:26 +0100
Message-Id: <20191216174759.397266886@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit 536870071dbc4278264f59c9a2f5f447e584d139 upstream.

In the fixup worker, if we fail to mark the range as delalloc in the io
tree, we must release the previously reserved metadata, as well as update
the outstanding extents counter for the inode, otherwise we leak metadata
space.

In pratice we can't return an error from btrfs_set_extent_delalloc(),
which is just a wrapper around __set_extent_bit(), as for most errors
__set_extent_bit() does a BUG_ON() (or panics which hits a BUG_ON() as
well) and returning an -EEXIST error doesn't happen in this case since
the exclusive bits parameter always has a value of 0 through this code
path. Nevertheless, just fix the error handling in the fixup worker,
in case one day __set_extent_bit() can return an error to this code
path.

Fixes: f3038ee3a3f101 ("btrfs: Handle btrfs_set_extent_delalloc failure in fixup worker")
CC: stable@vger.kernel.org # 4.19+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2161,12 +2161,16 @@ again:
 		mapping_set_error(page->mapping, ret);
 		end_extent_writepage(page, ret, page_start, page_end);
 		ClearPageChecked(page);
-		goto out;
+		goto out_reserved;
 	}
 
 	ClearPageChecked(page);
 	set_page_dirty(page);
+out_reserved:
 	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
+	if (ret)
+		btrfs_delalloc_release_space(inode, data_reserved, page_start,
+					     PAGE_SIZE, true);
 out:
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, page_start, page_end,
 			     &cached_state);


