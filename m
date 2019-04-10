Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFF0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D434A2082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="XMLCDCS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfDJXnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:43:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42293 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfDJXnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:43:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id x61so3529354edc.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 16:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lVqryB6S1f+7+dRTAY6Ggc/gqXVR5boZXsAqEDKVXmc=;
        b=XMLCDCS5QTv8GV+Rvjug+XJQCaQmurB5fuOwa8c+rlrv/XCbZMXhlzI/6M3wT1TjLz
         6PO63yyupurGt+7yYyEE4+qyn0a3vdFNK1RSXbmsh6aQ2+u0/U9Vwt+cegugMCJlZqmu
         kyk4N173v5qs84AQuXRxZti1hvWAV2BgDST1rh1CEZqIa7PBbney1SQSFbQvL9++EQNi
         tp5V5g2aSNfemBvKlwgoMXPZqUn7yFbndClFqiRqO7TlvDGIptpJH0FPowlTAQjF/+tX
         /kLi5Nk2H9QRYfMSaKnNF/Uzt9lVuMNQ7nBjWklfBRobCijcimLjY13DALcOjwRrxAIN
         CJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lVqryB6S1f+7+dRTAY6Ggc/gqXVR5boZXsAqEDKVXmc=;
        b=UsHe/X7q4O6u5ry4ukTmCDVhICiRZ4zP+3JdMKOT8tn3OyMbzFdcbc/3jLTvpMvINg
         J5wTTFxqRCtmBF2jqduRRThFQwitZ1sOZXZQUnE9B1wo2miV3FdNaF1VuSs5aoclwVg0
         Au+lcfPaXDIxUZWT3011gNXYqLf74eR4nH8iaQYXrtaCaaNY8Bm0cOQ8wYcn1dIqgUOo
         o4Ck0+0MBvafqMoYNlEX6/gsMpX3AJr1BIjWtlVP3CG5syjTlEJeK4eOBGp8ZcmBw6ID
         cJhQb7B29IxoWU3AiuhKaqjdlZTyHZzXH7IkfEMf6uOE6IqIoiYc8VMycw598Xd4KB8E
         ZHEw==
X-Gm-Message-State: APjAAAUhCKd5U3IZjXmik5q8RCBEAz/bG50FkpJ8Ink9H6KdkUIz6nkn
        rAD95OjmbqTPTHWPdFFrYCZIBQ==
X-Google-Smtp-Source: APXvYqxepdyiEKKCnkNqOYSj7H+8x6bGtA3571Nucc7F/yaZC8jtWAq/YprCciaVkp2f9OP09+uo3Q==
X-Received: by 2002:a50:fa4c:: with SMTP id c12mr22849799edq.37.1554939816757;
        Wed, 10 Apr 2019 16:43:36 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id f8sm4833015edt.36.2019.04.10.16.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:43:36 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, adobriyan@gmail.com,
        tglx@linutronix.de, mtk.manpages@gmail.com, bl0pbl33p@gmail.com,
        ldv@altlinux.org, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [RFC-2 PATCH 4/4] samples: show race-free pidfd metadata access
Date:   Thu, 11 Apr 2019 01:40:45 +0200
Message-Id: <20190410234045.29846-6-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190410234045.29846-1-christian@brauner.io>
References: <20190410234045.29846-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an sample program to show userspace how to get race-free access to
process metadata from a pidfd.
It is really not that difficult and instead of burdening the kernel with
this task by using fds to /proc/<pid> we can simply add a helper to libc
that does it for the user.

Signed-off-by: Christian Brauner <christian@brauner.io>
Signed-off-by: Jann Horn <jann@thejh.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Howells <dhowells@redhat.com>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 samples/Makefile               |   2 +-
 samples/pidfd/Makefile         |   6 ++
 samples/pidfd/pidfd-metadata.c | 169 +++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+), 1 deletion(-)
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
index 000000000000..c46c6c34a012
--- /dev/null
+++ b/samples/pidfd/pidfd-metadata.c
@@ -0,0 +1,169 @@
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
+static int raw_clone_pidfd(void)
+{
+	unsigned long flags = CLONE_PIDFD;
+
+#if defined(__s390x__) || defined(__s390__) || defined(__CRIS__)
+	/* On s390/s390x and cris the order of the first and second arguments
+         * of the system call is reversed.
+         */
+	return (int)syscall(__NR_clone, NULL, flags | SIGCHLD);
+#elif defined(__sparc__) && defined(__arch64__)
+	{
+		/*
+                 * sparc64 always returns the other process id in %o0, and a
+                 * boolean flag whether this is the child or the parent in %o1.
+                 * Inline assembly is needed to get the flag returned in %o1.
+                 */
+		int in_child;
+		int child_pid;
+		asm volatile("mov %2, %%g1\n\t"
+			     "mov %3, %%o0\n\t"
+			     "mov 0 , %%o1\n\t"
+			     "t 0x6d\n\t"
+			     "mov %%o1, %0\n\t"
+			     "mov %%o0, %1"
+			     : "=r"(in_child), "=r"(child_pid)
+			     : "i"(__NR_clone), "r"(flags | SIGCHLD)
+			     : "%o1", "%o0", "%g1");
+
+		if (in_child)
+			return 0;
+		else
+			return child_pid;
+	}
+#elif defined(__ia64__)
+	/* On ia64 the stack and stack size are passed as separate arguments. */
+	return (int)syscall(__NR_clone, flags | SIGCHLD, NULL, prctl_arg(0));
+#else
+	return (int)syscall(__NR_clone, flags | SIGCHLD, NULL);
+#endif
+}
+
+static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
+					unsigned int flags)
+{
+	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
+}
+
+static int pidfd_metadata_fd(int pidfd)
+{
+	int procfd, ret;
+	char path[100];
+	FILE *f;
+	size_t n = 0;
+	char *line = NULL;
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", pidfd);
+
+	f = fopen(path, "re");
+	if (!f)
+		return -1;
+
+	ret = 0;
+	while (getline(&line, &n, f) != -1) {
+		char *numstr;
+		size_t len;
+
+		if (strncmp(line, "Pid:\t", 5))
+			continue;
+
+		numstr = line + 5;
+		len = strlen(numstr);
+		if (len > 0 && numstr[len - 1] == '\n')
+			numstr[len - 1] = '\0';
+		ret = snprintf(path, sizeof(path), "/proc/%s", numstr);
+		break;
+	}
+	free(line);
+	fclose(f);
+
+	if (!ret) {
+		errno = ENOENT;
+		warn("Failed to parse pid from fdinfo\n");
+		return -1;
+	}
+
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
+	if (sys_pidfd_send_signal(pidfd, 0, NULL, 0) < 0) {
+		/* process does not exist */
+		if (errno == ESRCH) {
+			warn("The pid was recycled\n");
+			close(procfd);
+			return -1;
+		}
+
+		/* just not allowed to signal it */
+	}
+
+	return procfd;
+}
+
+int main(int argc, char *argv[])
+{
+	int procfd, ret = EXIT_FAILURE;
+	ssize_t bytes;
+	char buf[4096] = { 0 };
+
+	int pidfd = raw_clone_pidfd();
+	if (pidfd < 0)
+		return -1;
+
+	if (pidfd == 0) {
+		printf("%d\n", getpid());
+		exit(EXIT_SUCCESS);
+	}
+
+	procfd = pidfd_metadata_fd(pidfd);
+	close(pidfd);
+	if (procfd < 0)
+		goto out;
+
+	int statusfd = openat(procfd, "status", O_RDONLY | O_CLOEXEC);
+	close(procfd);
+	if (statusfd < 0)
+		goto out;
+
+	bytes = read(statusfd, buf, sizeof(buf));
+	if (bytes > 0)
+		bytes = write(STDOUT_FILENO, buf, bytes);
+	close(statusfd);
+
+out:
+	(void)wait(NULL);
+	if (bytes < 0 || ret)
+		exit(EXIT_FAILURE);
+
+	exit(EXIT_SUCCESS);
+}
-- 
2.21.0

