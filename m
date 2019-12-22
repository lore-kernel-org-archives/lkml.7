Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0517EC2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 14:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE01206D3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 14:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYA0EUZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLVOi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 09:38:57 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:39571 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfLVOi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 09:38:56 -0500
Received: by mail-wr1-f45.google.com with SMTP id y11so13977352wrt.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 06:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Uh+EOQZx4W3Qp5D71u67687J4I8oSrT9UDtYenmvLIU=;
        b=VYA0EUZihY9w7kyo+oNyvcR+muvNgcftPkUJkob8PzeLNKWq0RS/PtnYaWRiI7U5D6
         grxjfkeHgYtXwMxH8r1AA/sszvS8V+IXIhPCK6Rn5y2i6UmGSLI+eSMdBsXIPjStu3qd
         JD0MvfmWigNL2Oi4Hki2LLUcEXwdUky+jgvAVGEhFVJaaRY+uVxa2LjulIxTR5ou5iy4
         SHmXsFftuL5rc8n+UDizRXr3s48qVHwEB6JVmHCdy1KD4VeFsTrSdRwJTRkube4zvbUs
         t4RQ9VrIv1GPb6S+zpdIMmnALAsY3MbAidWttWfJtNFfivbhrRH9hCNQDxVjQzD9q0qv
         dBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Uh+EOQZx4W3Qp5D71u67687J4I8oSrT9UDtYenmvLIU=;
        b=GuCMQNCjcppWkrErbnhbMWC9aCw/AoRPdlj0nEA2sSbVUt51oD4FK6LN8s+FY6wX+6
         gvNzeov4J9F5cTqAHQGBF1BkqUFBnbRAegHK5U80kcIjdq5H2GfN3PmrFk50XXQ4K3Kv
         rIQI+I9fXwlCxyIG1sZ372ZaL9KYFq9pLVbd1/7sn3a1TnVAhVpHoiYw2zVUll8B50/p
         kLfkL+U9wRWrmsBsU+tH8fvzovav+G5O85XgN7OjOvKwPhVpSNHyIO6cleeBYE7lKdM2
         9nvV9Lm3hYFCQBD6MUePZaTfxesjH349PqZQIpXgFQ4hpJczy4dKTxV9W/6l++tLsuYK
         vYMA==
X-Gm-Message-State: APjAAAVDewwjfsN2+DDVo7vrMcVcMO+4vdUhgry1TMtzDwFN7wEb6AeG
        55cOw93zN7cKLauIJbhi6ZyKGho=
X-Google-Smtp-Source: APXvYqwyF9KO/Uz/dI0sNh2wrP0slhccMyIY/UVRtEopLJxuU6UzqEFY1xa7lc+WaPcymPuRcZn/CQ==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr24244479wrk.53.1577025534324;
        Sun, 22 Dec 2019 06:38:54 -0800 (PST)
Received: from avx2 ([46.53.254.212])
        by smtp.gmail.com with ESMTPSA id g23sm16553304wmk.14.2019.12.22.06.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 06:38:53 -0800 (PST)
Date:   Sun, 22 Dec 2019 17:38:50 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH -mm 1/3] ELF, coredump: allocate core ELF header on stack
Message-ID: <20191222143850.GA24341@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comment says ELF header is "too large to be on stack".
64 bytes on 64-bit is not large by any means.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2186,7 +2186,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	int segs, i;
 	size_t vma_data_size = 0;
 	struct vm_area_struct *vma, *gate_vma;
-	struct elfhdr *elf = NULL;
+	struct elfhdr elf;
 	loff_t offset = 0, dataoff;
 	struct elf_note_info info = { };
 	struct elf_phdr *phdr4note = NULL;
@@ -2207,10 +2207,6 @@ static int elf_core_dump(struct coredump_params *cprm)
 	 * exists while dumping the mm->vm_next areas to the core file.
 	 */
   
-	/* alloc memory for large data structures: too large to be on stack */
-	elf = kmalloc(sizeof(*elf), GFP_KERNEL);
-	if (!elf)
-		goto out;
 	/*
 	 * The number of segs are recored into ELF header as 16bit value.
 	 * Please check DEFAULT_MAX_MAP_COUNT definition when you modify here.
@@ -2234,7 +2230,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	 * Collect all the non-memory information about the process for the
 	 * notes.  This also sets up the file header.
 	 */
-	if (!fill_note_info(elf, e_phnum, &info, cprm->siginfo, cprm->regs))
+	if (!fill_note_info(&elf, e_phnum, &info, cprm->siginfo, cprm->regs))
 		goto cleanup;
 
 	has_dumped = 1;
@@ -2242,7 +2238,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 
-	offset += sizeof(*elf);				/* Elf header */
+	offset += sizeof(elf);				/* Elf header */
 	offset += segs * sizeof(struct elf_phdr);	/* Program headers */
 
 	/* Write notes phdr entry */
@@ -2285,12 +2281,12 @@ static int elf_core_dump(struct coredump_params *cprm)
 		shdr4extnum = kmalloc(sizeof(*shdr4extnum), GFP_KERNEL);
 		if (!shdr4extnum)
 			goto end_coredump;
-		fill_extnum_info(elf, shdr4extnum, e_shoff, segs);
+		fill_extnum_info(&elf, shdr4extnum, e_shoff, segs);
 	}
 
 	offset = dataoff;
 
-	if (!dump_emit(cprm, elf, sizeof(*elf)))
+	if (!dump_emit(cprm, &elf, sizeof(elf)))
 		goto end_coredump;
 
 	if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note)))
@@ -2374,8 +2370,6 @@ static int elf_core_dump(struct coredump_params *cprm)
 	kfree(shdr4extnum);
 	kvfree(vma_filesz);
 	kfree(phdr4note);
-	kfree(elf);
-out:
 	return has_dumped;
 }
 
