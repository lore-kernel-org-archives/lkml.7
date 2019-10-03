Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3620C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6748215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120694;
	bh=OZi46/LEW9kyWJKIzQu9CrXEOyEZid01NguqZCh4Q1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eeY1e9WPGoVh4DkGh0UBVjBDn3m2oHepTK9WNZ4SOELPzWp3cMYKRx7afbRBpestt
	 D06zGshXjUsol4AX6wgcy4X5oY7R37gQeHigAk6amKkK2k+nUAXQLtLRLqjbLms5j7
	 aBNtWdMZF5uzptXF9Lw0u/mIc36ex+ki6AOhUaT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392295AbfJCQiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404781AbfJCQiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:38:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60CD320830;
        Thu,  3 Oct 2019 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120688;
        bh=OZi46/LEW9kyWJKIzQu9CrXEOyEZid01NguqZCh4Q1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=03XJpzUJEr8sT7KBllJJZGH4aHf6dkGszRPfQDDOnDXtMZMzo0PTSAtDqC0Ye+/hj
         n77ZUS0sWFtomaScEyuBaaPIvxdtxpyaMtzKM7CyeDSeJ8xNG9ugJ/JCh6HH/li24J
         fkPczQiNU7FZqPKMCw60noDNQev6Tu3qGDeyCB7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.2 287/313] btrfs: qgroup: Fix reserved data space leak if we have multiple reserve calls
Date:   Thu,  3 Oct 2019 17:54:25 +0200
Message-Id: <20191003154601.353973257@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

commit d4e204948fe3e0dc8e1fbf3f8f3290c9c2823be3 upstream.

[BUG]
The following script can cause btrfs qgroup data space leak:

  mkfs.btrfs -f $dev
  mount $dev -o nospace_cache $mnt

  btrfs subv create $mnt/subv
  btrfs quota en $mnt
  btrfs quota rescan -w $mnt
  btrfs qgroup limit 128m $mnt/subv

  for (( i = 0; i < 3; i++)); do
          # Create 3 64M holes for latter fallocate to fail
          truncate -s 192m $mnt/subv/file
          xfs_io -c "pwrite 64m 4k" $mnt/subv/file > /dev/null
          xfs_io -c "pwrite 128m 4k" $mnt/subv/file > /dev/null
          sync

          # it's supposed to fail, and each failure will leak at least 64M
          # data space
          xfs_io -f -c "falloc 0 192m" $mnt/subv/file &> /dev/null
          rm $mnt/subv/file
          sync
  done

  # Shouldn't fail after we removed the file
  xfs_io -f -c "falloc 0 64m" $mnt/subv/file

[CAUSE]
Btrfs qgroup data reserve code allow multiple reservations to happen on
a single extent_changeset:
E.g:
	btrfs_qgroup_reserve_data(inode, &data_reserved, 0, SZ_1M);
	btrfs_qgroup_reserve_data(inode, &data_reserved, SZ_1M, SZ_2M);
	btrfs_qgroup_reserve_data(inode, &data_reserved, 0, SZ_4M);

Btrfs qgroup code has its internal tracking to make sure we don't
double-reserve in above example.

The only pattern utilizing this feature is in the main while loop of
btrfs_fallocate() function.

However btrfs_qgroup_reserve_data()'s error handling has a bug in that
on error it clears all ranges in the io_tree with EXTENT_QGROUP_RESERVED
flag but doesn't free previously reserved bytes.

This bug has a two fold effect:
- Clearing EXTENT_QGROUP_RESERVED ranges
  This is the correct behavior, but it prevents
  btrfs_qgroup_check_reserved_leak() to catch the leakage as the
  detector is purely EXTENT_QGROUP_RESERVED flag based.

- Leak the previously reserved data bytes.

The bug manifests when N calls to btrfs_qgroup_reserve_data are made and
the last one fails, leaking space reserved in the previous ones.

[FIX]
Also free previously reserved data bytes when btrfs_qgroup_reserve_data
fails.

Fixes: 524725537023 ("btrfs: qgroup: Introduce btrfs_qgroup_reserve_data function")
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/qgroup.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3425,6 +3425,9 @@ cleanup:
 	while ((unode = ulist_next(&reserved->range_changed, &uiter)))
 		clear_extent_bit(&BTRFS_I(inode)->io_tree, unode->val,
 				 unode->aux, EXTENT_QGROUP_RESERVED, 0, 0, NULL);
+	/* Also free data bytes of already reserved one */
+	btrfs_qgroup_free_refroot(root->fs_info, root->root_key.objectid,
+				  orig_reserved, BTRFS_QGROUP_RSV_DATA);
 	extent_changeset_release(reserved);
 	return ret;
 }


