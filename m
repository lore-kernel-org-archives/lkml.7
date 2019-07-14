Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021B5C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 19:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2E920C01
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 19:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfGNTCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 15:02:03 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:33058 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbfGNTCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 15:02:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2AA0D6058369;
        Sun, 14 Jul 2019 21:02:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cFwaXX4j7aim; Sun, 14 Jul 2019 21:02:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D01A5608311E;
        Sun, 14 Jul 2019 21:02:00 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fMomH4AhTAp7; Sun, 14 Jul 2019 21:02:00 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id AF16C6083266;
        Sun, 14 Jul 2019 21:02:00 +0200 (CEST)
Date:   Sun, 14 Jul 2019 21:02:00 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <1979519421.38685.1563130920671.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for 5.3-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Index: 7lfOxEzdE9qGSepyNCpNJsgfjzn/vg==
Thread-Topic: UML changes for 5.3-rc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:

  Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.3-rc1

for you to fetch changes up to b482e48d29f1461fd0d059a17f32bcfa274127b3:

  um: fix build without CONFIG_UML_TIME_TRAVEL_SUPPORT (2019-07-04 09:52:18 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- A new timer mode, time travel, for testing with UML
- Many bugfixes/improvements for the serial line driver
- Various bugfixes

----------------------------------------------------------------
Johannes Berg (9):
      um: fix os_timer_one_shot()
      um: Timer code cleanup
      um: Remove locking in deactivate_all_fds()
      um: Silence lockdep complaint about mmap_sem
      um: Don't garbage collect in deactivate_all_fds()
      um: Remove drivers/ssl.h
      um: Pass nsecs to os timer functions
      um: Support time travel mode
      um: fix build without CONFIG_UML_TIME_TRAVEL_SUPPORT

Jouni Malinen (1):
      um: Fix IRQ controller regression on console read

Krzysztof Kozlowski (1):
      um: configs: Remove useless UEVENT_HELPER_PATH

Marek Majkowski (1):
      um: Fix kcov crash during startup

 arch/um/Kconfig                         |  12 +++
 arch/um/configs/i386_defconfig          |   1 -
 arch/um/configs/x86_64_defconfig        |   1 -
 arch/um/drivers/chan_kern.c             |  52 +++++++++++--
 arch/um/drivers/ssl.c                   |   1 -
 arch/um/drivers/ssl.h                   |  13 ----
 arch/um/include/asm/mmu_context.h       |   2 +-
 arch/um/include/shared/os.h             |  10 +--
 arch/um/include/shared/timer-internal.h |  48 ++++++++++++
 arch/um/kernel/irq.c                    |   9 ++-
 arch/um/kernel/process.c                |  42 +++++++++-
 arch/um/kernel/skas/Makefile            |   2 +
 arch/um/kernel/skas/syscall.c           |  11 +++
 arch/um/kernel/time.c                   | 131 ++++++++++++++++++++++++++++++--
 arch/um/os-Linux/time.c                 | 127 +++++++------------------------
 15 files changed, 320 insertions(+), 142 deletions(-)
 delete mode 100644 arch/um/drivers/ssl.h
