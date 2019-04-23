Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7E4C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9832C21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik+GZV6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfDWT10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:27:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46329 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWT1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:27:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so21647045wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=s/H2R7dELQbiOQQ3GzohoBkprAGoMCBmAT18vzVi6Cc=;
        b=ik+GZV6dPDWP3WIqx5fEucyNgly1i+zhq6iSaJqe0d6FXPRTvdXB2WxvGOmfu8G7nm
         0pxoe+08K7npcB0CJL8FkpM4fNi9CJNcdF9cJn2CaqXjeAD7h0BMzwPoPQpVqCvutyr7
         5rRFWW77ke3wzmqW+fXGVrdWkIysmYfeE6l0276rcqoQxFuh9ivOE+NKix9LmmRNsLxp
         xBpIsbY0QqQEdF/opjljXPi7eun3zkqFAEXSPkoZOFljqbf2wWV/6kEcOhoqNKrAS4YI
         +O4gQvIR1sM4PC4SIaPcAK0GnmfG2U9tf8BdlO5v7d4a2MAJQ2zM+dudyeruDKlLpbCM
         7qPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=s/H2R7dELQbiOQQ3GzohoBkprAGoMCBmAT18vzVi6Cc=;
        b=QOVF9UuldepvgM4vyuzrrzdLzSFBfQ128+oJQIXxKsLUf7QYGmhvmxrv1xcEfWPmGS
         Pp/Jm3SAxPOYoXJAzaAOKaNDAZvY5ckyVYZdxsHZ34J69iuAooxZkI3YMYyrQognMmLf
         oBWjynomNtlvXatL8FZVzqA8hZvDVoWzzW/mtkyVmnOf7YVGYm9lJ67WXblfwFp2Ts/d
         IRWe9t2H1pEdV7y6sjbPaxm8xil2zzhTgbJwrqP6/A5ZazaCHqH3uQdOfMxMQjO3KR/g
         CfUMUqtdMhdCPiuylg/uQoWw7R5/YFMstV6OFBaYjkZHOh+0nDjmoYC1GfuQ/bvOAz8f
         +/Ug==
X-Gm-Message-State: APjAAAX3HmMivhG5NWyxJr3SegGHLXSJgveOq+u7qqahuecZyYG7KJWZ
        eYgWSOfGX8Nu2wDNzCUhO5X+ujE=
X-Google-Smtp-Source: APXvYqyba85JFxzG7K1xjgvH8n6pkJdLx8a4usGc2nIMaVZBR1AqjSNfpc1t1VANHvREQPzE4FjakA==
X-Received: by 2002:adf:ce0a:: with SMTP id p10mr2314958wrn.277.1556047643918;
        Tue, 23 Apr 2019 12:27:23 -0700 (PDT)
Received: from avx2 ([46.53.241.167])
        by smtp.gmail.com with ESMTPSA id w11sm32520558wre.15.2019.04.23.12.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 12:27:22 -0700 (PDT)
Date:   Tue, 23 Apr 2019 22:27:20 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] exec: test ->recursion_depth
Message-ID: <20190423192720.GA21433@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test that trivially recursing script onto itself doesn't work.

Note: this is different test from ELOOP tests in execveat.c
Those test that execveat(2) doesn't follow symlinks when told to do so.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/exec/.gitignore        |    3 -
 tools/testing/selftests/exec/Makefile          |    4 +
 tools/testing/selftests/exec/recursion-depth.c |   67 +++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -6,4 +6,5 @@ execveat.moved
 execveat.path.ephemeral
 execveat.ephemeral
 execveat.denatured
-xxxxxxxx*
\ No newline at end of file
+/recursion-depth
+xxxxxxxx*
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,11 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS = -Wall
+CFLAGS += -Wno-nonnull
+CFLAGS += -D_GNU_SOURCE
 
 TEST_GEN_PROGS := execveat
 TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
 # Makefile is a run-time dependency, since it's accessed by the execveat test
 TEST_FILES := Makefile
 
+TEST_GEN_PROGS += recursion-depth
+
 EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*
 
 include ../lib.mk
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/exec/recursion-depth.c
@@ -0,0 +1,67 @@
+/*
+ * Copyright (c) 2019 Alexey Dobriyan <adobriyan@gmail.com>
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
+/* Test that pointing #! script interpreter to self doesn't recurse. */
+#include <errno.h>
+#include <sched.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/mount.h>
+#include <unistd.h>
+
+int main(void)
+{
+	if (unshare(CLONE_NEWNS) == -1) {
+		if (errno == ENOSYS || errno == EPERM) {
+			fprintf(stderr, "error: unshare, errno %d\n", errno);
+			return 4;
+		}
+		fprintf(stderr, "error: unshare, errno %d\n", errno);
+		return 1;
+	}
+	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
+		fprintf(stderr, "error: mount '/', errno %d\n", errno);
+		return 1;
+	}
+	/* Require "exec" filesystem. */
+	if (mount(NULL, "/tmp", "ramfs", 0, NULL) == -1) {
+		fprintf(stderr, "error: mount ramfs, errno %d\n", errno);
+		return 1;
+	}
+
+#define FILENAME "/tmp/1"
+
+	int fd = creat(FILENAME, 0700);
+	if (fd == -1) {
+		fprintf(stderr, "error: creat, errno %d\n", errno);
+		return 1;
+	}
+#define S "#!" FILENAME "\n"
+	if (write(fd, S, strlen(S)) != strlen(S)) {
+		fprintf(stderr, "error: write, errno %d\n", errno);
+		return 1;
+	}
+	close(fd);
+
+	int rv = execve(FILENAME, NULL, NULL);
+	if (rv == -1 && errno == ELOOP) {
+		return 0;
+	}
+	fprintf(stderr, "error: execve, rv %d, errno %d\n", rv, errno);
+	return 1;
+}
