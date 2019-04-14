Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADE9C282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9792084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="V56kYj4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfDNUPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:15:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39415 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfDNUPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:15:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id k45so12837826edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 13:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=imR32vbY9WZZPOkf8zxQCMKbA2gLbgn3RsJOli4pRVg=;
        b=V56kYj4/RaS+1p/Oxwpnxf2knlKvEKMTUxGAtpUz3a9KSsx/71m6KwkGONa6H63gqD
         2Ir2g3K/eqx2YjYouXVqUdbmDeOEAUxN98ywj9ZLTaeJ7gE+xnvOy6Eubj8l5FoeAvhx
         Z8ThtuVS/0KVmIKImcGKlZsXvvq2U0LCFMYaX0v/LuZplp/Vj+OQ7ENJjEomtKnwcKE2
         juUAuYb0riTouqzczBK7qZ7S1YZR60V3aTrqIe0OdxX6U7nOfp/MsdGcHpT0bHYTfuck
         i3rtLkcIdnndsmlx21VgK7xZIQUcnSuKD37SkaOBMPiMW0EBR6qvumSjoJdXrzoxR3Gu
         kouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=imR32vbY9WZZPOkf8zxQCMKbA2gLbgn3RsJOli4pRVg=;
        b=W0QFa/eltTMNlm2rXyXMTXkNvDp8adNORQNoAvk4MiQbNgLZG9h6WHjei9miNkphkW
         WT4AfY/m96T6vFNraGK+Ma+nMBuLCakTGrM8BQzC102Kir9y5QIig2o6PtGbyayB4QDe
         hR0xT5JDt9jLnaAMHuDyL8fJfbhj8gKFGVvjTE6DNguJEJlUrqpiiibq6lbFEYzEpEY/
         xeue5xcsMmdpYYSGNGI+fjhmp6UEo4poEFJHE/9aGjHQMShARlWD2dZKQ2R2UvCIX1kY
         iwQLu85F+R0xUNtDqgcAZCCl4k0HCbw9t943cRVGD5X2GWkVHDDYbNEjwHsHH9o2lDXX
         FTeg==
X-Gm-Message-State: APjAAAWULtpW4ErM5oiNLS3Dkg2jlBj8rXfWGWICUUNtmt1rAOglPBb/
        hkHD5aS+9H2KJRxRqVKNsAqekQ==
X-Google-Smtp-Source: APXvYqy14zx0l6n0kwujuRSvhKN0ywYWUZBE1Lie8cRAB/oQYG7U0oBkYu543/IIvSUU4dmEaQWcQA==
X-Received: by 2002:a50:fc0a:: with SMTP id i10mr27003311edr.143.1555272917829;
        Sun, 14 Apr 2019 13:15:17 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id n21sm3383068edq.14.2019.04.14.13.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 13:15:17 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 4/4] samples: show race-free pidfd metadata access
Date:   Sun, 14 Apr 2019 22:14:36 +0200
Message-Id: <20190414201436.19502-5-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190414201436.19502-1-christian@brauner.io>
References: <20190414201436.19502-1-christian@brauner.io>
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
 samples/Makefile               |   2 +-
 samples/pidfd/Makefile         |   6 ++
 samples/pidfd/pidfd-metadata.c | 172 +++++++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+), 1 deletion(-)
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
index 000000000000..23a44e582ccb
--- /dev/null
+++ b/samples/pidfd/pidfd-metadata.c
@@ -0,0 +1,172 @@
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
+	unsigned long flags = CLONE_PIDFD | SIGCHLD;
+
+#if defined(__s390x__) || defined(__s390__) || defined(__CRIS__)
+	/*
+	 * On s390/s390x and cris the order of the first and second arguments
+	 * of the system call is reversed.
+	 */
+	return (int)syscall(__NR_clone, NULL, flags);
+#elif defined(__sparc__) && defined(__arch64__)
+	{
+		/*
+		 * sparc64 always returns the other process id in %o0, and a
+		 * boolean flag whether this is the child or the parent in %o1.
+		 * Inline assembly is needed to get the flag returned in %o1.
+		 */
+		int child_pid, in_child;
+
+		asm volatile("mov %2, %%g1\n\t"
+			     "mov %3, %%o0\n\t"
+			     "mov 0 , %%o1\n\t"
+			     "t 0x6d\n\t"
+			     "mov %%o1, %0\n\t"
+			     "mov %%o0, %1"
+			     : "=r"(in_child), "=r"(child_pid)
+			     : "i"(__NR_clone), "r"(flags)
+			     : "%o1", "%o0", "%g1");
+
+		if (in_child)
+			return 0;
+		else
+			return child_pid;
+	}
+#elif defined(__ia64__)
+	/* On ia64 stack and stack size are passed as separate arguments. */
+	return (int)syscall(__NR_clone, flags, NULL, 0UL);
+#else
+	return (int)syscall(__NR_clone, flags, NULL);
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
+	int pidfd, procfd, statusfd;
+	ssize_t bytes;
+
+	pidfd = raw_clone_pidfd();
+	if (pidfd < 0)
+		exit(ret);
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

