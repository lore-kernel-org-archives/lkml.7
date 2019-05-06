Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46619C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA242087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="K6FbGeEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfEFMhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:37:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33610 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfEFMhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:37:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id n17so15192449edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 05:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3utZMVbWOqFYhCcEBX/LpFdSZ4nL83caZ8XCZN9GGOs=;
        b=K6FbGeEFBQP0t32cNBSxYjsWx4Htvgs7ShxQtOePZjUQGSkNH3sLHpBg4uvjWvnv++
         nx/4yH5FLkwEoitZ0ho1obC7ak/hyy3mSnHda2ZFn21CKswObxE6X+jpMJrESsKufH2V
         g7e6RiEwiCD+IZmRzEweZ/SHn1hveYL4Kl+b0LyeL0s5MnlT43LvlaFw0g5WCFfYqoTN
         Uaq0IrnvJ7mFNyoKk6yK72tD8ZlU3YQ5bIJ4hjFHNBdSE8YQnmbTtFxII9rNJ6hly59K
         +zpIDgV2PrLMyt6NOr4P6xr826ZMribU8SeGuTaidhHNqF8uludrDKEMnhLdb++ubCaB
         rP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3utZMVbWOqFYhCcEBX/LpFdSZ4nL83caZ8XCZN9GGOs=;
        b=GjQhS+JI6IQVsKJSoSjHZILQvbMJNwZSWkw1np3XG0n+c+SM2Pr3LOHMg60HHBxMiN
         uiMAj6MKW9Ufc1f3XKAQAPb0ZAYs+YlZF5825r7YB9Mz8tkqxQx8fHQ0rFq/avHZOa2x
         BQbKNhE1ILcunmqDlAfhlZ6+M+kiujHzblpLf13Q7nuYwoGiGrOUHuqVxtVwGU4Cj67c
         qhUvdjLumLCIdIwkckepGw0p8Apq1BypHqoA3L0oTP6Hh5lgQLi+pg924uXlqXe6ZBAP
         ygUyJW3awLN1H+1y+kQ3f78lZfEBOHNT2K1G6akXcF6dUhPeAh4+48Hlr6Cd+Iu5IKGC
         02WQ==
X-Gm-Message-State: APjAAAXn3eOOekArV5VtDWV6Epd1epssH5vDhTg+Y9UJwRDGW9row7KL
        kFjM6TSNh7k3LYCtmig4wwSATw==
X-Google-Smtp-Source: APXvYqysNrN86yujwg2Jb9AHK/JuXq38HTSCTghZ45uCvk6U5UHOS27EyC5ZGiCYGGiTutVnjo+i2g==
X-Received: by 2002:a17:906:c456:: with SMTP id ck22mr15640777ejb.113.1557146268449;
        Mon, 06 May 2019 05:37:48 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id f8sm3034394edd.15.2019.05.06.05.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 05:37:47 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, jannh@google.com,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [GIT PULL] pidfd patches for v5.2-rc1
Date:   Mon,  6 May 2019 14:36:59 +0200
Message-Id: <20190506123659.23591-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the promised pull request for the CLONE_PIDFD flag to the clone()
syscall in its agreed upon form:

The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d:

  Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/pidfd-v5.2-rc1

for you to fetch changes up to 0786de75cbc560f779378c862b8bac16bee74d10:

  samples: show race-free pidfd metadata access (2019-05-06 13:26:37 +0200)

/* Testing */
The patches have been sitting in linux-next for quite a while.
The recent change date on two of the commits is caused by a necessary
update to Jann's mail address for the co-developed and signed-off-by lines.
No semantic changes were done!

/* Conflicts with other trees */
Please note, that the pidfd branch has two minor conflicts.  The first with
akpm-current/current. The conflict and fix for it can be found under [1].
The second with the kbuild tree. The conflict and fix for it can be found
under [2].
I'm happy to provide a fixed up tree but was told you usually prefer to do
it yourself when reasonably small.

/* Summary */
This patchset makes it possible to retrieve pidfds at process creation time
by introducing the new flag CLONE_PIDFD to the clone() system call.  Linus
originally suggested to implement this as a new flag to clone() instead of
making it a separate system call.

After a thorough review from Oleg CLONE_PIDFD returns pidfds in the
parent_tidptr argument. This means we can give back the associated pid and
the pidfd at the same time. Access to process metadata information thus
becomes rather trivial.

As has been agreed, CLONE_PIDFD creates file descriptors based on anonymous
inodes similar to the new mount api.  They are made unconditional by this
patchset as they are now needed by core kernel code (vfs, pidfd) even more
than they already were before (timerfd, signalfd, io_uring, epoll etc.).
The core patchset is rather small.  The bulky looking changelist is caused
by David's very simple changes to Kconfig to make anon inodes unconditional.

A pidfd comes with additional information in fdinfo if the kernel supports
procfs.  The fdinfo file contains the pid of the process in the callers pid
namespace in the same format as the procfs status file, i.e. "Pid:\t%d".

To remove worries about missing metadata access this patchset comes with a
sample/test program that illustrates how a combination of CLONE_PIDFD and
pidfd_send_signal() can be used to gain race-free access to process
metadata through /proc/<pid>.

Further work based on this patchset has been done by Joel.  His work makes
pidfds pollable.  It finished too late for this merge window.  I would
prefer to have it sitting in linux-next for a while and send it for
inclusion during the 5.3 merge window.

Please consider pulling these changes from the signed pidfd-v5.2-rc1 tag.

Thanks!
Christian

[1]: https://lore.kernel.org/lkml/20190423184657.3d16ba97@canb.auug.org.au/
[2]: https://lore.kernel.org/lkml/20190502183125.3b53300e@canb.auug.org.au/

----------------------------------------------------------------
pidfd patches for v5.2-rc1

----------------------------------------------------------------
Christian Brauner (3):
      clone: add CLONE_PIDFD
      signal: support CLONE_PIDFD with pidfd_send_signal
      samples: show race-free pidfd metadata access

David Howells (1):
      Make anon_inodes unconditional

 arch/arm/kvm/Kconfig           |   1 -
 arch/arm64/kvm/Kconfig         |   1 -
 arch/mips/kvm/Kconfig          |   1 -
 arch/powerpc/kvm/Kconfig       |   1 -
 arch/s390/kvm/Kconfig          |   1 -
 arch/x86/Kconfig               |   1 -
 arch/x86/kvm/Kconfig           |   1 -
 drivers/base/Kconfig           |   1 -
 drivers/char/tpm/Kconfig       |   1 -
 drivers/dma-buf/Kconfig        |   1 -
 drivers/gpio/Kconfig           |   1 -
 drivers/iio/Kconfig            |   1 -
 drivers/infiniband/Kconfig     |   1 -
 drivers/vfio/Kconfig           |   1 -
 fs/Makefile                    |   2 +-
 fs/notify/fanotify/Kconfig     |   1 -
 fs/notify/inotify/Kconfig      |   1 -
 include/linux/pid.h            |   2 +
 include/uapi/linux/sched.h     |   1 +
 init/Kconfig                   |  10 ----
 kernel/fork.c                  | 108 +++++++++++++++++++++++++++++++++++++--
 kernel/signal.c                |  12 +++--
 kernel/sys_ni.c                |   3 --
 samples/Makefile               |   2 +-
 samples/pidfd/Makefile         |   6 +++
 samples/pidfd/pidfd-metadata.c | 112 +++++++++++++++++++++++++++++++++++++++++
 26 files changed, 236 insertions(+), 38 deletions(-)
 create mode 100644 samples/pidfd/Makefile
 create mode 100644 samples/pidfd/pidfd-metadata.c
