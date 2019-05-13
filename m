Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F75C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA96208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557790701;
	bh=KHo/8VO1q8PL3nZybC3R+kGEoBbsv8Y0Pf5QPxbCbzc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=pK3a1LJCEFHMnsavScTJs7XAhVqTVtmYuCe1xnsQ47+zUc04VgqCKRyzlr0x/0mzM
	 PPSV4n9TNabcxDw2rN0hF/avLW1Rb+16HE5hFSWcA0hyUhYB1xZJ2fS7dXIhkejK/V
	 anvSuG5a8l8tLNADWr40K0x76R/GBw4CgmBIp+n4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfEMXiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 19:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfEMXiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 19:38:20 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34AA820879;
        Mon, 13 May 2019 23:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557790699;
        bh=KHo/8VO1q8PL3nZybC3R+kGEoBbsv8Y0Pf5QPxbCbzc=;
        h=Date:From:To:Cc:Subject:From;
        b=gBNHMtoCfSVHnVCV2d0qIt792RO4t/cNNMbhD2pP5rfMubxxghzk65jcy8rBUXY/h
         okAK8lDC6SiKq4pVzMhJS2SIsA4S+O7GQmbciN5EEWmU1dBWMu3Jrl7w472epO3fA/
         HDXE9FOrJsZWoh4E+ea9BH3r/q5WuJf2uS7EsqLA=
Date:   Mon, 13 May 2019 16:38:18 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs-for-5.2
Message-ID: <20190513233818.GA33287@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks as lways,

The following changes since commit 8ed86627f715eacbd6db6862f9499d6d96ea4ad6:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid (2019-04-03 06:11:12 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-v5.2-rc1

for you to fetch changes up to 2777e654371dd4207a3a7f4fb5fa39550053a080:

  f2fs: fix to avoid accessing xattr across the boundary (2019-05-09 09:43:29 -0700)

----------------------------------------------------------------
f2fs-for-5.2-rc1

Another round of various bug fixes came in. Damien improved SMR drive support a
bit, and Chao replaced BUG_ON() with reporting errors to user since we've not
hit from users but did hit from crafted images. We've found a disk layout bug
in large_nat_bits feature which supports very large NAT entries enabled at mkfs.
If the feature is enabled, it will give a notice to run fsck to correct the
on-disk layout.

Enhancement:
 - reduce memory consumption for SMR drive
 - better discard handling for multiple partitions
 - tracepoints for f2fs_file_write_iter/f2fs_filemap_fault
 - allow to change CP_CHKSUM_OFFSET
 - detect wrong layout of large_nat_bitmap feature
 - enhance checking valid data indices

Bug fix:
 - Multiple partition support for SMR drive
 - deadlock problem in f2fs_balance_fs_bg
 - add boundary checks to fix abnormal behaviors on fuzzed images
 - inline_xattr space calculations
 - replace f2fs_bug_on with errors

In addition, this series contains various memory boundary check and sanity check
of on-disk consistency.

----------------------------------------------------------------
Chao Yu (31):
      f2fs: fix potential recursive call when enabling data_flush
      f2fs: add comment for conditional compilation statement
      f2fs: add tracepoint for f2fs_file_write_iter()
      f2fs: fix to avoid deadloop in foreground GC
      f2fs: fix error path of recovery
      f2fs: fix to retrieve inline xattr space
      f2fs: fix to use inline space only if inline_xattr is enable
      f2fs: fix to avoid panic in dec_valid_block_count()
      f2fs: fix to avoid panic in dec_valid_node_count()
      f2fs: fix wrong __is_meta_io() macro
      f2fs: remove new blank line of f2fs kernel message
      f2fs: fix to clear dirty inode in error path of f2fs_iget()
      f2fs: fix to avoid panic in f2fs_remove_inode_page()
      f2fs: fix to do checksum even if inode page is uptodate
      f2fs: fix to do sanity check on free nid
      f2fs: fix to avoid panic in do_recover_data()
      f2fs: fix to do sanity check on valid node/block count
      f2fs: fix to do sanity check on valid block count of segment
      f2fs: fix to avoid panic in f2fs_inplace_write_data()
      f2fs: fix to set FI_UPDATE_WRITE correctly
      f2fs: introduce f2fs_read_single_page() for cleanup
      f2fs: allow address pointer number of dnode aligning to specified size
      f2fs: allow unfixed f2fs_checkpoint.checksum_offset
      f2fs: relocate chksum_offset for large_nat_bitmap feature
      f2fs: fix to consider multiple device for readonly check
      f2fs: fix to skip recovery on readonly device
      f2fs: fix to be aware of readonly device in write_checkpoint()
      f2fs: fix to handle error in f2fs_disable_checkpoint()
      f2fs: introduce DATA_GENERIC_ENHANCE
      f2fs: add tracepoint for f2fs_filemap_fault()
      f2fs: fix to avoid potential race on sbi->unusable_block_count access/update

Chengguang Xu (1):
      f2fs: remove redundant check in f2fs_file_write_iter()

Damien Le Moal (3):
      f2fs: Fix use of number of devices
      f2fs: Reduce zoned block device memory usage
      f2fs: improve discard handling with multi-device volumes

Hariprasad Kelam (1):
      f2fs: data: fix warning Using plain integer as NULL pointer

Park Ju Hyung (1):
      f2fs: mark is_extension_exist() inline

Randall Huang (1):
      f2fs: fix to avoid accessing xattr across the boundary

Youngjun Yoo (2):
      f2fs: insert space before the open parenthesis '('
      f2fs: Replace spaces with tab

 fs/f2fs/acl.c               |   4 +-
 fs/f2fs/checkpoint.c        | 108 +++++++++++++----
 fs/f2fs/data.c              | 285 +++++++++++++++++++++++++-------------------
 fs/f2fs/f2fs.h              | 127 +++++++++++++++-----
 fs/f2fs/file.c              |  76 +++++++-----
 fs/f2fs/gc.c                |  16 ++-
 fs/f2fs/inline.c            |  17 +++
 fs/f2fs/inode.c             |  12 +-
 fs/f2fs/namei.c             |   2 +-
 fs/f2fs/node.c              |  43 +++++--
 fs/f2fs/recovery.c          |  37 +++++-
 fs/f2fs/segment.c           |  71 ++++++-----
 fs/f2fs/segment.h           |  16 +--
 fs/f2fs/super.c             |  70 ++++++++---
 fs/f2fs/xattr.c             |  36 ++++--
 fs/f2fs/xattr.h             |   2 +
 include/linux/f2fs_fs.h     |  11 +-
 include/trace/events/f2fs.h |  57 +++++++++
 18 files changed, 688 insertions(+), 302 deletions(-)
