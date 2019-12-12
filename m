Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DAAC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C636A21655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfLLN7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:59:15 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:42634 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbfLLN7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:59:12 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 4003C200A95;
        Thu, 12 Dec 2019 13:59:11 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id C717120AFE; Thu, 12 Dec 2019 14:57:31 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] use do_mount() instead of ksys_mount()
Date:   Thu, 12 Dec 2019 14:57:21 +0100
Message-Id: <20191212135724.331342-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series replaces all in-kernel calls to the
userspace-focused wrapper ksys_mount() with calls to
the kernel-centric do_mount().

For each replacement, one needs to verify that the first and
third parameter (char *dev_name, char *type) are strings
allocated in kernelspace and that the fifth parameter
(void *data) is either NULL or refers to a full page (only
occurence in init/do_mounts.c::do_mount_root()). The second
and fourth parameters (char *dir_name, unsigned long flags)
are passed by ksys_mount() to do_mount() unchanged, and
therefore do not require particular care.

---

@viro: is this something for you to take and push upstream
for the next cycle?


The same changes (on top of commit ae4b064e2a616b545acf02b8f50cc513b32c7522:

  Merge tag 'afs-fixes-20191211' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs (2019-12-11 18:10:40 -0800)

are also available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git remove-ksys-mount

including all changes up to cccaa5e33525fc07f4a2ce0518e50b9ddf435e47:

  init: use do_mount() instead of ksys_mount() (2019-12-12 14:50:05 +0100)

----------------------------------------------------------------
Dominik Brodowski (3):
      devtmpfs: use do_mount() instead of ksys_mount()
      initrd: use do_mount() instead of ksys_mount()
      init: use do_mount() instead of ksys_mount()

 drivers/base/devtmpfs.c  |  6 +++---
 fs/namespace.c           | 10 ++--------
 include/linux/device.h   |  4 ++--
 include/linux/syscalls.h |  2 --
 init/do_mounts.c         | 30 +++++++++++++++++++++++-------
 init/do_mounts_initrd.c  |  6 +++---
 6 files changed, 33 insertions(+), 25 deletions(-)

Thanks,
	Dominik

-- 
2.24.1

