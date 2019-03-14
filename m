Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC444C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865DB20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHwxaR47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfCNUt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:49:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45436 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfCNUt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:49:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id h99so7318859wrh.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 13:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1OInTDWWSyHzDYinTjppp1/M+JAnEdl3APBv3aXtO8c=;
        b=qHwxaR47xC9uxqQsYRC2pq26F19ZaImXG7smIwTtOQkK+tNsfMsNQuNCyF0FgEpjR7
         Tzqo+VuR1Eh3rHHugmd0X5YywxEgGR6CwEufip5JYg3qMLltR6diu3xPGUVCW5V73wBA
         aBYPWe9C5wR82Mjqq+1rYeVNnQYRFfrHlgnjD5VKHTY6rj2zKfENaUXg/gbn6porkwTY
         i+RQa0JarYTbk7LObKC5Ap+hQGlqnV8AnJp5qVXMvkjwwtrD/N7rFGS8IyTBk3Cr7KV4
         Tj8qW9Vn88t9vkPeVQNADZx4D7AX2ubVVgw86qR8ybtgWwhjVFgxUNL0Phtu6eDnVvD8
         ZeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1OInTDWWSyHzDYinTjppp1/M+JAnEdl3APBv3aXtO8c=;
        b=BMlVXj9fkvVpPUR6RnKClYGhUAKjrq/p+XRVLnjaOlIbVS2g2hMU11DQ5h6y26lHwD
         xJZcI0vlPZHgpRDK2YUtRVRRUywWRBKXLXDq8bXXedCzH9oFjrNzdvaAF3eSx4mW0q3i
         tPb6zXa9Ob5O69r9Qo3TxCsIO2/i9rOB4gBJechOzDMR5r6Ygvl2MVX0fGcFMBySMAQ+
         4LCrI9g78OBvDtZ+ZnVIKLYkNCtY2IpWyodNY0Vx8BOtX7NK7+BuHu27zibl192dQhpP
         sLfbDKWnn2a9mGGPNWjrqXjsABD5XjdpbiYQFKKJ+AGS/utGYYnu0ySNrEz61PGlqOC2
         wjxw==
X-Gm-Message-State: APjAAAUC2ggcwnl+E17TUe3kfDA/dI25tdxMsRvgw59+0r6QLCaEs4nb
        8b490zg3trakMCMZbEkmcYGemSA=
X-Google-Smtp-Source: APXvYqxxLm2emjefsc71CYbrlL8oDs79AKiO98/I2G5RRs0OU7eZEOSq8XFhbBlUnZBZY8G7xqWkWA==
X-Received: by 2002:adf:f14f:: with SMTP id y15mr17873998wro.223.1552596596214;
        Thu, 14 Mar 2019 13:49:56 -0700 (PDT)
Received: from avx2 ([46.53.246.8])
        by smtp.gmail.com with ESMTPSA id h126sm260335wmf.2.2019.03.14.13.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:49:55 -0700 (PDT)
Date:   Thu, 14 Mar 2019 23:49:53 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] elf: free PT_INTERP filename ASAP
Message-ID: <20190314204953.GD18143@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason for PT_INTERP filename to linger till the end of
the whole loading process.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -686,7 +686,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	struct file *interpreter = NULL; /* to shut gcc up */
  	unsigned long load_addr = 0, load_bias = 0;
 	int load_addr_set = 0;
-	char * elf_interpreter = NULL;
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	unsigned long elf_bss, elf_brk;
@@ -742,6 +741,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	for (i = 0; i < loc->elf_ex.e_phnum; i++) {
 		if (elf_ppnt->p_type == PT_INTERP) {
+			char *elf_interpreter;
 			loff_t pos;
 
 			/* This is the program interpreter used for
@@ -773,9 +773,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				goto out_free_interp;
 
 			interpreter = open_exec(elf_interpreter);
+			kfree(elf_interpreter);
 			retval = PTR_ERR(interpreter);
 			if (IS_ERR(interpreter))
-				goto out_free_interp;
+				goto out_free_dentry;
 
 			/*
 			 * If the binary is not readable then enforce
@@ -795,6 +796,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			}
 
 			break;
+
+out_free_interp:
+			kfree(elf_interpreter);
+			goto out_free_ph;
 		}
 		elf_ppnt++;
 	}
@@ -819,7 +824,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 
 	/* Some simple consistency checks for the interpreter */
-	if (elf_interpreter) {
+	if (interpreter) {
 		retval = -ELIBBAD;
 		/* Not an ELF interpreter */
 		if (memcmp(loc->interp_elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
@@ -978,7 +983,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * independently randomized mmap region (0 load_bias
 			 * without MAP_FIXED).
 			 */
-			if (elf_interpreter) {
+			if (interpreter) {
 				load_bias = ELF_ET_DYN_BASE;
 				if (current->flags & PF_RANDOMIZE)
 					load_bias += arch_mmap_rnd();
@@ -1076,7 +1081,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out_free_dentry;
 	}
 
-	if (elf_interpreter) {
+	if (interpreter) {
 		unsigned long interp_map_addr = 0;
 
 		elf_entry = load_elf_interp(&loc->interp_elf_ex,
@@ -1100,7 +1105,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		allow_write_access(interpreter);
 		fput(interpreter);
-		kfree(elf_interpreter);
 	} else {
 		elf_entry = loc->elf_ex.e_entry;
 		if (BAD_ADDR(elf_entry)) {
@@ -1115,7 +1119,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	set_binfmt(&elf_format);
 
 #ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
-	retval = arch_setup_additional_pages(bprm, !!elf_interpreter);
+	retval = arch_setup_additional_pages(bprm, !!interpreter);
 	if (retval < 0)
 		goto out;
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
@@ -1177,8 +1181,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	allow_write_access(interpreter);
 	if (interpreter)
 		fput(interpreter);
-out_free_interp:
-	kfree(elf_interpreter);
 out_free_ph:
 	kfree(elf_phdata);
 	goto out;
