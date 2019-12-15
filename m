Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4107AC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 12:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038B1206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 12:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzdbS4Bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfLOMsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 07:48:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36666 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfLOMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 07:48:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so3651668wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 04:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iYYrbSVxkipHuY+Pf6/0dgQd4IriUu9zAM6B/gzjJts=;
        b=fzdbS4Bv4xWs6uN5cCt+U7fPLYDTWQ5945Nonax+RGADlca2kp/bkWtZSpwJMrusV4
         AdYvb0vg4T+jpdt8vxyyiBnk6U41C8RpUK5O7r1rbmVpIV5lVia/mVq6WsVXC03zUjDx
         7TaW1TkmX3f2UOwqUI3XhSjVA1cIjfqqiiueWTEz+lxdLk/nD+cShjSxrgApxjNe+dbc
         +arhbiq5xTqxEAjne29kpxyf4VsCrSLEKGTFEUZJQnxRYxa+tqBFgaoVKTF0ou/rTrnY
         KF0G8MTIDtG4mvJDsuMxA+vKkheyjGPSab+KylEJf9gzvjDsrqYAtFAj1F1RcShu6f07
         Q4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iYYrbSVxkipHuY+Pf6/0dgQd4IriUu9zAM6B/gzjJts=;
        b=SK14RkYNHQ4KvHRse2syWztwvxqLJV9qMBnZ2n/f7RFmgdIcuZ5EIk+L65sibX4HIb
         hnpd/vw6d5CC2PXVvM9C7WNeNtghTA0ToVUV4IQ1myBrx3o3p2DC6cPtPse3ku7fym+L
         rtN7zH5jnB8eDdk4JO8zz76/pwZlLHp8dvzBnTBcBquSatt1/SykVhtcArA//GyZCK7e
         b29vnS2IgOJ0DRUd1q9rZbKcyRtUklVoGyaDK+0LVlnvy5fWLwfRR1OrYWki7WNxwScM
         8r451l33ZmKiAA8CvTgcFpjFE/RkABIvgdbey56e6odnNPCLkbJwFbXdQl7xF9S2YE5s
         9iPQ==
X-Gm-Message-State: APjAAAWOHPgANYus9FIbsvr30Arzvc+uH1UYKNUJnVRFYM+SNMm4bB+q
        f1o8+aUxYc7xr6Qxlm53bw==
X-Google-Smtp-Source: APXvYqwffE6EuYxnZqn9KseN+zqDUVtNAqDLRQYF6kgEF+kD1BQLdadWoEKZhIbNsqbT+Ry0UOuyWg==
X-Received: by 2002:a1c:c908:: with SMTP id f8mr17481696wmb.66.1576414077724;
        Sun, 15 Dec 2019 04:47:57 -0800 (PST)
Received: from avx2 ([46.53.248.136])
        by smtp.gmail.com with ESMTPSA id f17sm17393540wmc.8.2019.12.15.04.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 04:47:57 -0800 (PST)
Date:   Sun, 15 Dec 2019 15:47:55 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH -mm 2/2] ELF: better codegen around current->mm
Message-ID: <20191215124755.GB21124@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"current->mm" pointer is stable in general except few cases one of which
execve(2). Compiler can't treat is as stable but it _is_ stable most of
the time. During ELF loading process ->mm becomes stable right after
flush_old_exec().

Help compiler by caching current->mm, otherwise it continues to refetch it.

	add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-141 (-141)
	Function                                     old     new   delta
	elf_core_dump                               5062    5039     -23
	load_elf_binary                             5426    5308    -118

Note: other cases are left as is because it is either pessimisation or
no change in binary size.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |   52 ++++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -165,6 +165,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 		unsigned long load_addr, unsigned long interp_load_addr,
 		unsigned long e_entry)
 {
+	struct mm_struct *mm = current->mm;
 	unsigned long p = bprm->p;
 	int argc = bprm->argc;
 	int envc = bprm->envc;
@@ -227,7 +228,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 		return -EFAULT;
 
 	/* Create the ELF interpreter info */
-	elf_info = (elf_addr_t *)current->mm->saved_auxv;
+	elf_info = (elf_addr_t *)mm->saved_auxv;
 	/* update AT_VECTOR_SIZE_BASE if the number of NEW_AUX_ENT() changes */
 #define NEW_AUX_ENT(id, val) \
 	do { \
@@ -276,13 +277,13 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	}
 #undef NEW_AUX_ENT
 	/* AT_NULL is zero; clear the rest too */
-	memset(elf_info, 0, (char *)current->mm->saved_auxv +
-			sizeof(current->mm->saved_auxv) - (char *)elf_info);
+	memset(elf_info, 0, (char *)mm->saved_auxv +
+			sizeof(mm->saved_auxv) - (char *)elf_info);
 
 	/* And advance past the AT_NULL entry.  */
 	elf_info += 2;
 
-	ei_index = elf_info - (elf_addr_t *)current->mm->saved_auxv;
+	ei_index = elf_info - (elf_addr_t *)mm->saved_auxv;
 	sp = STACK_ADD(p, ei_index);
 
 	items = (argc + 1) + (envc + 1) + 1;
@@ -301,7 +302,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	 * Grow the stack manually; some architectures have a limit on how
 	 * far ahead a user-space access may be in order to grow the stack.
 	 */
-	vma = find_extend_vma(current->mm, bprm->p);
+	vma = find_extend_vma(mm, bprm->p);
 	if (!vma)
 		return -EFAULT;
 
@@ -310,7 +311,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 		return -EFAULT;
 
 	/* Populate list of argv pointers back to argv strings. */
-	p = current->mm->arg_end = current->mm->arg_start;
+	p = mm->arg_end = mm->arg_start;
 	while (argc-- > 0) {
 		size_t len;
 		if (__put_user((elf_addr_t)p, sp++))
@@ -322,10 +323,10 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	}
 	if (__put_user(0, sp++))
 		return -EFAULT;
-	current->mm->arg_end = p;
+	mm->arg_end = p;
 
 	/* Populate list of envp pointers back to envp strings. */
-	current->mm->env_end = current->mm->env_start = p;
+	mm->env_end = mm->env_start = p;
 	while (envc-- > 0) {
 		size_t len;
 		if (__put_user((elf_addr_t)p, sp++))
@@ -337,10 +338,10 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	}
 	if (__put_user(0, sp++))
 		return -EFAULT;
-	current->mm->env_end = p;
+	mm->env_end = p;
 
 	/* Put the elf_info on the stack in the right place.  */
-	if (copy_to_user(sp, current->mm->saved_auxv, ei_index * sizeof(elf_addr_t)))
+	if (copy_to_user(sp, mm->saved_auxv, ei_index * sizeof(elf_addr_t)))
 		return -EFAULT;
 	return 0;
 }
@@ -701,6 +702,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		struct elfhdr interp_elf_ex;
 	} *loc;
 	struct arch_elf_state arch_state = INIT_ARCH_ELF_STATE;
+	struct mm_struct *mm;
 	struct pt_regs *regs;
 
 	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
@@ -1096,11 +1098,13 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			  load_addr, interp_load_addr, e_entry);
 	if (retval < 0)
 		goto out;
-	current->mm->end_code = end_code;
-	current->mm->start_code = start_code;
-	current->mm->start_data = start_data;
-	current->mm->end_data = end_data;
-	current->mm->start_stack = bprm->p;
+
+	mm = current->mm;
+	mm->end_code = end_code;
+	mm->start_code = start_code;
+	mm->start_data = start_data;
+	mm->end_data = end_data;
+	mm->start_stack = bprm->p;
 
 	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
 		/*
@@ -1111,12 +1115,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		 * growing down), and into the unused ELF_ET_DYN_BASE region.
 		 */
 		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
-		    elf_ex->e_type == ET_DYN && !interpreter)
-			current->mm->brk = current->mm->start_brk =
-				ELF_ET_DYN_BASE;
+		    elf_ex->e_type == ET_DYN && !interpreter) {
+			mm->brk = mm->start_brk = ELF_ET_DYN_BASE;
+		}
 
-		current->mm->brk = current->mm->start_brk =
-			arch_randomize_brk(current->mm);
+		mm->brk = mm->start_brk = arch_randomize_brk(mm);
 #ifdef compat_brk_randomized
 		current->brk_randomized = 1;
 #endif
@@ -1574,6 +1577,7 @@ static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
  */
 static int fill_files_note(struct memelfnote *note)
 {
+	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned count, size, names_ofs, remaining, n;
 	user_long_t *data;
@@ -1581,7 +1585,7 @@ static int fill_files_note(struct memelfnote *note)
 	char *name_base, *name_curpos;
 
 	/* *Estimated* file count and total data size needed */
-	count = current->mm->map_count;
+	count = mm->map_count;
 	if (count > UINT_MAX / 64)
 		return -EINVAL;
 	size = count * 64;
@@ -1599,7 +1603,7 @@ static int fill_files_note(struct memelfnote *note)
 	name_base = name_curpos = ((char *)data) + names_ofs;
 	remaining = size - names_ofs;
 	count = 0;
-	for (vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
+	for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
 		struct file *file;
 		const char *filename;
 
@@ -1633,10 +1637,10 @@ static int fill_files_note(struct memelfnote *note)
 	data[0] = count;
 	data[1] = PAGE_SIZE;
 	/*
-	 * Count usually is less than current->mm->map_count,
+	 * Count usually is less than mm->map_count,
 	 * we need to move filenames down.
 	 */
-	n = current->mm->map_count - count;
+	n = mm->map_count - count;
 	if (n != 0) {
 		unsigned shift_bytes = n * 3 * sizeof(data[0]);
 		memmove(name_base - shift_bytes, name_base,
