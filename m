Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CAEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F85214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfLLSOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:14:36 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:56748 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730080AbfLLSOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:14:35 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id D73D9200A85;
        Thu, 12 Dec 2019 18:14:33 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id D092420AFD; Thu, 12 Dec 2019 19:14:26 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] remove ksys_mount() and ksys_dup()
Date:   Thu, 12 Dec 2019 19:14:17 +0100
Message-Id: <20191212181422.31033-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ae4b064e2a616b545acf02b8f50cc513b32c7522:

  Merge tag 'afs-fixes-20191211' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs (2019-12-11 18:10:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git remove-ksys-mount-dup

for you to fetch changes up to 8243186f0cc7c57cf9d6a110cd7315c44e3e0be8:

  fs: remove ksys_dup() (2019-12-12 19:00:36 +0100)

This small series replaces all in-kernel calls to the
userspace-focused ksys_mount() and ksys_dup() with calls
to kernel-centric functions:

For each replacement of ksys_mount() with do_mount(),
one needs to verify that the first and third parameter
(char *dev_name, char *type) are strings allocated in
kernelspace and that the fifth parameter (void *data)
is either NULL or refers to a full page (only occurence
in init/do_mounts.c::do_mount_root()). The second and
fourth parameters (char *dir_name, unsigned long flags)
are passed by ksys_mount() to do_mount() unchanged, and
therefore do not require particular care.

Moreover, instead of pretending to be userspace, the opening
of /dev/console as stdin/stdout/stderr can be implemented
using in-kernel functions as well. Thereby, ksys_dup() can
be removed for good.

---

Changes since the split-series patches[1,2]:
- merge both series (on suggestion by Linus)
- remove pointless cast (on suggestion by Linus)

[1] https://lore.kernel.org/lkml/20191212135724.331342-1-linux@dominikbrodowski.net/
[2] https://lore.kernel.org/lkml/20191212140752.347520-1-linux@dominikbrodowski.net/


Thanks,
	Dominik


----------------------------------------------------------------
Dominik Brodowski (5):
      devtmpfs: use do_mount() instead of ksys_mount()
      initrd: use do_mount() instead of ksys_mount()
      init: use do_mount() instead of ksys_mount()
      init: unify opening /dev/console as stdin/stdout/stderr
      fs: remove ksys_dup()

 drivers/base/devtmpfs.c  |  6 +++---
 fs/file.c                |  7 +------
 fs/namespace.c           | 10 ++--------
 include/linux/device.h   |  4 ++--
 include/linux/initrd.h   |  2 ++
 include/linux/syscalls.h |  3 ---
 init/do_mounts.c         | 30 +++++++++++++++++++++++-------
 init/do_mounts_initrd.c  | 11 ++++-------
 init/main.c              | 31 ++++++++++++++++++++++++++-----
 9 files changed, 63 insertions(+), 41 deletions(-)

-- 
2.24.1
