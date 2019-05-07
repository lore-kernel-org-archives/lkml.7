Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16782C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 00:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C4020856
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 00:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfEGA6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 20:58:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38228 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfEGA6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 20:58:44 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hNoRO-000209-WB; Tue, 07 May 2019 00:58:43 +0000
Date:   Tue, 7 May 2019 01:58:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git pile 2: several fixes to backport
Message-ID: <20190507005842.GG23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	acct_on() fix for deadlock caught be overlayfs folks,
autofs RCU use-after-free SNAFU (->d_manage() can be called
lockless, so we need to RCU-delay freeing the objects it
looks at) and (hopefully) the end of "do we need freeing this
dentry RCU-delayed" whack-a-mole.

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git stable-fodder

for you to fetch changes up to ce285c267a003acbf607f3540ff71287f82e5282:

  autofs: fix use-after-free in lockless ->d_manage() (2019-04-09 19:18:19 -0400)

----------------------------------------------------------------
Al Viro (3):
      acct_on(): don't mess with freeze protection
      dcache: sort the freeing-without-RCU-delay mess for good.
      autofs: fix use-after-free in lockless ->d_manage()

 Documentation/filesystems/porting |  5 +++++
 fs/autofs/autofs_i.h              |  1 +
 fs/autofs/inode.c                 |  2 +-
 fs/dcache.c                       | 24 +++++++++++++-----------
 fs/internal.h                     |  2 --
 fs/nsfs.c                         |  3 +--
 include/linux/dcache.h            |  2 +-
 include/linux/mount.h             |  2 ++
 kernel/acct.c                     |  4 ++--
 9 files changed, 26 insertions(+), 19 deletions(-)
