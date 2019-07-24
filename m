Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A93C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B58F21850
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="RESSSGPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387490AbfGXOrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:47:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40110 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfGXOrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:47:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so21358389pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+x1xAgVfBQpMxOF18mx/2Uy7ftJyt8nFpuTntfkBjEg=;
        b=RESSSGPA0O+5JYyX91vaVnA6lsxVmp5RnMRaIXurS29e1+tNscsKmgS7lkixjyGmJk
         WsE81K7wiVC/+cBvIw6n+WE8+odmEvgd2JEX4qbTR49bt7D4k+EMACJ7F5mTFxRN8KCC
         lGIMAmNVS4XTWcGlxlEEPV0QRFtO17qh1moYf1iap6wJldUA9ZUut4t6QUWL/mlLYDVq
         5kltEKua2cU+bHZPplIAIp/HvcmO/bGgMKkobzb3Ldfdyk3/p3xirHjckEFgKrtOZ4xq
         UTwVECWAwAYu3+B0EllOPICWFksBbCitdIv0nmcHUia3I9uaduuGeXCJw6UqUlAq822c
         vvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+x1xAgVfBQpMxOF18mx/2Uy7ftJyt8nFpuTntfkBjEg=;
        b=UdEo0zfQiQhPhKSRek+TAowKAvBAsdr9SmnIs6wn0sp5CpZritjT2upPwl7K+RW9Pm
         fdpKUyk8dIulGWnOAAxgokiluMSPaS+VTGV49gV0vTdMzJIDrEtBYg4TthB8p0hwFmwH
         6Rz84LiWYMOvJYQYv6ZWWoKTvNlsHBgyBkyZChmVPoThB+9x8zY7keGFNFGj/y1CbUiU
         RLgj+EPeHaXmgKz6Z/b4Zzd5ZMCjzXf55A75PxUOExsW/TdTk/boK62jrDx9K6L0E6QX
         lMPW35cC/Z5Gg8S6/uICdNGq7zPm/3AgUaWKEorOhbvqs4Xd0vhnBMu7sLUx5aXoHbu4
         4ZSw==
X-Gm-Message-State: APjAAAVLlhrCpi66iisJLkaTRgvEeUUI5KnDYI0YMfdexphsbpbhiKtX
        MWvtFJNF/U465Bunm8Q8UuK2X96gzR8=
X-Google-Smtp-Source: APXvYqx2CApndS58bPPNWTkjY3oONltRsWGnVgGfycGpKFX379KiUYASuzahh7YPQTD+eRdHx+CHOA==
X-Received: by 2002:a17:90a:5806:: with SMTP id h6mr85582626pji.126.1563979643748;
        Wed, 24 Jul 2019 07:47:23 -0700 (PDT)
Received: from localhost.localdomain ([172.58.27.54])
        by smtp.gmail.com with ESMTPSA id g6sm41125644pgh.64.2019.07.24.07.47.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 07:47:22 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, oleg@redhat.com
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de, tj@kernel.org,
        dhowells@redhat.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH 0/5] pidfd: waiting on processes through pidfds
Date:   Wed, 24 Jul 2019 16:46:46 +0200
Message-Id: <20190724144651.28272-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

This adds the ability to wait on processes using pidfds. This is one of
the few missing pieces to make it possible to manage processes using
only pidfds.

pidfd_wait() does explicitly not allow scoping of the process referred
to by the pidfd, i.e. generic wait requests such as P_PGID and P_ALL and
other trickery such as passing in negative values and so on is not
supported.

The series also adds support for CLONE_WAIT_PID which prevents the
process referred to by the pidfd to appear in generic wait requests
similar to what is the default in FreeBSD.
This feature has been requested multiple times when I gave talks about
this work (for extensions see [1]).

The syscall patch is rather small overall. The largest portion of this
series are the tests and the cleanup to remove struct waitid_info from
exit.c.

Thanks!
Christian

[1]: In the future, we might add something like
     CLONE_WAIT_STATUS_FOREIGN (or some better name).
     Such pidfds will allow anyone to retrieve the exit status of a
     non-parent process by calling pidfd_wait() on it without reaping
     it. This has also been requested quite often and fits nicely into
     the api. But that's for a later patchset.

Christian Brauner (5):
  exit: kill struct waitid_info
  pidfd: add pidfd_wait()
  arch: wire-up pidfd_wait()
  pidfd: add CLONE_WAIT_PID
  pidfd: add pidfd_wait tests

 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |   4 +-
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 include/linux/pid.h                         |   5 +
 include/linux/sched.h                       |   1 +
 include/linux/syscalls.h                    |   4 +
 include/uapi/asm-generic/unistd.h           |   4 +-
 include/uapi/linux/sched.h                  |   1 +
 kernel/exit.c                               | 191 ++++++----
 kernel/fork.c                               |  19 +-
 kernel/signal.c                             |   7 +-
 tools/testing/selftests/pidfd/pidfd.h       |  25 ++
 tools/testing/selftests/pidfd/pidfd_test.c  |  14 -
 tools/testing/selftests/pidfd/pidfd_wait.c  | 398 ++++++++++++++++++++
 29 files changed, 606 insertions(+), 85 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_wait.c

-- 
2.22.0

