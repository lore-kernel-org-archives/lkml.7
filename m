Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C453CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CC920731
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574262145;
	bh=yxx+qE1WrejWUHpUk0uPaXwqaaabpk1t3tYxoMbmI4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hxHeTAjo3QlefVZLIyFi/u7xxtneIQD8dXr5SJA0fSZMcwYMYyUQR6mYDOgj4hwz9
	 7B6+hrTt2gPYFh502kOGb11hV3fj47csXgflTecBqz0NOYKLuMY0AeVn0h7rj3h9o5
	 xfezJC/9Ic5H7Y0pXN9ZyYF4ei3FX3lB3FH/OxCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfKTPCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:51518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbfKTPCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:02:24 -0500
Received: from linux-8ccs (x2f7fef5.dyn.telefonica.de [2.247.254.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39A7020731;
        Wed, 20 Nov 2019 15:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574262142;
        bh=yxx+qE1WrejWUHpUk0uPaXwqaaabpk1t3tYxoMbmI4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cw3bB3o7CtrF9VC80gZEKMIo5f9IDXKl8uk5lRrwC/Z29SxQ0gD8cvrNgX1evegkr
         rlNHZnDiG+l41WRpx5OzC/fLZg6WBpDP9S3qS6xldCsAdGvHam0w9Pr0PlCfBpJjTa
         U1pP0DZeBmrL/zg+MZjeULMd82pwIXEdBHokePYQ=
Date:   Wed, 20 Nov 2019 16:02:16 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthias Maennich <maennich@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] export.h: reduce __ksymtab_strings string duplication by
 using "MS" section flags
Message-ID: <20191120150215.GA756@linux-8ccs>
References: <20191120145110.8397-1-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191120145110.8397-1-jeyu@kernel.org>
X-OS:   Linux linux-8ccs 5.4.0-rc5-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Jessica Yu [20/11/19 15:51 +0100]:
>Commit c3a6cf19e695 ("export: avoid code duplication in
>include/linux/export.h") refactors export.h quite nicely, but introduces
>a slight increase in memory usage due to using the empty string ""
>instead of NULL to indicate that an exported symbol has no namespace. As
>mentioned in that commit, this meant an increase of 1 byte per exported
>symbol without a namespace. For example, if a kernel configuration has
>about 10k exported symbols, this would mean that the size of
>__ksymtab_strings would increase by roughly 10kB.
>
>We can alleviate this situation by utilizing the SHF_MERGE and
>SHF_STRING section flags. SHF_MERGE|SHF_STRING indicate to the linker
>that the data in the section are null-terminated strings that can be
>merged to eliminate duplication. More specifically, from the binutils
>documentation - "for sections with both M and S, a string which is a
>suffix of a larger string is considered a duplicate. Thus "def" will be
>merged with "abcdef"; A reference to the first "def" will be changed to
>a reference to "abcdef"+3". Thus, all the empty strings would be merged
>as well as any strings that can be merged according to the cited method
>above. For example, "memset" and "__memset" would be merged to just
>"__memset" in __ksymtab_strings.
>
>As of v5.4-rc5, the following statistics were gathered with x86
>defconfig with approximately 10.7k exported symbols.
>
>Size of __ksymtab_strings in vmlinux:
>-------------------------------------
>v5.4-rc5: 213834 bytes
>v5.4-rc5 with commit c3a6cf19e695: 224455 bytes
>v5.4-rc5 with this patch: 205759 bytes
>
>So, we already see memory savings of ~8kB compared to vanilla -rc5 and
>savings of nearly 18.7kB compared to -rc5 with commit c3a6cf19e695 on top.
>
>Unfortunately, as of this writing, strings will not get deduplicated for
>kernel modules, as ld does not do the deduplication for
>SHF_MERGE|SHF_STRINGS sections for relocatable files (ld -r), which
>kernel modules are. A patch for ld is currently being worked on to
>hopefully allow for string deduplication in relocatable files in the
>future.
>
>Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>Signed-off-by: Jessica Yu <jeyu@kernel.org>
>---
> include/asm-generic/export.h | 13 ++++++++++---
> include/linux/export.h       | 28 ++++++++++++++++++++++------
> 2 files changed, 32 insertions(+), 9 deletions(-)
>
>diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
>index fa577978fbbd..d0704f2602f4 100644
>--- a/include/asm-generic/export.h
>+++ b/include/asm-generic/export.h
>@@ -26,9 +26,16 @@
> .endm
>
> /*
>- * note on .section use: @progbits vs %progbits nastiness doesn't matter,
>- * since we immediately emit into those sections anyway.
>+ * note on .section use: we specify @progbits vs %progbits since usage of
>+ * "M" (SHF_MERGE) section flag requires it.
>  */
>+
>+#ifdef CONFIG_ARM
>+#define ARCH_PROGBITS %progbits
>+#else
>+#define ARCH_PROGBITS @progbits
>+#endif
>+
> .macro ___EXPORT_SYMBOL name,val,sec
> #ifdef CONFIG_MODULES
> 	.globl __ksymtab_\name
>@@ -37,7 +44,7 @@
> __ksymtab_\name:
> 	__put \val, __kstrtab_\name
> 	.previous
>-	.section __ksymtab_strings,"a"
>+	.section __ksymtab_strings,"aMS",ARCH_PROGBITS,1
> __kstrtab_\name:
> 	.asciz "\name"
> 	.previous
>diff --git a/include/linux/export.h b/include/linux/export.h
>index 201262793369..ab325a8e6bee 100644
>--- a/include/linux/export.h
>+++ b/include/linux/export.h
>@@ -81,16 +81,32 @@ struct kernel_symbol {
>
> #else
>
>+#ifdef CONFIG_ARM
>+#define ARCH_PROGBITS "%progbits"
>+#else
>+#define ARCH_PROGBITS "@progbits"
>+#endif

Just a comment, I don't like the duplication of this block, but I
wasn't sure where was the best place to have this define since
asm-generic/export.h and linux/export.h don't share includes, and
includes are generally kept to a minimum. If anyone has a better
idea, please let me know.

