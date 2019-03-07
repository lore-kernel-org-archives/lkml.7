Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0364C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A447D20854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObxM7CY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfCGScL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:32:11 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:54047 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfCGScI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:32:08 -0500
Received: by mail-wm1-f47.google.com with SMTP id e74so10256774wmg.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jvy+OOS4kVV1FObMMotQGR6YBIJ1JmI7LOHdrPjzg1I=;
        b=ObxM7CY8qZeXS8gUA1YtcWKJHYRKFty4ykbt/osQ1+B6+dGiXa+TcC1YqzgjB9RQU8
         yVdwrSdhqfgpMBZrFw4D0xJZa45hCNLJHPf0D+kYq4HTmbAmFpL5iarGO1JHUZPn1udV
         Q6Uq1MV6/2aQ//r/kb4gDhUtCnRiDPE65DMqMm3+/kB3pnQ6n7HaXkhF6koBveR+MlIH
         dpdsE1iNLxiLtaOFfu9rCnz+M6bwNplOFeIqu+mldStaFj8hC1ofSNaAu6IkfsdNqjTA
         2K/GJacUBliDCaMatjsXRLjn4U2CHTrD7g8GfZP3LKjyk98T3uSdwRKVfhfr7pq+2Vtc
         ZWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jvy+OOS4kVV1FObMMotQGR6YBIJ1JmI7LOHdrPjzg1I=;
        b=jXQRbrguWuTwKvkjZrbJbc+q47dk87oFDyGTAZhvNTT3zmiY37+LNcDzjR+fUqheNI
         gYwIgRJpIpETyfGzAfqSgL8EfMbXOE5Eazes+xXuiHq/sw+fyCB1QBr5Se2J14g88+f0
         Q7E2WMVi842qMYkudQaMoGjPisFq3sBfbezVzBK62r+oMcXsI4nCpYZzz6hwg9gT3I0c
         +uG1B0JHufMOZ/KqpetDYtZG9V5OC+OpsiBi60y0e4YAosYs8X0wgWTMy8aSFsRUQ26c
         kE3cZTCC5UjCsUs4IyTZ3E4mt5tDpj+Sg20Aq7gm5texlhgsCCqs+ij15IhfMVhguga4
         1hiw==
X-Gm-Message-State: APjAAAWeqd/dn2u7Mkkpy+veiJZGBgT8LLKs7RQcp7f9QAtWCLCdyqkH
        X7oSxgkzfeDlLpEy8LNaFg==
X-Google-Smtp-Source: APXvYqwng+B3U2epudmRS5OTITvBGHchZAtuTO/9tBsy7mV+rxSacD7v/s/kIxppQeh2ss0dJxZkYA==
X-Received: by 2002:a1c:9c04:: with SMTP id f4mr6592866wme.149.1551983526869;
        Thu, 07 Mar 2019 10:32:06 -0800 (PST)
Received: from avx2 ([46.53.242.20])
        by smtp.gmail.com with ESMTPSA id i62sm7050950wmg.17.2019.03.07.10.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 10:32:06 -0800 (PST)
Date:   Thu, 7 Mar 2019 21:32:04 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rong.a.chen@intel.com
Subject: [PATCH] proc: test with vsyscall in mind
Message-ID: <20190307183204.GA11405@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read from vsyscall page to tell if vsyscall is being used.

Reported-by: kernel test robot
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/proc-pid-vm.c |   49 +++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include <sched.h>
 #include <signal.h>
+#include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <string.h>
@@ -36,11 +37,14 @@
 #include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/wait.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/uio.h>
 #include <linux/kdev_t.h>
+#include <sys/time.h>
+#include <sys/resource.h>
 
 static inline long sys_execveat(int dirfd, const char *pathname, char **argv, char **envp, int flags)
 {
@@ -205,12 +209,44 @@ static int make_exe(const uint8_t *payload, size_t len)
 }
 #endif
 
+static bool g_vsyscall = false;
+
+static const char str_vsyscall[] =
+"ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
+
 #ifdef __x86_64__
+/*
+ * vsyscall page can't be unmapped, probe it with memory load.
+ */
+static void vsyscall(void)
+{
+	pid_t pid;
+	int wstatus;
+
+	pid = fork();
+	if (pid < 0) {
+		fprintf(stderr, "fork, errno %d\n", errno);
+		exit(1);
+	}
+	if (pid == 0) {
+		struct rlimit rlim = {0, 0};
+		(void)setrlimit(RLIMIT_CORE, &rlim);
+		*(volatile int *)0xffffffffff600000UL;
+		exit(0);
+	}
+	wait(&wstatus);
+	if (WIFEXITED(wstatus)) {
+		g_vsyscall = true;
+	}
+}
+
 int main(void)
 {
 	int pipefd[2];
 	int exec_fd;
 
+	vsyscall();
+
 	atexit(ate);
 
 	make_private_tmp();
@@ -261,9 +297,9 @@ int main(void)
 	snprintf(buf0 + MAPS_OFFSET, sizeof(buf0) - MAPS_OFFSET,
 		 "/tmp/#%llu (deleted)\n", (unsigned long long)st.st_ino);
 
-
 	/* Test /proc/$PID/maps */
 	{
+		const size_t len = strlen(buf0) + (g_vsyscall ? strlen(str_vsyscall) : 0);
 		char buf[256];
 		ssize_t rv;
 		int fd;
@@ -274,13 +310,16 @@ int main(void)
 			return 1;
 		}
 		rv = read(fd, buf, sizeof(buf));
-		assert(rv == strlen(buf0));
+		assert(rv == len);
 		assert(memcmp(buf, buf0, strlen(buf0)) == 0);
+		if (g_vsyscall) {
+			assert(memcmp(buf + strlen(buf0), str_vsyscall, strlen(str_vsyscall)) == 0);
+		}
 	}
 
 	/* Test /proc/$PID/smaps */
 	{
-		char buf[1024];
+		char buf[4096];
 		ssize_t rv;
 		int fd;
 
@@ -319,6 +358,10 @@ int main(void)
 		for (i = 0; i < sizeof(S)/sizeof(S[0]); i++) {
 			assert(memmem(buf, rv, S[i], strlen(S[i])));
 		}
+
+		if (g_vsyscall) {
+			assert(memmem(buf, rv, str_vsyscall, strlen(str_vsyscall)));
+		}
 	}
 
 	/* Test /proc/$PID/smaps_rollup */
