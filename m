Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003BFC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2CB22BE8
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbfGXVGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 17:06:09 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:9569 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387990AbfGXVFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 17:05:31 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 24 Jul 2019 14:05:14 -0700
Received: from rlwimi.localdomain (unknown [10.166.65.164])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id F0C6340708;
        Wed, 24 Jul 2019 14:05:29 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH v3 11/13] objtool: recordmcount: Start using objtool's elf wrapper
Date:   Wed, 24 Jul 2019 14:05:05 -0700
Message-ID: <5a7c9800dea10ebcc7deeafa8bb8b4b53c68e458.1563992889.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1563992889.git.mhelsley@vmware.com>
References: <cover.1563992889.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct elf to grab the file descriptor. We will later
move these calls into other functions as we expand the
lifetime of the struct elf so that it can be passed to
objtool elf.[ch] functions.

This creates the libelf/objcount data structures and gives
us two separte ways to walk the ELF file -- the libelf/objtool
way and the old recordmcount wrapper way which avoids these
extra data structures by using indices, offsets, and pointers
into the mmapped ELF file.

Subsequent patches will convert from the old recordmcount
accessors to the libelf/objtool accessors.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 2de31e2913d1..28b5c5e4beae 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -33,6 +33,8 @@
 
 #include "builtin-mcount.h"
 
+#include "elf.h"
+
 #ifndef EM_AARCH64
 #define EM_AARCH64	183
 #define R_AARCH64_NONE		0
@@ -53,6 +55,8 @@ static void *file_ptr;	/* current file pointer location */
 static void *file_append; /* added to the end of the file */
 static size_t file_append_size; /* how much is added to end of file */
 
+static struct elf *lf;
+
 /* Per-file resource cleanup when multiple files. */
 static void file_append_cleanup(void)
 {
@@ -69,6 +73,9 @@ static void mmap_cleanup(void)
 	else
 		free(file_map);
 	file_map = NULL;
+	if (lf)
+		elf_close(lf);
+	lf = NULL;
 }
 
 /* ulseek, uwrite, ...:  Check return value for errors. */
@@ -166,11 +173,12 @@ static void *mmap_file(char const *fname)
 	file_updated = 0;
 	sb.st_size = 0;
 
-	fd_map = open(fname, O_RDONLY);
-	if (fd_map < 0) {
+	lf = elf_read(fname, O_RDONLY);
+	if (!lf) {
 		perror(fname);
 		return NULL;
 	}
+	fd_map = lf->fd;
 	if (fstat(fd_map, &sb) < 0) {
 		perror(fname);
 		goto out;
@@ -190,14 +198,14 @@ static void *mmap_file(char const *fname)
 		}
 		if (read(fd_map, file_map, sb.st_size) != sb.st_size) {
 			perror(fname);
-			free(file_map);
-			file_map = NULL;
+			mmap_cleanup();
 			goto out;
 		}
 	} else
 		mmap_failed = 0;
 out:
-	close(fd_map);
+	elf_close(lf);
+	lf = NULL;
 	fd_map = -1;
 
 	file_end = file_map + sb.st_size;
-- 
2.20.1

