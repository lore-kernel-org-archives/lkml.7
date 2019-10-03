Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFA8C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277B6222C4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121537;
	bh=mdL0Q4Tu0YQ0/7eHxAxBpSVNI6snCFhuwkmBw7iEIB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ds8MurWfkb7THta82UjqDQo4QG/WY/BH4X5xOPpXf10SMBrqRpqe/escOUbhftd90
	 z7WmLVy5y8o1izywMNd1JWEqTFsS9i7CDyw8Rl517sz+bxMrRGjEpA8D5aXBWkUKar
	 B6MlRgciRl1zMAshUiCxNdYxhkiPs838mwYytqiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405664AbfJCQwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393171AbfJCQwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:52:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 528E02054F;
        Thu,  3 Oct 2019 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121528;
        bh=mdL0Q4Tu0YQ0/7eHxAxBpSVNI6snCFhuwkmBw7iEIB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SRNeIyqEOLiA+I9vnarFdqD0Zd9sIluEsar7nwixnCaFhHHpo5dvDUHyoVe1at7h2
         3Jv1zpoTsNdEn2EiYZJk8dme2HXWW686KoDtUHAn9FbfHZV6dy53rAsUo7OB3sZLxK
         DeOKlrULdE4UEhdPynLAk1IziAXe0qXV9S9L20As=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.3 313/344] btrfs: qgroup: Fix the wrong target io_tree when freeing reserved data space
Date:   Thu,  3 Oct 2019 17:54:38 +0200
Message-Id: <20191003154610.019756365@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

commit bab32fc069ce8829c416e8737c119f62a57970f9 upstream.

[BUG]
Under the following case with qgroup enabled, if some error happened
after we have reserved delalloc space, then in error handling path, we
could cause qgroup data space leakage:

>From btrfs_truncate_block() in inode.c:

	ret = btrfs_delalloc_reserve_space(inode, &data_reserved,
					   block_start, blocksize);
	if (ret)
		goto out;

 again:
	page = find_or_create_page(mapping, index, mask);
	if (!page) {
		btrfs_delalloc_release_space(inode, data_reserved,
					     block_start, blocksize, true);
		btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize, true);
		ret = -ENOMEM;
		goto out;
	}

[CAUSE]
In the above case, btrfs_delalloc_reserve_space() will call
btrfs_qgroup_reserve_data() and mark the io_tree range with
EXTENT_QGROUP_RESERVED flag.

In the error handling path, we have the following call stack:
btrfs_delalloc_release_space()
|- btrfs_free_reserved_data_space()
   |- btrsf_qgroup_free_data()
      |- __btrfs_qgroup_release_data(reserved=@reserved, free=1)
         |- qgroup_free_reserved_data(reserved=@reserved)
            |- clear_record_extent_bits();
            |- freed += changeset.bytes_changed;

However due to a completion bug, qgroup_free_reserved_data() will clear
EXTENT_QGROUP_RESERVED flag in BTRFS_I(inode)->io_failure_tree, other
than the correct BTRFS_I(inode)->io_tree.
Since io_failure_tree is never marked with that flag,
btrfs_qgroup_free_data() will not free any data reserved space at all,
causing a leakage.

This type of error handling can only be triggered by errors outside of
qgroup code. So EDQUOT error from qgroup can't trigger it.

[FIX]
Fix the wrong target io_tree.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Fixes: bc42bda22345 ("btrfs: qgroup: Fix qgroup reserved space underflow by only freeing reserved ranges")
CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/qgroup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3469,7 +3469,7 @@ static int qgroup_free_reserved_data(str
 		 * EXTENT_QGROUP_RESERVED, we won't double free.
 		 * So not need to rush.
 		 */
-		ret = clear_record_extent_bits(&BTRFS_I(inode)->io_failure_tree,
+		ret = clear_record_extent_bits(&BTRFS_I(inode)->io_tree,
 				free_start, free_start + free_len - 1,
 				EXTENT_QGROUP_RESERVED, &changeset);
 		if (ret < 0)


