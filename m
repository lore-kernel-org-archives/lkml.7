Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9417CC74A5B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6715921537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562865220;
	bh=bvCqdNXA0lNVRHiKVn7GV3+2W08VEttCRx0QEFub0cs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=EUVpUhgvnLnNBhiI1YUXX5S6oajdhiI2AWFXqMHw9hBsBevIAmxo8b9el8cUyDlXc
	 1l6p9UHLXU3tJRKVXjRA0mPjtLL8fzQaT9H3HUwLXVp/sYiMYv416Sb713N9WGJCGi
	 PbQ0VIa57+Yec2MrH/f4eDXhv1hHHwBQBywCsFRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfGKRNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbfGKRNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:13:38 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7453C20872;
        Thu, 11 Jul 2019 17:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562865217;
        bh=bvCqdNXA0lNVRHiKVn7GV3+2W08VEttCRx0QEFub0cs=;
        h=Date:From:To:Cc:Subject:From;
        b=0TqnHc8qfAgJztGG94YdRuN4xG2kZaS6sbf1z74YUdhdwMk2kV4Stu438wlgeKV8L
         oh3vC96kARmmtfPmwIhzbWFROiLU1zK2h36Bc/YzMJEobAdVQGMHqA8iWxDsHuoFlw
         sJBgH8E0onMZ8EOj+HQItpmYf2qEOsOwt7zk0lAw=
Date:   Thu, 11 Jul 2019 10:13:36 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs for 5.3
Message-ID: <20190711171336.GA66396@jaegeuk-macbookpro.roam.corp.google.com>
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

Thanks,

The following changes since commit e0654264c4806dc436b291294a0fbf9be7571ab6:

  Merge tag 'backlight-next-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight (2019-05-14 10:45:03 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.3

for you to fetch changes up to 2d008835ec2fcf6eef3285e41e62a5eabd1fe76b:

  f2fs: improve print log in f2fs_sanity_check_ckpt() (2019-07-10 18:44:47 -0700)

----------------------------------------------------------------
f2fs-for-5.3-rc1

In this round, we've introduced native swap file support which can exploit DIO,
enhanced existing checkpoint=disable feature with additional mount option to
tune the triggering condition, and allowed user to preallocate physical blocks
in a pinned file which will be useful to avoid f2fs fragmentation in append-only
workloads. In addition, we've fixed subtle quota corruption issue.

Enhancement:
 - add swap file support which uses DIO
 - allocate blocks for pinned file
 - allow SSR and mount option to enhance checkpoint=disable
 - enhance IPU IOs
 - add more sanity checks such as memory boundary access

Bug fix:
 - quota corruption in very corner case of error-injected SPO case
 - fix root_reserved on remount and some wrong counts
 - add missing fsck flag

Some patches were also introduced to clean up ambiguous i_flags and debugging
messages codes.

----------------------------------------------------------------
Chao Yu (10):
      f2fs: fix to check layout on last valid checkpoint park
      f2fs: add bio cache for IPU
      f2fs: fix to avoid deadloop if data_flush is on
      f2fs: fix to do sanity check on segment bitmap of LFS curseg
      f2fs: fix sparse warning
      f2fs: avoid get_valid_blocks() for cleanup
      f2fs: print kernel message if filesystem is inconsistent
      f2fs: use generic EFSBADCRC/EFSCORRUPTED
      f2fs: set SBI_NEED_FSCK for xattr corruption case
      f2fs: improve print log in f2fs_sanity_check_ckpt()

Daniel Rosenberg (4):
      f2fs: Lower threshold for disable_cp_again
      f2fs: Fix root reserved on remount
      f2fs: Fix accounting for unusable blocks
      f2fs: Add option to limit required GC for checkpoint=disable

Eric Biggers (1):
      f2fs: separate f2fs i_flags from fs_flags and ext4 i_flags

Geert Uytterhoeven (1):
      f2fs: Use DIV_ROUND_UP() instead of open-coding

Heng Xiao (1):
      f2fs: fix to avoid long latency during umount

Jaegeuk Kim (7):
      f2fs: link f2fs quota ops for sysfile
      f2fs: allow ssr block allocation during checkpoint=disable period
      f2fs: add missing sysfs entries in documentation
      f2fs: add a rw_sem to cover quota flag changes
      f2fs: allocate blocks for pinned file
      f2fs: support swap file w/ DIO
      f2fs: allow all the users to pin a file

Joe Perches (1):
      f2fs: introduce f2fs_<level> macros to wrap f2fs_printk()

Kimberly Brown (1):
      f2fs: replace ktype default_attrs with default_groups

Ocean Chen (1):
      f2fs: avoid out-of-range memory access

Park Ju Hyung (1):
      f2fs: always assume that the device is idle under gc_urgent

Qiuyang Sun (1):
      f2fs: ioctl for removing a range from F2FS

Sahitya Tummala (3):
      f2fs: add error prints for debugging mount failure
      f2fs: fix f2fs_show_options to show nodiscard mount option
      f2fs: fix is_idle() check for discard type

Wang Shilong (1):
      f2fs: only set project inherit bit for directory

 Documentation/ABI/testing/sysfs-fs-f2fs |   8 +
 Documentation/filesystems/f2fs.txt      | 133 ++++++-
 fs/f2fs/checkpoint.c                    | 107 +++---
 fs/f2fs/data.c                          | 249 +++++++++++--
 fs/f2fs/debug.c                         |   7 +
 fs/f2fs/dir.c                           |  16 +-
 fs/f2fs/extent_cache.c                  |   7 +-
 fs/f2fs/f2fs.h                          | 129 +++----
 fs/f2fs/file.c                          | 302 ++++++++++------
 fs/f2fs/gc.c                            | 196 +++++++++-
 fs/f2fs/inline.c                        |  16 +-
 fs/f2fs/inode.c                         |  78 ++--
 fs/f2fs/namei.c                         |  10 +-
 fs/f2fs/node.c                          |  38 +-
 fs/f2fs/recovery.c                      |  43 +--
 fs/f2fs/segment.c                       | 170 +++++++--
 fs/f2fs/segment.h                       |  16 +-
 fs/f2fs/super.c                         | 610 +++++++++++++++-----------------
 fs/f2fs/sysfs.c                         |  28 +-
 fs/f2fs/xattr.c                         |  10 +-
 include/trace/events/f2fs.h             |  11 +-
 21 files changed, 1409 insertions(+), 775 deletions(-)
