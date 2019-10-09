Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7493AECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188C0206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20150623.gappssmtp.com header.i=@hev-cc.20150623.gappssmtp.com header.b="QJCnbxtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbfJIMPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:15:43 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44473 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbfJIMPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:15:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id 21so1487946otj.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 05:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DahaXN4cQ1Sbo1Fnn4k8yn7MVBwBOhf3xKC5pmRNsas=;
        b=QJCnbxtGpXyQhZG2w0JRsd72Ul0yrR8M9VdmzRo1Bmy3B5JbWRrLsT9waaeOkPoOKE
         oAxTUcBv+8+pKG+QZYznrVKl4vigaGOgeqcDgfJWQZ97VjfPzg5ouZitEtvMO5CCRVhk
         IQof4eWPONMyOMkSnoDbOcHGSO8WsmRf3f+/q4GUVpFky5Zv2Vd2c3km0ckYbxstrI/R
         57BCHLLy+aqNSLtAvE4blGwtYeBrYn/rVlEkdohHVA8lngODlKEkQBu8pCduzRbGf+JT
         K9autCkAqDj6VoqqvS2NqlpsA4lFwGVejn+cQvV1W1iv9+0TypeylpG5VbuiL54Xgb/Z
         9r8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DahaXN4cQ1Sbo1Fnn4k8yn7MVBwBOhf3xKC5pmRNsas=;
        b=cY3vaA/qvTLEMP0hqQE+8BOaoMOU965rlVcG++YzK+kzr7X9wP1aokMVYGZdaLrkdF
         4uF8vryEbIRVTOOdiZ2zChnnVGTqf3VdHIw8aWaKdUWZ0D6m6vkSmdo4EMpRP0FMpngl
         YodGx5z5/pdIfbZmzXM80iN+qfRUx5s2soLAYOWU2z1P9P5fXaeIjgxVX+yF5zqyKIUV
         kxVbJWIwg2TRe2+lWMCdekdiJPFWjh3XqXTXCPp2TH4Ay8VnWXVVp15X/+dOOOs4Asmg
         M2HtJSUA1c5hryxrQCbAGBIAVIxM5Qqtdo6mlU/IWcABG7ZahIpRigiF/D0YBij/6CZC
         s06A==
X-Gm-Message-State: APjAAAUlbfbAoZl1NEMwNRrN5QLy8rg3iL7VIldSQUZKd6P8Js2poHZr
        IFtEg0wBM5rnJIw0PNDy2CYDYChaNx9AUs0JDic=
X-Google-Smtp-Source: APXvYqydJyNboU+IJcUvlA1VXdSMpWIGIUJHtG7ry/v5j7mO9ZBREUWyFCO+c/kdRaFU+0QP2TrESg==
X-Received: by 2002:a9d:6c96:: with SMTP id c22mr2595180otr.194.1570623337953;
        Wed, 09 Oct 2019 05:15:37 -0700 (PDT)
Received: from hev-sbc.hz.ali.com ([47.89.83.40])
        by smtp.gmail.com with ESMTPSA id a69sm584269oib.14.2019.10.09.05.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 05:15:37 -0700 (PDT)
From:   hev <r@hev.cc>
To:     linux-fsdevel@vger.kernel.org
Cc:     Heiher <r@hev.cc>, Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Penyaev <rpenyaev@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: add epoll selftests
Date:   Wed,  9 Oct 2019 20:15:18 +0800
Message-Id: <20191009121518.4027-1-r@hev.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiher <r@hev.cc>

This adds the promised selftest for epoll. It will verify the wakeups
of epoll. Including leaf and nested mode, epoll_wait() and poll() and
multi-threads.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roman Penyaev <rpenyaev@suse.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: hev <r@hev.cc>
---
 tools/testing/selftests/Makefile              |    1 +
 .../selftests/filesystems/epoll/.gitignore    |    1 +
 .../selftests/filesystems/epoll/Makefile      |    7 +
 .../filesystems/epoll/epoll_wakeup_test.c     | 3074 +++++++++++++++++
 4 files changed, 3083 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/epoll/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/epoll/Makefile
 create mode 100644 tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9781ca79794a..57b91b0ac7cb 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -11,6 +11,7 @@ TARGETS += efivarfs
 TARGETS += exec
 TARGETS += filesystems
 TARGETS += filesystems/binderfs
+TARGETS += filesystems/epoll
 TARGETS += firmware
 TARGETS += ftrace
 TARGETS += futex
diff --git a/tools/testing/selftests/filesystems/epoll/.gitignore b/tools/testing/selftests/filesystems/epoll/.gitignore
new file mode 100644
index 000000000000..9ae8db44ec14
--- /dev/null
+++ b/tools/testing/selftests/filesystems/epoll/.gitignore
@@ -0,0 +1 @@
+epoll_wakeup_test
diff --git a/tools/testing/selftests/filesystems/epoll/Makefile b/tools/testing/selftests/filesystems/epoll/Makefile
new file mode 100644
index 000000000000..e62f3d4f68da
--- /dev/null
+++ b/tools/testing/selftests/filesystems/epoll/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -I../../../../../usr/include/
+LDFLAGS += -lpthread
+TEST_GEN_PROGS := epoll_wakeup_test
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
new file mode 100644
index 000000000000..37a04dab56f0
--- /dev/null
+++ b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
@@ -0,0 +1,3074 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <poll.h>
+#include <unistd.h>
+#include <signal.h>
+#include <pthread.h>
+#include <sys/epoll.h>
+#include <sys/socket.h>
+#include "../../kselftest_harness.h"
+
+struct epoll_mtcontext
+{
+	int efd[3];
+	int sfd[4];
+	int count;
+
+	pthread_t main;
+	pthread_t waiter;
+};
+
+static void signal_handler(int signum)
+{
+}
+
+static void kill_timeout(struct epoll_mtcontext *ctx)
+{
+	usleep(1000000);
+	pthread_kill(ctx->main, SIGUSR1);
+	pthread_kill(ctx->waiter, SIGUSR1);
+}
+
+static void *waiter_entry1a(void *data)
+{
+	struct epoll_event e;
+	struct epoll_mtcontext *ctx = data;
+
+	if (epoll_wait(ctx->efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx->count, 1);
+
+	return NULL;
+}
+
+static void *waiter_entry1ap(void *data)
+{
+	struct pollfd pfd;
+	struct epoll_event e;
+	struct epoll_mtcontext *ctx = data;
+
+	pfd.fd = ctx->efd[0];
+	pfd.events = POLLIN;
+	if (poll(&pfd, 1, -1) > 0) {
+		if (epoll_wait(ctx->efd[0], &e, 1, 0) > 0)
+			__sync_fetch_and_add(&ctx->count, 1);
+	}
+
+	return NULL;
+}
+
+static void *waiter_entry1o(void *data)
+{
+	struct epoll_event e;
+	struct epoll_mtcontext *ctx = data;
+
+	if (epoll_wait(ctx->efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_or(&ctx->count, 1);
+
+	return NULL;
+}
+
+static void *waiter_entry1op(void *data)
+{
+	struct pollfd pfd;
+	struct epoll_event e;
+	struct epoll_mtcontext *ctx = data;
+
+	pfd.fd = ctx->efd[0];
+	pfd.events = POLLIN;
+	if (poll(&pfd, 1, -1) > 0) {
+		if (epoll_wait(ctx->efd[0], &e, 1, 0) > 0)
+			__sync_fetch_and_or(&ctx->count, 1);
+	}
+
+	return NULL;
+}
+
+static void *waiter_entry2a(void *data)
+{
+	struct epoll_event events[2];
+	struct epoll_mtcontext *ctx = data;
+
+	if (epoll_wait(ctx->efd[0], events, 2, -1) > 0)
+		__sync_fetch_and_add(&ctx->count, 1);
+
+	return NULL;
+}
+
+static void *waiter_entry2ap(void *data)
+{
+	struct pollfd pfd;
+	struct epoll_event events[2];
+	struct epoll_mtcontext *ctx = data;
+
+	pfd.fd = ctx->efd[0];
+	pfd.events = POLLIN;
+	if (poll(&pfd, 1, -1) > 0) {
+		if (epoll_wait(ctx->efd[0], events, 2, 0) > 0)
+			__sync_fetch_and_add(&ctx->count, 1);
+	}
+
+	return NULL;
+}
+
+static void *emitter_entry1(void *data)
+{
+	struct epoll_mtcontext *ctx = data;
+
+	usleep(100000);
+	write(ctx->sfd[1], "w", 1);
+
+	kill_timeout(ctx);
+
+	return NULL;
+}
+
+static void *emitter_entry2(void *data)
+{
+	struct epoll_mtcontext *ctx = data;
+
+	usleep(100000);
+	write(ctx->sfd[1], "w", 1);
+	write(ctx->sfd[3], "w", 1);
+
+	kill_timeout(ctx);
+
+	return NULL;
+}
+
+/*
+ *          t0
+ *           | (ew)
+ *          e0
+ *           | (lt)
+ *          s0
+ */
+TEST(epoll1)
+{
+	int efd;
+	int sfd[2];
+	struct epoll_event e;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sfd), 0);
+
+	efd = epoll_create(1);
+	ASSERT_GE(efd, 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+
+	EXPECT_EQ(epoll_wait(efd, &e, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd, &e, 1, 0), 1);
+
+	close(efd);
+	close(sfd[0]);
+	close(sfd[1]);
+}
+
+/*
+ *          t0
+ *           | (ew)
+ *          e0
+ *           | (et)
+ *          s0
+ */
+TEST(epoll2)
+{
+	int efd;
+	int sfd[2];
+	struct epoll_event e;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sfd), 0);
+
+	efd = epoll_create(1);
+	ASSERT_GE(efd, 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+
+	EXPECT_EQ(epoll_wait(efd, &e, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd, &e, 1, 0), 0);
+
+	close(efd);
+	close(sfd[0]);
+	close(sfd[1]);
+}
+
+/*
+ *           t0
+ *            | (ew)
+ *           e0
+ *     (lt) /  \ (lt)
+ *        s0    s2
+ */
+TEST(epoll3)
+{
+	int efd;
+	int sfd[4];
+	struct epoll_event events[2];
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[2]), 0);
+
+	efd = epoll_create(1);
+	ASSERT_GE(efd, 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], events), 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd, EPOLL_CTL_ADD, sfd[2], events), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+	ASSERT_EQ(write(sfd[3], "w", 1), 1);
+
+	EXPECT_EQ(epoll_wait(efd, events, 2, 0), 2);
+	EXPECT_EQ(epoll_wait(efd, events, 2, 0), 2);
+
+	close(efd);
+	close(sfd[0]);
+	close(sfd[1]);
+	close(sfd[2]);
+	close(sfd[3]);
+}
+
+/*
+ *           t0
+ *            | (ew)
+ *           e0
+ *     (et) /  \ (et)
+ *        s0    s2
+ */
+TEST(epoll4)
+{
+	int efd;
+	int sfd[4];
+	struct epoll_event events[2];
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[2]), 0);
+
+	efd = epoll_create(1);
+	ASSERT_GE(efd, 0);
+
+	events[0].events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], events), 0);
+
+	events[0].events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd, EPOLL_CTL_ADD, sfd[2], events), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+	ASSERT_EQ(write(sfd[3], "w", 1), 1);
+
+	EXPECT_EQ(epoll_wait(efd, events, 2, 0), 2);
+	EXPECT_EQ(epoll_wait(efd, events, 2, 0), 0);
+
+	close(efd);
+	close(sfd[0]);
+	close(sfd[1]);
+	close(sfd[2]);
+	close(sfd[3]);
+}
+
+/*
+ *          t0
+ *           | (p)
+ *          e0
+ *           | (lt)
+ *          s0
+ */
+TEST(epoll5)
+{
+	int efd;
+	int sfd[2];
+	struct pollfd pfd;
+	struct epoll_event e;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[0]), 0);
+
+	efd = epoll_create(1);
+	ASSERT_GE(efd, 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+
+	pfd.fd = efd;
+	pfd.events = POLLIN;
+	ASSERT_EQ(poll(&pfd, 1, 0), 1);
+	ASSERT_EQ(epoll_wait(efd, &e, 1, 0), 1);
+
+	pfd.fd = efd;
+	pfd.events = POLLIN;
+	ASSERT_EQ(poll(&pfd, 1, 0), 1);
+	ASSERT_EQ(epoll_wait(efd, &e, 1, 0), 1);
+
+	close(efd);
+	close(sfd[0]);
+	close(sfd[1]);
+}
+
+/*
+ *          t0
+ *           | (p)
+ *          e0
+ *           | (et)
+ *          s0
+ */
+TEST(epoll6)
+{
+	int efd;
+	int sfd[2];
+	struct pollfd pfd;
+	struct epoll_event e;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[0]), 0);
+
+	efd = epoll_create(1);
+	ASSERT_GE(efd, 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+
+	pfd.fd = efd;
+	pfd.events = POLLIN;
+	ASSERT_EQ(poll(&pfd, 1, 0), 1);
+	ASSERT_EQ(epoll_wait(efd, &e, 1, 0), 1);
+
+	pfd.fd = efd;
+	pfd.events = POLLIN;
+	ASSERT_EQ(poll(&pfd, 1, 0), 0);
+	ASSERT_EQ(epoll_wait(efd, &e, 1, 0), 0);
+
+	close(efd);
+	close(sfd[0]);
+	close(sfd[1]);
+}
+
+/*
+ *           t0
+ *            | (p)
+ *           e0
+ *     (lt) /  \ (lt)
+ *        s0    s2
+ */
+
+TEST(epoll7)
+{
+	int efd;
+	int sfd[4];
+	struct pollfd pfd;
+	struct epoll_event events[2];
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[2]), 0);
+
+	efd = epoll_create(1);
+	ASSERT_GE(efd, 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], events), 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd, EPOLL_CTL_ADD, sfd[2], events), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+	ASSERT_EQ(write(sfd[3], "w", 1), 1);
+
+	pfd.fd = efd;
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd, events, 2, 0), 2);
+
+	pfd.fd = efd;
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd, events, 2, 0), 2);
+
+	close(efd);
+	close(sfd[0]);
+	close(sfd[1]);
+	close(sfd[2]);
+	close(sfd[3]);
+}
+
+/*
+ *           t0
+ *            | (p)
+ *           e0
+ *     (et) /  \ (et)
+ *        s0    s2
+ */
+TEST(epoll8)
+{
+	int efd;
+	int sfd[4];
+	struct pollfd pfd;
+	struct epoll_event events[2];
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[2]), 0);
+
+	efd = epoll_create(1);
+	ASSERT_GE(efd, 0);
+
+	events[0].events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], events), 0);
+
+	events[0].events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd, EPOLL_CTL_ADD, sfd[2], events), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+	ASSERT_EQ(write(sfd[3], "w", 1), 1);
+
+	pfd.fd = efd;
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd, events, 2, 0), 2);
+
+	pfd.fd = efd;
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 0);
+	EXPECT_EQ(epoll_wait(efd, events, 2, 0), 0);
+
+	close(efd);
+	close(sfd[0]);
+	close(sfd[1]);
+	close(sfd[2]);
+	close(sfd[3]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (ew)
+ *           e0
+ *            | (lt)
+ *           s0
+ */
+TEST(epoll9)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1a, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (ew)
+ *           e0
+ *            | (et)
+ *           s0
+ */
+TEST(epoll10)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1a, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 1);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (ew)
+ *           e0
+ *     (lt) /  \ (lt)
+ *        s0    s2
+ */
+TEST(epoll11)
+{
+	pthread_t emitter;
+	struct epoll_event events[2];
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[2]), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.sfd[0], events), 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.sfd[2], events), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry2a, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry2, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], events, 2, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+	close(ctx.sfd[2]);
+	close(ctx.sfd[3]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (ew)
+ *           e0
+ *     (et) /  \ (et)
+ *        s0    s2
+ */
+TEST(epoll12)
+{
+	pthread_t emitter;
+	struct epoll_event events[2];
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[2]), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	events[0].events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.sfd[0], events), 0);
+
+	events[0].events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.sfd[2], events), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1a, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry2, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], events, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+	close(ctx.sfd[2]);
+	close(ctx.sfd[3]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (p)
+ *           e0
+ *            | (lt)
+ *           s0
+ */
+TEST(epoll13)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1ap, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (p)
+ *           e0
+ *            | (et)
+ *           s0
+ */
+TEST(epoll14)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1ap, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 1);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (p)
+ *           e0
+ *     (lt) /  \ (lt)
+ *        s0    s2
+ */
+TEST(epoll15)
+{
+	pthread_t emitter;
+	struct epoll_event events[2];
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[2]), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.sfd[0], events), 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.sfd[2], events), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry2ap, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry2, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], events, 2, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+	close(ctx.sfd[2]);
+	close(ctx.sfd[3]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (p)
+ *           e0
+ *     (et) /  \ (et)
+ *        s0    s2
+ */
+TEST(epoll16)
+{
+	pthread_t emitter;
+	struct epoll_event events[2];
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[2]), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	events[0].events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.sfd[0], events), 0);
+
+	events[0].events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.sfd[2], events), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1ap, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry2, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], events, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+	close(ctx.sfd[2]);
+	close(ctx.sfd[3]);
+}
+
+/*
+ *          t0
+ *           | (ew)
+ *          e0
+ *           | (lt)
+ *          e1
+ *           | (lt)
+ *          s0
+ */
+TEST(epoll17)
+{
+	int efd[2];
+	int sfd[2];
+	struct epoll_event e;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sfd), 0);
+
+	efd[0] = epoll_create(1);
+	ASSERT_GE(efd[0], 0);
+
+	efd[1] = epoll_create(1);
+	ASSERT_GE(efd[1], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+
+	EXPECT_EQ(epoll_wait(efd[0], &e, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd[0], &e, 1, 0), 1);
+
+	close(efd[0]);
+	close(efd[1]);
+	close(sfd[0]);
+	close(sfd[1]);
+}
+
+/*
+ *          t0
+ *           | (ew)
+ *          e0
+ *           | (lt)
+ *          e1
+ *           | (et)
+ *          s0
+ */
+TEST(epoll18)
+{
+	int efd[2];
+	int sfd[2];
+	struct epoll_event e;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sfd), 0);
+
+	efd[0] = epoll_create(1);
+	ASSERT_GE(efd[0], 0);
+
+	efd[1] = epoll_create(1);
+	ASSERT_GE(efd[1], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+
+	EXPECT_EQ(epoll_wait(efd[0], &e, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd[0], &e, 1, 0), 1);
+
+	close(efd[0]);
+	close(efd[1]);
+	close(sfd[0]);
+	close(sfd[1]);
+}
+
+/*
+ *           t0
+ *            | (ew)
+ *           e0
+ *            | (et)
+ *           e1
+ *            | (lt)
+ *           s0
+ */
+TEST(epoll19)
+{
+	int efd[2];
+	int sfd[2];
+	struct epoll_event e;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sfd), 0);
+
+	efd[0] = epoll_create(1);
+	ASSERT_GE(efd[0], 0);
+
+	efd[1] = epoll_create(1);
+	ASSERT_GE(efd[1], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+
+	EXPECT_EQ(epoll_wait(efd[0], &e, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd[0], &e, 1, 0), 0);
+
+	close(efd[0]);
+	close(efd[1]);
+	close(sfd[0]);
+	close(sfd[1]);
+}
+
+/*
+ *           t0
+ *            | (ew)
+ *           e0
+ *            | (et)
+ *           e1
+ *            | (et)
+ *           s0
+ */
+TEST(epoll20)
+{
+	int efd[2];
+	int sfd[2];
+	struct epoll_event e;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sfd), 0);
+
+	efd[0] = epoll_create(1);
+	ASSERT_GE(efd[0], 0);
+
+	efd[1] = epoll_create(1);
+	ASSERT_GE(efd[1], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+
+	EXPECT_EQ(epoll_wait(efd[0], &e, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd[0], &e, 1, 0), 0);
+
+	close(efd[0]);
+	close(efd[1]);
+	close(sfd[0]);
+	close(sfd[1]);
+}
+
+/*
+ *          t0
+ *           | (p)
+ *          e0
+ *           | (lt)
+ *          e1
+ *           | (lt)
+ *          s0
+ */
+TEST(epoll21)
+{
+	int efd[2];
+	int sfd[2];
+	struct pollfd pfd;
+	struct epoll_event e;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sfd), 0);
+
+	efd[0] = epoll_create(1);
+	ASSERT_GE(efd[0], 0);
+
+	efd[1] = epoll_create(1);
+	ASSERT_GE(efd[1], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+
+	pfd.fd = efd[0];
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd[0], &e, 1, 0), 1);
+
+	pfd.fd = efd[0];
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd[0], &e, 1, 0), 1);
+
+	close(efd[0]);
+	close(efd[1]);
+	close(sfd[0]);
+	close(sfd[1]);
+}
+
+/*
+ *          t0
+ *           | (p)
+ *          e0
+ *           | (lt)
+ *          e1
+ *           | (et)
+ *          s0
+ */
+TEST(epoll22)
+{
+	int efd[2];
+	int sfd[2];
+	struct pollfd pfd;
+	struct epoll_event e;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sfd), 0);
+
+	efd[0] = epoll_create(1);
+	ASSERT_GE(efd[0], 0);
+
+	efd[1] = epoll_create(1);
+	ASSERT_GE(efd[1], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+
+	pfd.fd = efd[0];
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd[0], &e, 1, 0), 1);
+
+	pfd.fd = efd[0];
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd[0], &e, 1, 0), 1);
+
+	close(efd[0]);
+	close(efd[1]);
+	close(sfd[0]);
+	close(sfd[1]);
+}
+
+/*
+ *          t0
+ *           | (p)
+ *          e0
+ *           | (et)
+ *          e1
+ *           | (lt)
+ *          s0
+ */
+TEST(epoll23)
+{
+	int efd[2];
+	int sfd[2];
+	struct pollfd pfd;
+	struct epoll_event e;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sfd), 0);
+
+	efd[0] = epoll_create(1);
+	ASSERT_GE(efd[0], 0);
+
+	efd[1] = epoll_create(1);
+	ASSERT_GE(efd[1], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+
+	pfd.fd = efd[0];
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd[0], &e, 1, 0), 1);
+
+	pfd.fd = efd[0];
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 0);
+	EXPECT_EQ(epoll_wait(efd[0], &e, 1, 0), 0);
+
+	close(efd[0]);
+	close(efd[1]);
+	close(sfd[0]);
+	close(sfd[1]);
+}
+
+/*
+ *          t0
+ *           | (p)
+ *          e0
+ *           | (et)
+ *          e1
+ *           | (et)
+ *          s0
+ */
+TEST(epoll24)
+{
+	int efd[2];
+	int sfd[2];
+	struct pollfd pfd;
+	struct epoll_event e;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sfd), 0);
+
+	efd[0] = epoll_create(1);
+	ASSERT_GE(efd[0], 0);
+
+	efd[1] = epoll_create(1);
+	ASSERT_GE(efd[1], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+
+	pfd.fd = efd[0];
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd[0], &e, 1, 0), 1);
+
+	pfd.fd = efd[0];
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 0);
+	EXPECT_EQ(epoll_wait(efd[0], &e, 1, 0), 0);
+
+	close(efd[0]);
+	close(efd[1]);
+	close(sfd[0]);
+	close(sfd[1]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (ew)
+ *           e0
+ *            | (lt)
+ *           e1
+ *            | (lt)
+ *           s0
+ */
+TEST(epoll25)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1a, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (ew)
+ *           e0
+ *            | (lt)
+ *           e1
+ *            | (et)
+ *           s0
+ */
+TEST(epoll26)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1a, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (ew)
+ *           e0
+ *            | (et)
+ *           e1
+ *            | (lt)
+ *           s0
+ */
+TEST(epoll27)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1a, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 1);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (ew)
+ *           e0
+ *            | (et)
+ *           e1
+ *            | (et)
+ *           s0
+ */
+TEST(epoll28)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1a, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 1);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (p)
+ *           e0
+ *            | (lt)
+ *           e1
+ *            | (lt)
+ *           s0
+ */
+TEST(epoll29)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1ap, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (p)
+ *           e0
+ *            | (lt)
+ *           e1
+ *            | (et)
+ *           s0
+ */
+TEST(epoll30)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1ap, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (p)
+ *           e0
+ *            | (et)
+ *           e1
+ *            | (lt)
+ *           s0
+ */
+TEST(epoll31)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1ap, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 1);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (p)
+ *           e0
+ *            | (et)
+ *           e1
+ *            | (et)
+ *           s0
+ */
+TEST(epoll32)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1ap, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 1);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0   t1
+ *    (ew) |    | (ew)
+ *         |   e0
+ *          \  / (lt)
+ *           e1
+ *            | (lt)
+ *           s0
+ */
+TEST(epoll33)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1a, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[1], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0   t1
+ *    (ew) |    | (ew)
+ *         |   e0
+ *          \  / (lt)
+ *           e1
+ *            | (et)
+ *           s0
+ */
+TEST(epoll34)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1o, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[1], &e, 1, -1) > 0)
+		__sync_fetch_and_or(&ctx.count, 2);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_TRUE((ctx.count == 2) || (ctx.count == 3));
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0   t1
+ *    (ew) |    | (ew)
+ *         |   e0
+ *          \  / (et)
+ *           e1
+ *            | (lt)
+ *           s0
+ */
+TEST(epoll35)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1a, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[1], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0   t1
+ *    (ew) |    | (ew)
+ *         |   e0
+ *          \  / (et)
+ *           e1
+ *            | (et)
+ *           s0
+ */
+TEST(epoll36)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1o, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[1], &e, 1, -1) > 0)
+		__sync_fetch_and_or(&ctx.count, 2);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_TRUE((ctx.count == 2) || (ctx.count == 3));
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0   t1
+ *     (p) |    | (ew)
+ *         |   e0
+ *          \  / (lt)
+ *           e1
+ *            | (lt)
+ *           s0
+ */
+TEST(epoll37)
+{
+	pthread_t emitter;
+	struct pollfd pfd;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1a, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	pfd.fd = ctx.efd[1];
+	pfd.events = POLLIN;
+	if (poll(&pfd, 1, -1) > 0) {
+		if (epoll_wait(ctx.efd[1], &e, 1, 0) > 0)
+			__sync_fetch_and_add(&ctx.count, 1);
+	}
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0   t1
+ *     (p) |    | (ew)
+ *         |   e0
+ *          \  / (lt)
+ *           e1
+ *            | (et)
+ *           s0
+ */
+TEST(epoll38)
+{
+	pthread_t emitter;
+	struct pollfd pfd;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1o, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	pfd.fd = ctx.efd[1];
+	pfd.events = POLLIN;
+	if (poll(&pfd, 1, -1) > 0) {
+		if (epoll_wait(ctx.efd[1], &e, 1, 0) > 0)
+			__sync_fetch_and_or(&ctx.count, 2);
+	}
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_TRUE((ctx.count == 2) || (ctx.count == 3));
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0   t1
+ *     (p) |    | (ew)
+ *         |   e0
+ *          \  / (et)
+ *           e1
+ *            | (lt)
+ *           s0
+ */
+TEST(epoll39)
+{
+	pthread_t emitter;
+	struct pollfd pfd;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1a, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	pfd.fd = ctx.efd[1];
+	pfd.events = POLLIN;
+	if (poll(&pfd, 1, -1) > 0) {
+		if (epoll_wait(ctx.efd[1], &e, 1, 0) > 0)
+			__sync_fetch_and_add(&ctx.count, 1);
+	}
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0   t1
+ *     (p) |    | (ew)
+ *         |   e0
+ *          \  / (et)
+ *           e1
+ *            | (et)
+ *           s0
+ */
+TEST(epoll40)
+{
+	pthread_t emitter;
+	struct pollfd pfd;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1o, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	pfd.fd = ctx.efd[1];
+	pfd.events = POLLIN;
+	if (poll(&pfd, 1, -1) > 0) {
+		if (epoll_wait(ctx.efd[1], &e, 1, 0) > 0)
+			__sync_fetch_and_or(&ctx.count, 2);
+	}
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_TRUE((ctx.count == 2) || (ctx.count == 3));
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0   t1
+ *    (ew) |    | (p)
+ *         |   e0
+ *          \  / (lt)
+ *           e1
+ *            | (lt)
+ *           s0
+ */
+TEST(epoll41)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1ap, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[1], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0   t1
+ *    (ew) |    | (p)
+ *         |   e0
+ *          \  / (lt)
+ *           e1
+ *            | (et)
+ *           s0
+ */
+TEST(epoll42)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1op, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[1], &e, 1, -1) > 0)
+		__sync_fetch_and_or(&ctx.count, 2);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_TRUE((ctx.count == 2) || (ctx.count == 3));
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0   t1
+ *    (ew) |    | (p)
+ *         |   e0
+ *          \  / (et)
+ *           e1
+ *            | (lt)
+ *           s0
+ */
+TEST(epoll43)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1ap, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[1], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0   t1
+ *    (ew) |    | (p)
+ *         |   e0
+ *          \  / (et)
+ *           e1
+ *            | (et)
+ *           s0
+ */
+TEST(epoll44)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1op, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[1], &e, 1, -1) > 0)
+		__sync_fetch_and_or(&ctx.count, 2);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_TRUE((ctx.count == 2) || (ctx.count == 3));
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0   t1
+ *     (p) |    | (p)
+ *         |   e0
+ *          \  / (lt)
+ *           e1
+ *            | (lt)
+ *           s0
+ */
+TEST(epoll45)
+{
+	pthread_t emitter;
+	struct pollfd pfd;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1ap, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	pfd.fd = ctx.efd[1];
+	pfd.events = POLLIN;
+	if (poll(&pfd, 1, -1) > 0) {
+		if (epoll_wait(ctx.efd[1], &e, 1, 0) > 0)
+			__sync_fetch_and_add(&ctx.count, 1);
+	}
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0   t1
+ *     (p) |    | (p)
+ *         |   e0
+ *          \  / (lt)
+ *           e1
+ *            | (et)
+ *           s0
+ */
+TEST(epoll46)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1op, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[1], &e, 1, -1) > 0)
+		__sync_fetch_and_or(&ctx.count, 2);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_TRUE((ctx.count == 2) || (ctx.count == 3));
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0   t1
+ *     (p) |    | (p)
+ *         |   e0
+ *          \  / (et)
+ *           e1
+ *            | (lt)
+ *           s0
+ */
+TEST(epoll47)
+{
+	pthread_t emitter;
+	struct pollfd pfd;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1ap, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	pfd.fd = ctx.efd[1];
+	pfd.events = POLLIN;
+	if (poll(&pfd, 1, -1) > 0) {
+		if (epoll_wait(ctx.efd[1], &e, 1, 0) > 0)
+			__sync_fetch_and_add(&ctx.count, 1);
+	}
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *        t0   t1
+ *     (p) |    | (p)
+ *         |   e0
+ *          \  / (et)
+ *           e1
+ *            | (et)
+ *           s0
+ */
+TEST(epoll48)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1op, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry1, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[1], &e, 1, -1) > 0)
+		__sync_fetch_and_or(&ctx.count, 2);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_TRUE((ctx.count == 2) || (ctx.count == 3));
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
+/*
+ *           t0
+ *            | (ew)
+ *           e0
+ *     (lt) /  \ (lt)
+ *        e1    e2
+ *    (lt) |     | (lt)
+ *        s0    s2
+ */
+TEST(epoll49)
+{
+	int efd[3];
+	int sfd[4];
+	struct epoll_event events[2];
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[2]), 0);
+
+	efd[0] = epoll_create(1);
+	ASSERT_GE(efd[0], 0);
+
+	efd[1] = epoll_create(1);
+	ASSERT_GE(efd[1], 0);
+
+	efd[2] = epoll_create(1);
+	ASSERT_GE(efd[2], 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], events), 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[2], EPOLL_CTL_ADD, sfd[2], events), 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], events), 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[2], events), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+	ASSERT_EQ(write(sfd[3], "w", 1), 1);
+
+	EXPECT_EQ(epoll_wait(efd[0], events, 2, 0), 2);
+	EXPECT_EQ(epoll_wait(efd[0], events, 2, 0), 2);
+
+	close(efd[0]);
+	close(efd[1]);
+	close(efd[2]);
+	close(sfd[0]);
+	close(sfd[1]);
+	close(sfd[2]);
+	close(sfd[3]);
+}
+
+/*
+ *           t0
+ *            | (ew)
+ *           e0
+ *     (et) /  \ (et)
+ *        e1    e2
+ *    (lt) |     | (lt)
+ *        s0    s2
+ */
+TEST(epoll50)
+{
+	int efd[3];
+	int sfd[4];
+	struct epoll_event events[2];
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[2]), 0);
+
+	efd[0] = epoll_create(1);
+	ASSERT_GE(efd[0], 0);
+
+	efd[1] = epoll_create(1);
+	ASSERT_GE(efd[1], 0);
+
+	efd[2] = epoll_create(1);
+	ASSERT_GE(efd[2], 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], events), 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[2], EPOLL_CTL_ADD, sfd[2], events), 0);
+
+	events[0].events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], events), 0);
+
+	events[0].events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[2], events), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+	ASSERT_EQ(write(sfd[3], "w", 1), 1);
+
+	EXPECT_EQ(epoll_wait(efd[0], events, 2, 0), 2);
+	EXPECT_EQ(epoll_wait(efd[0], events, 2, 0), 0);
+
+	close(efd[0]);
+	close(efd[1]);
+	close(efd[2]);
+	close(sfd[0]);
+	close(sfd[1]);
+	close(sfd[2]);
+	close(sfd[3]);
+}
+
+/*
+ *           t0
+ *            | (p)
+ *           e0
+ *     (lt) /  \ (lt)
+ *        e1    e2
+ *    (lt) |     | (lt)
+ *        s0    s2
+ */
+TEST(epoll51)
+{
+	int efd[3];
+	int sfd[4];
+	struct pollfd pfd;
+	struct epoll_event events[2];
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[2]), 0);
+
+	efd[0] = epoll_create(1);
+	ASSERT_GE(efd[0], 0);
+
+	efd[1] = epoll_create(1);
+	ASSERT_GE(efd[1], 0);
+
+	efd[2] = epoll_create(1);
+	ASSERT_GE(efd[2], 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], events), 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[2], EPOLL_CTL_ADD, sfd[2], events), 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], events), 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[2], events), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+	ASSERT_EQ(write(sfd[3], "w", 1), 1);
+
+	pfd.fd = efd[0];
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd[0], events, 2, 0), 2);
+
+	pfd.fd = efd[0];
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd[0], events, 2, 0), 2);
+
+	close(efd[0]);
+	close(efd[1]);
+	close(efd[2]);
+	close(sfd[0]);
+	close(sfd[1]);
+	close(sfd[2]);
+	close(sfd[3]);
+}
+
+/*
+ *           t0
+ *            | (p)
+ *           e0
+ *     (et) /  \ (et)
+ *        e1    e2
+ *    (lt) |     | (lt)
+ *        s0    s2
+ */
+TEST(epoll52)
+{
+	int efd[3];
+	int sfd[4];
+	struct pollfd pfd;
+	struct epoll_event events[2];
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[2]), 0);
+
+	efd[0] = epoll_create(1);
+	ASSERT_GE(efd[0], 0);
+
+	efd[1] = epoll_create(1);
+	ASSERT_GE(efd[1], 0);
+
+	efd[2] = epoll_create(1);
+	ASSERT_GE(efd[2], 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], events), 0);
+
+	events[0].events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd[2], EPOLL_CTL_ADD, sfd[2], events), 0);
+
+	events[0].events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], events), 0);
+
+	events[0].events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[2], events), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+	ASSERT_EQ(write(sfd[3], "w", 1), 1);
+
+	pfd.fd = efd[0];
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 1);
+	EXPECT_EQ(epoll_wait(efd[0], events, 2, 0), 2);
+
+	pfd.fd = efd[0];
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 0);
+	EXPECT_EQ(epoll_wait(efd[0], events, 2, 0), 0);
+
+	close(efd[0]);
+	close(efd[1]);
+	close(efd[2]);
+	close(sfd[0]);
+	close(sfd[1]);
+	close(sfd[2]);
+	close(sfd[3]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (ew)
+ *           e0
+ *     (lt) /  \ (lt)
+ *        e1    e2
+ *    (lt) |     | (lt)
+ *        s0    s2
+ */
+TEST(epoll53)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[2]), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	ctx.efd[2] = epoll_create(1);
+	ASSERT_GE(ctx.efd[2], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[2], EPOLL_CTL_ADD, ctx.sfd[2], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[2], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1a, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry2, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.efd[2]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+	close(ctx.sfd[2]);
+	close(ctx.sfd[3]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (ew)
+ *           e0
+ *     (et) /  \ (et)
+ *        e1    e2
+ *    (lt) |     | (lt)
+ *        s0    s2
+ */
+TEST(epoll54)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[2]), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	ctx.efd[2] = epoll_create(1);
+	ASSERT_GE(ctx.efd[2], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[2], EPOLL_CTL_ADD, ctx.sfd[2], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[2], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1a, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry2, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.efd[2]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+	close(ctx.sfd[2]);
+	close(ctx.sfd[3]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (p)
+ *           e0
+ *     (lt) /  \ (lt)
+ *        e1    e2
+ *    (lt) |     | (lt)
+ *        s0    s2
+ */
+TEST(epoll55)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[2]), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	ctx.efd[2] = epoll_create(1);
+	ASSERT_GE(ctx.efd[2], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[2], EPOLL_CTL_ADD, ctx.sfd[2], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[2], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1ap, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry2, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.efd[2]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+	close(ctx.sfd[2]);
+	close(ctx.sfd[3]);
+}
+
+/*
+ *        t0    t1
+ *     (ew) \  / (p)
+ *           e0
+ *     (et) /  \ (et)
+ *        e1    e2
+ *    (lt) |     | (lt)
+ *        s0    s2
+ */
+TEST(epoll56)
+{
+	pthread_t emitter;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[2]), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	ctx.efd[2] = epoll_create(1);
+	ASSERT_GE(ctx.efd[2], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[2], EPOLL_CTL_ADD, ctx.sfd[2], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[2], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1ap, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry2, &ctx), 0);
+
+	if (epoll_wait(ctx.efd[0], &e, 1, -1) > 0)
+		__sync_fetch_and_add(&ctx.count, 1);
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.efd[2]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+	close(ctx.sfd[2]);
+	close(ctx.sfd[3]);
+}
+
+/*
+ *        t0    t1
+ *      (p) \  / (p)
+ *           e0
+ *     (lt) /  \ (lt)
+ *        e1    e2
+ *    (lt) |     | (lt)
+ *        s0    s2
+ */
+TEST(epoll57)
+{
+	pthread_t emitter;
+	struct pollfd pfd;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[2]), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	ctx.efd[2] = epoll_create(1);
+	ASSERT_GE(ctx.efd[2], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[2], EPOLL_CTL_ADD, ctx.sfd[2], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[2], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1ap, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry2, &ctx), 0);
+
+	pfd.fd = ctx.efd[0];
+	pfd.events = POLLIN;
+	if (poll(&pfd, 1, -1) > 0) {
+		if (epoll_wait(ctx.efd[0], &e, 1, 0) > 0)
+			__sync_fetch_and_add(&ctx.count, 1);
+	}
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.efd[2]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+	close(ctx.sfd[2]);
+	close(ctx.sfd[3]);
+}
+
+/*
+ *        t0    t1
+ *      (p) \  / (p)
+ *           e0
+ *     (et) /  \ (et)
+ *        e1    e2
+ *    (lt) |     | (lt)
+ *        s0    s2
+ */
+TEST(epoll58)
+{
+	pthread_t emitter;
+	struct pollfd pfd;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &ctx.sfd[2]), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.efd[1] = epoll_create(1);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	ctx.efd[2] = epoll_create(1);
+	ASSERT_GE(ctx.efd[2], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[1], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[2], EPOLL_CTL_ADD, ctx.sfd[2], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &e), 0);
+
+	e.events = EPOLLIN | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[2], &e), 0);
+
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&ctx.waiter, NULL, waiter_entry1ap, &ctx), 0);
+	ASSERT_EQ(pthread_create(&emitter, NULL, emitter_entry2, &ctx), 0);
+
+	pfd.fd = ctx.efd[0];
+	pfd.events = POLLIN;
+	if (poll(&pfd, 1, -1) > 0) {
+		if (epoll_wait(ctx.efd[0], &e, 1, 0) > 0)
+			__sync_fetch_and_add(&ctx.count, 1);
+	}
+
+	ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
+	EXPECT_EQ(ctx.count, 2);
+
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+	close(ctx.efd[2]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+	close(ctx.sfd[2]);
+	close(ctx.sfd[3]);
+}
+
+TEST_HARNESS_MAIN
-- 
2.23.0

