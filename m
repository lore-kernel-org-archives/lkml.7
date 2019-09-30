Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E256C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510A021855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569843948;
	bh=iv/Dtkavbg/c29QLGURU+cPsjlv6mILK2Etm2RWqlsg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0u5dUATXWEM1Yz1eflAxtBjMpm0o1ItcJUD0YuAxaop88t035yAXDR5pIrwI4PsJw
	 jaMYK1RdWoxJbBftoDt7a5Ddrv5aNbBNekbVBchmqoxiOdoArtWbEzPh3RRlb566e3
	 Pj1UXSqTRwd0iSUXKX8Gv92O+w3xb1fThK7IdElQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfI3Lpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 07:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbfI3Lpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 07:45:47 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97087216F4;
        Mon, 30 Sep 2019 11:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569843946;
        bh=iv/Dtkavbg/c29QLGURU+cPsjlv6mILK2Etm2RWqlsg=;
        h=From:To:Cc:Subject:Date:From;
        b=0SYpXQ7z0QqoDRun4j/lbd+Nx36/8rnMBqY1n7l6Y4BBOg6z5T4r6JtXfDJGLvQQr
         dcVxK9jQDZFTsjWZbuJCCNAP+8uqw3xcoyqeX9kSfNfU9Th0kgCph02Y2BHC1OSk3F
         da3X7DvTVSE0cKe9gbaWg3qLY9bKfNv/RYIiA1FE=
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org, yamada.masahiro@socionext.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Partially revert "compiler: enable CONFIG_OPTIMIZE_INLINING forcibly"
Date:   Mon, 30 Sep 2019 12:45:40 +0100
Message-Id: <20190930114540.27498-1-will@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ac7c3e4ff401b304489a031938dbeaab585bfe0a for ARM and
arm64.

Building an arm64 kernel with CONFIG_OPTIMIZE_INLINING=y has been shown
to violate fixed register allocations of local variables passed to
inline assembly with GCC prior to version 9 which can lead to subtle
failures at runtime:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91111

A very similar has been reported for 32-bit ARM as well:

  https://lkml.kernel.org/r/f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de

Although GCC 9.1 appears to work for the specific case in the bugzilla
above, the exact issue has not been root-caused so play safe and disable
the option for now on these architectures.

Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will@kernel.org>
---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 93d97f9b0157..c37c72adaeff 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -312,6 +312,7 @@ config HEADERS_CHECK
 
 config OPTIMIZE_INLINING
 	def_bool y
+	depends on !(ARM || ARM64) # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91111
 	help
 	  This option determines if the kernel forces gcc to inline the functions
 	  developers have marked 'inline'. Doing so takes away freedom from gcc to
-- 
2.23.0.444.g18eeb5a265-goog

