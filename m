Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9077BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EF62064A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553888371;
	bh=etBGuV6PwBK1HAFdXgMmSlo/sAX8N1C9CSNbEslUngs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=MBUQxzSKsyY/uMJZ7nEn0PwMx2GYaFNwDfglfT/6kAarXTgicR1Oy0qhLSO0sT42R
	 x5I3+Ou7iNckGOykGxM4Gez2mmNET3UPeY1x1w/egwu+MlNQpjbdJieWgg5N/FY36N
	 NMRb5o9ZnTrSGALOup8tEH7B00Gr3/ZDHc4XS664=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfC2Tja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729652AbfC2Tj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:39:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE3032064A;
        Fri, 29 Mar 2019 19:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553888368;
        bh=etBGuV6PwBK1HAFdXgMmSlo/sAX8N1C9CSNbEslUngs=;
        h=Date:From:To:Cc:Subject:From;
        b=oOzq51Ek/l2f1VVGxN/dSgcXl/quHtmU9FS+fHWR8wXWhE7SHbfdlU1cTTYCgMXnu
         QvCUAEbN8kR/ZGAmexwg5Y32vH3QXgVBMligIV5laWLX47DD02oNMvi65qfsaIf9N8
         snt9mfh0vlnObpPz8e7FOWs9LEEcNyrCgx3fAkqY=
Date:   Fri, 29 Mar 2019 20:39:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.1-rc3
Message-ID: <20190329193926.GA11564@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.1-rc3

for you to fetch changes up to 0532a1b0d045115521a93acf28f1270df89ad806:

  virt: vbox: Implement passing requestor info to the host for VirtualBox 6.0.x (2019-03-28 01:55:18 +0900)

----------------------------------------------------------------
Char/Misc driver fixes for 5.1-rc3

Here are some binder, habanalabs, and vboxguest driver fixes for
5.1-rc3.

The Binder fixes resolve some reported issues found by testing, first by
the selinux developers, and then earlier today by syzbot.

The habanalabs fixes are all minor, resolving a number of tiny things.

The vboxguest patches are a bit larger.  They resolve the fact that
virtual box decided to change their api in their latest release in a way
that broke the existing kernel code, despite saying that they were never
going to do that.  So this is a bit of a "new feature", but is good to
get merged so that 5.1 will work with the latest release.  The changes
are not large and of course virtual box "swears" they will not break
this again, but no one is holding their breath here.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Merge tag 'misc-habanalabs-fixes-2019-03-26' of git://people.freedesktop.org/~gabbayo/linux into char-misc-next:

Hans de Goede (1):
      virt: vbox: Implement passing requestor info to the host for VirtualBox 6.0.x

Oded Gabbay (3):
      habanalabs: perform accounting for active CS
      habanalabs: prevent host crash during suspend/resume
      habanalabs: cast to expected type

Omer Shpigelman (4):
      habanalabs: fix MMU number of pages calculation
      habanalabs: fix bug when mapping very large memory area
      habanalabs: complete user context cleanup before hard reset
      habanalabs: fix mapping with page size bigger than 4KB

Todd Kjos (2):
      binder: fix BUG_ON found by selinux-testsuite
      binder: fix race between munmap() and direct reclaim

 drivers/android/binder.c                     |   3 +-
 drivers/android/binder_alloc.c               |  18 ++---
 drivers/misc/habanalabs/command_submission.c |   6 ++
 drivers/misc/habanalabs/debugfs.c            |   7 +-
 drivers/misc/habanalabs/device.c             |  71 ++++++++++++++++--
 drivers/misc/habanalabs/goya/goya.c          |  65 +---------------
 drivers/misc/habanalabs/habanalabs.h         |  21 +++---
 drivers/misc/habanalabs/hw_queue.c           |   5 +-
 drivers/misc/habanalabs/memory.c             |  38 +++++-----
 drivers/misc/habanalabs/mmu.c                |   6 +-
 drivers/virt/vboxguest/vboxguest_core.c      | 106 ++++++++++++++++++---------
 drivers/virt/vboxguest/vboxguest_core.h      |  15 ++--
 drivers/virt/vboxguest/vboxguest_linux.c     |  26 ++++++-
 drivers/virt/vboxguest/vboxguest_utils.c     |  32 ++++----
 drivers/virt/vboxguest/vboxguest_version.h   |   9 +--
 drivers/virt/vboxguest/vmmdev.h              |   8 +-
 include/linux/vbox_utils.h                   |  12 +--
 include/uapi/linux/vbox_vmmdev_types.h       |  60 +++++++++++++++
 18 files changed, 324 insertions(+), 184 deletions(-)
