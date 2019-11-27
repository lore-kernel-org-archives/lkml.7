Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEFEC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6603920661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574884901;
	bh=o6w7PgA47rzSdbjn85d9GgkgbdSbOIW/GWwPXGXodEE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rRqD3a9cxyqPdMheaN0btWegKooqH9D1HT5hRPOOhxsHUe7WPopBbRTjCt14oiP+A
	 7Vq6aRYsN6ov8D0o+ahKxRLytH9AzvlhL9eZd7F9aAM4pySZXYmaQhVX2YU4lYQooa
	 ExHAPuIi6SqGq1vRK5UQLCG8E2JytFJ0eHKKpaJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfK0UBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:01:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfK0UBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:01:40 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F09205ED;
        Wed, 27 Nov 2019 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574884899;
        bh=o6w7PgA47rzSdbjn85d9GgkgbdSbOIW/GWwPXGXodEE=;
        h=Date:From:To:Cc:Subject:From;
        b=sP308u2hbDXMR2q3dZZo0JBwDMksE1GhaFfilJEywtHZ9B2ypm5TxWvNtauRR1VI2
         NPkhuCiAm3Utir3jIaNyly1yLhyWGvfDvhH3qwI5k5S5o3bdjmPur1+pI6uAGvFSmH
         W+2JLVhxK6WBnVw4g5njwl88mwmw7B22ETUlMXkw=
Date:   Wed, 27 Nov 2019 12:01:38 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: [GIT PULL] f2fs for 5.5
Message-ID: <20191127200138.GA47793@jaegeuk-macbookpro.roam.corp.google.com>
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

The following changes since commit b145b0eb2031a620ca010174240963e4d2c6ce26:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2019-10-04 11:17:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.5

for you to fetch changes up to 803e74be04b32f7785742dcabfc62116718fbb06:

  f2fs: stop GC when the victim becomes fully valid (2019-11-25 10:01:28 -0800)

----------------------------------------------------------------
f2fs-for-5.5-rc1

In this round, we've introduced fairly small number of patches as below.

Enhancement:
 - improve the in-place-update IO flow
 - allocate segment to guarantee no GC for pinned files

Bug fix:
 - fix updatetime in lazytime mode
 - potential memory leak in f2fs_listxattr
 - record parent inode number in rename2 correctly
 - fix deadlock in f2fs_gc along with atomic writes
 - avoid needless data migration in GC

----------------------------------------------------------------
Chao Yu (6):
      f2fs: fix to update time in lazytime mode
      f2fs: cache global IPU bio
      f2fs: fix wrong description in document
      f2fs: fix to update dir's i_pino during cross_rename
      f2fs: fix potential overflow
      f2fs: show f2fs instance in printk_ratelimited

Chengguang Xu (1):
      f2fs: choose hardlimit when softlimit is larger than hardlimit in f2fs_statfs_project()

Chengguang Xu via Linux-f2fs-devel (1):
      f2fs: mark recovery flag correctly in read_raw_super_block()

Jaegeuk Kim (4):
      f2fs: avoid kernel panic on corruption test
      f2fs: support aligned pinned file
      f2fs: expose main_blkaddr in sysfs
      f2fs: stop GC when the victim becomes fully valid

Qiuyang Sun (2):
      f2fs: update multi-dev metadata in resize_fs
      f2fs: check total_segments from devices in raw_super

Randall Huang (1):
      f2fs: fix to avoid memory leakage in f2fs_listxattr

Sahitya Tummala (1):
      f2fs: Fix deadlock in f2fs_gc() context during atomic files handling

 Documentation/ABI/testing/sysfs-fs-f2fs |   6 +
 Documentation/filesystems/f2fs.txt      |   5 +-
 fs/f2fs/checkpoint.c                    |   2 +-
 fs/f2fs/data.c                          | 190 +++++++++++++++++++++++++-------
 fs/f2fs/dir.c                           |   7 +-
 fs/f2fs/f2fs.h                          |  63 +++++++----
 fs/f2fs/file.c                          |  47 ++++++--
 fs/f2fs/gc.c                            |  46 +++++++-
 fs/f2fs/inode.c                         |   8 +-
 fs/f2fs/namei.c                         |  15 ++-
 fs/f2fs/node.c                          |   3 +-
 fs/f2fs/recovery.c                      |   2 +-
 fs/f2fs/segment.c                       |  64 ++++++++---
 fs/f2fs/segment.h                       |   2 +
 fs/f2fs/super.c                         |  50 +++++++--
 fs/f2fs/sysfs.c                         |   4 +
 fs/f2fs/xattr.c                         |  14 ++-
 17 files changed, 421 insertions(+), 107 deletions(-)
