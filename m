Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1284DC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EBB20675
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd3UCrpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfEHUCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:02:38 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:37998 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfEHUCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:02:38 -0400
Received: by mail-it1-f173.google.com with SMTP id q19so6003560itk.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 13:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=NX1dhmAYw30JeP7gm7UfQTk75TfutWH9BZfCbRAaVks=;
        b=dd3UCrpxoIJgvYKNH642z/OFG2Z9mx9sdXDY2HN6ohQS1e8J1aSaiUvqCxCscn/d54
         3p2wKXXUvANJAU6Pmn51j5JgGQeoVTqcpAaLlvR5WgaLj++Ni/SzN5LcWiATgMagY5L1
         86HiKI1Og7CQFfqDTAxhiqcDY34yUXC7R6LPs1Bryb58DcEktWRXY92s1bsWkwR+hfZ+
         ZpfpYVSo29m9KKN/C0moExlmg2RYxwXdeIMMBBFFC1Z0Ij/fyr1JPULjlZI+C5auZE3h
         ubcKrDZajN9se5HTxfLmopjZIWbWymbpnPjJSHEp646ZkzZ9kAViTm/J1zTWYVZd4nIm
         DYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=NX1dhmAYw30JeP7gm7UfQTk75TfutWH9BZfCbRAaVks=;
        b=HD1MFLmtDVULncUyS6Jd1tR/6ZPgIn79ynJgaa4bKZ6Kc4nF9cyDR1+5j4pPRiIKSN
         cs0MFb+YVOMRbFc0CdgKYVl13JVlhuT/gEQH1TuyoVFX9+xR3n9M1tefvekHnNRz7ToW
         0R4a8m4StDmZ0tw/rRJ738D57w7Gso+2ltnt1U18xYK1VqrAqIObZKB0J1B+w0PHF31G
         q/bh7CUi/wmhs3jw72OetGPWuIZzOlxR59/04BLk2VnWr+3DICxjn/4ezTzMuDOCrFof
         KqXEa79Pam86yTIrKHjRGW6U3CXPfPSrcZERZm3ebe3CZS5mJgq8WYCYtX9RNVs7qhdq
         iWWw==
X-Gm-Message-State: APjAAAVXdxAMXoJGLHtpSUuAANSPb4OGsTlfZffpgUMVRxZ+QZPI4l+t
        5EmImYeivrQjioTzJNFjgEzM/B+5bYXx+CfGjwQ=
X-Google-Smtp-Source: APXvYqxzeos0igmyj3/52y+62Y7QjVSyBc5Ju0CKx7tiwlhAPYGINm+HW4BRekg3OVqT8qLrIqXxu886Z3hIF2T8vHE=
X-Received: by 2002:a24:4ace:: with SMTP id k197mr5252888itb.46.1557345757167;
 Wed, 08 May 2019 13:02:37 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 8 May 2019 22:02:26 +0200
Message-ID: <CAHpGcMKxSTuA9vcPXqBCxo2w7aisPM=ZvZ=Yqgcoq+j1MbqBDQ@mail.gmail.com>
Subject: GFS2: Pull Request (2nd attempt)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following changes for the GFS2 file
system, now without resolving the merge conflict Stephen Rothwell has
pointed out between commit

  2b070cfe582b ("block: remove the i argument to bio_for_each_segment_all")

which is already merged, interacting with commit

  e21e191994af ("gfs2: read journal in large chunks")

which is part of this pull request. Stephen's suggested resolution of
the conflict can be found at
https://lore.kernel.org/lkml/20190506150707.618f013d@canb.auug.org.au/.

Thanks,
Andreas

The following changes since commit b4b52b881cf08e13d110eac811d4becc0775abbf:

  Merge tag 'Wimplicit-fallthrough-5.2-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux
(2019-05-07 12:48:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
tags/gfs2-for-5.2

for you to fetch changes up to f4686c26ecc34e8e458b8235f0af5198c9b13bfd:

  gfs2: read journal in large chunks (2019-05-07 23:39:15 +0200)

----------------------------------------------------------------
We've got the following patches ready for this merge window:

"gfs2: Fix loop in gfs2_rbm_find (v2)"

  A rework of a fix we ended up reverting in 5.0 because of an iozone
  performance regression.

"gfs2: read journal in large chunks" and
"gfs2: fix race between gfs2_freeze_func and unmount"

  An improved version of a commit we also ended up reverting in 5.0
  because of a regression in xfstest generic/311.  It turns out that the
  journal changes were mostly innocent and that unfreeze didn't wait for
  the freeze to complete, which caused the filesystem to be unmounted
  before it was actually idle.

"gfs2: Fix occasional glock use-after-free"
"gfs2: Fix iomap write page reclaim deadlock"
"gfs2: Fix lru_count going negative"

  Fixes for various problems reported and partially fixed by Citrix
  engineers.  Thank you very much.

"gfs2: clean_journal improperly set sd_log_flush_head"

  Another fix from Bob.

A few other minor cleanups.

----------------------------------------------------------------
Abhi Das (2):
      gfs2: fix race between gfs2_freeze_func and unmount
      gfs2: read journal in large chunks

Andreas Gruenbacher (7):
      gfs2: Fix loop in gfs2_rbm_find (v2)
      gfs2: Fix occasional glock use-after-free
      gfs2: Remove misleading comments in gfs2_evict_inode
      gfs2: Remove unnecessary extern declarations
      gfs2: Rename sd_log_le_{revoke,ordered}
      gfs2: Rename gfs2_trans_{add_unrevoke => remove_revoke}
      gfs2: Fix iomap write page reclaim deadlock

Bob Peterson (2):
      gfs2: clean_journal improperly set sd_log_flush_head
      gfs2: Replace gl_revokes with a GLF flag

Ross Lagerwall (1):
      gfs2: Fix lru_count going negative

 fs/gfs2/aops.c       |  14 ++-
 fs/gfs2/bmap.c       | 118 ++++++++++++++---------
 fs/gfs2/bmap.h       |   1 +
 fs/gfs2/dir.c        |   2 +-
 fs/gfs2/glock.c      |  25 +++--
 fs/gfs2/glops.c      |   3 +-
 fs/gfs2/incore.h     |   9 +-
 fs/gfs2/log.c        |  47 ++++++----
 fs/gfs2/log.h        |   5 +-
 fs/gfs2/lops.c       | 261 ++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/gfs2/lops.h       |  11 +--
 fs/gfs2/main.c       |   1 -
 fs/gfs2/ops_fstype.c |   7 +-
 fs/gfs2/recovery.c   | 135 ++------------------------
 fs/gfs2/recovery.h   |   4 +-
 fs/gfs2/rgrp.c       |  56 +++++------
 fs/gfs2/super.c      |  20 ++--
 fs/gfs2/trans.c      |   4 +-
 fs/gfs2/trans.h      |   2 +-
 fs/gfs2/xattr.c      |   6 +-
 20 files changed, 438 insertions(+), 293 deletions(-)
