Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAA1C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AA42075C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCOUET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:04:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfCOUES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:04:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5EE9DC04FFF2;
        Fri, 15 Mar 2019 20:04:18 +0000 (UTC)
Received: from ceranb.redhat.com (ovpn-204-143.brq.redhat.com [10.40.204.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFE665D9C8;
        Fri, 15 Mar 2019 20:04:15 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        bpf@vger.kernel.org (open list:BPF (Safe dynamic programs and tools)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] selftests: bpf: modify urandom_read and link it non-statically
Date:   Fri, 15 Mar 2019 21:04:14 +0100
Message-Id: <20190315200414.32346-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 15 Mar 2019 20:04:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After some experiences I found that urandom_read does not need to be
linked statically. When the 'read' syscall call is moved to separate
non-inlined function then bpf_get_stackid() is able to find
the executable in stack trace and extract its build_id from it.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 tools/testing/selftests/bpf/Makefile       |  2 +-
 tools/testing/selftests/bpf/urandom_read.c | 15 +++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2aed37ea61a4..c33900a8fec0 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -69,7 +69,7 @@ TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
 all: $(TEST_CUSTOM_PROGS)
 
 $(OUTPUT)/urandom_read: $(OUTPUT)/%: %.c
-	$(CC) -o $@ -static $< -Wl,--build-id
+	$(CC) -o $@ $< -Wl,--build-id
 
 BPFOBJ := $(OUTPUT)/libbpf.a
 
diff --git a/tools/testing/selftests/bpf/urandom_read.c b/tools/testing/selftests/bpf/urandom_read.c
index 9de8b7cb4e6d..db781052758d 100644
--- a/tools/testing/selftests/bpf/urandom_read.c
+++ b/tools/testing/selftests/bpf/urandom_read.c
@@ -7,11 +7,19 @@
 
 #define BUF_SIZE 256
 
+static __attribute__((noinline))
+void urandom_read(int fd, int count)
+{
+       char buf[BUF_SIZE];
+       int i;
+
+       for (i = 0; i < count; ++i)
+               read(fd, buf, BUF_SIZE);
+}
+
 int main(int argc, char *argv[])
 {
 	int fd = open("/dev/urandom", O_RDONLY);
-	int i;
-	char buf[BUF_SIZE];
 	int count = 4;
 
 	if (fd < 0)
@@ -20,8 +28,7 @@ int main(int argc, char *argv[])
 	if (argc == 2)
 		count = atoi(argv[1]);
 
-	for (i = 0; i < count; ++i)
-		read(fd, buf, BUF_SIZE);
+	urandom_read(fd, count);
 
 	close(fd);
 	return 0;
-- 
2.19.2

