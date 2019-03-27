Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1A1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39BE21738
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Hn3r/SP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfC0WTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:19:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36076 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfC0WTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:19:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id s16so6246610edr.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IK42H6HQ0aFhFj9k727vVqGkwfqt5bO/uER0OppDz8s=;
        b=Hn3r/SP1cVMkTsOy9qCpl8djr+zEeUmkFdrapgP4DdTiTP1X7DAs1hFJGH73bJWEAr
         oj5QEG8eqr/YDI5DmlFuIJKdqx5Gi+cDBhbVVrwMpm9EeHxqxvcj1JCDUc5P7q3iXCJM
         z2+fmc86OaL2IlhCxDSkO+lm9dOVITpcGBJE8rjSq2tZaGC+BN8Jldqt9qDfxcrAzRXR
         AJqKnCECQzYNwYK3eDARy0nmOtiIrW1hTzj1zkOLOH1Ukj5Md9Cyh02/3FQNVw+pJ0Vj
         tqXLLVm462NjLFaHIZ5VyWBLKd4Zk7DVe1wDaYYixAxPQDBLflW+Hsis2EqvRpENqNSy
         Btew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IK42H6HQ0aFhFj9k727vVqGkwfqt5bO/uER0OppDz8s=;
        b=P7o2rJBaXz3ci7H82JbVhU0P+5F7ADJhq0vtx8VUnkkL2wGYdrsJZZWGCt8ER/6WdN
         lVxjzcq9Zh1a6yawKSKqybo3sMxVYW6ZkLGgIxaw7aSfGvvvnVqT0jAOSulB1QpmyS1N
         IsamSg7c/k9G8E0B7T0fyBwpkBZPn7X3PHC66qy10TGB8e0MffD6LdchtUTgWdCQ+kgI
         KwJMaE4g6I4BNTDcXX0grzMH6A/I/COALjJeYczycg3DnyibgVUnKjwka9r8wWE9YYXW
         +1xaPTHG5Dza4dyHYv4RtnfT/TJg+ukwkyGEML+h2dW/e5BGak3ma+182YT9vx6/JPb7
         kOeQ==
X-Gm-Message-State: APjAAAUcRFdQMSxxhnToAAMfU+9e35/ZSlNHJxZUM8szGv+a9ZH4S/QW
        fj6UwML1Qrt0c/CFmxrb207pSQ==
X-Google-Smtp-Source: APXvYqwZZA6NKxzl9Zf1ng1MA8txumQTybsuiEMtFlxMILHQwUhdNenEZijoWwdfUfV20B+VEu+BWw==
X-Received: by 2002:a17:906:3941:: with SMTP id g1mr6986098eje.168.1553725185970;
        Wed, 27 Mar 2019 15:19:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id l20sm1878067ejb.30.2019.03.27.15.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 15:19:45 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jannh@google.com, khlebnikov@yandex-team.ru, luto@kernel.org,
        dhowells@redhat.com, serge@hallyn.com, ebiederm@xmission.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, keescook@chromium.org, adobriyan@gmail.com,
        tglx@linutronix.de, mtk.manpages@gmail.com, bl0pbl33p@gmail.com,
        ldv@altlinux.org, akpm@linux-foundation.org, oleg@redhat.com,
        nagarathnam.muthusamy@oracle.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 4/4] tests: add pidfd_open() tests
Date:   Wed, 27 Mar 2019 23:19:10 +0100
Message-Id: <20190327221910.5897-5-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327221910.5897-1-christian@brauner.io>
References: <20190327221910.5897-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a simple test case for pidfd_open().

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jann Horn <jannh@google.com
Cc: David Howells <dhowells@redhat.com>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 tools/testing/selftests/pidfd/Makefile        |   2 +-
 .../testing/selftests/pidfd/pidfd_open_test.c | 201 ++++++++++++++++++
 2 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_open_test.c

diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index deaf8073bc06..b36c0be70848 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,6 +1,6 @@
 CFLAGS += -g -I../../../../usr/include/
 
-TEST_GEN_PROGS := pidfd_test
+TEST_GEN_PROGS := pidfd_test pidfd_open_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
new file mode 100644
index 000000000000..07a262a9ef2c
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/mount.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+
+static inline int sys_pidfd_open(pid_t pid, int procfd, int pidfd,
+				 unsigned int flags)
+{
+	return syscall(__NR_pidfd_open, pid, procfd, pidfd, flags);
+}
+
+static int safe_int(const char *numstr, int *converted)
+{
+	char *err = NULL;
+	signed long int sli;
+
+	errno = 0;
+	sli = strtol(numstr, &err, 0);
+	if (errno == ERANGE && (sli == LONG_MAX || sli == LONG_MIN))
+		return -ERANGE;
+
+	if (errno != 0 && sli == 0)
+		return -EINVAL;
+
+	if (err == numstr || *err != '\0')
+		return -EINVAL;
+
+	if (sli > INT_MAX || sli < INT_MIN)
+		return -ERANGE;
+
+	*converted = (int)sli;
+	return 0;
+}
+
+static int char_left_gc(const char *buffer, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (buffer[i] == ' ' ||
+		    buffer[i] == '\t')
+			continue;
+
+		return i;
+	}
+
+	return 0;
+}
+
+static int char_right_gc(const char *buffer, size_t len)
+{
+	int i;
+
+	for (i = len - 1; i >= 0; i--) {
+		if (buffer[i] == ' '  ||
+		    buffer[i] == '\t' ||
+		    buffer[i] == '\n' ||
+		    buffer[i] == '\0')
+			continue;
+
+		return i + 1;
+	}
+
+	return 0;
+}
+
+static char *trim_whitespace_in_place(char *buffer)
+{
+	buffer += char_left_gc(buffer, strlen(buffer));
+	buffer[char_right_gc(buffer, strlen(buffer))] = '\0';
+	return buffer;
+}
+
+static pid_t get_pid_from_status_file(int *fd)
+{
+	int ret;
+	FILE *f;
+	size_t n = 0;
+	pid_t result = -1;
+	char *line = NULL;
+
+	/* fd now belongs to FILE and will be closed by fclose() */
+	f = fdopen(*fd, "r");
+	if (!f)
+		return -1;
+
+	while (getline(&line, &n, f) != -1) {
+		char *numstr;
+
+		if (strncmp(line, "Pid:", 4))
+			continue;
+
+		numstr = trim_whitespace_in_place(line + 4);
+		ret = safe_int(numstr, &result);
+		if (ret < 0)
+			goto out;
+
+		break;
+	}
+
+out:
+	free(line);
+	fclose(f);
+	*fd = -1;
+	return result;
+}
+
+int main(int argc, char **argv)
+{
+	int ret = 1;
+	int pidfd = -1, pidfd2 = -1, procfd = -1, procpidfd = -1, statusfd = -1;
+	pid_t pid;
+
+	pidfd = sys_pidfd_open(getpid(), -1, -1, 0);
+	if (pidfd < 0) {
+		ksft_print_msg("%s - failed to open pidfd\n", strerror(errno));
+		goto on_error;
+	}
+
+	procfd = open("/proc", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
+	if (procfd < 0) {
+		ksft_print_msg("%s - failed to open /proc\n", strerror(errno));
+		goto on_error;
+	}
+
+	procpidfd = sys_pidfd_open(-1, procfd, pidfd, PIDFD_TO_PROCFD);
+	if (procpidfd < 0) {
+		ksft_print_msg(
+			"%s - failed to retrieve /proc/<pid> from pidfd\n",
+			strerror(errno));
+		goto on_error;
+	}
+
+	pidfd2 = sys_pidfd_open(-1, procpidfd, -1, PROCFD_TO_PIDFD);
+	if (pidfd2 < 0) {
+		ksft_print_msg(
+			"%s - failed to retrieve  pidfd from procpidfd\n",
+			strerror(errno));
+		goto on_error;
+	}
+
+	statusfd = openat(procpidfd, "status", O_CLOEXEC | O_RDONLY);
+	if (statusfd < 0) {
+		ksft_print_msg("%s - failed to open /proc/<pid>/status\n",
+			       strerror(errno));
+		goto on_error;
+	}
+
+	pid = get_pid_from_status_file(&statusfd);
+	if (pid < 0) {
+		ksft_print_msg(
+			"%s - failed to retrieve pid from /proc/<pid>/status\n",
+			strerror(errno));
+		goto on_error;
+	}
+
+	if (pid != getpid()) {
+		ksft_print_msg(
+			"%s - actual pid %d does not equal retrieved pid from /proc/<pid>/status\n",
+			strerror(errno), pid, getpid());
+		goto on_error;
+	}
+
+	ret = 0;
+
+on_error:
+	if (pidfd >= 0)
+		close(pidfd);
+
+	if (pidfd2 >= 0)
+		close(pidfd2);
+
+	if (procfd >= 0)
+		close(procfd);
+
+	if (procpidfd >= 0)
+		close(procpidfd);
+
+	if (statusfd >= 0)
+		close(statusfd);
+
+	return !ret ? ksft_exit_pass() : ksft_exit_fail();
+}
-- 
2.21.0

