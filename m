Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFDCC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2ED20643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YuoHdoCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfDSTBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:01:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55773 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbfDSTBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:01:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JJ192M392577
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 12:01:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JJ192M392577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555700469;
        bh=R0oSIO9Gq6h4PXcSM+joBS74mSRr59UfK0izs7A6W3k=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YuoHdoCqLzphOqw5mBCEA2vT1JHSLcf1Yq6yHEobk760Izekf53Wqubs5Oebde/j/
         aBbycJIpRYOlC00w6Q7J+e5ogLv4iAqH1rsXrWpSPSf88reHIMUM2LB517lzmL4b6u
         9iDlYVHxtxC177+gAYOnsOQhoTB1y3WnsIsSa82LPTobjQv7J3ue57nFCcHwb2z6lo
         tPs77Nk9He6r9jUIisOBDosfSRzWQgd/sRzLNiGKZPLcjjdNr28XHdWbJTQcXSgVzP
         LA/xmotOmoaMiMAw1ZLuclyl/NeanCQvaVaw39A87lIwuX2QEvC17OU6sNB1qQS6Ff
         /wNvB3o0E3NSQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JJ18Ii392571;
        Fri, 19 Apr 2019 12:01:08 -0700
Date:   Fri, 19 Apr 2019 12:01:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Artem Savkov <tipbot@zytor.com>
Message-ID: <tip-f36e7495dd3990d6848e6d6703c78f1f17a97538@git.kernel.org>
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        hpa@zytor.com, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        asavkov@redhat.com, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, joe.lawrence@redhat.com
Reply-To: tglx@linutronix.de, asavkov@redhat.com,
          linux-kernel@vger.kernel.org, jpoimboe@redhat.com, hpa@zytor.com,
          ebiederm@xmission.com, torvalds@linux-foundation.org,
          mingo@kernel.org, joe.lawrence@redhat.com, peterz@infradead.org
In-Reply-To: <20181129155615.2594-1-asavkov@redhat.com>
References: <20181129155615.2594-1-asavkov@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/tools/relocs: Fix big section header tables
Git-Commit-ID: f36e7495dd3990d6848e6d6703c78f1f17a97538
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f36e7495dd3990d6848e6d6703c78f1f17a97538
Gitweb:     https://git.kernel.org/tip/f36e7495dd3990d6848e6d6703c78f1f17a97538
Author:     Artem Savkov <asavkov@redhat.com>
AuthorDate: Thu, 29 Nov 2018 16:56:15 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 20:54:07 +0200

x86/tools/relocs: Fix big section header tables

In case when the number of entries in the section header table is larger
then or equal to SHN_LORESERVE the size of the table is held in the sh_size
member of the initial entry in section header table instead of e_shnum.
Same with the string table index which is located in sh_link instead of
e_shstrndx.

This case is easily reproducible with KCFLAGS="-ffunction-sections",
bzImage build fails with "String table index out of bounds" error.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Eric W . Biederman <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181129155615.2594-1-asavkov@redhat.com
[ Simplify the die() lines. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/tools/relocs.c | 74 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 29 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index b629f6992d9f..f345586f5e50 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -11,7 +11,9 @@
 #define Elf_Shdr		ElfW(Shdr)
 #define Elf_Sym			ElfW(Sym)
 
-static Elf_Ehdr ehdr;
+static Elf_Ehdr		ehdr;
+static unsigned long	shnum;
+static unsigned int	shstrndx;
 
 struct relocs {
 	uint32_t	*offset;
@@ -241,9 +243,9 @@ static const char *sec_name(unsigned shndx)
 {
 	const char *sec_strtab;
 	const char *name;
-	sec_strtab = secs[ehdr.e_shstrndx].strtab;
+	sec_strtab = secs[shstrndx].strtab;
 	name = "<noname>";
-	if (shndx < ehdr.e_shnum) {
+	if (shndx < shnum) {
 		name = sec_strtab + secs[shndx].shdr.sh_name;
 	}
 	else if (shndx == SHN_ABS) {
@@ -271,7 +273,7 @@ static const char *sym_name(const char *sym_strtab, Elf_Sym *sym)
 static Elf_Sym *sym_lookup(const char *symname)
 {
 	int i;
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		long nsyms;
 		char *strtab;
@@ -366,27 +368,41 @@ static void read_ehdr(FILE *fp)
 	ehdr.e_shnum     = elf_half_to_cpu(ehdr.e_shnum);
 	ehdr.e_shstrndx  = elf_half_to_cpu(ehdr.e_shstrndx);
 
-	if ((ehdr.e_type != ET_EXEC) && (ehdr.e_type != ET_DYN)) {
+	shnum = ehdr.e_shnum;
+	shstrndx = ehdr.e_shstrndx;
+
+	if ((ehdr.e_type != ET_EXEC) && (ehdr.e_type != ET_DYN))
 		die("Unsupported ELF header type\n");
-	}
-	if (ehdr.e_machine != ELF_MACHINE) {
+	if (ehdr.e_machine != ELF_MACHINE)
 		die("Not for %s\n", ELF_MACHINE_NAME);
-	}
-	if (ehdr.e_version != EV_CURRENT) {
+	if (ehdr.e_version != EV_CURRENT)
 		die("Unknown ELF version\n");
-	}
-	if (ehdr.e_ehsize != sizeof(Elf_Ehdr)) {
+	if (ehdr.e_ehsize != sizeof(Elf_Ehdr))
 		die("Bad Elf header size\n");
-	}
-	if (ehdr.e_phentsize != sizeof(Elf_Phdr)) {
+	if (ehdr.e_phentsize != sizeof(Elf_Phdr))
 		die("Bad program header entry\n");
-	}
-	if (ehdr.e_shentsize != sizeof(Elf_Shdr)) {
+	if (ehdr.e_shentsize != sizeof(Elf_Shdr))
 		die("Bad section header entry\n");
+
+
+	if (shnum == SHN_UNDEF || shstrndx == SHN_XINDEX) {
+		Elf_Shdr shdr;
+
+		if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0)
+			die("Seek to %d failed: %s\n", ehdr.e_shoff, strerror(errno));
+
+		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
+			die("Cannot read initial ELF section header: %s\n", strerror(errno));
+
+		if (shnum == SHN_UNDEF)
+			shnum = elf_xword_to_cpu(shdr.sh_size);
+
+		if (shstrndx == SHN_XINDEX)
+			shstrndx = elf_word_to_cpu(shdr.sh_link);
 	}
-	if (ehdr.e_shstrndx >= ehdr.e_shnum) {
+
+	if (shstrndx >= shnum)
 		die("String table index out of bounds\n");
-	}
 }
 
 static void read_shdrs(FILE *fp)
@@ -394,20 +410,20 @@ static void read_shdrs(FILE *fp)
 	int i;
 	Elf_Shdr shdr;
 
-	secs = calloc(ehdr.e_shnum, sizeof(struct section));
+	secs = calloc(shnum, sizeof(struct section));
 	if (!secs) {
 		die("Unable to allocate %d section headers\n",
-		    ehdr.e_shnum);
+		    shnum);
 	}
 	if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0) {
 		die("Seek to %d failed: %s\n",
 			ehdr.e_shoff, strerror(errno));
 	}
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
 			die("Cannot read ELF section headers %d/%d: %s\n",
-			    i, ehdr.e_shnum, strerror(errno));
+			    i, shnum, strerror(errno));
 		sec->shdr.sh_name      = elf_word_to_cpu(shdr.sh_name);
 		sec->shdr.sh_type      = elf_word_to_cpu(shdr.sh_type);
 		sec->shdr.sh_flags     = elf_xword_to_cpu(shdr.sh_flags);
@@ -418,7 +434,7 @@ static void read_shdrs(FILE *fp)
 		sec->shdr.sh_info      = elf_word_to_cpu(shdr.sh_info);
 		sec->shdr.sh_addralign = elf_xword_to_cpu(shdr.sh_addralign);
 		sec->shdr.sh_entsize   = elf_xword_to_cpu(shdr.sh_entsize);
-		if (sec->shdr.sh_link < ehdr.e_shnum)
+		if (sec->shdr.sh_link < shnum)
 			sec->link = &secs[sec->shdr.sh_link];
 	}
 
@@ -427,7 +443,7 @@ static void read_shdrs(FILE *fp)
 static void read_strtabs(FILE *fp)
 {
 	int i;
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		if (sec->shdr.sh_type != SHT_STRTAB) {
 			continue;
@@ -452,7 +468,7 @@ static void read_strtabs(FILE *fp)
 static void read_symtabs(FILE *fp)
 {
 	int i,j;
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		if (sec->shdr.sh_type != SHT_SYMTAB) {
 			continue;
@@ -485,7 +501,7 @@ static void read_symtabs(FILE *fp)
 static void read_relocs(FILE *fp)
 {
 	int i,j;
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		if (sec->shdr.sh_type != SHT_REL_TYPE) {
 			continue;
@@ -528,7 +544,7 @@ static void print_absolute_symbols(void)
 
 	printf("Absolute symbols\n");
 	printf(" Num:    Value Size  Type       Bind        Visibility  Name\n");
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		char *sym_strtab;
 		int j;
@@ -566,7 +582,7 @@ static void print_absolute_relocs(void)
 	else
 		format = "%08"PRIx32" %08"PRIx32" %10s %08"PRIx32"  %s\n";
 
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		struct section *sec_applies, *sec_symtab;
 		char *sym_strtab;
@@ -650,7 +666,7 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 {
 	int i;
 	/* Walk through the relocations */
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		char *sym_strtab;
 		Elf_Sym *sh_symtab;
 		struct section *sec_applies, *sec_symtab;
@@ -706,7 +722,7 @@ static Elf_Addr per_cpu_load_addr;
 static void percpu_init(void)
 {
 	int i;
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		ElfW(Sym) *sym;
 		if (strcmp(sec_name(i), ".data..percpu"))
 			continue;
