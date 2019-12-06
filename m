Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32CCC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 00:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900432075C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 00:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfLFA64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 19:58:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52234 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfLFA64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 19:58:56 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1id1xN-0001DM-Ah; Fri, 06 Dec 2019 00:58:53 +0000
Date:   Fri, 6 Dec 2019 00:58:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ian Kent <raven@themaw.net>
Subject: [git pull] vfs.git autofs-related stuff
Message-ID: <20191206005853.GK4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	autofs misuses checks for ->d_subdirs emptiness; the cursors are
in the same lists, resulting in false negatives.  It's not needed anyway,
since autofs maintains counter in struct autofs_info, containing 0 for
removed ones, 1 for live symlinks and 1 + number of children for live
directories, which is precisely what we need for those checks.  This
series switches to use of that counter and untangles the crap around
its uses (it needs not be atomic and there's a bunch of completely pointless
"defensive" checks).

	This fell out of dcache_readdir work; the main point is to get
rid of ->d_subdirs abuses in there.  I've more followup cleanups, but
I hadn't run those by Ian yet, so they can go next cycle.

The following changes since commit 5f68056ca50fdd3954a93ae66fea7452abddb66f:

  autofs_lookup(): hold ->d_lock over playing with ->d_flags (2019-07-27 10:03:14 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git next.autofs

for you to fetch changes up to 850d71acd52cd331474116fbd60cf8b3f3ded93e:

  autofs: don't bother with atomics for ino->count (2019-09-17 23:31:27 -0400)

----------------------------------------------------------------
Al Viro (4):
      autofs_clear_leaf_automount_flags(): use ino->count instead of ->d_subdirs
      autofs: get rid of pointless checks around ->count handling
      autofs_dir_rmdir(): check ino->count for deciding whether it's empty...
      autofs: don't bother with atomics for ino->count

 fs/autofs/autofs_i.h |  2 +-
 fs/autofs/expire.c   |  6 +++---
 fs/autofs/root.c     | 39 ++++++++++++++-------------------------
 3 files changed, 18 insertions(+), 29 deletions(-)
