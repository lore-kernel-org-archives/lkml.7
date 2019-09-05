Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B1EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D471C2137B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388633AbfIEPod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390537AbfIEPno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C9321907;
        Thu,  5 Sep 2019 15:43:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvC-0007at-S6; Thu, 05 Sep 2019 11:43:42 -0400
Message-Id: <20190905154342.751522961@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [for-next][PATCH 18/25] recordmcount: Kernel style function signature formatting
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Helsley <mhelsley@vmware.com>

The uwrite() and ulseek() functions are formatted inconsistently
with the rest of the file and the kernel overall. While we're
making other changes here let's fix this.

Link: http://lkml.kernel.org/r/4c67698f734be9867a2aba7035fe0ce59e1e4423.1564596289.git.mhelsley@vmware.com

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 scripts/recordmcount.c | 21 +++++++--------------
 scripts/recordmcount.h | 13 ++++++-------
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index c6d395b8ff29..67f9c45b824f 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -52,8 +52,7 @@ static void *file_append; /* added to the end of the file */
 static size_t file_append_size; /* how much is added to end of file */
 
 /* Per-file resource cleanup when multiple files. */
-static void
-cleanup(void)
+static void cleanup(void)
 {
 	if (!mmap_failed)
 		munmap(file_map, sb.st_size);
@@ -68,8 +67,7 @@ cleanup(void)
 
 /* ulseek, uwrite, ...:  Check return value for errors. */
 
-static off_t
-ulseek(off_t const offset, int const whence)
+static off_t ulseek(off_t const offset, int const whence)
 {
 	switch (whence) {
 	case SEEK_SET:
@@ -89,8 +87,7 @@ ulseek(off_t const offset, int const whence)
 	return file_ptr - file_map;
 }
 
-static ssize_t
-uwrite(void const *const buf, size_t const count)
+static ssize_t uwrite(void const *const buf, size_t const count)
 {
 	size_t cnt = count;
 	off_t idx = 0;
@@ -127,8 +124,7 @@ uwrite(void const *const buf, size_t const count)
 	return count;
 }
 
-static void *
-umalloc(size_t size)
+static void * umalloc(size_t size)
 {
 	void *const addr = malloc(size);
 	if (addr == 0) {
@@ -394,8 +390,7 @@ static uint32_t (*w)(uint32_t);
 static uint32_t (*w2)(uint16_t);
 
 /* Names of the sections that could contain calls to mcount. */
-static int
-is_mcounted_section_name(char const *const txtname)
+static int is_mcounted_section_name(char const *const txtname)
 {
 	return strncmp(".text",          txtname, 5) == 0 ||
 		strcmp(".init.text",     txtname) == 0 ||
@@ -448,8 +443,7 @@ static void MIPS64_r_info(Elf64_Rel *const rp, unsigned sym, unsigned type)
 	}).r_info;
 }
 
-static int
-do_file(char const *const fname)
+static int do_file(char const *const fname)
 {
 	Elf32_Ehdr *const ehdr = mmap_file(fname);
 	unsigned int reltype = 0;
@@ -597,8 +591,7 @@ do_file(char const *const fname)
 	return rc;
 }
 
-int
-main(int argc, char *argv[])
+int main(int argc, char *argv[])
 {
 	const char ftrace[] = "/ftrace.o";
 	int ftrace_size = sizeof(ftrace) - 1;
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 3796eb37fb12..ca9aaac89bfb 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -468,11 +468,10 @@ static int find_secsym_ndx(unsigned const txtndx,
 }
 
 /* Evade ISO C restriction: no declaration after statement in has_rel_mcount. */
-static char const *
-__has_rel_mcount(Elf_Shdr const *const relhdr,  /* is SHT_REL or SHT_RELA */
-		 Elf_Shdr const *const shdr0,
-		 char const *const shstrtab,
-		 char const *const fname)
+static char const * __has_rel_mcount(Elf_Shdr const *const relhdr, /* reltype */
+				     Elf_Shdr const *const shdr0,
+				     char const *const shstrtab,
+				     char const *const fname)
 {
 	/* .sh_info depends on .sh_type == SHT_REL[,A] */
 	Elf_Shdr const *const txthdr = &shdr0[w(relhdr->sh_info)];
@@ -524,8 +523,8 @@ static unsigned tot_relsize(Elf_Shdr const *const shdr0,
 
 
 /* Overall supervision for Elf32 ET_REL file. */
-static int
-do_func(Elf_Ehdr *const ehdr, char const *const fname, unsigned const reltype)
+static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
+		   unsigned const reltype)
 {
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
 		+ (void *)ehdr);
-- 
2.20.1


