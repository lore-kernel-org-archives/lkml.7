Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9491CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5932D2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2hMj2Nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732993AbfDQVeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:34:18 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35128 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQVeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:34:17 -0400
Received: by mail-wr1-f51.google.com with SMTP id o12so245430wrn.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=D2mdso43FDtrQIMyDGVfJVDvIXS87WUDbsJPmpc1fIQ=;
        b=A2hMj2NqUCNFlnGTDs+j8tiEo6TAA2n1lXr5r+0LUn19VsoOZYNU4KVSGF/yVY9wTD
         yyGU8J89kvrQrqC9zETF+Hyb5YqbDie8PRq23pPUH6H9Af6S0IqBqaBsI2ISWb/OUsKH
         jU6okD85rg9hmmP5BkBnTRDtlmw6rsX1XacRsgfRbzmts7+frADd554mQa1JILuHIavF
         HdEit1+Burkez4N+VsT+Tis8yBG+Hrz2wGj+FRotXczOjhhVxdTT8jdxKj5ErVuTPH8l
         sfuwMKU9KW8CL7hIpZTWHxCBSYTyAiacf7CBscUYT4m92C7bAHbd4PgsSMmDYf02hkVB
         5hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=D2mdso43FDtrQIMyDGVfJVDvIXS87WUDbsJPmpc1fIQ=;
        b=s+GG9CF86LzciRiJRdXOeU1AxJsNbNps/2GhQFtQbPhEINH8k1GmXgoztKB/YnWuJN
         /MUQktD6FXcFDFos/43IDL46E5sLkmQwYxFifJgTms52gChg513odFZ4WqB+LKdb+q0T
         tuy16zyqI/9B47VzLzZU3FFMM1TcYz2ihshqzKelkMS1q4JcPVg7j8VWRK5MEVGUy1cJ
         C7baDPkV3EVNIw1Ice9iNreM3VL1jtLoAHOFOkpwMZavF+jW84lpRwv43v9WPr9jz6oI
         jV7rjkv+T7FKDAh9qoJz8cSclfOEG4alZeHNowvuYa4vUQDxrerQFx3bP6YJ0PopRxR0
         +RHQ==
X-Gm-Message-State: APjAAAUUKMF0MEqidrcR+lAp1Y0RFkVY6qaVQah0FIwJWg16whoESNBA
        J+MJlGYpTnMOL3wD6jwxJw==
X-Google-Smtp-Source: APXvYqw8P8cTm394hDcp6MQcqEVbfQl96fYOkvFiY3enkbjmrVofX2ZVImfsLRfT2Pi3cKosUeKpYw==
X-Received: by 2002:a5d:4f89:: with SMTP id d9mr38785732wru.195.1555536855847;
        Wed, 17 Apr 2019 14:34:15 -0700 (PDT)
Received: from avx2 ([46.53.244.117])
        by smtp.gmail.com with ESMTPSA id o1sm59797wmh.47.2019.04.17.14.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 14:34:15 -0700 (PDT)
Date:   Thu, 18 Apr 2019 00:34:13 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH -mm] elf: extract PROT_* calculations
Message-ID: <20190417213413.GB26474@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 places where mapping protections are calculated: one for
executable, another one for interpreter -- take them out.

ELF read and execute permissions are interchanged with Linux PROT_READ
and PROT_EXEC, microoptimizations are welcome!

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -524,6 +524,19 @@ static inline int arch_check_elf(struct elfhdr *ehdr, bool has_interp,
 
 #endif /* !CONFIG_ARCH_BINFMT_ELF_STATE */
 
+static inline int make_prot(u32 p_flags)
+{
+	int prot = 0;
+
+	if (p_flags & PF_R)
+		prot |= PROT_READ;
+	if (p_flags & PF_W)
+		prot |= PROT_WRITE;
+	if (p_flags & PF_X)
+		prot |= PROT_EXEC;
+	return prot;
+}
+
 /* This is much more generalized than the library routine read function,
    so we keep this separate.  Technically the library read function
    is only provided so that we can read a.out libraries that have
@@ -563,16 +576,10 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
 		if (eppnt->p_type == PT_LOAD) {
 			int elf_type = MAP_PRIVATE | MAP_DENYWRITE;
-			int elf_prot = 0;
+			int elf_prot = make_prot(eppnt->p_flags);
 			unsigned long vaddr = 0;
 			unsigned long k, map_addr;
 
-			if (eppnt->p_flags & PF_R)
-		    		elf_prot = PROT_READ;
-			if (eppnt->p_flags & PF_W)
-				elf_prot |= PROT_WRITE;
-			if (eppnt->p_flags & PF_X)
-				elf_prot |= PROT_EXEC;
 			vaddr = eppnt->p_vaddr;
 			if (interp_elf_ex->e_type == ET_EXEC || load_addr_set)
 				elf_type |= MAP_FIXED_NOREPLACE;
@@ -891,7 +898,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	   the correct location in memory. */
 	for(i = 0, elf_ppnt = elf_phdata;
 	    i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
-		int elf_prot = 0, elf_flags, elf_fixed = MAP_FIXED_NOREPLACE;
+		int elf_prot, elf_flags, elf_fixed = MAP_FIXED_NOREPLACE;
 		unsigned long k, vaddr;
 		unsigned long total_size = 0;
 
@@ -932,12 +939,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			elf_fixed = MAP_FIXED;
 		}
 
-		if (elf_ppnt->p_flags & PF_R)
-			elf_prot |= PROT_READ;
-		if (elf_ppnt->p_flags & PF_W)
-			elf_prot |= PROT_WRITE;
-		if (elf_ppnt->p_flags & PF_X)
-			elf_prot |= PROT_EXEC;
+		elf_prot = make_prot(elf_ppnt->p_flags);
 
 		elf_flags = MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE;
 
