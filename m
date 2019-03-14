Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AE3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2088921871
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552601890;
	bh=93MlPcfcpRBLvQ07dcLRBGk/+jPr+scKy0CzyYnoEZw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=GUcXhlvLco7aPD4mcNwOOAr03jjf7Zv84AXxGzENN/hqvcRoT1OAlJi6XCppR3qHq
	 hBqjLrJcJaK00aws7PMz/3lYLdUFoL0Z7zpO7b92Efom6sfkuW7e/oYZypQCtaEMGq
	 nIzVz2hIf1VLnaywO6ZeYrBI+aolFgS3HiVaZ2CI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfCNWSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbfCNWSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:18:08 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 519932186A;
        Thu, 14 Mar 2019 22:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552601887;
        bh=93MlPcfcpRBLvQ07dcLRBGk/+jPr+scKy0CzyYnoEZw=;
        h=Date:From:To:Cc:Subject:From;
        b=BqJdviVFnz3DgNh7jnGt3siaGjFz2SSnmP+kBOPsOveLMcSyix/T0PMm86kvZATkS
         NcHhjlDWmwlzRQUSifVQX/beeHZyzbyfPWFh8yMkbcNkvs2BGf996BRMLrMywauVVi
         417hauD+PtoK0W9pcyPO0sOuXyOYdevBTfv9EGu0=
Date:   Thu, 14 Mar 2019 15:18:06 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs-for-5.1
Message-ID: <20190314221806.GA87066@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Sorry for late request. Could you please consider this pull request?

Thanks,

The following changes since commit 3bd6e94bec122a951d462c239b47954cf5f36e33:

  arch: restore generic-y += shmparam.h for some architectures (2019-01-06 18:16:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.1

for you to fetch changes up to aff7b628ac2d58616b74789389ebb1e987081f49:

  f2fs: set pin_file under CAP_SYS_ADMIN (2019-03-14 10:20:54 -0700)

----------------------------------------------------------------
f2fs-for-5.1-rc1

We've continued mainly to fix bugs in this round, as f2fs has been shipped
in more devices. Especially, we've focused on stabilizing checkpoint=disable
feature, and provided some interfaces for QA.

Enhancement:
 - expose FS_NOCOW_FL for pin_file
 - run discard jobs at unmount time with timeout
 - tune discarding thread to avoid idling which consumes power
 - some checking codes to address vulnerabilities
 - give random value to i_generation
 - shutdown with more flags for QA

Bug fix:
 - clean up stale objects when mount is failed along with checkpoint=disable
 - fix system being stuck due to wrong count by atomic writes
 - handle some corrupted disk cases
 - fix a deadlock in f2fs_read_inline_dir

We've also added some minor build errors and clean-up patches.

----------------------------------------------------------------
Chao Yu (23):
      f2fs: check inject_rate validity during configuring
      f2fs: fix to trigger fsck if dirent.name_len is zero
      f2fs: fix to initialize variable to avoid UBSAN/smatch warning
      f2fs: fix to set sbi dirty correctly
      f2fs: fix to document inline_xattr_size option
      f2fs: fix potential data inconsistence of checkpoint
      f2fs: fix to check inline_xattr_size boundary correctly
      f2fs: don't allow negative ->write_io_size_bits
      f2fs: fix to retry fill_super only if recovery failed
      f2fs: make fault injection covering __submit_flush_wait()
      f2fs: fix encrypted page memory leak
      f2fs: fix to update iostat correctly in IPU path
      f2fs: fix to dirty inode for i_mode recovery
      f2fs: fix to avoid deadlock of atomic file operations
      f2fs: trace f2fs_ioc_shutdown
      f2fs: print more parameters in trace_f2fs_map_blocks
      f2fs: fix to use kvfree instead of kzfree
      f2fs: remove wrong comment in f2fs_invalidate_page()
      f2fs: fix to add refcount once page is tagged PG_private
      f2fs: don't trigger read IO for beyond EOF page
      f2fs: fix to do sanity check with inode.i_inline_xattr_size
      f2fs: fix to adapt small inline xattr space in __find_inline_xattr()
      f2fs: fix to avoid deadlock in f2fs_read_inline_dir()

Chengguang Xu (2):
      f2fs: change error code to -ENOMEM from -EINVAL
      f2fs: jump to label 'free_node_inode' when failing from d_make_root()

Gao Xiang (3):
      f2fs: use xattr_prefix to wrap up
      f2fs: silence VM_WARN_ON_ONCE in mempool_alloc
      f2fs: no need to take page lock in readdir

Geliang Tang (1):
      f2fs: fix typos in code comments

Greg Kroah-Hartman (1):
      f2fs: no need to check return value of debugfs_create functions

Jaegeuk Kim (15):
      f2fs: wait on atomic writes to count F2FS_CP_WB_DATA
      f2fs: don't access node/meta inode mapping after iput
      f2fs: export FS_NOCOW_FL flag to user
      f2fs: run discard jobs when put_super
      f2fs: add quick mode of checkpoint=disable for QA
      f2fs: try to keep CP_TRIMMED_FLAG after successful umount
      f2fs: don't wake up too frequently, if there is lots of IOs
      f2fs: avoid null pointer exception in dcc_info
      f2fs: flush quota blocks after turnning it off
      f2fs: sync filesystem after roll-forward recovery
      f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG
      f2fs: fix wrong #endif
      f2fs: give random value to i_generation
      f2fs: give some messages for inline_xattr_size
      f2fs: set pin_file under CAP_SYS_ADMIN

Sahitya Tummala (1):
      f2fs: do not use mutex lock in atomic context

Sheng Yong (3):
      f2fs: check if file namelen exceeds max value
      f2fs: add brackets for macros
      f2fs: UBSAN: set boolean value iostat_enable correctly

YueHaibing (1):
      f2fs: remove set but not used variable 'err'

Zeng Guangyue (1):
      f2fs: correct spelling mistake

Zhikang Zhang (1):
      f2fs: fix compile warnings: 'struct *' declared inside parameter list

zhengliang (1):
      f2fs: fix to data block override node segment by mistake

 Documentation/ABI/testing/sysfs-fs-f2fs |   7 ++
 Documentation/filesystems/f2fs.txt      |   2 +
 fs/f2fs/checkpoint.c                    |  20 ++++--
 fs/f2fs/data.c                          |  59 ++++++++---------
 fs/f2fs/debug.c                         |  39 +++++------
 fs/f2fs/dir.c                           |  15 +++--
 fs/f2fs/extent_cache.c                  |   2 +-
 fs/f2fs/f2fs.h                          |  81 +++++++++++++++--------
 fs/f2fs/file.c                          |  46 +++++++------
 fs/f2fs/inline.c                        |  12 +++-
 fs/f2fs/inode.c                         |  15 +++++
 fs/f2fs/namei.c                         |   3 +-
 fs/f2fs/node.c                          |   6 +-
 fs/f2fs/segment.c                       |  80 +++++++++++++++-------
 fs/f2fs/segment.h                       |   2 +-
 fs/f2fs/super.c                         | 114 ++++++++++++++++++++++----------
 fs/f2fs/sysfs.c                         |  17 ++++-
 fs/f2fs/trace.c                         |  20 ++++--
 fs/f2fs/xattr.c                         |  25 ++++---
 fs/f2fs/xattr.h                         |   6 ++
 include/linux/f2fs_fs.h                 |  20 +++---
 include/trace/events/f2fs.h             |  47 ++++++++++++-
 22 files changed, 430 insertions(+), 208 deletions(-)
