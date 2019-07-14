Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DF3C742D2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 19:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF978214AE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 19:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfGNTCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 15:02:12 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:33094 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbfGNTCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 15:02:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3545A6074CD5;
        Sun, 14 Jul 2019 21:02:10 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0CY1gMs9aDPi; Sun, 14 Jul 2019 21:02:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E126A6074CF8;
        Sun, 14 Jul 2019 21:02:09 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4uf6qr9J4IfK; Sun, 14 Jul 2019 21:02:09 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id BE16E6074CD5;
        Sun, 14 Jul 2019 21:02:09 +0200 (CEST)
Date:   Sun, 14 Jul 2019 21:02:09 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <1267151613.38686.1563130929727.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBIFS changes for 5.3-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Index: lukcal4QcUCgWCO+vvtjPRX4XXI9kw==
Thread-Topic: UBIFS changes for 5.3-rc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 6fbc7275c7a9ba97877050335f290341a1fd8dbf:

  Linux 5.2-rc7 (2019-06-30 11:25:36 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/upstream-5.3-rc1

for you to fetch changes up to 8009ce956c3d28022af6b122e50213ad830fc902:

  ubifs: Don't leak orphans on memory during commit (2019-07-08 20:01:34 +0200)

Please note there is a merge conflict between commits
334d581528b9 ("vfs: Convert ubifs to use the new mount API") and
eeabb9866e4c ("ubifs: Add support for zstd compression.")

For zstd we add a new mount parameter.
In case of doubt I'll happily review your merge resolution.

----------------------------------------------------------------
This pull request contains the following changes for UBIFS

- Support for zstd compression
- Support for offline signed filesystems
- Various fixes for regressions

----------------------------------------------------------------
Liu Song (3):
      ubifs: Simplify redundant code
      ubifs: Fix typo of output in get_cs_sqnum
      ubifs: remove unnecessary check in ubifs_log_start_commit

Michele Dionisio (1):
      ubifs: Add support for zstd compression.

Richard Weinberger (3):
      ubifs: Correctly use tnc_next() in search_dh_cookie()
      ubifs: Check link count of inodes when killing orphans.
      ubifs: Don't leak orphans on memory during commit

Sascha Hauer (1):
      ubifs: support offline signed images

 fs/ubifs/Kconfig       | 13 ++++++-
 fs/ubifs/auth.c        | 86 +++++++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/compress.c    | 27 ++++++++++++++-
 fs/ubifs/log.c         |  5 +--
 fs/ubifs/master.c      | 53 ++++++++++++++++++++++++----
 fs/ubifs/orphan.c      | 94 +++++++++++++++++++++++++++++++-------------------
 fs/ubifs/recovery.c    |  2 +-
 fs/ubifs/sb.c          | 52 ++++++++++++++--------------
 fs/ubifs/super.c       | 46 ++++++++++++++++++------
 fs/ubifs/tnc.c         | 16 ++++++---
 fs/ubifs/ubifs-media.h | 30 +++++++++++++++-
 fs/ubifs/ubifs.h       |  6 ++--
 12 files changed, 338 insertions(+), 92 deletions(-)
