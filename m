Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7C9C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 18:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88152082F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 18:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmxM3dn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfGFSBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 14:01:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55105 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfGFSBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 14:01:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so8970581wme.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=ce9pDn+p0lzDUivArI5urMOJhwgxOz5qkkZMURB1rVg=;
        b=QmxM3dn7NmmIhD5l/Rsu1xf5XUCSHAl0wNbh/hJ7By3hE3zgZxktjsc+vfj1xquBz9
         C4Byia8t223WcOCOnDjyUw4fScBxfEfWmIvApfLi6tWrMSkrhV9tQDX8SaKi8fqj826r
         9nwQuw3VEEOfkhRZCwlrCEvQbiyddyooHM16Ujlq0yLoj/jErV1Tix+aOoZH4XKZy98n
         TVD0h4tlfUUz+8DHo2/KBPiFUFXn4agG0cKAsQnnETSCCGr5V2M9Ao7TGhcFjDd9NDZb
         dbt+9CnD3rpNe9pikHdKyBsWv/WJf5FNM18nT01gCMDaXE8AAqbY7oxwVtfDDN2+IOLs
         hp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=ce9pDn+p0lzDUivArI5urMOJhwgxOz5qkkZMURB1rVg=;
        b=NorcDXiSdIm4gV1oxWA7l7AnuAzqtqcAmTVIo+xlbPXXlwQcw7n1nk2xYOgtzQgvBk
         nkNm/nsdCjSkxY+JmEjHEtJezOfre/s+7cilrRk1nNkPSi/TeZ5IFYfZZuDX6T3FXs6j
         Jo/3+MukVeQeph7qS4ePsYf/UpiIB+l0GrxU5dBGYws7MIATeRa3LlDvUggG2puuQoH7
         P6fP1ytbEmKM+lUvx4J3hVi1AyqoQ7JF6IG6O0S7bZIUr7j+rHNKnNSXbB87tu1rrLCT
         mw1dFYfjhfql+aDw23QrH9EwmuJzCirIXMQbSaHuMQwOOBVJMapdkIfEg881eux+icQX
         tMBQ==
X-Gm-Message-State: APjAAAVGEvVgX67icyL2a8GCynGMmtTdJjO+2M8SOz03DyMoODDvHUu2
        pskPy3wJ0mNhTLtjY/EIvA==
X-Google-Smtp-Source: APXvYqwSu/TRQBlyOndVRYnD4OQeBDoDFsCHAPY4dJ0o7v0amHI0HMmAIPTy5hkMgkE8xwxOEFlwEw==
X-Received: by 2002:a1c:b457:: with SMTP id d84mr9284284wmf.153.1562436109192;
        Sat, 06 Jul 2019 11:01:49 -0700 (PDT)
Received: from avx2 ([46.53.252.147])
        by smtp.gmail.com with ESMTPSA id e7sm11406939wmd.0.2019.07.06.11.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 11:01:48 -0700 (PDT)
Date:   Sat, 6 Jul 2019 21:01:46 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: test /proc/sysvipc vs setns(CLONE_NEWIPC)
Message-ID: <20190706180146.GA21015@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I thought that /proc/sysvipc has the same bug as /proc/net

	commit 1fde6f21d90f8ba5da3cb9c54ca991ed72696c43
	proc: fix /proc/net/* after setns(2)

However, it doesn't! /proc/sysvipc files do

	get_ipc_ns(current->nsproxy->ipc_ns);

in their open() hook and avoid the problem.

Keep the test, maybe /proc/sysvipc will become broken someday :-\

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/.gitignore      |    1 
 tools/testing/selftests/proc/Makefile        |    1 
 tools/testing/selftests/proc/setns-sysvipc.c |  133 +++++++++++++++++++++++++++
 3 files changed, 135 insertions(+)

--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -12,4 +12,5 @@
 /read
 /self
 /setns-dcache
+/setns-sysvipc
 /thread-self
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -17,6 +17,7 @@ TEST_GEN_PROGS += proc-uptime-002
 TEST_GEN_PROGS += read
 TEST_GEN_PROGS += self
 TEST_GEN_PROGS += setns-dcache
+TEST_GEN_PROGS += setns-sysvipc
 TEST_GEN_PROGS += thread-self
 
 include ../lib.mk
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/setns-sysvipc.c
@@ -0,0 +1,133 @@
+/*
+ * Copyright © 2019 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+/*
+ * Test that setns(CLONE_NEWIPC) points to new /proc/sysvipc content even
+ * if old one is in dcache.
+ */
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+
+static pid_t pid = -1;
+
+static void f(void)
+{
+	if (pid > 0) {
+		kill(pid, SIGTERM);
+	}
+}
+
+int main(void)
+{
+	int fd[2];
+	char _ = 0;
+	int nsfd;
+
+	atexit(f);
+
+	/* Check for priviledges and syscall availability straight away. */
+	if (unshare(CLONE_NEWIPC) == -1) {
+		if (errno == ENOSYS || errno == EPERM) {
+			return 4;
+		}
+		return 1;
+	}
+	/* Distinguisher between two otherwise empty IPC namespaces. */
+	if (shmget(IPC_PRIVATE, 1, IPC_CREAT) == -1) {
+		return 1;
+	}
+
+	if (pipe(fd) == -1) {
+		return 1;
+	}
+
+	pid = fork();
+	if (pid == -1) {
+		return 1;
+	}
+
+	if (pid == 0) {
+		if (unshare(CLONE_NEWIPC) == -1) {
+			return 1;
+		}
+
+		if (write(fd[1], &_, 1) != 1) {
+			return 1;
+		}
+
+		pause();
+
+		return 0;
+	}
+
+	if (read(fd[0], &_, 1) != 1) {
+		return 1;
+	}
+
+	{
+		char buf[64];
+		snprintf(buf, sizeof(buf), "/proc/%u/ns/ipc", pid);
+		nsfd = open(buf, O_RDONLY);
+		if (nsfd == -1) {
+			return 1;
+		}
+	}
+
+	/* Reliably pin dentry into dcache. */
+	(void)open("/proc/sysvipc/shm", O_RDONLY);
+
+	if (setns(nsfd, CLONE_NEWIPC) == -1) {
+		return 1;
+	}
+
+	kill(pid, SIGTERM);
+	pid = 0;
+
+	{
+		char buf[4096];
+		ssize_t rv;
+		int fd;
+
+		fd = open("/proc/sysvipc/shm", O_RDONLY);
+		if (fd == -1) {
+			return 1;
+		}
+
+#define S32 "       key      shmid perms       size  cpid  lpid nattch   uid   gid  cuid  cgid      atime      dtime      ctime        rss       swap\n"
+#define S64 "       key      shmid perms                  size  cpid  lpid nattch   uid   gid  cuid  cgid      atime      dtime      ctime                   rss                  swap\n"
+		rv = read(fd, buf, sizeof(buf));
+		if (rv == strlen(S32)) {
+			assert(memcmp(buf, S32, strlen(S32)) == 0);
+		} else if (rv == strlen(S64)) {
+			assert(memcmp(buf, S64, strlen(S64)) == 0);
+		} else {
+			assert(0);
+		}
+	}
+
+	return 0;
+}
