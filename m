Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD30C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7232064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="WOTtYhmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfDSTEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:04:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36790 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfDSTEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:04:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id a15so3456147wrw.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XJ01hKxZLKe1u+6afENm6kro7+6msX6Ewvh2hye3xlE=;
        b=WOTtYhmfUhJUKyBJiiwH2cJsgsS6ijmcTERUPueiXXWzFQnz4Kjt+0yM/qitXAO1jD
         PtHWHTpgMR0LSYAVe2IU0WF29xghsilTbFF4ScPjevxHhorEW2bfHPfCW6puG0w4ZLWW
         J+r6nY9WUYfFxLUWlwvAh6DhufaMjbpXRCAir/WZ82wGdsSQLTfVy7WeE3nRwRhdi8BK
         pMw4J05nsPoDkxEsiH+A2nLrhNhuEksTRm+CtEpE+KhlDC/6jRTgB9r+3vrVeoAXsVkB
         cn11lekiquINPXXKdb7MMblMz0Vpv/A/dGcFGrJOykHFwZvv82NCOXew23JOmNenpb6z
         Bfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJ01hKxZLKe1u+6afENm6kro7+6msX6Ewvh2hye3xlE=;
        b=DW44h3MRC50gXQhM9MLwhsrwBnY8fmGGzxgv183hhVoqap28j4sb9wzJTNV3eWUBeJ
         kzhdSZ6OLcDwrkGoPB4Bp+Fnc8hzn1ZMGZAsDaP3fUZM0vyUQF7pLfH9AONVsBEJdcnz
         pL+OmiO3AdTjEcsj31A+GcUI/XXqUQEQm8DxPmWu2ECjv0JnCr6LhC0hFmHab6JD5Pr8
         w2rAqp4Muca9rDFClx+/NOpyTfH5p7vyTXMQu9vq6DlEKtBKBlLZCSGpFMCRQ352ZLsd
         4A+hNiJkSvObOtePuwiOQe6iPs0c24XIM1gpidicqL5ICvQlyz3albrt1/eMrbdzmHSj
         XrcQ==
X-Gm-Message-State: APjAAAXkOtbrdskS+PmlWBdQO+zwU191VEkriK0jBS7trgZBRPe1992I
        FBUvRTRtoU/eP6jGvxZ6ZjzOMmU/ibodSg==
X-Google-Smtp-Source: APXvYqxFnhkl+cBCwshitvKcRInmKTpypV0lJ8R/qekztS64NcZOymOysAyPqhM4UelY3qXR+K1pqQ==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr2738396wrn.148.1555675772391;
        Fri, 19 Apr 2019 05:09:32 -0700 (PDT)
Received: from localhost.localdomain ([185.197.132.10])
        by smtp.gmail.com with ESMTPSA id f128sm6464574wme.28.2019.04.19.05.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 05:09:31 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, oleg@redhat.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jann@thejh.net>
Subject: [PATCH v3 4/4] samples: show race-free pidfd metadata access
Date:   Fri, 19 Apr 2019 14:09:04 +0200
Message-Id: <20190419120904.27502-5-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190419120904.27502-1-christian@brauner.io>
References: <20190419120904.27502-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a sample program showing userspace how to get race-free access
to process metadata from a pidfd.  It is rather easy to do and userspace
can actually simply reuse code that currently parses a process's status
file in procfs.
The program can easily be extended into a generic helper suitable for
inclusion in a libc to make it even easier for userspace to gain metadata
access.

Since this came up in a discussion because this API is going to be used
in various service managers: A lot of programs will have a whitelist
seccomp filter that returns <some-errno> for all new syscalls.  This
means that programs might get confused if CLONE_PIDFD works but the
later pidfd_send_signal() syscall doesn't.  Hence, here's a ahead of
time check that pidfd_send_signal() is supported:

bool pidfd_send_signal_supported()
{
        int procfd = open("/proc/self", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
        if (procfd < 0)
                return false;

        /*
         * A process is always allowed to signal itself so
         * pidfd_send_signal() should never fail this test. If it does
         * it must mean it is not available, blocked by an LSM, seccomp,
         * or other.
         */
        return pidfd_send_signal(procfd, 0, NULL, 0) == 0;
}

Signed-off-by: Christian Brauner <christian@brauner.io>
Co-developed-by: Jann Horn <jann@thejh.net>
Signed-off-by: Jann Horn <jann@thejh.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Howells <dhowells@redhat.com>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
/* changelog */
v1:
- Christian Brauner <christian@brauner.io>:
  - adapt sample program to changes in how CLONE_PIDFD returns the pidfd
    With Oleg's suggestion we can simplify the program even more.
v2: patch unchanged
v3: patch unchanged
---
 samples/Makefile               |   2 +-
 samples/pidfd/Makefile         |   6 ++
 samples/pidfd/pidfd-metadata.c | 112 +++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 samples/pidfd/Makefile
 create mode 100644 samples/pidfd/pidfd-metadata.c

diff --git a/samples/Makefile b/samples/Makefile
index b1142a958811..fadadb1c3b05 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
 			   configfs/ connector/ v4l/ trace_printk/ \
-			   vfio-mdev/ statx/ qmi/ binderfs/
+			   vfio-mdev/ statx/ qmi/ binderfs/ pidfd/
diff --git a/samples/pidfd/Makefile b/samples/pidfd/Makefile
new file mode 100644
index 000000000000..0ff97784177a
--- /dev/null
+++ b/samples/pidfd/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+hostprogs-y := pidfd-metadata
+always := $(hostprogs-y)
+HOSTCFLAGS_pidfd-metadata.o += -I$(objtree)/usr/include
+all: pidfd-metadata
diff --git a/samples/pidfd/pidfd-metadata.c b/samples/pidfd/pidfd-metadata.c
new file mode 100644
index 000000000000..bd8456fc4c0e
--- /dev/null
+++ b/samples/pidfd/pidfd-metadata.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <err.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#ifndef CLONE_PIDFD
+#define CLONE_PIDFD 0x00001000
+#endif
+
+static int do_child(void *args)
+{
+	printf("%d\n", getpid());
+	_exit(EXIT_SUCCESS);
+}
+
+static pid_t pidfd_clone(int flags, int *pidfd)
+{
+	size_t stack_size = 1024;
+	char *stack[1024] = { 0 };
+
+#ifdef __ia64__
+	return __clone2(do_child, stack, stack_size, flags | SIGCHLD, NULL, pidfd);
+#else
+	return clone(do_child, stack + stack_size, flags | SIGCHLD, NULL, pidfd);
+#endif
+}
+
+static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
+					unsigned int flags)
+{
+	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
+}
+
+static int pidfd_metadata_fd(pid_t pid, int pidfd)
+{
+	int procfd, ret;
+	char path[100];
+
+	snprintf(path, sizeof(path), "/proc/%d", pid);
+	procfd = open(path, O_DIRECTORY | O_RDONLY | O_CLOEXEC);
+	if (procfd < 0) {
+		warn("Failed to open %s\n", path);
+		return -1;
+	}
+
+	/*
+	 * Verify that the pid has not been recycled and our /proc/<pid> handle
+	 * is still valid.
+	 */
+	ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
+	if (ret < 0) {
+		switch (errno) {
+		case EPERM:
+			/* Process exists, just not allowed to signal it. */
+			break;
+		default:
+			warn("Failed to signal process\n");
+			close(procfd);
+			procfd = -1;
+		}
+	}
+
+	return procfd;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = EXIT_FAILURE;
+	char buf[4096] = { 0 };
+	pid_t pid;
+	int pidfd, procfd, statusfd;
+	ssize_t bytes;
+
+	pid = pidfd_clone(CLONE_PIDFD, &pidfd);
+	if (pid < 0)
+		exit(ret);
+
+	procfd = pidfd_metadata_fd(pid, pidfd);
+	close(pidfd);
+	if (procfd < 0)
+		goto out;
+
+	statusfd = openat(procfd, "status", O_RDONLY | O_CLOEXEC);
+	close(procfd);
+	if (statusfd < 0)
+		goto out;
+
+	bytes = read(statusfd, buf, sizeof(buf));
+	if (bytes > 0)
+		bytes = write(STDOUT_FILENO, buf, bytes);
+	close(statusfd);
+	ret = EXIT_SUCCESS;
+
+out:
+	(void)wait(NULL);
+
+	exit(ret);
+}
-- 
2.21.0

