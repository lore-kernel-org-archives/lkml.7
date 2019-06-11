Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE60CC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE39D2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436919AbfFKWW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 18:22:29 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:3298 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436857AbfFKWWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:22:22 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 11 Jun 2019 15:22:13 -0700
Received: from rlwimi.localdomain (unknown [10.129.220.121])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 8236741BB0;
        Tue, 11 Jun 2019 15:22:19 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH v2 12/13] objtool: recordmcount: Search for __mcount_loc before walking the sections
Date:   Tue, 11 Jun 2019 15:21:54 -0700
Message-ID: <647d2e73e05c21cbc6ee7bc411b29602945c77fb.1560285597.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1560285597.git.mhelsley@vmware.com>
References: <cover.1560285597.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

recordmcount iterates over the sections in the order they're
listed in the ELF file and checks whether the section name
indicates it's of interest. Objtool's elf code works differently
 -- it scans the elf file and builds up data structures
representing the headers, sections, etc. and then supplies
functions to search these structures. Both walk the elf file
in order, however objtool uses more memory to enable faster
searches it needs for other tools such as the reliable backtrace
support offered by the ORC unwinder.

Rather than walk the section table a second time in the recordmcount
code, we use objtool's elf code to search for the section
recordmcount is interested in. This also simplifies flow and means
we can easily check for already-processed object files before we
do any of the more complex things recordmcount does.

This also allows us to remove the already_has_rel_mcount string
pointer trick.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c |  2 --
 tools/objtool/recordmcount.h | 22 +++-------------------
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 61050b78d5a0..649a03e463dd 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -204,8 +204,6 @@ static void *mmap_file(char const *fname)
 	} else
 		mmap_failed = 0;
 out:
-	elf_close(lf);
-	lf = NULL;
 	fd_map = -1;
 
 	file_end = file_map + sb.st_size;
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index b7348f1af758..03643c68486b 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -26,7 +26,6 @@
 #undef nop_mcount
 #undef missing_sym
 #undef find_secsym_ndx
-#undef already_has_rel_mcount
 #undef __has_rel_mcount
 #undef has_rel_mcount
 #undef tot_relsize
@@ -58,7 +57,6 @@
 # define nop_mcount		nop_mcount_64
 # define missing_sym		missing_sym_64
 # define find_secsym_ndx	find64_secsym_ndx
-# define already_has_rel_mcount	already_has_rel_mcount_64
 # define __has_rel_mcount	__has64_rel_mcount
 # define has_rel_mcount		has64_rel_mcount
 # define tot_relsize		tot64_relsize
@@ -93,7 +91,6 @@
 # define nop_mcount		nop_mcount_32
 # define missing_sym		missing_sym_32
 # define find_secsym_ndx	find32_secsym_ndx
-# define already_has_rel_mcount	already_has_rel_mcount_32
 # define __has_rel_mcount	__has32_rel_mcount
 # define has_rel_mcount		has32_rel_mcount
 # define tot_relsize		tot32_relsize
@@ -471,8 +468,6 @@ static unsigned find_secsym_ndx(unsigned const txtndx,
 	return missing_sym;
 }
 
-char const *already_has_rel_mcount = "success"; /* our work here is done! */
-
 /* Evade ISO C restriction: no declaration after statement in has_rel_mcount. */
 static char const * __has_rel_mcount(Elf_Shdr const *const relhdr, /* reltype */
 				     Elf_Shdr const *const shdr0,
@@ -483,11 +478,6 @@ static char const * __has_rel_mcount(Elf_Shdr const *const relhdr, /* reltype */
 	Elf_Shdr const *const txthdr = &shdr0[w(relhdr->sh_info)];
 	char const *const txtname = &shstrtab[w(txthdr->sh_name)];
 
-	if (strcmp("__mcount_loc", txtname) == 0) {
-		fprintf(stderr, "warning: __mcount_loc already exists: %s\n",
-			fname);
-		return already_has_rel_mcount;
-	}
 	if (w(txthdr->sh_type) != SHT_PROGBITS ||
 	    !(_w(txthdr->sh_flags) & SHF_EXECINSTR))
 		return NULL;
@@ -516,10 +506,6 @@ static unsigned tot_relsize(Elf_Shdr const *const shdr0,
 
 	for (; nhdr; --nhdr, ++shdrp) {
 		txtname = has_rel_mcount(shdrp, shdr0, shstrtab, fname);
-		if (txtname == already_has_rel_mcount) {
-			totrelsz = 0;
-			break;
-		}
 		if (txtname && is_mcounted_section_name(txtname))
 			totrelsz += _w(shdrp->sh_size);
 	}
@@ -555,6 +541,9 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 
 	int result = 0;
 
+	if (find_section_by_name(lf, "__mcount_loc") != NULL)
+		return 0;
+
 	totrelsz = tot_relsize(shdr0, nhdr, shstrtab, fname);
 	if (totrelsz == 0)
 		return 0;
@@ -574,11 +563,6 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 	for (relhdr = shdr0, k = nhdr; k; --k, ++relhdr) {
 		char const *const txtname = has_rel_mcount(relhdr, shdr0,
 			shstrtab, fname);
-		if (txtname == already_has_rel_mcount) {
-			result = 0;
-			file_updated = 0;
-			goto out; /* Nothing to be done; don't append! */
-		}
 		if (txtname && is_mcounted_section_name(txtname)) {
 			uint_t recval = 0;
 			unsigned const int recsym = find_secsym_ndx(
-- 
2.20.1

