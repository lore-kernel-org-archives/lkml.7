Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7BBC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 17:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A423620409
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 17:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFLOT6Uq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfLHRMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 12:12:49 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:52944 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfLHRMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 12:12:49 -0500
Received: by mail-wm1-f43.google.com with SMTP id p9so12917265wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 09:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VKUfXsWo+4UBPTp3/qUbXcAxcxx4tJXBHax20EFoN3M=;
        b=HFLOT6UqTMgKAYSmpytxA2BTMETmZEXhVVkFiZRbrjgvU3lUDugVqmdG26PKg1W7ad
         tK2/I/WpJl2CiHwTiul6D+FebSqqJBSeOwQSWK5IxDIKkEiEllUsat/0PLF2V9H1n0WC
         kz5VEWX3wzelg0d8k9V5G0vZZeTsu+/RwOk/LD7j4HDMVCD+lUprVk8lTDLvgLiDO99v
         P8Yp/5+E9GYN+IpqneDjOftNgW6tbiHLkoYOKSgpdxLUfKwNNg4dA3uZeyGtsC5q/B5Y
         uKn2tnHKkbrXSRgr2RIYRTq53xxbT/jW198gmJZjsCppk/mdgJkuhxT3PEd0wjXAtrkZ
         9QRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VKUfXsWo+4UBPTp3/qUbXcAxcxx4tJXBHax20EFoN3M=;
        b=Pm65cRcpvUhSaK0HUrGvUrJgfADbBuw/cAohUdPfA5lNkIqFz5ZHoxZqS26ewxMXva
         AtpBAMxwuYVOLlWob4RERayuBS41jEY48ucEpIp7vYwlOwGqcKJdhgB3Ogrf3ohxufLr
         IpLBrUdl7qB4XqBMZB29agsth/VEuXdIJj9MlQOmD7JSedNrtksPh8jgfjvIDcx/W819
         mrJMmAOOnEmDMpFc1EBRuzJO/kdYShJHsxNLtZjjvVgljj1qny33orYp3A68cmGL9Kex
         LVnTIn2Q5404cMVJLis1Tc127BCr5hvyjFbumfeV+UuruNV7FhEdTgNTXWTyR6y5Unzi
         uStg==
X-Gm-Message-State: APjAAAXjrFn30KKBYcljSAhDDkJ7/jt54nwBRDWm7G2nRLIiHulFZNXx
        0ABddj66d73lv6QJynM+0uFkN74=
X-Google-Smtp-Source: APXvYqyPPtyawZefUu8w8YPyiSJycnZ57jPa+/R8lUU4duW5o3SD7NeyVyLGp8UthHXJZ2a4Y/57Sg==
X-Received: by 2002:a1c:46:: with SMTP id 67mr20659705wma.51.1575825166167;
        Sun, 08 Dec 2019 09:12:46 -0800 (PST)
Received: from avx2 ([46.53.249.42])
        by smtp.gmail.com with ESMTPSA id l6sm10574983wme.42.2019.12.08.09.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 09:12:45 -0800 (PST)
Date:   Sun, 8 Dec 2019 20:12:42 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ELF: don't copy ELF header around
Message-ID: <20191208171242.GA19716@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ELF header is read into bprm->buf[] by generic execve code.

Save a memcpy and allocate just one header for the interpreter instead
of two headers (64 bytes instead of 128 on 64-bit).

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |   55 +++++++++++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -161,8 +161,9 @@ static int padzero(unsigned long elf_bss)
 #endif
 
 static int
-create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
-		unsigned long load_addr, unsigned long interp_load_addr)
+create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
+		unsigned long load_addr, unsigned long interp_load_addr,
+		unsigned long e_entry)
 {
 	unsigned long p = bprm->p;
 	int argc = bprm->argc;
@@ -251,7 +252,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
 	NEW_AUX_ENT(AT_FLAGS, 0);
-	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
+	NEW_AUX_ENT(AT_ENTRY, e_entry);
 	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
 	NEW_AUX_ENT(AT_GID, from_kgid_munged(cred->user_ns, cred->gid));
@@ -689,12 +690,13 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	int bss_prot = 0;
 	int retval, i;
 	unsigned long elf_entry;
+	unsigned long e_entry;
 	unsigned long interp_load_addr = 0;
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long reloc_func_desc __maybe_unused = 0;
 	int executable_stack = EXSTACK_DEFAULT;
+	struct elfhdr *elf_ex = (struct elfhdr *)bprm->buf;
 	struct {
-		struct elfhdr elf_ex;
 		struct elfhdr interp_elf_ex;
 	} *loc;
 	struct arch_elf_state arch_state = INIT_ARCH_ELF_STATE;
@@ -705,30 +707,27 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		retval = -ENOMEM;
 		goto out_ret;
 	}
-	
-	/* Get the exec-header */
-	loc->elf_ex = *((struct elfhdr *)bprm->buf);
 
 	retval = -ENOEXEC;
 	/* First of all, some simple consistency checks */
-	if (memcmp(loc->elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
+	if (memcmp(elf_ex->e_ident, ELFMAG, SELFMAG) != 0)
 		goto out;
 
-	if (loc->elf_ex.e_type != ET_EXEC && loc->elf_ex.e_type != ET_DYN)
+	if (elf_ex->e_type != ET_EXEC && elf_ex->e_type != ET_DYN)
 		goto out;
-	if (!elf_check_arch(&loc->elf_ex))
+	if (!elf_check_arch(elf_ex))
 		goto out;
-	if (elf_check_fdpic(&loc->elf_ex))
+	if (elf_check_fdpic(elf_ex))
 		goto out;
 	if (!bprm->file->f_op->mmap)
 		goto out;
 
-	elf_phdata = load_elf_phdrs(&loc->elf_ex, bprm->file);
+	elf_phdata = load_elf_phdrs(elf_ex, bprm->file);
 	if (!elf_phdata)
 		goto out;
 
 	elf_ppnt = elf_phdata;
-	for (i = 0; i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
+	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
 		char *elf_interpreter;
 
 		if (elf_ppnt->p_type != PT_INTERP)
@@ -782,7 +781,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	}
 
 	elf_ppnt = elf_phdata;
-	for (i = 0; i < loc->elf_ex.e_phnum; i++, elf_ppnt++)
+	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++)
 		switch (elf_ppnt->p_type) {
 		case PT_GNU_STACK:
 			if (elf_ppnt->p_flags & PF_X)
@@ -792,7 +791,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			break;
 
 		case PT_LOPROC ... PT_HIPROC:
-			retval = arch_elf_pt_proc(&loc->elf_ex, elf_ppnt,
+			retval = arch_elf_pt_proc(elf_ex, elf_ppnt,
 						  bprm->file, false,
 						  &arch_state);
 			if (retval)
@@ -836,7 +835,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	 * still possible to return an error to the code that invoked
 	 * the exec syscall.
 	 */
-	retval = arch_check_elf(&loc->elf_ex,
+	retval = arch_check_elf(elf_ex,
 				!!interpreter, &loc->interp_elf_ex,
 				&arch_state);
 	if (retval)
@@ -849,8 +848,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
 	   may depend on the personality.  */
-	SET_PERSONALITY2(loc->elf_ex, &arch_state);
-	if (elf_read_implies_exec(loc->elf_ex, executable_stack))
+	SET_PERSONALITY2(*elf_ex, &arch_state);
+	if (elf_read_implies_exec(*elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
 	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
@@ -877,7 +876,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	/* Now we do a little grungy work by mmapping the ELF image into
 	   the correct location in memory. */
 	for(i = 0, elf_ppnt = elf_phdata;
-	    i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
+	    i < elf_ex->e_phnum; i++, elf_ppnt++) {
 		int elf_prot, elf_flags;
 		unsigned long k, vaddr;
 		unsigned long total_size = 0;
@@ -921,9 +920,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		 * If we are loading ET_EXEC or we have already performed
 		 * the ET_DYN load_addr calculations, proceed normally.
 		 */
-		if (loc->elf_ex.e_type == ET_EXEC || load_addr_set) {
+		if (elf_ex->e_type == ET_EXEC || load_addr_set) {
 			elf_flags |= MAP_FIXED;
-		} else if (loc->elf_ex.e_type == ET_DYN) {
+		} else if (elf_ex->e_type == ET_DYN) {
 			/*
 			 * This logic is run once for the first LOAD Program
 			 * Header for ET_DYN binaries to calculate the
@@ -972,7 +971,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			load_bias = ELF_PAGESTART(load_bias - vaddr);
 
 			total_size = total_mapping_size(elf_phdata,
-							loc->elf_ex.e_phnum);
+							elf_ex->e_phnum);
 			if (!total_size) {
 				retval = -EINVAL;
 				goto out_free_dentry;
@@ -990,7 +989,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (!load_addr_set) {
 			load_addr_set = 1;
 			load_addr = (elf_ppnt->p_vaddr - elf_ppnt->p_offset);
-			if (loc->elf_ex.e_type == ET_DYN) {
+			if (elf_ex->e_type == ET_DYN) {
 				load_bias += error -
 				             ELF_PAGESTART(load_bias + vaddr);
 				load_addr += load_bias;
@@ -1031,7 +1030,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 	}
 
-	loc->elf_ex.e_entry += load_bias;
+	e_entry = elf_ex->e_entry + load_bias;
 	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
@@ -1074,7 +1073,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		allow_write_access(interpreter);
 		fput(interpreter);
 	} else {
-		elf_entry = loc->elf_ex.e_entry;
+		elf_entry = e_entry;
 		if (BAD_ADDR(elf_entry)) {
 			retval = -EINVAL;
 			goto out_free_dentry;
@@ -1092,8 +1091,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out;
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
 
-	retval = create_elf_tables(bprm, &loc->elf_ex,
-			  load_addr, interp_load_addr);
+	retval = create_elf_tables(bprm, elf_ex,
+			  load_addr, interp_load_addr, e_entry);
 	if (retval < 0)
 		goto out;
 	current->mm->end_code = end_code;
@@ -1111,7 +1110,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		 * growing down), and into the unused ELF_ET_DYN_BASE region.
 		 */
 		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
-		    loc->elf_ex.e_type == ET_DYN && !interpreter)
+		    elf_ex->e_type == ET_DYN && !interpreter)
 			current->mm->brk = current->mm->start_brk =
 				ELF_ET_DYN_BASE;
 
