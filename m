Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13CCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC6120830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140876;
	bh=4+ZI5CvHTgzdgmdN0lK5VqRpOn9dqFBWacv2sDQA6ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bqAVlus5LuCqCcJgsSE640PCGxBtssc/oQPCPclJsdCuWk0VmydKM/VwATddNgAIx
	 T0By4gbaRn8HGu1Z1NgdAmva0VnP/74T8TAUFc5KUrPEj5wDUc4sxLRn0aLIFTPsg4
	 GhtCwiQBBKuiZW+mSWHlgn2igCCQ9FqL5hyKCuP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733311AbfDARbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:31:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733292AbfDARbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:31:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1AF720856;
        Mon,  1 Apr 2019 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139904;
        bh=4+ZI5CvHTgzdgmdN0lK5VqRpOn9dqFBWacv2sDQA6ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrKuUA3/bLPhmdRzkRD2xfCjFhyGPSWff0yU9DZuU9MT6cO30w0cAQtJJv0MbcK7v
         ijQ1pl5YYbd5pB14TSsFL81ZsTy5D0TbtFYrqxXMvs5ZqmkNRt/7kEaG0gyO17BXMS
         POa1FCxg2Uwkl31jMQz8frUe4+eJDeALBQ5+J+7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 049/131] arm64: hide __efistub_ aliases from kallsyms
Date:   Mon,  1 Apr 2019 19:01:59 +0200
Message-Id: <20190401170056.413922861@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 75feee3d9d51775072d3a04f47d4a439a4c4590e ]

Commit e8f3010f7326 ("arm64/efi: isolate EFI stub from the kernel
proper") isolated the EFI stub code from the kernel proper by prefixing
all of its symbols with __efistub_, and selectively allowing access to
core kernel symbols from the stub by emitting __efistub_ aliases for
functions and variables that the stub can access legally.

As an unintended side effect, these aliases are emitted into the
kallsyms symbol table, which means they may turn up in backtraces,
e.g.,

  ...
  PC is at __efistub_memset+0x108/0x200
  LR is at fixup_init+0x3c/0x48
  ...
  [<ffffff8008328608>] __efistub_memset+0x108/0x200
  [<ffffff8008094dcc>] free_initmem+0x2c/0x40
  [<ffffff8008645198>] kernel_init+0x20/0xe0
  [<ffffff8008085cd0>] ret_from_fork+0x10/0x40

The backtrace in question has nothing to do with the EFI stub, but
simply returns one of the several aliases of memset() that have been
recorded in the kallsyms table. This is undesirable, since it may
suggest to people who are not aware of this that the issue they are
seeing is somehow EFI related.

So hide the __efistub_ aliases from kallsyms, by emitting them as
absolute linker symbols explicitly. The distinction between those
and section relative symbols is completely irrelevant to these
definitions, and to the final link we are performing when these
definitions are being taken into account (the distinction is only
relevant to symbols defined inside a section definition when performing
a partial link), and so the resulting values are identical to the
original ones. Since absolute symbols are ignored by kallsyms, this
will result in these values to be omitted from its symbol table.

After this patch, the backtrace generated from the same address looks
like this:
  ...
  PC is at __memset+0x108/0x200
  LR is at fixup_init+0x3c/0x48
  ...
  [<ffffff8008328608>] __memset+0x108/0x200
  [<ffffff8008094dcc>] free_initmem+0x2c/0x40
  [<ffffff8008645198>] kernel_init+0x20/0xe0
  [<ffffff8008085cd0>] ret_from_fork+0x10/0x40

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/image.h | 40 ++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index bc2abb8b1599..999633bd7294 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -64,6 +64,16 @@
 
 #ifdef CONFIG_EFI
 
+/*
+ * Prevent the symbol aliases below from being emitted into the kallsyms
+ * table, by forcing them to be absolute symbols (which are conveniently
+ * ignored by scripts/kallsyms) rather than section relative symbols.
+ * The distinction is only relevant for partial linking, and only for symbols
+ * that are defined within a section declaration (which is not the case for
+ * the definitions below) so the resulting values will be identical.
+ */
+#define KALLSYMS_HIDE(sym)	ABSOLUTE(sym)
+
 /*
  * The EFI stub has its own symbol namespace prefixed by __efistub_, to
  * isolate it from the kernel proper. The following symbols are legally
@@ -73,25 +83,25 @@
  * linked at. The routines below are all implemented in assembler in a
  * position independent manner
  */
-__efistub_memcmp		= __pi_memcmp;
-__efistub_memchr		= __pi_memchr;
-__efistub_memcpy		= __pi_memcpy;
-__efistub_memmove		= __pi_memmove;
-__efistub_memset		= __pi_memset;
-__efistub_strlen		= __pi_strlen;
-__efistub_strcmp		= __pi_strcmp;
-__efistub_strncmp		= __pi_strncmp;
-__efistub___flush_dcache_area	= __pi___flush_dcache_area;
+__efistub_memcmp		= KALLSYMS_HIDE(__pi_memcmp);
+__efistub_memchr		= KALLSYMS_HIDE(__pi_memchr);
+__efistub_memcpy		= KALLSYMS_HIDE(__pi_memcpy);
+__efistub_memmove		= KALLSYMS_HIDE(__pi_memmove);
+__efistub_memset		= KALLSYMS_HIDE(__pi_memset);
+__efistub_strlen		= KALLSYMS_HIDE(__pi_strlen);
+__efistub_strcmp		= KALLSYMS_HIDE(__pi_strcmp);
+__efistub_strncmp		= KALLSYMS_HIDE(__pi_strncmp);
+__efistub___flush_dcache_area	= KALLSYMS_HIDE(__pi___flush_dcache_area);
 
 #ifdef CONFIG_KASAN
-__efistub___memcpy		= __pi_memcpy;
-__efistub___memmove		= __pi_memmove;
-__efistub___memset		= __pi_memset;
+__efistub___memcpy		= KALLSYMS_HIDE(__pi_memcpy);
+__efistub___memmove		= KALLSYMS_HIDE(__pi_memmove);
+__efistub___memset		= KALLSYMS_HIDE(__pi_memset);
 #endif
 
-__efistub__text			= _text;
-__efistub__end			= _end;
-__efistub__edata		= _edata;
+__efistub__text			= KALLSYMS_HIDE(_text);
+__efistub__end			= KALLSYMS_HIDE(_end);
+__efistub__edata		= KALLSYMS_HIDE(_edata);
 
 #endif
 
-- 
2.19.1



