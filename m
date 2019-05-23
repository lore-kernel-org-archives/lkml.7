Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE21C282DC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE73A20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfEWAED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:04:03 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:9702 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726890AbfEWAD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:03:57 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 22 May 2019 17:03:49 -0700
Received: from rlwimi.localdomain (unknown [10.129.221.32])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 87311B2067;
        Wed, 22 May 2019 20:03:56 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 07/13] recordmcount: Remove redundant cleanup() calls
Date:   Wed, 22 May 2019 17:03:30 -0700
Message-ID: <29af02c412faf7507561dc25d58eb73740da1c67.1558569448.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558569448.git.mhelsley@vmware.com>
References: <cover.1558569448.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Redundant cleanup calls were introduced when transitioning from
the old error/success handling via setjmp/longjmp -- the longjmp
ensured the cleanup() call only happened once but replacing
the success_file()/fail_file() calls with cleanup() meant that
multiple cleanup() calls can happen as we return from function
calls.

In do_file(), looking just before and after the "goto out" jumps we
can see that multiple cleanups() are being performed. We remove
cleanup() calls from the nested functions because it makes the code
easier to review -- the resources being cleaned up are generally
allocated and initialized in the callers so freeing them there
makes more sense.

Other redundant cleanup() calls:

mmap_file() is only called from do_file() and, if mmap_file() fails,
then we goto out and do cleanup() there too.

write_file() is only called from do_file() and do_file()
calls cleanup() unconditionally after returning from write_file()
therefore the cleanup() calls in write_file() are not necessary.

find_secsym_ndx(), called from do_func()'s for-loop, when we are
cleaning up here it's obvious that we break out of the loop and
do another cleanup().

__has_rel_mcount() is called from two parts of do_func()
and calls cleanup(). In theory we move them into do_func(), however
these in turn prove redundant so another simplification step
removes them as well.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 scripts/recordmcount.c | 13 -------------
 scripts/recordmcount.h |  2 --
 2 files changed, 15 deletions(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 3301769254ec..1c8b38c0d7fe 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -258,17 +258,14 @@ static void *mmap_file(char const *fname)
 	fd_map = open(fname, O_RDONLY);
 	if (fd_map < 0) {
 		perror(fname);
-		cleanup();
 		return NULL;
 	}
 	if (fstat(fd_map, &sb) < 0) {
 		perror(fname);
-		cleanup();
 		goto out;
 	}
 	if (!S_ISREG(sb.st_mode)) {
 		fprintf(stderr, "not a regular file: %s\n", fname);
-		cleanup();
 		goto out;
 	}
 	file_map = mmap(0, sb.st_size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
@@ -314,13 +311,11 @@ static int write_file(const char *fname)
 	fd_map = open(tmp_file, O_WRONLY | O_TRUNC | O_CREAT, sb.st_mode);
 	if (fd_map < 0) {
 		perror(fname);
-		cleanup();
 		return -1;
 	}
 	n = write(fd_map, file_map, sb.st_size);
 	if (n != sb.st_size) {
 		perror("write");
-		cleanup();
 		close(fd_map);
 		return -1;
 	}
@@ -328,7 +323,6 @@ static int write_file(const char *fname)
 		n = write(fd_map, file_append, file_append_size);
 		if (n != file_append_size) {
 			perror("write");
-			cleanup();
 			close(fd_map);
 			return -1;
 		}
@@ -336,7 +330,6 @@ static int write_file(const char *fname)
 	close(fd_map);
 	if (rename(tmp_file, fname) < 0) {
 		perror(fname);
-		cleanup();
 		return -1;
 	}
 	return 0;
@@ -458,7 +451,6 @@ static int do_file(char const *const fname)
 	default:
 		fprintf(stderr, "unrecognized ELF data encoding %d: %s\n",
 			ehdr->e_ident[EI_DATA], fname);
-		cleanup();
 		goto out;
 	case ELFDATA2LSB:
 		if (*(unsigned char const *)&endian != 1) {
@@ -491,7 +483,6 @@ static int do_file(char const *const fname)
 	    w2(ehdr->e_type) != ET_REL ||
 	    ehdr->e_ident[EI_VERSION] != EV_CURRENT) {
 		fprintf(stderr, "unrecognized ET_REL file %s\n", fname);
-		cleanup();
 		goto out;
 	}
 
@@ -500,7 +491,6 @@ static int do_file(char const *const fname)
 	default:
 		fprintf(stderr, "unrecognized e_machine %u %s\n",
 			w2(ehdr->e_machine), fname);
-		cleanup();
 		goto out;
 	case EM_386:
 		reltype = R_386_32;
@@ -544,14 +534,12 @@ static int do_file(char const *const fname)
 	default:
 		fprintf(stderr, "unrecognized ELF class %d %s\n",
 			ehdr->e_ident[EI_CLASS], fname);
-		cleanup();
 		goto out;
 	case ELFCLASS32:
 		if (w2(ehdr->e_ehsize) != sizeof(Elf32_Ehdr)
 		||  w2(ehdr->e_shentsize) != sizeof(Elf32_Shdr)) {
 			fprintf(stderr,
 				"unrecognized ET_REL file: %s\n", fname);
-			cleanup();
 			goto out;
 		}
 		if (w2(ehdr->e_machine) == EM_MIPS) {
@@ -567,7 +555,6 @@ static int do_file(char const *const fname)
 		||  w2(ghdr->e_shentsize) != sizeof(Elf64_Shdr)) {
 			fprintf(stderr,
 				"unrecognized ET_REL file: %s\n", fname);
-			cleanup();
 			goto out;
 		}
 		if (w2(ghdr->e_machine) == EM_S390) {
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 0ce8e0aaa5ec..ffab6bb96852 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -469,7 +469,6 @@ static unsigned find_secsym_ndx(unsigned const txtndx,
 	}
 	fprintf(stderr, "Cannot find symbol for section %u: %s.\n",
 		txtndx, txtname);
-	cleanup();
 	return missing_sym;
 }
 
@@ -488,7 +487,6 @@ static char const * __has_rel_mcount(Elf_Shdr const *const relhdr, /* reltype */
 	if (strcmp("__mcount_loc", txtname) == 0) {
 		fprintf(stderr, "warning: __mcount_loc already exists: %s\n",
 			fname);
-		cleanup();
 		return already_has_rel_mcount;
 	}
 	if (w(txthdr->sh_type) != SHT_PROGBITS ||
-- 
2.20.1

