Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0666DC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFA420861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="OTVren8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbfGHNyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:54:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38771 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfGHNyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:54:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so7085271wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsZRyZk2ydCDsozTRtauLBSuYylLgt58f0TX4440DqM=;
        b=OTVren8YrptMgJAPkssI2YoV2QTaG2D2txhuXhJBaWQ951JTfWF9sBrACWVtic8F47
         TSR2lw8pcABg4EIGAeuHbd5SX9PDtc+LgaCWERTmkm0MUW3jtx9VJjEI8UVrzjyJLX+3
         ph3nY943gXPobcTuKFJr4bllEdYS1WsY63BI09Qri0phrq4cJxoE2zk/HiqCo7y8W+i+
         EJv+mv9rQC6VG/X/Cl3PDT3ESaE5VrGRyB7WhM1J64gt3oHbfUb9bOLSTY1Jzc68PvZ3
         rhyUzlRAQMdmJBWN8W1thadxQvyRjTT6+RR8UUioQIDvcSSoWaqzg3WHYViyduEmU8kX
         hlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsZRyZk2ydCDsozTRtauLBSuYylLgt58f0TX4440DqM=;
        b=tmgOm0uRmGSEhLc3t/n1PGqnPLWRHoUOLm5FKco+p3L6tyVj1JCv31L1WvpufzqO/N
         be6tFndgwKqxqCUoFtRYUGr4pIe1srE/bu/2KFgJzV9dMW59BKDs0xIDa9ckaq/3z8LL
         XTkfPUINrBzZqBTuWPGYQRIj89px+blvRsg8jBLwldMsswwla5qYG2V49HqONz4+pO2t
         0TgUNyH10EvLmX6Buxlev4DxTcUSvCvJ6fP656+tZBrJhs93xs7TWVmM7+aZJ+BRti0A
         C44XwqTm7S76XSxsu9ilcHG8VsbV0BhWV/Yi8vdARwFwgSm1/eh+MRor9yhIKuawlOFS
         7KFQ==
X-Gm-Message-State: APjAAAXedvHK5AwUIW1GVRH79YJy6tW9bK5KQrJBc3JFWulQPD0NpcJV
        j8YV3Ohi/1XDJCtFlm/MHBU/Zci7Fl3Cag==
X-Google-Smtp-Source: APXvYqypVziQKib06FW2afZcyXCzD6i6+HFfCzY6Aatbkb7HaUqi2woTyOyg1EQGyX3mChohKNpcjg==
X-Received: by 2002:adf:e50b:: with SMTP id j11mr19054902wrm.351.1562594071959;
        Mon, 08 Jul 2019 06:54:31 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id n125sm25358730wmf.6.2019.07.08.06.54.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 06:54:31 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org
Cc:     joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [GIT PULL] pidfd updates for v5.3
Date:   Mon,  8 Jul 2019 15:54:23 +0200
Message-Id: <20190708135423.5309-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This pull request adds support for pidfd polling and the pidfd_open()
syscall to support retrieving pidfds for processes created without
CLONE_PIDFD.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/pidfd-updates-v5.3

for you to fetch changes up to 172bb24a4f480c180bee646f6616f714ac4bcab2:

  tests: add pidfd_open() tests (2019-06-28 12:17:55 +0200)

/* Summary */
With this tag come two main features.

First, it adds polling support for pidfds. This allows process managers to
know when a (non-parent) process dies in a race-free way. The nofitication
mechanism used follows the same logic that is currently used when the
parent of a task is notified of a child's death.
With this patchset it is possible to put pidfds in an {e}poll loop and get
reliable notifications for process (i.e. thread-group) exit.

The second feature compliments the first one by making it possible to
retrieve pollable pidfds for processes that were not created using
CLONE_PIDFD.
A lot of processes get created with traditional PID-based calls such as
fork() or clone() (without CLONE_PIDFD). For these processes a caller can
currently not create a pollable pidfd. This is a problem for Android's low
memory killer (LMK) and service managers such as systemd.

Both patchsets are accompanied by selftests.

/* Testing */
All patches are based on v5.2-rc1 and have been sitting in linux-next since
then and have not caused any failures or warnings.

/* Conflicts with v5.2 */
A test-merge of my tree into pristine v5.2 revealed conflicts in the
following two files:
- tools/testing/selftests/pidfd/Makefile
- tools/testing/selftests/pidfd/pidfd_test.c
Fwiw, both conflicts should be trivially resolveable by just accepting all
changes introduced by this tag but I am also happy to provide a
fixed-up/rebased tree.

Note, following Al's changes in
6fd2fe494b17 (" copy_process(): don't use ksys_close() on cleanups")
the function pidfd_create() that pidfd_open() relied on got removed. I
fixed this up *without* rebasing in-tree to not break linux-next and
minimize merge conflicts with other branches. I hope that was ok to do
(The original branch does still exist at [2] for comparison.).

/* Conflicts with other trees */
Based on linux-next, I am only aware of a single trivial conflict with
Andrew's tree where a change to switch struct pid to use refcount_t
has included a new header.

/* Syscall number 434 */
pidfd_open() uses syscall number 434. I'm not aware of any other syscall
targeted for 5.3 that has chosen the same number.
The syscall required no arch-specific massaging and has hence been added to
all architectures at the same time.

/* Adoption in userspace */
Good news is that the work done so far and the work done in this branch for
pidfd_open() and polling support do already see some adoption:
- Android is in the process of backporting this work to all their LTS
  kernels (cf. [3]).
- Service managers make use of pidfd_send_signal but will need to wait
  until we enable waiting on pidfds for full adoption.
- And projects I maintain make use of both pidfd_send_signal and
  CLONE_PIDFD (cf. [4]) and will use polling support and pidfd_open() too.

/* New signing subkey */
So that there are no suprises, please note that I signed-off the tag with a
new signing key: 0x91C61BC06578DCA2
It's an ed25519 signing subkey that I moved to a Nitrokey and that's
available from the new, safer keys.openpgp.org keyserver.
Given the SKS churn I figured it might be a good idea to use a new,
dedicated kernel-only subkey instead of my general signing subkey.

Please consider pulling these changes from the signed pidfd-updates-v5.3 tag.

Thanks!
Christian

[1]: 6fd2fe494b17bf2dec37b610d23a43a72b16923a
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=pidfd_open
[3]: https://android-review.googlesource.com/q/topic:%22pidfd+polling+support+4.9+backport%22
     https://android-review.googlesource.com/q/topic:%22pidfd+polling+support+4.14+backport%22
     https://android-review.googlesource.com/q/topic:%22pidfd+polling+support+4.19+backport%22
[4]: https://github.com/lxc/lxc/blob/aab6e3eb73c343231cdde775db938994fc6f2803/src/lxc/start.c#L1753

----------------------------------------------------------------
pidfd-updates-v5.3

----------------------------------------------------------------
Christian Brauner (3):
      pid: add pidfd_open()
      arch: wire-up pidfd_open()
      tests: add pidfd_open() tests

Joel Fernandes (Google) (2):
      pidfd: add polling support
      pidfd: add polling selftests

 arch/alpha/kernel/syscalls/syscall.tbl          |   1 +
 arch/arm/tools/syscall.tbl                      |   1 +
 arch/arm64/include/asm/unistd.h                 |   2 +-
 arch/arm64/include/asm/unistd32.h               |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl           |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl           |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl       |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl       |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl       |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl         |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl        |   1 +
 arch/s390/kernel/syscalls/syscall.tbl           |   1 +
 arch/sh/kernel/syscalls/syscall.tbl             |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl          |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl          |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl          |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl         |   1 +
 include/linux/pid.h                             |   3 +
 include/linux/syscalls.h                        |   1 +
 include/uapi/asm-generic/unistd.h               |   4 +-
 kernel/fork.c                                   |  26 +++
 kernel/pid.c                                    |  71 +++++++
 kernel/signal.c                                 |  11 ++
 tools/testing/selftests/pidfd/.gitignore        |   1 +
 tools/testing/selftests/pidfd/Makefile          |   5 +-
 tools/testing/selftests/pidfd/pidfd.h           |  57 ++++++
 tools/testing/selftests/pidfd/pidfd_open_test.c | 169 ++++++++++++++++
 tools/testing/selftests/pidfd/pidfd_test.c      | 252 ++++++++++++++++++++----
 29 files changed, 576 insertions(+), 44 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd.h
 create mode 100644 tools/testing/selftests/pidfd/pidfd_open_test.c
