Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FD2C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7827206D3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="DmYJXSqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfLIHGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 02:06:54 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43845 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfLIHGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 02:06:53 -0500
Received: by mail-io1-f65.google.com with SMTP id s2so13596524iog.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 23:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yIxXYG1YTWqah7KHNRVeSjqJgD6uhzEhEyRg4kk5RV8=;
        b=DmYJXSqoXIPZuTIXFp8vraozHx7BwI0R2pioNaaS278xlAiCJOGNC1W8GSHTyOai4i
         NefzvQyXwmeQCIwPo8vkLyBBJADfJye02qR5gSicDw60lfTlpOA6ZoIBHzy8TDN2hbmt
         3IYOG0e9+e5WXoImrYVcDkfzezP6KYj/QSBc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yIxXYG1YTWqah7KHNRVeSjqJgD6uhzEhEyRg4kk5RV8=;
        b=RlFTCd/E9pj1dftrc4lfiPlwcsVqxac93nCQRaOJ0N2paHY4xMOttO4Ov3NpuZWj8B
         6pKfupV8Yip60GsUAUugMVMstGkTtZmlfh0Q9jMDLZnAGb61sh6EGWyqFlfMhyWB8dIK
         uCw9Dy+hOPQk5xh8/+CsnteqITOTwM2vsuediHCMhHtLXmlSGBTU/5hPtI6EDdnbRcE5
         kDCw+rwpUhD0dp+ebEevNpIlqoTwt4sJpqcVVfPxJyox2+0X/rnpYjHSzaL9SVrP16Dj
         thP5Xcs3MLNB+p2Bue1luy1MIE5MpYztnEeZMiE7gtscBpa2uApw6L8pyi7QnWFdPL/B
         mD/Q==
X-Gm-Message-State: APjAAAV717BLEL2CieHB+ig9kyMevLClGU8+Rfg8CzCI4zuYTKlhKcW/
        Ixu0C3WJBFwMqfUyJmMSrLbSBrKGAC/GZw==
X-Google-Smtp-Source: APXvYqyNz9gr9z8RBM1I8ttENofoW7KGGplVpf7ZnnsDxfp3uZFvu65tigRIs7Pq5n5ydDX0OV3SQA==
X-Received: by 2002:a02:cdd9:: with SMTP id m25mr25419197jap.123.1575875211378;
        Sun, 08 Dec 2019 23:06:51 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id y11sm6519521ilp.46.2019.12.08.23.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Dec 2019 23:06:51 -0800 (PST)
Date:   Mon, 9 Dec 2019 07:06:49 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2 4/4] samples: Add example of using PTRACE_GETFD in
 conjunction with user trap
Message-ID: <20191209070646.GA32477@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sample adds the usage of SECCOMP_RET_USER_NOTIF together with ptrace
PTRACE_GETFD. It shows trapping a syscall, and handling it by extracting
the FD into the parent process without stopping the child process.
Although, in this example, there's no explicit policy separation in
the two processes, it can be generalized into the example of a transparent
proxy.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 samples/seccomp/.gitignore         |   1 +
 samples/seccomp/Makefile           |   9 +-
 samples/seccomp/user-trap-ptrace.c | 193 +++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 samples/seccomp/user-trap-ptrace.c

diff --git a/samples/seccomp/.gitignore b/samples/seccomp/.gitignore
index d1e2e817d556..169bc130ec39 100644
--- a/samples/seccomp/.gitignore
+++ b/samples/seccomp/.gitignore
@@ -2,3 +2,4 @@ bpf-direct
 bpf-fancy
 dropper
 user-trap
+user-trap-ptrace
diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index 82b7347318d1..c0f3ef713f5b 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 ifndef CROSS_COMPILE
-hostprogs-y := bpf-fancy dropper bpf-direct user-trap
+hostprogs-y := bpf-fancy dropper bpf-direct user-trap user-trap-ptrace
 
 HOSTCFLAGS_bpf-fancy.o += -I$(objtree)/usr/include
 HOSTCFLAGS_bpf-fancy.o += -idirafter $(objtree)/include
@@ -24,6 +24,11 @@ HOSTCFLAGS_user-trap.o += -I$(objtree)/usr/include
 HOSTCFLAGS_user-trap.o += -idirafter $(objtree)/include
 user-trap-objs := user-trap.o user-trap-helper.o
 
+HOSTCFLAGS_user-trap-ptrace.o += -I$(objtree)/usr/include
+HOSTCFLAGS_user-trap-ptrace.o += -idirafter $(objtree)/include
+user-trap-ptrace-objs := user-trap-ptrace.o user-trap-helper.o
+
+
 # Try to match the kernel target.
 ifndef CONFIG_64BIT
 
@@ -39,10 +44,12 @@ HOSTCFLAGS_dropper.o += $(MFLAG)
 HOSTCFLAGS_bpf-helper.o += $(MFLAG)
 HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
 HOSTCFLAGS_user-trap.o += $(MFLAG)
+HOSTCFLAGS_user-trap-ptrace.o += $(MFLAG)
 HOSTLDLIBS_bpf-direct += $(MFLAG)
 HOSTLDLIBS_bpf-fancy += $(MFLAG)
 HOSTLDLIBS_dropper += $(MFLAG)
 HOSTLDLIBS_user-trap += $(MFLAG)
+HOSTLDLIBS_user-trap-ptrace += $(MFLAG)
 endif
 always := $(hostprogs-y)
 endif
diff --git a/samples/seccomp/user-trap-ptrace.c b/samples/seccomp/user-trap-ptrace.c
new file mode 100644
index 000000000000..5cca1cb4916c
--- /dev/null
+++ b/samples/seccomp/user-trap-ptrace.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/seccomp.h>
+#include <linux/ptrace.h>
+#include <linux/prctl.h>
+#include <sys/socket.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/ioctl.h>
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <netinet/in.h>
+#include "user-trap-helper.h"
+
+#define CHILD_PORT_TRY_BIND	80
+#define CHILD_PORT_ACTUAL_BIND	4998
+
+static int ptrace(long request, long pid, void *addr, unsigned long data)
+{
+	errno = 0;
+	return syscall(__NR_ptrace, request, pid, addr, data);
+}
+
+static int ptrace_getfd(long pid, struct ptrace_getfd_args *args)
+{
+	errno = 0;
+	return syscall(__NR_ptrace, PTRACE_GETFD, pid, sizeof(*args), args);
+}
+
+static int tracee(void)
+{
+	struct sockaddr_in addr = {
+		.sin_family	= AF_INET,
+		.sin_port	= htons(CHILD_PORT_TRY_BIND),
+		.sin_addr	= {
+			.s_addr	= htonl(INADDR_ANY)
+		}
+	};
+	socklen_t addrlen = sizeof(addr);
+	int sock, ret = 1;
+
+	sock = socket(AF_INET, SOCK_STREAM, 0);
+	if (sock == -1) {
+		perror("socket");
+		goto out;
+	}
+
+
+	if (bind(sock, (struct sockaddr *) &addr, sizeof(addr))) {
+		perror("bind");
+		goto out;
+	}
+
+	printf("Child successfully performed bind operation\n");
+	if (getsockname(sock, (struct sockaddr *) &addr, &addrlen)) {
+		perror("getsockname");
+		goto out;
+	}
+
+
+	printf("Socket bound to port %d\n", ntohs(addr.sin_port));
+	assert(ntohs(addr.sin_port) == CHILD_PORT_ACTUAL_BIND);
+
+	ret = 0;
+out:
+	return ret;
+}
+
+static int handle_req(int listener)
+{
+	struct sockaddr_in addr = {
+		.sin_family	= AF_INET,
+		.sin_port	= htons(4998),
+		.sin_addr	= {
+			.s_addr	= htonl(INADDR_LOOPBACK)
+		}
+	};
+	struct ptrace_getfd_args getfd_args = {
+		.options = PTRACE_GETFD_O_CLOEXEC
+	};
+	struct seccomp_notif_sizes sizes;
+	struct seccomp_notif_resp *resp;
+	struct seccomp_notif *req;
+	int fd, ret = 1;
+
+	if (seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes) < 0) {
+		perror("seccomp(GET_NOTIF_SIZES)");
+		goto out;
+	}
+	req = malloc(sizes.seccomp_notif);
+	if (!req)
+		goto out;
+	memset(req, 0, sizeof(*req));
+
+	resp = malloc(sizes.seccomp_notif_resp);
+	if (!resp)
+		goto out_free_req;
+	memset(resp, 0, sizeof(*resp));
+
+	if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, req)) {
+		perror("ioctl recv");
+		goto out;
+	}
+	printf("Child tried to call bind with fd: %lld\n", req->data.args[0]);
+	getfd_args.fd = req->data.args[0];
+	fd = ptrace_getfd(req->pid, &getfd_args);
+	if (fd == -1) {
+		perror("ptrace_getfd");
+		goto out_free_resp;
+	}
+	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr))) {
+		perror("bind");
+		goto out_free_resp;
+	}
+
+	resp->id = req->id;
+	resp->error = 0;
+	resp->val = 0;
+	if (ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, resp) < 0) {
+		perror("ioctl send");
+		goto out_free_resp;
+	}
+
+	ret = 0;
+out_free_resp:
+	free(resp);
+out_free_req:
+	free(req);
+out:
+	return ret;
+}
+
+int main(void)
+{
+	int listener, sk_pair[2], ret = 1;
+	pid_t pid;
+
+	if (socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair) < 0) {
+		perror("socketpair");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		perror("fork");
+		goto close_pair;
+	}
+	if (pid == 0) {
+		if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+			perror("prctl(NO_NEW_PRIVS)");
+			exit(1);
+		}
+		listener = user_trap_syscall(__NR_bind,
+					     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+		if (listener < 0) {
+			perror("seccomp");
+			exit(1);
+		}
+		if (send_fd(sk_pair[1], listener) < 0)
+			exit(1);
+		close(listener);
+		exit(tracee());
+	}
+
+	if (ptrace(PTRACE_SEIZE, pid, 0, PTRACE_O_EXITKILL)) {
+		perror("ptrace(PTRACE_SEIZE)");
+		goto kill_child;
+	}
+
+	listener = recv_fd(sk_pair[0]);
+	if (listener < 0)
+		goto kill_child;
+
+	if (handle_req(listener))
+		goto kill_child;
+
+	/* Wait for child to finish */
+	waitpid(pid, NULL, 0);
+
+	ret = 0;
+	goto close_pair;
+
+kill_child:
+	kill(pid, SIGKILL);
+close_pair:
+	close(sk_pair[0]);
+	close(sk_pair[1]);
+out:
+	return ret;
+}
-- 
2.20.1

