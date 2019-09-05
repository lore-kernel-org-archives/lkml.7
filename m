Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F65C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B66521D71
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390648AbfIEPnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390542AbfIEPnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E14A521924;
        Thu,  5 Sep 2019 15:43:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvD-0007cL-D0; Thu, 05 Sep 2019 11:43:43 -0400
Message-Id: <20190905154343.292050287@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [for-next][PATCH 21/25] recordmcount: Clarify what cleanup() does
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Helsley <mhelsley@vmware.com>

cleanup() mostly frees/unmaps the malloc'd/privately-mapped
copy of the ELF file recordmcount is working on, which is
set up in mmap_file(). It also deals with positioning within
the pseduo prive-mapping of the file and appending to the ELF
file.

Split into two steps:
	mmap_cleanup() for the mapping itself
	file_append_cleanup() for allocations storing the
		appended ELF data.

Also, move the global variable initializations out of the main,
per-object-file loop and nearer to the alloc/init (mmap_file())
and two cleanup functions so we can more clearly see how they're
related.

Link: http://lkml.kernel.org/r/2a387ac86d133d22c68f57b9933c32bab1d09a2d.1564596289.git.mhelsley@vmware.com

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 scripts/recordmcount.c | 151 ++++++++++++++++++++++-------------------
 1 file changed, 81 insertions(+), 70 deletions(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 5677fcc88a72..612268eabef4 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -48,21 +48,26 @@ static void *file_map;	/* pointer of the mapped file */
 static void *file_end;	/* pointer to the end of the mapped file */
 static int file_updated; /* flag to state file was changed */
 static void *file_ptr;	/* current file pointer location */
+
 static void *file_append; /* added to the end of the file */
 static size_t file_append_size; /* how much is added to end of file */
 
 /* Per-file resource cleanup when multiple files. */
-static void cleanup(void)
+static void file_append_cleanup(void)
+{
+	free(file_append);
+	file_append = NULL;
+	file_append_size = 0;
+	file_updated = 0;
+}
+
+static void mmap_cleanup(void)
 {
 	if (!mmap_failed)
 		munmap(file_map, sb.st_size);
 	else
 		free(file_map);
 	file_map = NULL;
-	free(file_append);
-	file_append = NULL;
-	file_append_size = 0;
-	file_updated = 0;
 }
 
 /* ulseek, uwrite, ...:  Check return value for errors. */
@@ -103,7 +108,8 @@ static ssize_t uwrite(void const *const buf, size_t const count)
 		}
 		if (!file_append) {
 			perror("write");
-			cleanup();
+			file_append_cleanup();
+			mmap_cleanup();
 			return -1;
 		}
 		if (file_ptr < file_end) {
@@ -129,12 +135,76 @@ static void * umalloc(size_t size)
 	void *const addr = malloc(size);
 	if (addr == 0) {
 		fprintf(stderr, "malloc failed: %zu bytes\n", size);
-		cleanup();
+		file_append_cleanup();
+		mmap_cleanup();
 		return NULL;
 	}
 	return addr;
 }
 
+/*
+ * Get the whole file as a programming convenience in order to avoid
+ * malloc+lseek+read+free of many pieces.  If successful, then mmap
+ * avoids copying unused pieces; else just read the whole file.
+ * Open for both read and write; new info will be appended to the file.
+ * Use MAP_PRIVATE so that a few changes to the in-memory ElfXX_Ehdr
+ * do not propagate to the file until an explicit overwrite at the last.
+ * This preserves most aspects of consistency (all except .st_size)
+ * for simultaneous readers of the file while we are appending to it.
+ * However, multiple writers still are bad.  We choose not to use
+ * locking because it is expensive and the use case of kernel build
+ * makes multiple writers unlikely.
+ */
+static void *mmap_file(char const *fname)
+{
+	/* Avoid problems if early cleanup() */
+	fd_map = -1;
+	mmap_failed = 1;
+	file_map = NULL;
+	file_ptr = NULL;
+	file_updated = 0;
+	sb.st_size = 0;
+
+	fd_map = open(fname, O_RDONLY);
+	if (fd_map < 0) {
+		perror(fname);
+		return NULL;
+	}
+	if (fstat(fd_map, &sb) < 0) {
+		perror(fname);
+		goto out;
+	}
+	if (!S_ISREG(sb.st_mode)) {
+		fprintf(stderr, "not a regular file: %s\n", fname);
+		goto out;
+	}
+	file_map = mmap(0, sb.st_size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
+			fd_map, 0);
+	if (file_map == MAP_FAILED) {
+		mmap_failed = 1;
+		file_map = umalloc(sb.st_size);
+		if (!file_map) {
+			perror(fname);
+			goto out;
+		}
+		if (read(fd_map, file_map, sb.st_size) != sb.st_size) {
+			perror(fname);
+			free(file_map);
+			file_map = NULL;
+			goto out;
+		}
+	} else
+		mmap_failed = 0;
+out:
+	close(fd_map);
+	fd_map = -1;
+
+	file_end = file_map + sb.st_size;
+
+	return file_map;
+}
+
+
 static unsigned char ideal_nop5_x86_64[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
 static unsigned char ideal_nop5_x86_32[5] = { 0x3e, 0x8d, 0x74, 0x26, 0x00 };
 static unsigned char *ideal_nop;
@@ -238,61 +308,6 @@ static int make_nop_arm64(void *map, size_t const offset)
 	return 0;
 }
 
-/*
- * Get the whole file as a programming convenience in order to avoid
- * malloc+lseek+read+free of many pieces.  If successful, then mmap
- * avoids copying unused pieces; else just read the whole file.
- * Open for both read and write; new info will be appended to the file.
- * Use MAP_PRIVATE so that a few changes to the in-memory ElfXX_Ehdr
- * do not propagate to the file until an explicit overwrite at the last.
- * This preserves most aspects of consistency (all except .st_size)
- * for simultaneous readers of the file while we are appending to it.
- * However, multiple writers still are bad.  We choose not to use
- * locking because it is expensive and the use case of kernel build
- * makes multiple writers unlikely.
- */
-static void *mmap_file(char const *fname)
-{
-	file_map = NULL;
-	sb.st_size = 0;
-	fd_map = open(fname, O_RDONLY);
-	if (fd_map < 0) {
-		perror(fname);
-		return NULL;
-	}
-	if (fstat(fd_map, &sb) < 0) {
-		perror(fname);
-		goto out;
-	}
-	if (!S_ISREG(sb.st_mode)) {
-		fprintf(stderr, "not a regular file: %s\n", fname);
-		goto out;
-	}
-	file_map = mmap(0, sb.st_size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
-			fd_map, 0);
-	mmap_failed = 0;
-	if (file_map == MAP_FAILED) {
-		mmap_failed = 1;
-		file_map = umalloc(sb.st_size);
-		if (!file_map) {
-			perror(fname);
-			goto out;
-		}
-		if (read(fd_map, file_map, sb.st_size) != sb.st_size) {
-			perror(fname);
-			free(file_map);
-			file_map = NULL;
-			goto out;
-		}
-	}
-out:
-	close(fd_map);
-
-	file_end = file_map + sb.st_size;
-
-	return file_map;
-}
-
 static int write_file(const char *fname)
 {
 	char tmp_file[strlen(fname) + 4];
@@ -438,10 +453,11 @@ static void MIPS64_r_info(Elf64_Rel *const rp, unsigned sym, unsigned type)
 
 static int do_file(char const *const fname)
 {
-	Elf32_Ehdr *const ehdr = mmap_file(fname);
 	unsigned int reltype = 0;
+	Elf32_Ehdr *ehdr;
 	int rc = -1;
 
+	ehdr = mmap_file(fname);
 	if (!ehdr)
 		goto out;
 
@@ -577,7 +593,8 @@ static int do_file(char const *const fname)
 
 	rc = write_file(fname);
 out:
-	cleanup();
+	file_append_cleanup();
+	mmap_cleanup();
 	return rc;
 }
 
@@ -620,12 +637,6 @@ int main(int argc, char *argv[])
 		    strcmp(file + (len - ftrace_size), ftrace) == 0)
 			continue;
 
-		/* Avoid problems if early cleanup() */
-		fd_map = -1;
-		mmap_failed = 1;
-		file_map = NULL;
-		file_ptr = NULL;
-		file_updated = 0;
 		if (do_file(file)) {
 			fprintf(stderr, "%s: failed\n", file);
 			++n_error;
-- 
2.20.1


