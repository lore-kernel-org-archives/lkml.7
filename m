Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E9EC432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 20:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E1920833
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 20:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfLAUSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 15:18:51 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:51630 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfLAUSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 15:18:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2D70C6075EB6;
        Sun,  1 Dec 2019 21:18:48 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1qL7f3SkNBTT; Sun,  1 Dec 2019 21:18:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A40D56126B4E;
        Sun,  1 Dec 2019 21:18:47 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CChYr051KwzE; Sun,  1 Dec 2019 21:18:47 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7CBB56075EB6;
        Sun,  1 Dec 2019 21:18:47 +0100 (CET)
Date:   Sun, 1 Dec 2019 21:18:47 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <1044415561.103245.1575231527451.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBI/UBIFS/JFFS2 changes for v5.5-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Index: p5Yb5RXGCOXDDkhbu+z8eXKDdqTkQw==
Thread-Topic: UBI/UBIFS/JFFS2 changes for v5.5-rc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit ec5385196779fb927e7d8d5bf31bef14d7ce98ed:

  Merge tag 'iommu-fixes-v5.4-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu (2019-11-17 11:27:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/upstream-5.5-rc1

for you to fetch changes up to 6e78c01fde9023e0701f3af880c1fd9de6e4e8e3:

  Revert "jffs2: Fix possible null-pointer dereferences in jffs2_add_frag_to_fragtree()" (2019-11-29 11:29:58 +0100)

----------------------------------------------------------------
This pull request contains mostly fixes for UBI, UBIFS and JFFS2:

UBI:
- Fix a regression around producing a anchor PEB for fastmap.
  Due to a change in our locking fastmap was unable to produce
  fresh anchors an re-used the existing one a way to often.

UBIFS:
- Fixes for endianness. A few places blindly assumed little endian.
- Fix for a memory leak in the orphan code.
- Fix for a possible crash during a commit.
- Revert a wrong bugfix.

JFFS2:
- Revert a bad bugfix in (false positive from a code checking
  tool).

----------------------------------------------------------------
Ben Dooks (Codethink) (3):
      ubifs: Force prandom result to __le32
      ubifs: Fixed missed le64_to_cpu() in journal
      ubifs: Fix type of sup->hash_algo

Joel Stanley (1):
      Revert "jffs2: Fix possible null-pointer dereferences in jffs2_add_frag_to_fragtree()"

Richard Weinberger (2):
      ubifs: Remove obsolete TODO from dfs_file_write()
      Revert "ubifs: Fix memory leak bug in alloc_ubifs_info() error path"

Rishi Gupta (1):
      ubi: Fix warning static is not at beginning of declaration

Sascha Hauer (1):
      ubi: Fix producing anchor PEBs

Stefan Roese (1):
      ubi: Print skip_check in ubi_dump_vol_info()

Zhihao Cheng (2):
      ubifs: do_kill_orphans: Fix a memory leak bug
      ubifs: ubifs_tnc_start_commit: Fix OOB in layout_in_gaps

 drivers/mtd/ubi/debug.c      |  1 +
 drivers/mtd/ubi/fastmap-wl.c | 31 ++++++++++++++++++-------------
 drivers/mtd/ubi/fastmap.c    | 14 +++++---------
 drivers/mtd/ubi/ubi.h        |  8 +++++---
 drivers/mtd/ubi/wl.c         | 32 ++++++++++++++------------------
 drivers/mtd/ubi/wl.h         |  1 -
 fs/jffs2/nodelist.c          |  2 +-
 fs/ubifs/debug.c             | 12 ------------
 fs/ubifs/journal.c           |  4 ++--
 fs/ubifs/orphan.c            | 17 ++++++++++-------
 fs/ubifs/sb.c                |  2 +-
 fs/ubifs/super.c             |  4 +---
 fs/ubifs/tnc_commit.c        | 34 +++++++++++++++++++++++++++-------
 13 files changed, 85 insertions(+), 77 deletions(-)
