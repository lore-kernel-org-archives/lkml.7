Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3015C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85688217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458245;
	bh=9u2zOZAZXSR6MbZbH+eT1eRdvxgZbEQLoTvDrp8Rtl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vjBUnwMWzjWVgfDvOjAbLSegMWfkWuLOU0LKXg6BmBeDwV0vKQfmanMQ61HviBuzx
	 idoll0mCzWSe4+bA2/9qgIu8vp5DaIOC9SUCybGrXpk049J/yUEezMCmkiYsFps1sY
	 b0+MIal8vsCjSP6YEyFDRUA+Hw6Ji1jTAo0YMILM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391089AbfIZAhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390340AbfIZAgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:36:18 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9533E21D7B;
        Thu, 26 Sep 2019 00:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458177;
        bh=9u2zOZAZXSR6MbZbH+eT1eRdvxgZbEQLoTvDrp8Rtl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRuAVf1sPyRrC6OddkwHbOhVxJIwoyXImnGBqMcZwqN3k+cQp9TU0XJ6zdegZs1to
         284S/nO/z/r22EzJ3MQV64fbXAJOmBASNbX3GMg4Ba0HSJvhWS3EUI4ASalBeLZKSA
         h6jvL4b+z54s9PWstvneHclvdwZC3z516Swb9h+c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 55/66] perf copyfile: Move copyfile routines to separate files
Date:   Wed, 25 Sep 2019 21:32:33 -0300
Message-Id: <20190926003244.13962-56-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Further reducing the util.c hodgepodge files.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0i62zh7ok25znibyebgq0qs4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build        |   1 +
 tools/perf/util/build-id.c   |   3 +-
 tools/perf/util/copyfile.c   | 144 +++++++++++++++++++++++++++++++++++
 tools/perf/util/copyfile.h   |  16 ++++
 tools/perf/util/symbol-elf.c |   2 +-
 tools/perf/util/util.c       | 135 --------------------------------
 tools/perf/util/util.h       |   5 --
 7 files changed, 164 insertions(+), 142 deletions(-)
 create mode 100644 tools/perf/util/copyfile.c
 create mode 100644 tools/perf/util/copyfile.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index fd89d6a8cd65..4d1894e38a81 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -3,6 +3,7 @@ perf-y += block-range.o
 perf-y += build-id.o
 perf-y += cacheline.o
 perf-y += config.o
+perf-y += copyfile.o
 perf-y += ctype.o
 perf-y += db-export.o
 perf-y += env.o
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 7928c398a063..c076fc7fe025 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -7,12 +7,13 @@
  * Copyright (C) 2009, 2010 Red Hat Inc.
  * Copyright (C) 2009, 2010 Arnaldo Carvalho de Melo <acme@redhat.com>
  */
-#include "util.h" // copyfile_ns(), lsdir(), mkdir_p(), rm_rf()
+#include "util.h" // lsdir(), mkdir_p(), rm_rf()
 #include <dirent.h>
 #include <errno.h>
 #include <stdio.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include "util/copyfile.h"
 #include "dso.h"
 #include "build-id.h"
 #include "event.h"
diff --git a/tools/perf/util/copyfile.c b/tools/perf/util/copyfile.c
new file mode 100644
index 000000000000..3fa0db136667
--- /dev/null
+++ b/tools/perf/util/copyfile.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "util/copyfile.h"
+#include "util/namespaces.h"
+#include <internal/lib.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static int slow_copyfile(const char *from, const char *to, struct nsinfo *nsi)
+{
+	int err = -1;
+	char *line = NULL;
+	size_t n;
+	FILE *from_fp, *to_fp;
+	struct nscookie nsc;
+
+	nsinfo__mountns_enter(nsi, &nsc);
+	from_fp = fopen(from, "r");
+	nsinfo__mountns_exit(&nsc);
+	if (from_fp == NULL)
+		goto out;
+
+	to_fp = fopen(to, "w");
+	if (to_fp == NULL)
+		goto out_fclose_from;
+
+	while (getline(&line, &n, from_fp) > 0)
+		if (fputs(line, to_fp) == EOF)
+			goto out_fclose_to;
+	err = 0;
+out_fclose_to:
+	fclose(to_fp);
+	free(line);
+out_fclose_from:
+	fclose(from_fp);
+out:
+	return err;
+}
+
+int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size)
+{
+	void *ptr;
+	loff_t pgoff;
+
+	pgoff = off_in & ~(page_size - 1);
+	off_in -= pgoff;
+
+	ptr = mmap(NULL, off_in + size, PROT_READ, MAP_PRIVATE, ifd, pgoff);
+	if (ptr == MAP_FAILED)
+		return -1;
+
+	while (size) {
+		ssize_t ret = pwrite(ofd, ptr + off_in, size, off_out);
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret <= 0)
+			break;
+
+		size -= ret;
+		off_in += ret;
+		off_out += ret;
+	}
+	munmap(ptr, off_in + size);
+
+	return size ? -1 : 0;
+}
+
+static int copyfile_mode_ns(const char *from, const char *to, mode_t mode,
+			    struct nsinfo *nsi)
+{
+	int fromfd, tofd;
+	struct stat st;
+	int err;
+	char *tmp = NULL, *ptr = NULL;
+	struct nscookie nsc;
+
+	nsinfo__mountns_enter(nsi, &nsc);
+	err = stat(from, &st);
+	nsinfo__mountns_exit(&nsc);
+	if (err)
+		goto out;
+	err = -1;
+
+	/* extra 'x' at the end is to reserve space for '.' */
+	if (asprintf(&tmp, "%s.XXXXXXx", to) < 0) {
+		tmp = NULL;
+		goto out;
+	}
+	ptr = strrchr(tmp, '/');
+	if (!ptr)
+		goto out;
+	ptr = memmove(ptr + 1, ptr, strlen(ptr) - 1);
+	*ptr = '.';
+
+	tofd = mkstemp(tmp);
+	if (tofd < 0)
+		goto out;
+
+	if (fchmod(tofd, mode))
+		goto out_close_to;
+
+	if (st.st_size == 0) { /* /proc? do it slowly... */
+		err = slow_copyfile(from, tmp, nsi);
+		goto out_close_to;
+	}
+
+	nsinfo__mountns_enter(nsi, &nsc);
+	fromfd = open(from, O_RDONLY);
+	nsinfo__mountns_exit(&nsc);
+	if (fromfd < 0)
+		goto out_close_to;
+
+	err = copyfile_offset(fromfd, 0, tofd, 0, st.st_size);
+
+	close(fromfd);
+out_close_to:
+	close(tofd);
+	if (!err)
+		err = link(tmp, to);
+	unlink(tmp);
+out:
+	free(tmp);
+	return err;
+}
+
+int copyfile_ns(const char *from, const char *to, struct nsinfo *nsi)
+{
+	return copyfile_mode_ns(from, to, 0755, nsi);
+}
+
+int copyfile_mode(const char *from, const char *to, mode_t mode)
+{
+	return copyfile_mode_ns(from, to, mode, NULL);
+}
+
+int copyfile(const char *from, const char *to)
+{
+	return copyfile_mode(from, to, 0755);
+}
diff --git a/tools/perf/util/copyfile.h b/tools/perf/util/copyfile.h
new file mode 100644
index 000000000000..e85d2f22f3cc
--- /dev/null
+++ b/tools/perf/util/copyfile.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef PERF_COPYFILE_H_
+#define PERF_COPYFILE_H_
+
+#include <linux/types.h>
+#include <sys/types.h>
+#include <fcntl.h>
+
+struct nsinfo;
+
+int copyfile(const char *from, const char *to);
+int copyfile_mode(const char *from, const char *to, mode_t mode);
+int copyfile_ns(const char *from, const char *to, struct nsinfo *nsi);
+int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size);
+
+#endif // PERF_COPYFILE_H_
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 6fbfdf8bf61f..66f4be1df573 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -17,7 +17,7 @@
 #include "machine.h"
 #include "vdso.h"
 #include "debug.h"
-#include "util.h"
+#include "util/copyfile.h"
 #include <linux/ctype.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index cb6fa4c98470..5eda6e19c947 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -2,10 +2,7 @@
 #include "util.h"
 #include "debug.h"
 #include "event.h"
-#include "namespaces.h"
-#include <internal/lib.h>
 #include <api/fs/fs.h>
-#include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/utsname.h>
 #include <dirent.h>
@@ -233,138 +230,6 @@ struct strlist *lsdir(const char *name,
 	return list;
 }
 
-static int slow_copyfile(const char *from, const char *to, struct nsinfo *nsi)
-{
-	int err = -1;
-	char *line = NULL;
-	size_t n;
-	FILE *from_fp, *to_fp;
-	struct nscookie nsc;
-
-	nsinfo__mountns_enter(nsi, &nsc);
-	from_fp = fopen(from, "r");
-	nsinfo__mountns_exit(&nsc);
-	if (from_fp == NULL)
-		goto out;
-
-	to_fp = fopen(to, "w");
-	if (to_fp == NULL)
-		goto out_fclose_from;
-
-	while (getline(&line, &n, from_fp) > 0)
-		if (fputs(line, to_fp) == EOF)
-			goto out_fclose_to;
-	err = 0;
-out_fclose_to:
-	fclose(to_fp);
-	free(line);
-out_fclose_from:
-	fclose(from_fp);
-out:
-	return err;
-}
-
-int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size)
-{
-	void *ptr;
-	loff_t pgoff;
-
-	pgoff = off_in & ~(page_size - 1);
-	off_in -= pgoff;
-
-	ptr = mmap(NULL, off_in + size, PROT_READ, MAP_PRIVATE, ifd, pgoff);
-	if (ptr == MAP_FAILED)
-		return -1;
-
-	while (size) {
-		ssize_t ret = pwrite(ofd, ptr + off_in, size, off_out);
-		if (ret < 0 && errno == EINTR)
-			continue;
-		if (ret <= 0)
-			break;
-
-		size -= ret;
-		off_in += ret;
-		off_out += ret;
-	}
-	munmap(ptr, off_in + size);
-
-	return size ? -1 : 0;
-}
-
-static int copyfile_mode_ns(const char *from, const char *to, mode_t mode,
-			    struct nsinfo *nsi)
-{
-	int fromfd, tofd;
-	struct stat st;
-	int err;
-	char *tmp = NULL, *ptr = NULL;
-	struct nscookie nsc;
-
-	nsinfo__mountns_enter(nsi, &nsc);
-	err = stat(from, &st);
-	nsinfo__mountns_exit(&nsc);
-	if (err)
-		goto out;
-	err = -1;
-
-	/* extra 'x' at the end is to reserve space for '.' */
-	if (asprintf(&tmp, "%s.XXXXXXx", to) < 0) {
-		tmp = NULL;
-		goto out;
-	}
-	ptr = strrchr(tmp, '/');
-	if (!ptr)
-		goto out;
-	ptr = memmove(ptr + 1, ptr, strlen(ptr) - 1);
-	*ptr = '.';
-
-	tofd = mkstemp(tmp);
-	if (tofd < 0)
-		goto out;
-
-	if (fchmod(tofd, mode))
-		goto out_close_to;
-
-	if (st.st_size == 0) { /* /proc? do it slowly... */
-		err = slow_copyfile(from, tmp, nsi);
-		goto out_close_to;
-	}
-
-	nsinfo__mountns_enter(nsi, &nsc);
-	fromfd = open(from, O_RDONLY);
-	nsinfo__mountns_exit(&nsc);
-	if (fromfd < 0)
-		goto out_close_to;
-
-	err = copyfile_offset(fromfd, 0, tofd, 0, st.st_size);
-
-	close(fromfd);
-out_close_to:
-	close(tofd);
-	if (!err)
-		err = link(tmp, to);
-	unlink(tmp);
-out:
-	free(tmp);
-	return err;
-}
-
-int copyfile_ns(const char *from, const char *to, struct nsinfo *nsi)
-{
-	return copyfile_mode_ns(from, to, 0755, nsi);
-}
-
-int copyfile_mode(const char *from, const char *to, mode_t mode)
-{
-	return copyfile_mode_ns(from, to, mode, NULL);
-}
-
-int copyfile(const char *from, const char *to)
-{
-	return copyfile_mode(from, to, 0755);
-}
-
 size_t hex_width(u64 v)
 {
 	size_t n = 1;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index b78b73e5bb32..9969b8b46f7c 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -17,7 +17,6 @@ void usage(const char *err) __noreturn;
 void die(const char *err, ...) __noreturn __printf(1, 2);
 
 struct dirent;
-struct nsinfo;
 struct strlist;
 
 int mkdir_p(char *path, mode_t mode);
@@ -25,10 +24,6 @@ int rm_rf(const char *path);
 int rm_rf_perf_data(const char *path);
 struct strlist *lsdir(const char *name, bool (*filter)(const char *, struct dirent *));
 bool lsdir_no_dot_filter(const char *name, struct dirent *d);
-int copyfile(const char *from, const char *to);
-int copyfile_mode(const char *from, const char *to, mode_t mode);
-int copyfile_ns(const char *from, const char *to, struct nsinfo *nsi);
-int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size);
 
 size_t hex_width(u64 v);
 
-- 
2.21.0

