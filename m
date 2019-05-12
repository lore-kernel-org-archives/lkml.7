Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5217CC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 21:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2977F2089E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 21:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfELVm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 17:42:29 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:59480 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfELVm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 17:42:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9EDAB6083105;
        Sun, 12 May 2019 23:42:26 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id D2MeRBObez8u; Sun, 12 May 2019 23:42:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 499036083106;
        Sun, 12 May 2019 23:42:26 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wrwgI9aogwER; Sun, 12 May 2019 23:42:26 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2A0B06083105;
        Sun, 12 May 2019 23:42:26 +0200 (CEST)
Date:   Sun, 12 May 2019 23:42:26 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2058307720.56057.1557697346125.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBI/UBIFS changes for v5.2-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Index: q2S9vZko+Wx+u2XNEMK1d3JpTp5ORg==
Thread-Topic: UBI/UBIFS changes for v5.2-rc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 37624b58542fb9f2d9a70e6ea006ef8a5f66c30b:

  Linux 5.1-rc7 (2019-04-28 17:04:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/upstream-5.2-rc1

for you to fetch changes up to 04d37e5a8b1fad2d625727af3d738c6fd9491720:

  ubi: wl: Fix uninitialized variable (2019-05-07 21:58:33 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UBI/UBIFS

- fscrypt framework usage updates
- One huge fix for xattr unlink
- Cleanup of fscrypt ifdefs
- Fix for our new UBIFS auth feature

----------------------------------------------------------------
Andrey Abramov (1):
      ubifs: find.c: replace swap function with built-in one

Arnd Bergmann (1):
      ubifs: work around high stack usage with clang

Eric Biggers (2):
      ubifs: remove unnecessary calls to set up directory key
      ubifs: remove unnecessary #ifdef around fscrypt_ioctl_get_policy()

Gustavo A. R. Silva (1):
      ubi: wl: Fix uninitialized variable

Richard Weinberger (3):
      ubifs: journal: Handle xattrs like files
      ubifs: orphan: Handle xattrs like files
      ubifs: Limit number of xattrs per inode

Sascha Hauer (4):
      ubifs: Do not skip hash checking in data nodes
      ubifs: Remove #ifdef around CONFIG_FS_ENCRYPTION
      ubifs: Remove ifdefs around CONFIG_UBIFS_ATIME_SUPPORT
      ubifs: Drop unnecessary setting of zbr->znode

YueHaibing (1):
      ubifs: remove unused function __ubifs_shash_final

 drivers/mtd/ubi/wl.c    |   2 +-
 fs/ubifs/auth.c         |  35 +++-----
 fs/ubifs/debug.c        |   1 -
 fs/ubifs/dir.c          |  29 ++++---
 fs/ubifs/file.c         |  16 ++--
 fs/ubifs/find.c         |   9 +--
 fs/ubifs/ioctl.c        |  11 +--
 fs/ubifs/journal.c      |  72 ++++++++++++++---
 fs/ubifs/misc.h         |   8 ++
 fs/ubifs/orphan.c       | 208 ++++++++++++++++++++++++++++++++----------------
 fs/ubifs/sb.c           |   7 +-
 fs/ubifs/super.c        |  22 ++---
 fs/ubifs/tnc.c          |  15 ++--
 fs/ubifs/ubifs.h        |   6 +-
 fs/ubifs/xattr.c        |  71 +++++++++++++++--
 include/linux/fscrypt.h |  11 +++
 16 files changed, 345 insertions(+), 178 deletions(-)
