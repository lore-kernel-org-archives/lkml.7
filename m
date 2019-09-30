Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAC2C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 05:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6222086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 05:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdzDhpGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfI3FtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 01:49:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44738 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfI3FtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 01:49:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id i14so6720809pgt.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 22:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nTyKTixdmn3fWlZSMKqI+ME67BJO0vwEvb6x4HC5OpA=;
        b=XdzDhpGktBu9KaisAZm5uiKRmQbIqKunbhGVDriAwdnFxah4atpIE4Er5OCMKKjLYg
         cu+dCHuDTPEXhnn8YKSPzHdxUifL9f+2h6ICQ/E+H1r6oc3RlARBPwpIbefwsnnW9IDY
         2+jlmkxJYZ/ldIktJ/rGsLKM3ooTXzDgNebQYKkEWbDUs63PEXYeYwshiyqYP9el9Oqf
         06fBkx4fdllMofVZCZjtI+yjsFYV4/opxtSB33YZuLyw6NniR3mgH7I/hkXpzCcmTD2j
         LYXujFZMYgxDITvP93e5gZxBkLp6ks+AnrGUj0zIA33/mT1AAhCj9RcjocfvBGEbaTaS
         r6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nTyKTixdmn3fWlZSMKqI+ME67BJO0vwEvb6x4HC5OpA=;
        b=BnfSXjITxGGqtGvLHRDWcMSPWFVmdKNnsFrkALUfLRyAA0w0suKYwLyX1Vd8vzlEAE
         nfDvCjDgDvbxWYk6iX4sqbvbOQuNJpPagl2MO9vojhp1xw37YxSEK+R2kSitO/IlCXV9
         0mtcXHL0u1up5YkgBcnnCRz8gHL0Vf6ZxPj4CLwe85vURrH/lM9jpjQoZoRbwxqzLkM7
         A1RTKYXSot1co0sshXH2eyFHA7UDYuYgLUiTAM4mSv1o+5P4hVlvuusyCDaz3g1AJSqZ
         qZt70vo9dTifhqsF5zYtZs+jq2tAV4XPtW1oX4orahuvDI09C41bP7M9IBeICJVoIOH4
         PGUg==
X-Gm-Message-State: APjAAAVXS2gWUi2Q3sLB/Ct1c5D47DB47dxKAZppnT+STAGzUbDP+GMn
        04h/r6TGp41XRqCCccpEnJ3wCyxPzbc=
X-Google-Smtp-Source: APXvYqx5LE+8Q6tf7q3Pz7Irou50eygzo6Rc00aYxWABwJWTc90BdC2obPSlpUQzJAiDRqn3Vb92bQ==
X-Received: by 2002:a17:90a:284c:: with SMTP id p12mr25077366pjf.87.1569822549796;
        Sun, 29 Sep 2019 22:49:09 -0700 (PDT)
Received: from LGEARND20B15 ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id 8sm12551272pgd.87.2019.09.29.22.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 22:49:09 -0700 (PDT)
Date:   Mon, 30 Sep 2019 14:49:03 +0900
From:   Austin Kim <austindh.kim@gmail.com>
To:     linux@armlinux.org.uk, info@metux.net, arnd@arndb.de,
        allison@lohutok.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        austindh.kim@gmail.com
Subject: [PATCH] ARM: module: remove 'always false' statement
Message-ID: <20190930054903.GA12163@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The each field of 'struct elf32_rel' is declared as below.
typedef struct elf32_rel {
   Elf32_Addr r_offset;
   Elf32_Word r_info;
} Elf32_Rel;

typedef __u32 Elf32_Addr;
typedef __u32 Elf32_Word;

This means that 'r_offset' and 'r_info' could contain non-negative value.
So 'always false' statement can be dropped.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 arch/arm/kernel/module.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index deef17f..617de32 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -83,7 +83,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 #endif
 
 		offset = ELF32_R_SYM(rel->r_info);
-		if (offset < 0 || offset > (symsec->sh_size / sizeof(Elf32_Sym))) {
+		if (offset > (symsec->sh_size / sizeof(Elf32_Sym))) {
 			pr_err("%s: section %u reloc %u: bad relocation sym offset\n",
 				module->name, relindex, i);
 			return -ENOEXEC;
@@ -92,8 +92,8 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 		sym = ((Elf32_Sym *)symsec->sh_addr) + offset;
 		symname = strtab + sym->st_name;
 
-		if (rel->r_offset < 0 || rel->r_offset > dstsec->sh_size - sizeof(u32)) {
-			pr_err("%s: section %u reloc %u sym '%s': out of bounds relocation, offset %d size %u\n",
+		if (rel->r_offset > dstsec->sh_size - sizeof(u32)) {
+			pr_err("%s: section %u reloc %u sym '%s': out of bounds relocation, offset %u size %u\n",
 			       module->name, relindex, i, symname,
 			       rel->r_offset, dstsec->sh_size);
 			return -ENOEXEC;
-- 
2.6.2

