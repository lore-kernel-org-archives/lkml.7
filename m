Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BECC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D076420872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Ms6gbJhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfDPRFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:05:13 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35415 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbfDPRFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:05:13 -0400
Received: by mail-vs1-f68.google.com with SMTP id d8so11984737vsp.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yv9QS7uzgP9GlJMFMz27LYIAGIRyKRTC6nWxsWHozIo=;
        b=Ms6gbJhVcBtWUb691nTHIq17JkFfHLn1SaiVpLU0UyUH6jzm6h90QpYbPYTwVFsjB8
         aXB73zVn5/hQAFdpX+i0vzwG70bM4iAUoFBhY6wHaUS8vLzEeU+ZG/jZivfr80i3kH6b
         UtUAGmFMbJG6t44ql464erkPVWPeLZjRTjAyYXgtxqL8ukul+97vj/5InPWI5iBBmsMe
         KmX79tJpWxt+HQqUaaLyKAJQonUmZo+hoS4KQ1qLKTkQY775XrAaV5psTPc4AQSqzJ9E
         opmut4TXgcWdkCMQFFsueJkqHmAZHIMMwvWrs8f9eKtRKpxUxNj1mAuAziXUN5eCPlQ/
         h9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yv9QS7uzgP9GlJMFMz27LYIAGIRyKRTC6nWxsWHozIo=;
        b=RgWkunmTnHQHGBvgf52ETdiCRf3beV3m1lWyu2HzS5bimY6kZo0IAvne62DEV+EqRS
         2UBpRTJBFA9uhp4+RoQ2VyPm1HIyVZtQabOWkb7xtsNSPOWjel8tgq0KdCweIKwmdv1L
         3Lwr8opd9O3K9NMzToZ0fgvSoCHbMoD/cmu7omBVcKmvDTxN0bLjyrmwCyWe+1jlQS9v
         Kg/0Ijgucy17jVDFxYzKus3TMaVyD5zwtFMGPI6Ms0052dgu69gEECBLU8nr/LKQuyQf
         AQPeJgqWTRFNaSFDWTiDyIeGAs1MlOlPCmUclcDVHpdtmPBZjTFHu9LfdXGjXOhvBnrU
         Kxkg==
X-Gm-Message-State: APjAAAXMyGcbIXk78LvUClxKz8rA5t5zcp4xxXOEYiJAeb6VU9gd8mMw
        l4x9Jwvbi1O+idZ+GujRwHAKaQ==
X-Google-Smtp-Source: APXvYqyjnzYkABxQZfTflkw6ICQF1SREF83juhbHwXkQCIXLypXnovZjasuWTCqUanPKuQvCZgb+sg==
X-Received: by 2002:a67:69d7:: with SMTP id e206mr44452168vsc.79.1555434311809;
        Tue, 16 Apr 2019 10:05:11 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
        by smtp.gmail.com with ESMTPSA id c192sm45178368vka.10.2019.04.16.10.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:05:11 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 4/4] samples: show race-free pidfd metadata access
Date:   Tue, 16 Apr 2019 19:02:33 +0200
Message-Id: <20190416170233.10208-5-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190416170233.10208-1-christian@brauner.io>
References: <20190416170233.10208-1-christian@brauner.io>
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

