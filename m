Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B1CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314982184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="EFmNls0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388657AbfDRKTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:19:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41126 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388596AbfDRKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:19:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id g6so1337451edc.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 03:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d1yLxh/3OGBPpg7gZTiln7HJ/Xk6s0nIJsrbG5ZrHVQ=;
        b=EFmNls0rCsDDcjpEBjX2jUCT265jk/AAs2ALb1dFa9InyS5jEbrpV302LkDa+Ry4k0
         xxuKEkqwNEAZldyVZM/QvODix7L/cNk3VQj7yJyN2/wAzXKkPXI+9MxHQeFfnQZ7WQtq
         zdXggyUd4QzqwOQbDq/lV+mlboIUnLc4eo+ZZJ509OIxtoRds4SBK36SVxyeY+WyJXnT
         BvNR4qO/0ZN9jXbhRmVjN8VQSi3YRZdjYzt5wiWxdfCFVkhnDSnyiKJIC6OnrYWCM7v9
         Q9REZXfEh7qu/M3XD54R28ZL0BzL2BoPvNA8fHhpkUGHibTF3+UjUYt8deBj82QOZjKJ
         dayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d1yLxh/3OGBPpg7gZTiln7HJ/Xk6s0nIJsrbG5ZrHVQ=;
        b=ZRJi7m0e0LpIucDRQqRWicT0IemHSHAM8F6GrIcPGQJ4Unh6y1vT4H5jBxd5Iz1Eec
         Fwenms0vNrA6DqKre4kcU5F5YreJwp8CGcNmdsZQdZU5MAS+Z5VzC3hgGCgGN/ibNtPw
         /jmBrkVUX1yoHHNlrjNWaWmxKNf92FoNQSRXsR4gYMnlZa5/weB4pXfOgXxoFcy1f5o0
         Uy/1jJNarWwMKe/4srOBBw8RyTS9qy06Y5foQ+TND90o0Ez8+14ZOXWCg7dy00xnyTas
         q58uCIwOJttUJyV0GjlO9oo6I7e+5SmWlxhE8etSo9Dj+xcweA8MyhE7iXyqen/Sr0wy
         6byA==
X-Gm-Message-State: APjAAAVRJA+vFugCZrL8L+WYKg8hQ1PqK7DOopenV0HrZ0iu0Z2OLtTZ
        fWo6T+Ah39hKcebL73O9sqp0Dg==
X-Google-Smtp-Source: APXvYqxBgHjR2FELVDsMO0Yb/HPpk/Umas1K4nmOwQQIgk1fKowcdYNLzgQw+rYS9k9OfwNWkpOwOA==
X-Received: by 2002:a17:906:3e48:: with SMTP id t8mr46479676eji.145.1555582767828;
        Thu, 18 Apr 2019 03:19:27 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id 31sm400479edf.18.2019.04.18.03.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 03:19:26 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, oleg@redhat.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 5/5] samples: show race-free pidfd metadata access
Date:   Thu, 18 Apr 2019 12:18:41 +0200
Message-Id: <20190418101841.4476-6-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418101841.4476-1-christian@brauner.io>
References: <20190418101841.4476-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a sample program showing userspace how to get race-free access to
process metadata from a pidfd. It is rather easy to do and userspace can
actually simply reuse code that currently parses a process's status file in
procfs.
The program can easily be extended into a generic helper suitable for
inclusion in a libc to make it even easier for userspace to gain metadata
access.

Since this came up in a discussion since this API is going to be used in
various service managers. A lot of programs will have a whitelist seccomp
filter that returns EPERM for all new syscalls. This means that programs
might get confused if CLONE_PIDFD works but the later pidfd_send_signal()
syscall doesn't. Hence, here's a ahead of time check that
pidfd_send_signal() is supported:

bool pidfd_send_signal_supported()
{
        int procfd = open("/proc/self", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
        if (procfd < 0)
                return false;

        /* pidfd_send_signal() should never fail this test. So it must
         * mean it is not available or blocked by an LSM or seccomp or
         * other. So * fallback to using pids in this case.
         */
        return pidfd_send_signal(procfd, 0, NULL, 0) == 0;
}

Signed-off-by: Christian Brauner <christian@brauner.io>
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

