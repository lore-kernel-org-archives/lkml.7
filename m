Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D059C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8B220823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551736047;
	bh=fClwGSFA7kc/dFe1L6NHlmOv29M2164AcuAGeMFCXJ0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=tVJtCzwb5PVWAMHTV+7fB7JwV9TdnLOf1/+27+oKKRHKh96sr4/u+HawPqEz/FvQr
	 CNXkc+yxaJ2tA41CGJJLYW0os7yhJTiVV8gETvsFdcEWxsQxFWkicbAd0IXawP96Uy
	 l9tPu5YCbftyJj/8AopVYaGCgaW6Wsxva90V9mVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfCDVrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:47:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfCDVrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:47:25 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F697206B6;
        Mon,  4 Mar 2019 21:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551736043;
        bh=fClwGSFA7kc/dFe1L6NHlmOv29M2164AcuAGeMFCXJ0=;
        h=Date:From:To:Cc:Subject:From;
        b=TBJELGVeRtgNaRMnV3HL1juXdeHJsy5F6cMC0M3q2MDo0Dg0bDySzYmIj+r0wI921
         qUG+2WotRpCltmY0vXvP3rRco2xeuW+cj3TUTzijf++8vDtMgDu3Hlh2E3Nx4Uwqj9
         hz7ZE0WUmzpmPe7c+KC9TQu+XrR27Ss6xstRj2Tg=
Date:   Mon, 4 Mar 2019 13:47:22 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for v5.1
Message-ID: <20190304214721.GA215807@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to 129ca2d2a83f44551e73a408fa5e75a7b5169abb:

  MAINTAINERS: add Eric Biggers as an fscrypt maintainer (2019-02-20 15:33:28 -0800)

----------------------------------------------------------------
fscrypt updates for v5.1

First: Ted, Jaegeuk, and I have decided to add me as a co-maintainer for
fscrypt, and we're now using a shared git tree.  So we've updated
MAINTAINERS accordingly, and I'm doing the pull request this time.

The actual changes for v5.1 are:

- Remove the fs-specific kconfig options like CONFIG_EXT4_ENCRYPTION and
  make fscrypt support for all fscrypt-capable filesystems be controlled
  by CONFIG_FS_ENCRYPTION, similar to how CONFIG_QUOTA works.

- Improve error code for rename() and link() into encrypted directories.

- Various cleanups.

----------------------------------------------------------------
Chandan Rajendra (3):
      ext4: use IS_ENCRYPTED() to check encryption status
      f2fs: use IS_ENCRYPTED() to check encryption status
      fscrypt: remove filesystem specific build config option

Eric Biggers (2):
      fscrypt: remove CRYPTO_CTR dependency
      fscrypt: return -EXDEV for incompatible rename or link into encrypted dir

Theodore Ts'o (1):
      MAINTAINERS: add Eric Biggers as an fscrypt maintainer

 Documentation/filesystems/fscrypt.rst   |  16 +-
 MAINTAINERS                             |   3 +-
 arch/mips/configs/generic_defconfig     |   2 +-
 arch/nds32/configs/defconfig            |   2 +-
 arch/s390/configs/debug_defconfig       |   2 +-
 arch/s390/configs/performance_defconfig |   2 +-
 fs/crypto/Kconfig                       |   6 +-
 fs/crypto/fscrypt_private.h             |   1 -
 fs/crypto/hooks.c                       |   6 +-
 fs/crypto/policy.c                      |   3 +-
 fs/ext4/Kconfig                         |  15 --
 fs/ext4/dir.c                           |  10 +-
 fs/ext4/ext4.h                          |  12 +-
 fs/ext4/ext4_jbd2.h                     |   2 +-
 fs/ext4/extents.c                       |   4 +-
 fs/ext4/ialloc.c                        |   2 +-
 fs/ext4/inode.c                         |  24 +-
 fs/ext4/ioctl.c                         |   4 +-
 fs/ext4/move_extent.c                   |   3 +-
 fs/ext4/namei.c                         |  18 +-
 fs/ext4/page-io.c                       |   9 +-
 fs/ext4/readpage.c                      |   5 +-
 fs/ext4/super.c                         |   6 +-
 fs/ext4/sysfs.c                         |   4 +-
 fs/f2fs/Kconfig                         |  12 +-
 fs/f2fs/data.c                          |   4 +-
 fs/f2fs/dir.c                           |  10 +-
 fs/f2fs/f2fs.h                          |  14 +-
 fs/f2fs/file.c                          |  10 +-
 fs/f2fs/inode.c                         |   4 +-
 fs/f2fs/namei.c                         |   6 +-
 fs/f2fs/super.c                         |   8 +-
 fs/f2fs/sysfs.c                         |   4 +-
 fs/ubifs/Kconfig                        |  12 +-
 fs/ubifs/Makefile                       |   2 +-
 fs/ubifs/ioctl.c                        |   4 +-
 fs/ubifs/sb.c                           |   2 +-
 fs/ubifs/super.c                        |   2 +-
 fs/ubifs/ubifs.h                        |   5 +-
 include/linux/fs.h                      |   4 +-
 include/linux/fscrypt.h                 | 420 +++++++++++++++++++++++++++++++-
 include/linux/fscrypt_notsupp.h         | 231 ------------------
 include/linux/fscrypt_supp.h            | 204 ----------------
 43 files changed, 518 insertions(+), 601 deletions(-)
 delete mode 100644 include/linux/fscrypt_notsupp.h
 delete mode 100644 include/linux/fscrypt_supp.h
