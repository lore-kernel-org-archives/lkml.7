Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED598C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB16C2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568226375;
	bh=Ih6q6C0Ey30P2dlsz+uDKXdLbs5oAKqU5nDPKbljbi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HV2A6mgAVG0Z5EAhh6+tfHAW4mUG4zDqrngJ9fCzcN6zx+Az/rNWJFvVtkXRbq8ZI
	 6x1IftU8kR4VUhSpceS5QpW30LHvp4r53Q8qDyWUg0Jh1NnRH+lgwq2Nz70vy4f8Is
	 Q3oSz9qskmDTyDMH5MSSuRo7hnTmUijbh5GoFgsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfIKS0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 14:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbfIKS0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:26:14 -0400
Received: from linux-8ccs (ip5f5ade65.dynamic.kabel-deutschland.de [95.90.222.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53FC220863;
        Wed, 11 Sep 2019 18:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568226373;
        bh=Ih6q6C0Ey30P2dlsz+uDKXdLbs5oAKqU5nDPKbljbi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eXp/lwwVvWeEMbRvy3kuxSz/AaCEA3vwhWofMQlcUiNHEwd2d9u/hKgUSbuDKHs62
         yfGnWux9k7HS7uMGj4a7Qnq0+S/Ms6J/PzTf5vdVVCwqHK7q1LzPVwWClrKGzwFeyo
         JBLtX5XN6jtYKxMI32h8dwTT1n8uVVW6draC3nE4=
Date:   Wed, 11 Sep 2019 20:26:07 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, maco@android.com,
        gregkh@linuxfoundation.org,
        Matthias Maennich <maennich@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] module: Fix link failure due to invalid relocation on
 namespace offset
Message-ID: <20190911182607.GB640@linux-8ccs>
References: <20190911122646.13838-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190911122646.13838-1-will@kernel.org>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Will Deacon [11/09/19 13:26 +0100]:
>Commit 8651ec01daed ("module: add support for symbol namespaces.")
>broke linking for arm64 defconfig:
>
>  | lib/crypto/arc4.o: In function `__ksymtab_arc4_setkey':
>  | arc4.c:(___ksymtab+arc4_setkey+0x8): undefined reference to `no symbol'
>  | lib/crypto/arc4.o: In function `__ksymtab_arc4_crypt':
>  | arc4.c:(___ksymtab+arc4_crypt+0x8): undefined reference to `no symbol'
>
>This is because the dummy initialisation of the 'namespace_offset' field
>in 'struct kernel_symbol' when using EXPORT_SYMBOL on architectures with
>support for PREL32 locations uses an offset from an absolute address (0)
>in an effort to trick 'offset_to_pointer' into behaving as a NOP,
>allowing non-namespaced symbols to be treated in the same way as those
>belonging to a namespace.
>
>Unfortunately, place-relative relocations require a symbol reference
>rather than an absolute value and, although x86 appears to get away with
>this due to placing the kernel text at the top of the address space, it
>almost certainly results in a runtime failure if the kernel is relocated
>dynamically as a result of KASLR.
>
>Rework 'namespace_offset' so that a value of 0, which cannot occur for a
>valid namespaced symbol, indicates that the corresponding symbol does
>not belong to a namespace.
>
>Cc: Matthias Maennich <maennich@google.com>
>Cc: Jessica Yu <jeyu@kernel.org>
>Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>Cc: Catalin Marinas <catalin.marinas@arm.com>
>Fixes: 8651ec01daed ("module: add support for symbol namespaces.")
>Reported-by: kbuild test robot <lkp@intel.com>
>Signed-off-by: Will Deacon <will@kernel.org>

Applied, thanks everyone!

Jessica

>---
>
>Please note that I've not been able to test this at LPC, but it's been
>submitted to kernelci.
>
> include/asm-generic/export.h | 2 +-
> include/linux/export.h       | 2 +-
> kernel/module.c              | 2 ++
> 3 files changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
>index e2b5d0f569d3..d0912c7ac2fc 100644
>--- a/include/asm-generic/export.h
>+++ b/include/asm-generic/export.h
>@@ -17,7 +17,7 @@
>
> .macro __put, val, name
> #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>-	.long	\val - ., \name - ., 0 - .
>+	.long	\val - ., \name - ., 0
> #elif defined(CONFIG_64BIT)
> 	.quad	\val, \name, 0
> #else
>diff --git a/include/linux/export.h b/include/linux/export.h
>index 2c5468d8ea9a..ef5d015d754a 100644
>--- a/include/linux/export.h
>+++ b/include/linux/export.h
>@@ -68,7 +68,7 @@ extern struct module __this_module;
> 	    "__ksymtab_" #sym ":				\n"	\
> 	    "	.long	" #sym "- .				\n"	\
> 	    "	.long	__kstrtab_" #sym "- .			\n"	\
>-	    "	.long	0 - .					\n"	\
>+	    "	.long	0					\n"	\
> 	    "	.previous					\n")
>
> struct kernel_symbol {
>diff --git a/kernel/module.c b/kernel/module.c
>index f76efcf2043e..7ab244c4e1ba 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -547,6 +547,8 @@ static const char *kernel_symbol_name(const struct kernel_symbol *sym)
> static const char *kernel_symbol_namespace(const struct kernel_symbol *sym)
> {
> #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>+	if (!sym->namespace_offset)
>+		return NULL;
> 	return offset_to_ptr(&sym->namespace_offset);
> #else
> 	return sym->namespace;
>-- 
>2.23.0.162.g0b9fbb3734-goog
>
