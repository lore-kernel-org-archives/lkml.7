Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9ECC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECDE20872
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568204817;
	bh=MseBqWNeudWiY5Pr7ynKRYTy7jqmwG9LbsTu29MhRKY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nZZjdzmRJChpwPEo+5XjdNNEDiF3gVdyIT/WEi5XlrfqzpzrvrSBe8bpdJaeKE6gd
	 6KZpIrrotNPrn3O7Z53mxOvvd6lUu/cZGF7gLSkywKSeNC62jErJdnWWhopCokrpch
	 4MBFZIyKzsgnEOxtuc/R2rWm8BFdpr49tlf4O/OU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfIKM04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfIKM04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:26:56 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7220A2075C;
        Wed, 11 Sep 2019 12:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568204815;
        bh=MseBqWNeudWiY5Pr7ynKRYTy7jqmwG9LbsTu29MhRKY=;
        h=From:To:Cc:Subject:Date:From;
        b=LZdJBvqCBTeZla1V84Jvesl+/iKxoEMHllQ6mdelwy6CTJTUtMeG23jEOWk9243i+
         7nWDOMMWIdhPNK+TRxsdmaTNGp7NciuNvs1Zx8Au6khZC07bagyXzJ97FH/gkXkBmQ
         CsnNzvqSqBcBz7jA1rgVBX6+SX5AL/zvH1eD2PUw=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     maco@android.com, gregkh@linuxfoundation.org,
        Will Deacon <will@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] module: Fix link failure due to invalid relocation on namespace offset
Date:   Wed, 11 Sep 2019 13:26:46 +0100
Message-Id: <20190911122646.13838-1-will@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8651ec01daed ("module: add support for symbol namespaces.")
broke linking for arm64 defconfig:

  | lib/crypto/arc4.o: In function `__ksymtab_arc4_setkey':
  | arc4.c:(___ksymtab+arc4_setkey+0x8): undefined reference to `no symbol'
  | lib/crypto/arc4.o: In function `__ksymtab_arc4_crypt':
  | arc4.c:(___ksymtab+arc4_crypt+0x8): undefined reference to `no symbol'

This is because the dummy initialisation of the 'namespace_offset' field
in 'struct kernel_symbol' when using EXPORT_SYMBOL on architectures with
support for PREL32 locations uses an offset from an absolute address (0)
in an effort to trick 'offset_to_pointer' into behaving as a NOP,
allowing non-namespaced symbols to be treated in the same way as those
belonging to a namespace.

Unfortunately, place-relative relocations require a symbol reference
rather than an absolute value and, although x86 appears to get away with
this due to placing the kernel text at the top of the address space, it
almost certainly results in a runtime failure if the kernel is relocated
dynamically as a result of KASLR.

Rework 'namespace_offset' so that a value of 0, which cannot occur for a
valid namespaced symbol, indicates that the corresponding symbol does
not belong to a namespace.

Cc: Matthias Maennich <maennich@google.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Fixes: 8651ec01daed ("module: add support for symbol namespaces.")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Will Deacon <will@kernel.org>
---

Please note that I've not been able to test this at LPC, but it's been
submitted to kernelci.

 include/asm-generic/export.h | 2 +-
 include/linux/export.h       | 2 +-
 kernel/module.c              | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index e2b5d0f569d3..d0912c7ac2fc 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -17,7 +17,7 @@
 
 .macro __put, val, name
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-	.long	\val - ., \name - ., 0 - .
+	.long	\val - ., \name - ., 0
 #elif defined(CONFIG_64BIT)
 	.quad	\val, \name, 0
 #else
diff --git a/include/linux/export.h b/include/linux/export.h
index 2c5468d8ea9a..ef5d015d754a 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -68,7 +68,7 @@ extern struct module __this_module;
 	    "__ksymtab_" #sym ":				\n"	\
 	    "	.long	" #sym "- .				\n"	\
 	    "	.long	__kstrtab_" #sym "- .			\n"	\
-	    "	.long	0 - .					\n"	\
+	    "	.long	0					\n"	\
 	    "	.previous					\n")
 
 struct kernel_symbol {
diff --git a/kernel/module.c b/kernel/module.c
index f76efcf2043e..7ab244c4e1ba 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -547,6 +547,8 @@ static const char *kernel_symbol_name(const struct kernel_symbol *sym)
 static const char *kernel_symbol_namespace(const struct kernel_symbol *sym)
 {
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	if (!sym->namespace_offset)
+		return NULL;
 	return offset_to_ptr(&sym->namespace_offset);
 #else
 	return sym->namespace;
-- 
2.23.0.162.g0b9fbb3734-goog

