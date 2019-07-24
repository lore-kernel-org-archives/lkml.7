Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3629C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBBD21880
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbfGXVFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 17:05:33 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:26268 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387955AbfGXVF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 17:05:28 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 24 Jul 2019 14:05:11 -0700
Received: from rlwimi.localdomain (unknown [10.166.65.164])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id DF61F40708;
        Wed, 24 Jul 2019 14:05:25 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH v3 03/13] recordmcount: Remove unused fd from uwrite() and ulseek()
Date:   Wed, 24 Jul 2019 14:04:57 -0700
Message-ID: <2a136e820ee208469d375265c7b8eb28570749a0.1563992889.git.mhelsley@vmware.com>
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

uwrite() works within the pseudo-mapping and extends it as necessary
without needing the file descriptor (fd) parameter passed to it.
Similarly, ulseek() doesn't need its fd parameter. These parameters
were only added because the functions bear a conceptual resemblance
to write() and lseek(). Worse, they obscure the fact that at the time
uwrite() and ulseek() are called fd_map is not a valid file descriptor.

Remove the unused file descriptor parameters that make it look like
fd_map is still valid.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 scripts/recordmcount.c | 16 ++++++++--------
 scripts/recordmcount.h | 26 +++++++++++++-------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index c0dd46344063..1fe5fba99959 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -92,7 +92,7 @@ succeed_file(void)
 /* ulseek, uwrite, ...:  Check return value for errors. */
 
 static off_t
-ulseek(int const fd, off_t const offset, int const whence)
+ulseek(off_t const offset, int const whence)
 {
 	switch (whence) {
 	case SEEK_SET:
@@ -113,7 +113,7 @@ ulseek(int const fd, off_t const offset, int const whence)
 }
 
 static size_t
-uwrite(int const fd, void const *const buf, size_t const count)
+uwrite(void const *const buf, size_t const count)
 {
 	size_t cnt = count;
 	off_t idx = 0;
@@ -183,8 +183,8 @@ static int make_nop_x86(void *map, size_t const offset)
 		return -1;
 
 	/* convert to nop */
-	ulseek(fd_map, offset - 1, SEEK_SET);
-	uwrite(fd_map, ideal_nop, 5);
+	ulseek(offset - 1, SEEK_SET);
+	uwrite(ideal_nop, 5);
 	return 0;
 }
 
@@ -232,10 +232,10 @@ static int make_nop_arm(void *map, size_t const offset)
 		return -1;
 
 	/* Convert to nop */
-	ulseek(fd_map, off, SEEK_SET);
+	ulseek(off, SEEK_SET);
 
 	do {
-		uwrite(fd_map, ideal_nop, nop_size);
+		uwrite(ideal_nop, nop_size);
 	} while (--cnt > 0);
 
 	return 0;
@@ -252,8 +252,8 @@ static int make_nop_arm64(void *map, size_t const offset)
 		return -1;
 
 	/* Convert to nop */
-	ulseek(fd_map, offset, SEEK_SET);
-	uwrite(fd_map, ideal_nop, 4);
+	ulseek(offset, SEEK_SET);
+	uwrite(ideal_nop, 4);
 	return 0;
 }
 
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 47fca2c69a73..c1e1b04b4871 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -202,14 +202,14 @@ static void append_func(Elf_Ehdr *const ehdr,
 	new_e_shoff = t;
 
 	/* body for new shstrtab */
-	ulseek(fd_map, sb.st_size, SEEK_SET);
-	uwrite(fd_map, old_shstr_sh_offset + (void *)ehdr, old_shstr_sh_size);
-	uwrite(fd_map, mc_name, 1 + strlen(mc_name));
+	ulseek(sb.st_size, SEEK_SET);
+	uwrite(old_shstr_sh_offset + (void *)ehdr, old_shstr_sh_size);
+	uwrite(mc_name, 1 + strlen(mc_name));
 
 	/* old(modified) Elf_Shdr table, word-byte aligned */
-	ulseek(fd_map, t, SEEK_SET);
+	ulseek(t, SEEK_SET);
 	t += sizeof(Elf_Shdr) * old_shnum;
-	uwrite(fd_map, old_shoff + (void *)ehdr,
+	uwrite(old_shoff + (void *)ehdr,
 	       sizeof(Elf_Shdr) * old_shnum);
 
 	/* new sections __mcount_loc and .rel__mcount_loc */
@@ -225,7 +225,7 @@ static void append_func(Elf_Ehdr *const ehdr,
 	mcsec.sh_info = 0;
 	mcsec.sh_addralign = _w(_size);
 	mcsec.sh_entsize = _w(_size);
-	uwrite(fd_map, &mcsec, sizeof(mcsec));
+	uwrite(&mcsec, sizeof(mcsec));
 
 	mcsec.sh_name = w(old_shstr_sh_size);
 	mcsec.sh_type = (sizeof(Elf_Rela) == rel_entsize)
@@ -239,15 +239,15 @@ static void append_func(Elf_Ehdr *const ehdr,
 	mcsec.sh_info = w(old_shnum);
 	mcsec.sh_addralign = _w(_size);
 	mcsec.sh_entsize = _w(rel_entsize);
-	uwrite(fd_map, &mcsec, sizeof(mcsec));
+	uwrite(&mcsec, sizeof(mcsec));
 
-	uwrite(fd_map, mloc0, (void *)mlocp - (void *)mloc0);
-	uwrite(fd_map, mrel0, (void *)mrelp - (void *)mrel0);
+	uwrite(mloc0, (void *)mlocp - (void *)mloc0);
+	uwrite(mrel0, (void *)mrelp - (void *)mrel0);
 
 	ehdr->e_shoff = _w(new_e_shoff);
 	ehdr->e_shnum = w2(2 + w2(ehdr->e_shnum));  /* {.rel,}__mcount_loc */
-	ulseek(fd_map, 0, SEEK_SET);
-	uwrite(fd_map, ehdr, sizeof(*ehdr));
+	ulseek(0, SEEK_SET);
+	uwrite(ehdr, sizeof(*ehdr));
 }
 
 static unsigned get_mcountsym(Elf_Sym const *const sym0,
@@ -396,8 +396,8 @@ static void nop_mcount(Elf_Shdr const *const relhdr,
 			Elf_Rel rel;
 			rel = *(Elf_Rel *)relp;
 			Elf_r_info(&rel, Elf_r_sym(relp), rel_type_nop);
-			ulseek(fd_map, (void *)relp - (void *)ehdr, SEEK_SET);
-			uwrite(fd_map, &rel, sizeof(rel));
+			ulseek((void *)relp - (void *)ehdr, SEEK_SET);
+			uwrite(&rel, sizeof(rel));
 		}
 		relp = (Elf_Rel const *)(rel_entsize + (void *)relp);
 	}
-- 
2.20.1

