Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E32206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="K7SYjhIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfC2Pyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:54:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42659 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfC2Pyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:54:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so3179938wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zrSpjNKWo+VxkqnG1fy57YXNJNah4GR2oKpOsjS7Ne4=;
        b=K7SYjhIulP256a6OSQ5dJKoTPBswE+Dx1ImJPd5X7+2HLBlF40xvB17ZUgtQVQpYja
         YxtTBEqhgXlUfKT7rfch91TE5Qp6L+tijJui3/u5YTk29jesNFCN4OIHSz14Z9jN6OAh
         h+ycmVBDUA5aCerBw6C/owyms2lLv5lf+L2adeEfQbgCTsFrNkbdRNt9bbd88QIlrqzf
         MSDQKegCMLbI7KnDgC9nOoZzWEsRD8MZ+bmNJxsfTFOByf4RMcb4u1sOl/fCq/P60U9E
         AlMjVqpFNky7larEs/LaIqQgKJdEvbKyVYtqcQ9XcqksalDMFbZvhZgf0k0DA1Mo8WxJ
         o0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zrSpjNKWo+VxkqnG1fy57YXNJNah4GR2oKpOsjS7Ne4=;
        b=dm7u/uBHqlWLVTqoENFocskZpXUroTVph/WPRQ+vlAEJyAdCrlWT72howDNUqwOq92
         8XP1SVOqIptmqci3NOEdE/e9QrXjuem0rscEIqOg4xk6cuPRLIa0IV6oQ1o0XWh97RrI
         sPHi6DZI7yistJAtGLfjtqNizn22tz5cCOLr5raoTmjFds2LiVykCi18BWHWFQQE4SeL
         v5sdcj4tSxCtXFFtx8GKA8v/aSqVtdqbTm3u2Ln/Q2/kFBiuKXCVj3mQYRzLP2w1/O05
         Gx9nSo8NJNYvwJL5c1SGXEn+grWGqt3clXAnDYUP5cgrNfTBU3kCdgxA1cDq0GSzf5v4
         mO8g==
X-Gm-Message-State: APjAAAUS4qrFNk/7xspEmnIiGEzkncs5dbciUonYbheTEB4CVf2dBjhS
        KfCA60UbYrpQeotsU0/DrQWefw==
X-Google-Smtp-Source: APXvYqynRc7cWYhfJvBUQeTbJUGPO7LH6H8sibwhV5+7GfiAfTYp41dWnbX54soYEdq/lqoonPQjUA==
X-Received: by 2002:adf:fa47:: with SMTP id y7mr2593967wrr.27.1553874882338;
        Fri, 29 Mar 2019 08:54:42 -0700 (PDT)
Received: from localhost.localdomain (p2E5A5955.dip0.t-ipconnect.de. [46.90.89.85])
        by smtp.gmail.com with ESMTPSA id e1sm4177959wrw.66.2019.03.29.08.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 08:54:40 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jannh@google.com, luto@kernel.org, dhowells@redhat.com,
        serge@hallyn.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, ebiederm@xmission.com, khlebnikov@yandex-team.ru,
        keescook@chromium.org, adobriyan@gmail.com, tglx@linutronix.de,
        mtk.manpages@gmail.com, bl0pbl33p@gmail.com, ldv@altlinux.org,
        akpm@linux-foundation.org, oleg@redhat.com,
        nagarathnam.muthusamy@oracle.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 0/5] pid: add pidfd_open()
Date:   Fri, 29 Mar 2019 16:54:20 +0100
Message-Id: <20190329155425.26059-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/* Introduction */
This adds the pidfd_open() syscall.
pidfd_open() allows to retrieve file descriptors for a given pid. This
includes both file descriptors for processes and file descriptors for
threads.

With the addition of this syscalls pidfds become independent of procfs just
as pids are. Of course, if CONFIG_PROC_FS is not set then metadata access
for processes will not be possible but everything else will just work fine.
In addition, this allows us to remove the dependency of pidfd_send_signal()
on procfs and enable it unconditionally.
With the ability to call pidfd_open() on tids we can now add a flag to
pidfd_send_signal() to signal to a specific thread capturing the
functionality of tgkill() and related thread-focused signal syscalls.

The desire to lift the restriction for pidfds on procfs has been expressed
by multiple people (cf. the commit message of commit
3eb39f47934f9d5a3027fe00d906a45fe3a15fad and [2]).

/* Signature */
int pidfd_open(pid_t pid, unsigned int flags);

/* pidfds are anon inode file descriptors */
These pidfds are allocated using anon_inode_getfd(), are O_CLOEXEC by
default and can be used with the pidfd_send_signal() syscall. They are not
dirfds and as such have the advantage that we can make them pollable or
readable in the future if we see a need to do so. The pidfds are not
associated with a specific pid namespaces but rather only reference struct
pid of a given process in their private_data member.
Additionally, Andy made an argument that we should go forward with
non-proc-dirfd file descriptors for the sake of security and extensibility
(cf. [3]). This will unblock or help move along work on pidfd_wait which
is currently ongoing.

/* Process Metadata Access */
One of the oustanding issues has been how to get information about a given
process if pidfds are regular file descriptors and do not provide access to
the process /proc/<pid> directory.
Various solutions have been proposed. The one that most people prefer is to
be able to retrieve a file descriptor to /proc/<pid> based on a pidfd
(cf. [5]). The prefered solution for how to do this has been to implement
an ioctl that for pidfds that translates a pidfd into a dirfd for
/proc/<pid>. This has been implemented in this patchset as well. If
PIDFD_GET_PROCFD is passed as a command to an ioctl() taking a pidfd and an
fd referring to a procfs directory as an argument a corresponding dirfd to
/proc/<pid> can be retrieved.
The ioctl() makes very sure that the struct pid associated with the
/proc/<pid> fd is identical to the struct pid stashed in the pidfd. This
ensures that we avoid pid recycling issues.

/* Testing */
The patchset comes with tests (which btw. I consider mandatory with
every feature-patch that intends to go through the pidfd tree):
- test that no invalid flags can be passed to pidfd_open()
- test that no invalid pid can be passed to pidfd_open()
- test that a pidfd can be retrieved with pidfd_open()
- test whether a pidfd can be converted into an fd to /proc/<pid> to get
  metadata access
- test that a pidfd retrieved based on a pid that has been recycled cannot
  be converted into /proc/<pid> for that recycled pid

/* Example */
int pidfd = pidfd_open(1234, 0);
int procfd = open("/proc", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
int procpidfd = ioctl(pidfd, PIDFD_GET_PROCFD, procfd);
int statusfd = openat(procpidfd, "status", O_RDONLY | O_CLOEXEC);
int ret = read(statusfd, buf, sizeof(buf));
ret = pidfd_send_signal(pidfd, SIGKILL, NULL, 0);

/* References */
[1]: https://lore.kernel.org/lkml/20181228233725.722tdfgijxcssg76@brauner.io/
[2]: https://lore.kernel.org/lkml/20190320203910.GA2842@avx2/
[3]: https://lore.kernel.org/lkml/CALCETrXO=V=+qEdLDVPf8eCgLZiB9bOTrUfe0V-U-tUZoeoRDA@mail.gmail.com
[4]: https://lore.kernel.org/lkml/CAHk-=wgmKZm-fESEiLq_W37sKpqCY89nQkPNfWhvF_CQ1ANgcw@mail.gmail.com
[5]: https://lore.kernel.org/lkml/533075A9-A6CF-4549-AFC8-B90505B198FD@joelfernandes.org

Christian Brauner (4):
  pid: add pidfd_open()
  signal: support pidfd_open() with pidfd_send_signal()
  signal: PIDFD_SIGNAL_TID threads via pidfds
  tests: add pidfd_open() tests

David Howells (1):
  Make anon_inodes unconditional

 arch/arm/kvm/Kconfig                          |   1 -
 arch/arm64/kvm/Kconfig                        |   1 -
 arch/mips/kvm/Kconfig                         |   1 -
 arch/powerpc/kvm/Kconfig                      |   1 -
 arch/s390/kvm/Kconfig                         |   1 -
 arch/x86/Kconfig                              |   1 -
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/x86/kvm/Kconfig                          |   1 -
 drivers/base/Kconfig                          |   1 -
 drivers/char/tpm/Kconfig                      |   1 -
 drivers/dma-buf/Kconfig                       |   1 -
 drivers/gpio/Kconfig                          |   1 -
 drivers/iio/Kconfig                           |   1 -
 drivers/infiniband/Kconfig                    |   1 -
 drivers/vfio/Kconfig                          |   1 -
 fs/Makefile                                   |   2 +-
 fs/notify/fanotify/Kconfig                    |   1 -
 fs/notify/inotify/Kconfig                     |   1 -
 include/linux/pid.h                           |   2 +
 include/linux/syscalls.h                      |   1 +
 include/uapi/linux/wait.h                     |   5 +
 init/Kconfig                                  |  10 -
 kernel/pid.c                                  | 181 +++++++++
 kernel/signal.c                               | 130 +++++--
 kernel/sys_ni.c                               |   3 -
 tools/testing/selftests/pidfd/Makefile        |   2 +-
 tools/testing/selftests/pidfd/pidfd.h         |  57 +++
 .../testing/selftests/pidfd/pidfd_open_test.c | 361 ++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd_test.c    |  41 +-
 30 files changed, 701 insertions(+), 112 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd.h
 create mode 100644 tools/testing/selftests/pidfd/pidfd_open_test.c

-- 
2.21.0

