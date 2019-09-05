Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EDDC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CD621920
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390637AbfIEPnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390536AbfIEPno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29FCE218DE;
        Thu,  5 Sep 2019 15:43:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvC-0007aP-Lk; Thu, 05 Sep 2019 11:43:42 -0400
Message-Id: <20190905154342.561298672@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [for-next][PATCH 17/25] recordmcount: Rewrite error/success handling
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Helsley <mhelsley@vmware.com>

Recordmcount uses setjmp/longjmp to manage control flow as
it reads and then writes the ELF file. This unusual control
flow is hard to follow and check in addition to being unlike
kernel coding style.

So we rewrite these paths to use regular return values to
indicate error/success. When an error or previously-completed object
file is found we return an error code following kernel
coding conventions -- negative error values and 0 for success when
we're not returning a pointer. We return NULL for those that fail
and return non-NULL pointers otherwise.

One oddity is already_has_rel_mcount -- there we use pointer comparison
rather than string comparison to differentiate between
previously-processed object files and returning the name of a text
section.

Link: http://lkml.kernel.org/r/8ba8633d4afe444931f363c8d924bf9565b89a86.1564596289.git.mhelsley@vmware.com

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 scripts/recordmcount.c | 162 +++++++++++++++++++++--------------------
 scripts/recordmcount.h | 141 ++++++++++++++++++++++++-----------
 2 files changed, 184 insertions(+), 119 deletions(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 1fe5fba99959..c6d395b8ff29 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -27,7 +27,6 @@
 #include <getopt.h>
 #include <elf.h>
 #include <fcntl.h>
-#include <setjmp.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -43,7 +42,6 @@ static int fd_map;	/* File descriptor for file being modified. */
 static int mmap_failed; /* Boolean flag. */
 static char gpfx;	/* prefix for global symbol name (sometimes '_') */
 static struct stat sb;	/* Remember .st_size, etc. */
-static jmp_buf jmpenv;	/* setjmp/longjmp per-file error escape */
 static const char *altmcount;	/* alternate mcount symbol name */
 static int warn_on_notrace_sect; /* warn when section has mcount not being recorded */
 static void *file_map;	/* pointer of the mapped file */
@@ -53,13 +51,6 @@ static void *file_ptr;	/* current file pointer location */
 static void *file_append; /* added to the end of the file */
 static size_t file_append_size; /* how much is added to end of file */
 
-/* setjmp() return values */
-enum {
-	SJ_SETJMP = 0,  /* hardwired first return */
-	SJ_FAIL,
-	SJ_SUCCEED
-};
-
 /* Per-file resource cleanup when multiple files. */
 static void
 cleanup(void)
@@ -75,20 +66,6 @@ cleanup(void)
 	file_updated = 0;
 }
 
-static void __attribute__((noreturn))
-fail_file(void)
-{
-	cleanup();
-	longjmp(jmpenv, SJ_FAIL);
-}
-
-static void __attribute__((noreturn))
-succeed_file(void)
-{
-	cleanup();
-	longjmp(jmpenv, SJ_SUCCEED);
-}
-
 /* ulseek, uwrite, ...:  Check return value for errors. */
 
 static off_t
@@ -107,12 +84,12 @@ ulseek(off_t const offset, int const whence)
 	}
 	if (file_ptr < file_map) {
 		fprintf(stderr, "lseek: seek before file\n");
-		fail_file();
+		return -1;
 	}
 	return file_ptr - file_map;
 }
 
-static size_t
+static ssize_t
 uwrite(void const *const buf, size_t const count)
 {
 	size_t cnt = count;
@@ -129,7 +106,8 @@ uwrite(void const *const buf, size_t const count)
 		}
 		if (!file_append) {
 			perror("write");
-			fail_file();
+			cleanup();
+			return -1;
 		}
 		if (file_ptr < file_end) {
 			cnt = file_end - file_ptr;
@@ -155,7 +133,8 @@ umalloc(size_t size)
 	void *const addr = malloc(size);
 	if (addr == 0) {
 		fprintf(stderr, "malloc failed: %zu bytes\n", size);
-		fail_file();
+		cleanup();
+		return NULL;
 	}
 	return addr;
 }
@@ -183,8 +162,10 @@ static int make_nop_x86(void *map, size_t const offset)
 		return -1;
 
 	/* convert to nop */
-	ulseek(offset - 1, SEEK_SET);
-	uwrite(ideal_nop, 5);
+	if (ulseek(offset - 1, SEEK_SET) < 0)
+		return -1;
+	if (uwrite(ideal_nop, 5) < 0)
+		return -1;
 	return 0;
 }
 
@@ -232,10 +213,12 @@ static int make_nop_arm(void *map, size_t const offset)
 		return -1;
 
 	/* Convert to nop */
-	ulseek(off, SEEK_SET);
+	if (ulseek(off, SEEK_SET) < 0)
+		return -1;
 
 	do {
-		uwrite(ideal_nop, nop_size);
+		if (uwrite(ideal_nop, nop_size) < 0)
+			return -1;
 	} while (--cnt > 0);
 
 	return 0;
@@ -252,8 +235,10 @@ static int make_nop_arm64(void *map, size_t const offset)
 		return -1;
 
 	/* Convert to nop */
-	ulseek(offset, SEEK_SET);
-	uwrite(ideal_nop, 4);
+	if (ulseek(offset, SEEK_SET) < 0)
+		return -1;
+	if (uwrite(ideal_nop, 4) < 0)
+		return -1;
 	return 0;
 }
 
@@ -272,14 +257,23 @@ static int make_nop_arm64(void *map, size_t const offset)
  */
 static void *mmap_file(char const *fname)
 {
+	file_map = NULL;
+	sb.st_size = 0;
 	fd_map = open(fname, O_RDONLY);
-	if (fd_map < 0 || fstat(fd_map, &sb) < 0) {
+	if (fd_map < 0) {
+		perror(fname);
+		cleanup();
+		return NULL;
+	}
+	if (fstat(fd_map, &sb) < 0) {
 		perror(fname);
-		fail_file();
+		cleanup();
+		goto out;
 	}
 	if (!S_ISREG(sb.st_mode)) {
 		fprintf(stderr, "not a regular file: %s\n", fname);
-		fail_file();
+		cleanup();
+		goto out;
 	}
 	file_map = mmap(0, sb.st_size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
 			fd_map, 0);
@@ -287,11 +281,18 @@ static void *mmap_file(char const *fname)
 	if (file_map == MAP_FAILED) {
 		mmap_failed = 1;
 		file_map = umalloc(sb.st_size);
+		if (!file_map) {
+			perror(fname);
+			goto out;
+		}
 		if (read(fd_map, file_map, sb.st_size) != sb.st_size) {
 			perror(fname);
-			fail_file();
+			free(file_map);
+			file_map = NULL;
+			goto out;
 		}
 	}
+out:
 	close(fd_map);
 
 	file_end = file_map + sb.st_size;
@@ -299,13 +300,13 @@ static void *mmap_file(char const *fname)
 	return file_map;
 }
 
-static void write_file(const char *fname)
+static int write_file(const char *fname)
 {
 	char tmp_file[strlen(fname) + 4];
 	size_t n;
 
 	if (!file_updated)
-		return;
+		return 0;
 
 	sprintf(tmp_file, "%s.rc", fname);
 
@@ -317,25 +318,32 @@ static void write_file(const char *fname)
 	fd_map = open(tmp_file, O_WRONLY | O_TRUNC | O_CREAT, sb.st_mode);
 	if (fd_map < 0) {
 		perror(fname);
-		fail_file();
+		cleanup();
+		return -1;
 	}
 	n = write(fd_map, file_map, sb.st_size);
 	if (n != sb.st_size) {
 		perror("write");
-		fail_file();
+		cleanup();
+		close(fd_map);
+		return -1;
 	}
 	if (file_append_size) {
 		n = write(fd_map, file_append, file_append_size);
 		if (n != file_append_size) {
 			perror("write");
-			fail_file();
+			cleanup();
+			close(fd_map);
+			return -1;
 		}
 	}
 	close(fd_map);
 	if (rename(tmp_file, fname) < 0) {
 		perror(fname);
-		fail_file();
+		cleanup();
+		return -1;
 	}
+	return 0;
 }
 
 /* w8rev, w8nat, ...: Handle endianness. */
@@ -400,6 +408,8 @@ is_mcounted_section_name(char const *const txtname)
 		strcmp(".cpuidle.text", txtname) == 0;
 }
 
+static char const *already_has_rel_mcount = "success"; /* our work here is done! */
+
 /* 32 bit and 64 bit are very similar */
 #include "recordmcount.h"
 #define RECORD_MCOUNT_64
@@ -438,11 +448,15 @@ static void MIPS64_r_info(Elf64_Rel *const rp, unsigned sym, unsigned type)
 	}).r_info;
 }
 
-static void
+static int
 do_file(char const *const fname)
 {
 	Elf32_Ehdr *const ehdr = mmap_file(fname);
 	unsigned int reltype = 0;
+	int rc = -1;
+
+	if (!ehdr)
+		goto out;
 
 	w = w4nat;
 	w2 = w2nat;
@@ -452,8 +466,8 @@ do_file(char const *const fname)
 	default:
 		fprintf(stderr, "unrecognized ELF data encoding %d: %s\n",
 			ehdr->e_ident[EI_DATA], fname);
-		fail_file();
-		break;
+		cleanup();
+		goto out;
 	case ELFDATA2LSB:
 		if (*(unsigned char const *)&endian != 1) {
 			/* main() is big endian, file.o is little endian. */
@@ -485,7 +499,8 @@ do_file(char const *const fname)
 	||  w2(ehdr->e_type) != ET_REL
 	||  ehdr->e_ident[EI_VERSION] != EV_CURRENT) {
 		fprintf(stderr, "unrecognized ET_REL file %s\n", fname);
-		fail_file();
+		cleanup();
+		goto out;
 	}
 
 	gpfx = 0;
@@ -493,8 +508,8 @@ do_file(char const *const fname)
 	default:
 		fprintf(stderr, "unrecognized e_machine %u %s\n",
 			w2(ehdr->e_machine), fname);
-		fail_file();
-		break;
+		cleanup();
+		goto out;
 	case EM_386:
 		reltype = R_386_32;
 		rel_type_nop = R_386_NONE;
@@ -534,20 +549,22 @@ do_file(char const *const fname)
 	default:
 		fprintf(stderr, "unrecognized ELF class %d %s\n",
 			ehdr->e_ident[EI_CLASS], fname);
-		fail_file();
-		break;
+		cleanup();
+		goto out;
 	case ELFCLASS32:
 		if (w2(ehdr->e_ehsize) != sizeof(Elf32_Ehdr)
 		||  w2(ehdr->e_shentsize) != sizeof(Elf32_Shdr)) {
 			fprintf(stderr,
 				"unrecognized ET_REL file: %s\n", fname);
-			fail_file();
+			cleanup();
+			goto out;
 		}
 		if (w2(ehdr->e_machine) == EM_MIPS) {
 			reltype = R_MIPS_32;
 			is_fake_mcount32 = MIPS32_is_fake_mcount;
 		}
-		do32(ehdr, fname, reltype);
+		if (do32(ehdr, fname, reltype) < 0)
+			goto out;
 		break;
 	case ELFCLASS64: {
 		Elf64_Ehdr *const ghdr = (Elf64_Ehdr *)ehdr;
@@ -555,7 +572,8 @@ do_file(char const *const fname)
 		||  w2(ghdr->e_shentsize) != sizeof(Elf64_Shdr)) {
 			fprintf(stderr,
 				"unrecognized ET_REL file: %s\n", fname);
-			fail_file();
+			cleanup();
+			goto out;
 		}
 		if (w2(ghdr->e_machine) == EM_S390) {
 			reltype = R_390_64;
@@ -567,13 +585,16 @@ do_file(char const *const fname)
 			Elf64_r_info = MIPS64_r_info;
 			is_fake_mcount64 = MIPS64_is_fake_mcount;
 		}
-		do64(ghdr, fname, reltype);
+		if (do64(ghdr, fname, reltype) < 0)
+			goto out;
 		break;
 	}
 	}  /* end switch */
 
-	write_file(fname);
+	rc = write_file(fname);
+out:
 	cleanup();
+	return rc;
 }
 
 int
@@ -604,7 +625,6 @@ main(int argc, char *argv[])
 	/* Process each file in turn, allowing deep failure. */
 	for (i = optind; i < argc; i++) {
 		char *file = argv[i];
-		int const sjval = setjmp(jmpenv);
 		int len;
 
 		/*
@@ -617,28 +637,16 @@ main(int argc, char *argv[])
 		    strcmp(file + (len - ftrace_size), ftrace) == 0)
 			continue;
 
-		switch (sjval) {
-		default:
-			fprintf(stderr, "internal error: %s\n", file);
-			exit(1);
-			break;
-		case SJ_SETJMP:    /* normal sequence */
-			/* Avoid problems if early cleanup() */
-			fd_map = -1;
-			mmap_failed = 1;
-			file_map = NULL;
-			file_ptr = NULL;
-			file_updated = 0;
-			do_file(file);
-			break;
-		case SJ_FAIL:    /* error in do_file or below */
+		/* Avoid problems if early cleanup() */
+		fd_map = -1;
+		mmap_failed = 1;
+		file_map = NULL;
+		file_ptr = NULL;
+		file_updated = 0;
+		if (do_file(file)) {
 			fprintf(stderr, "%s: failed\n", file);
 			++n_error;
-			break;
-		case SJ_SUCCEED:    /* premature success */
-			/* do nothing */
-			break;
-		}  /* end switch */
+		}
 	}
 	return !!n_error;
 }
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index c1e1b04b4871..3796eb37fb12 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -174,7 +174,7 @@ static int MIPS_is_fake_mcount(Elf_Rel const *rp)
 }
 
 /* Append the new shstrtab, Elf_Shdr[], __mcount_loc and its relocations. */
-static void append_func(Elf_Ehdr *const ehdr,
+static int append_func(Elf_Ehdr *const ehdr,
 			Elf_Shdr *const shstr,
 			uint_t const *const mloc0,
 			uint_t const *const mlocp,
@@ -202,15 +202,20 @@ static void append_func(Elf_Ehdr *const ehdr,
 	new_e_shoff = t;
 
 	/* body for new shstrtab */
-	ulseek(sb.st_size, SEEK_SET);
-	uwrite(old_shstr_sh_offset + (void *)ehdr, old_shstr_sh_size);
-	uwrite(mc_name, 1 + strlen(mc_name));
+	if (ulseek(sb.st_size, SEEK_SET) < 0)
+		return -1;
+	if (uwrite(old_shstr_sh_offset + (void *)ehdr, old_shstr_sh_size) < 0)
+		return -1;
+	if (uwrite(mc_name, 1 + strlen(mc_name)) < 0)
+		return -1;
 
 	/* old(modified) Elf_Shdr table, word-byte aligned */
-	ulseek(t, SEEK_SET);
+	if (ulseek(t, SEEK_SET) < 0)
+		return -1;
 	t += sizeof(Elf_Shdr) * old_shnum;
-	uwrite(old_shoff + (void *)ehdr,
-	       sizeof(Elf_Shdr) * old_shnum);
+	if (uwrite(old_shoff + (void *)ehdr,
+	       sizeof(Elf_Shdr) * old_shnum) < 0)
+		return -1;
 
 	/* new sections __mcount_loc and .rel__mcount_loc */
 	t += 2*sizeof(mcsec);
@@ -225,7 +230,8 @@ static void append_func(Elf_Ehdr *const ehdr,
 	mcsec.sh_info = 0;
 	mcsec.sh_addralign = _w(_size);
 	mcsec.sh_entsize = _w(_size);
-	uwrite(&mcsec, sizeof(mcsec));
+	if (uwrite(&mcsec, sizeof(mcsec)) < 0)
+		return -1;
 
 	mcsec.sh_name = w(old_shstr_sh_size);
 	mcsec.sh_type = (sizeof(Elf_Rela) == rel_entsize)
@@ -239,15 +245,22 @@ static void append_func(Elf_Ehdr *const ehdr,
 	mcsec.sh_info = w(old_shnum);
 	mcsec.sh_addralign = _w(_size);
 	mcsec.sh_entsize = _w(rel_entsize);
-	uwrite(&mcsec, sizeof(mcsec));
 
-	uwrite(mloc0, (void *)mlocp - (void *)mloc0);
-	uwrite(mrel0, (void *)mrelp - (void *)mrel0);
+	if (uwrite(&mcsec, sizeof(mcsec)) < 0)
+		return -1;
+
+	if (uwrite(mloc0, (void *)mlocp - (void *)mloc0) < 0)
+		return -1;
+	if (uwrite(mrel0, (void *)mrelp - (void *)mrel0) < 0)
+		return -1;
 
 	ehdr->e_shoff = _w(new_e_shoff);
 	ehdr->e_shnum = w2(2 + w2(ehdr->e_shnum));  /* {.rel,}__mcount_loc */
-	ulseek(0, SEEK_SET);
-	uwrite(ehdr, sizeof(*ehdr));
+	if (ulseek(0, SEEK_SET) < 0)
+		return -1;
+	if (uwrite(ehdr, sizeof(*ehdr)) < 0)
+		return -1;
+	return 0;
 }
 
 static unsigned get_mcountsym(Elf_Sym const *const sym0,
@@ -351,9 +364,9 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
  * that are not going to be traced. The mcount calls here will be converted
  * into nops.
  */
-static void nop_mcount(Elf_Shdr const *const relhdr,
-		       Elf_Ehdr const *const ehdr,
-		       const char *const txtname)
+static int nop_mcount(Elf_Shdr const *const relhdr,
+		      Elf_Ehdr const *const ehdr,
+		      const char *const txtname)
 {
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
 		+ (void *)ehdr);
@@ -376,15 +389,18 @@ static void nop_mcount(Elf_Shdr const *const relhdr,
 			mcountsym = get_mcountsym(sym0, relp, str0);
 
 		if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
-			if (make_nop)
+			if (make_nop) {
 				ret = make_nop((void *)ehdr, _w(shdr->sh_offset) + _w(relp->r_offset));
+				if (ret < 0)
+					return -1;
+			}
 			if (warn_on_notrace_sect && !once) {
 				printf("Section %s has mcount callers being ignored\n",
 				       txtname);
 				once = 1;
 				/* just warn? */
 				if (!make_nop)
-					return;
+					return 0;
 			}
 		}
 
@@ -396,14 +412,16 @@ static void nop_mcount(Elf_Shdr const *const relhdr,
 			Elf_Rel rel;
 			rel = *(Elf_Rel *)relp;
 			Elf_r_info(&rel, Elf_r_sym(relp), rel_type_nop);
-			ulseek((void *)relp - (void *)ehdr, SEEK_SET);
-			uwrite(&rel, sizeof(rel));
+			if (ulseek((void *)relp - (void *)ehdr, SEEK_SET) < 0)
+				return -1;
+			if (uwrite(&rel, sizeof(rel)) < 0)
+				return -1;
 		}
 		relp = (Elf_Rel const *)(rel_entsize + (void *)relp);
 	}
+	return 0;
 }
 
-
 /*
  * Find a symbol in the given section, to be used as the base for relocating
  * the table of offsets of calls to mcount.  A local or global symbol suffices,
@@ -414,9 +432,10 @@ static void nop_mcount(Elf_Shdr const *const relhdr,
  *    Num:    Value  Size Type    Bind   Vis      Ndx Name
  *      2: 00000000     0 SECTION LOCAL  DEFAULT    1
  */
-static unsigned find_secsym_ndx(unsigned const txtndx,
+static int find_secsym_ndx(unsigned const txtndx,
 				char const *const txtname,
 				uint_t *const recvalp,
+				unsigned int *sym_index,
 				Elf_Shdr const *const symhdr,
 				Elf_Ehdr const *const ehdr)
 {
@@ -438,15 +457,16 @@ static unsigned find_secsym_ndx(unsigned const txtndx,
 				continue;
 
 			*recvalp = _w(symp->st_value);
-			return symp - sym0;
+			*sym_index = symp - sym0;
+			return 0;
 		}
 	}
 	fprintf(stderr, "Cannot find symbol for section %u: %s.\n",
 		txtndx, txtname);
-	fail_file();
+	cleanup();
+	return -1;
 }
 
-
 /* Evade ISO C restriction: no declaration after statement in has_rel_mcount. */
 static char const *
 __has_rel_mcount(Elf_Shdr const *const relhdr,  /* is SHT_REL or SHT_RELA */
@@ -461,7 +481,8 @@ __has_rel_mcount(Elf_Shdr const *const relhdr,  /* is SHT_REL or SHT_RELA */
 	if (strcmp("__mcount_loc", txtname) == 0) {
 		fprintf(stderr, "warning: __mcount_loc already exists: %s\n",
 			fname);
-		succeed_file();
+		cleanup();
+		return already_has_rel_mcount;
 	}
 	if (w(txthdr->sh_type) != SHT_PROGBITS ||
 	    !(_w(txthdr->sh_flags) & SHF_EXECINSTR))
@@ -491,6 +512,10 @@ static unsigned tot_relsize(Elf_Shdr const *const shdr0,
 
 	for (; nhdr; --nhdr, ++shdrp) {
 		txtname = has_rel_mcount(shdrp, shdr0, shstrtab, fname);
+		if (txtname == already_has_rel_mcount) {
+			totrelsz = 0;
+			break;
+		}
 		if (txtname && is_mcounted_section_name(txtname))
 			totrelsz += _w(shdrp->sh_size);
 	}
@@ -499,7 +524,7 @@ static unsigned tot_relsize(Elf_Shdr const *const shdr0,
 
 
 /* Overall supervision for Elf32 ET_REL file. */
-static void
+static int
 do_func(Elf_Ehdr *const ehdr, char const *const fname, unsigned const reltype)
 {
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
@@ -513,26 +538,54 @@ do_func(Elf_Ehdr *const ehdr, char const *const fname, unsigned const reltype)
 	unsigned k;
 
 	/* Upper bound on space: assume all relevant relocs are for mcount. */
-	unsigned const totrelsz = tot_relsize(shdr0, nhdr, shstrtab, fname);
-	Elf_Rel *const mrel0 = umalloc(totrelsz);
-	Elf_Rel *      mrelp = mrel0;
+	unsigned       totrelsz;
 
-	/* 2*sizeof(address) <= sizeof(Elf_Rel) */
-	uint_t *const mloc0 = umalloc(totrelsz>>1);
-	uint_t *      mlocp = mloc0;
+	Elf_Rel *      mrel0;
+	Elf_Rel *      mrelp;
+
+	uint_t *      mloc0;
+	uint_t *      mlocp;
 
 	unsigned rel_entsize = 0;
 	unsigned symsec_sh_link = 0;
 
+	int result = 0;
+
+	totrelsz = tot_relsize(shdr0, nhdr, shstrtab, fname);
+	if (totrelsz == 0)
+		return 0;
+	mrel0 = umalloc(totrelsz);
+	mrelp = mrel0;
+	if (!mrel0)
+		return -1;
+
+	/* 2*sizeof(address) <= sizeof(Elf_Rel) */
+	mloc0 = umalloc(totrelsz>>1);
+	mlocp = mloc0;
+	if (!mloc0) {
+		free(mrel0);
+		return -1;
+	}
+
 	for (relhdr = shdr0, k = nhdr; k; --k, ++relhdr) {
 		char const *const txtname = has_rel_mcount(relhdr, shdr0,
 			shstrtab, fname);
+		if (txtname == already_has_rel_mcount) {
+			result = 0;
+			file_updated = 0;
+			goto out; /* Nothing to be done; don't append! */
+		}
 		if (txtname && is_mcounted_section_name(txtname)) {
+			unsigned int recsym;
 			uint_t recval = 0;
-			unsigned const recsym = find_secsym_ndx(
-				w(relhdr->sh_info), txtname, &recval,
-				&shdr0[symsec_sh_link = w(relhdr->sh_link)],
-				ehdr);
+
+			symsec_sh_link = w(relhdr->sh_link);
+			result = find_secsym_ndx(w(relhdr->sh_info), txtname,
+						&recval, &recsym,
+						&shdr0[symsec_sh_link],
+						ehdr);
+			if (result)
+				goto out;
 
 			rel_entsize = _w(relhdr->sh_entsize);
 			mlocp = sift_rel_mcount(mlocp,
@@ -543,13 +596,17 @@ do_func(Elf_Ehdr *const ehdr, char const *const fname, unsigned const reltype)
 			 * This section is ignored by ftrace, but still
 			 * has mcount calls. Convert them to nops now.
 			 */
-			nop_mcount(relhdr, ehdr, txtname);
+			if (nop_mcount(relhdr, ehdr, txtname) < 0) {
+				result = -1;
+				goto out;
+			}
 		}
 	}
-	if (mloc0 != mlocp) {
-		append_func(ehdr, shstr, mloc0, mlocp, mrel0, mrelp,
-			    rel_entsize, symsec_sh_link);
-	}
+	if (!result && mloc0 != mlocp)
+		result = append_func(ehdr, shstr, mloc0, mlocp, mrel0, mrelp,
+				     rel_entsize, symsec_sh_link);
+out:
 	free(mrel0);
 	free(mloc0);
+	return result;
 }
-- 
2.20.1


