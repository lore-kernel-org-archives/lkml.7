Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE43C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6201022459
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka9lo2qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfJEQwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 12:52:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39502 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfJEQwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 12:52:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id a15so8726301edt.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 09:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=d9ykpvhm3YkXpauA7Wa3H8Nocq0SnmYsOUAHR5mLQng=;
        b=ka9lo2qjiZehblCq14J4nvM4wqsN5XFZs/noLiAHrPDqWJiAsf/PzngJKfOYcyKM1P
         BnSYSFiDKHNZ4TvEm3plCc2VDnGmKcm1KpLXkce7ef3AR9R7Urt4wE5yC1kmI5/bHGyF
         2n+a3FIyM0fYGAxeZRXdGJL+5Y8hg9+U6VjjEkswlg1Bhc1lSayJdARQBt/mCbtYI6F4
         WBTibtUSl7YZvHM58tsE7jzUGLPIn3DcJHi0iFdRYImmXFhGxdtCTI5R5O77nuenFit9
         mCLqoJ6POOhXpuLhKXRimPxJp+OGMWasOtZsBWOgXppS8BX3DtYWjhSRXjWuuFDrc5gx
         u3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=d9ykpvhm3YkXpauA7Wa3H8Nocq0SnmYsOUAHR5mLQng=;
        b=SlNXYrZIa8PHmAohV3mAz6IyHSsAamw5V8FGWSfNtNMXsxEp66/Z97FnfKbO0qJ8f3
         AcyOFnyUwGPYobUSs0aDga69EZ5jLmEd7z6RxumLjlZAtw2NXB17n7k8J1hFjdBMLWTL
         CXHTXKdEGehH1Lqx+iBc/6Qj5KnSmbpnNFM4tDKncjDaLZeATyRcm3NItYsWqbRHVof5
         7EU5ZfIWsRTukc0YEwgrnTm+Mewh9zesammyz2gbS42afz1iRrZl0u1kLxsIQ5rs/J8r
         O5X8Lw+I493b1NwWhKkmjqKDKz+dXrHMjB7NK1Ms6oTv3TRsFFkY098BOCGv5xZxagAm
         EhJg==
X-Gm-Message-State: APjAAAUMudURKFOwB4kk2lyhcsLyemnhuIL12ShAs6IuX+hZ5HhQwxeC
        PbXP0rcxWnpaAQi54zPK0InN52M=
X-Google-Smtp-Source: APXvYqyuAWgst+1SPYPfiNiDFN+WjQlj2B21jQQacNuxo9Jhj71WDKl91p6hsTKPMVUIlqMzB7RycA==
X-Received: by 2002:a17:906:1f12:: with SMTP id w18mr17156837ejj.224.1570294337577;
        Sat, 05 Oct 2019 09:52:17 -0700 (PDT)
Received: from avx2 ([46.53.253.60])
        by smtp.gmail.com with ESMTPSA id o22sm1092576ejr.40.2019.10.05.09.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Oct 2019 09:52:17 -0700 (PDT)
Date:   Sat, 5 Oct 2019 19:52:15 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] elf: extract elf_read() function
Message-ID: <20191005165215.GB26927@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ELF reads done by the kernel have very complicated error detection code
which better live in one place.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |   49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -404,6 +404,17 @@ static unsigned long total_mapping_size(const struct elf_phdr *cmds, int nr)
 				ELF_PAGESTART(cmds[first_idx].p_vaddr);
 }
 
+static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
+{
+	ssize_t rv;
+
+	rv = kernel_read(file, buf, len, &pos);
+	if (unlikely(rv != len)) {
+		return (rv < 0) ? rv : -EIO;
+	}
+	return 0;
+}
+
 /**
  * load_elf_phdrs() - load ELF program headers
  * @elf_ex:   ELF header of the binary whose program headers should be loaded
@@ -418,7 +429,6 @@ static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
 {
 	struct elf_phdr *elf_phdata = NULL;
 	int retval, err = -1;
-	loff_t pos = elf_ex->e_phoff;
 	unsigned int size;
 
 	/*
@@ -439,9 +449,9 @@ static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
 		goto out;
 
 	/* Read in the program headers */
-	retval = kernel_read(elf_file, elf_phdata, size, &pos);
-	if (retval != size) {
-		err = (retval < 0) ? retval : -EIO;
+	retval = elf_read(elf_file, elf_phdata, size, elf_ex->e_phoff);
+	if (retval < 0) {
+		err = retval;
 		goto out;
 	}
 
@@ -720,7 +730,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	elf_ppnt = elf_phdata;
 	for (i = 0; i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
 		char *elf_interpreter;
-		loff_t pos;
 
 		if (elf_ppnt->p_type != PT_INTERP)
 			continue;
@@ -738,14 +747,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (!elf_interpreter)
 			goto out_free_ph;
 
-		pos = elf_ppnt->p_offset;
-		retval = kernel_read(bprm->file, elf_interpreter,
-				     elf_ppnt->p_filesz, &pos);
-		if (retval != elf_ppnt->p_filesz) {
-			if (retval >= 0)
-				retval = -EIO;
+		retval = elf_read(bprm->file, elf_interpreter, elf_ppnt->p_filesz,
+				  elf_ppnt->p_offset);
+		if (retval < 0)
 			goto out_free_interp;
-		}
 		/* make sure path is NULL terminated */
 		retval = -ENOEXEC;
 		if (elf_interpreter[elf_ppnt->p_filesz - 1] != '\0')
@@ -764,14 +769,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		would_dump(bprm, interpreter);
 
 		/* Get the exec headers */
-		pos = 0;
-		retval = kernel_read(interpreter, &loc->interp_elf_ex,
-				     sizeof(loc->interp_elf_ex), &pos);
-		if (retval != sizeof(loc->interp_elf_ex)) {
-			if (retval >= 0)
-				retval = -EIO;
+		retval = elf_read(interpreter, &loc->interp_elf_ex,
+				  sizeof(loc->interp_elf_ex), 0);
+		if (retval < 0)
 			goto out_free_dentry;
-		}
 
 		break;
 
@@ -1181,11 +1182,10 @@ static int load_elf_library(struct file *file)
 	unsigned long elf_bss, bss, len;
 	int retval, error, i, j;
 	struct elfhdr elf_ex;
-	loff_t pos = 0;
 
 	error = -ENOEXEC;
-	retval = kernel_read(file, &elf_ex, sizeof(elf_ex), &pos);
-	if (retval != sizeof(elf_ex))
+	retval = elf_read(file, &elf_ex, sizeof(elf_ex), 0);
+	if (retval < 0)
 		goto out;
 
 	if (memcmp(elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
@@ -1210,9 +1210,8 @@ static int load_elf_library(struct file *file)
 
 	eppnt = elf_phdata;
 	error = -ENOEXEC;
-	pos =  elf_ex.e_phoff;
-	retval = kernel_read(file, eppnt, j, &pos);
-	if (retval != j)
+	retval = elf_read(file, eppnt, j, elf_ex.e_phoff);
+	if (retval < 0)
 		goto out_free_ph;
 
 	for (j = 0, i = 0; i<elf_ex.e_phnum; i++)
