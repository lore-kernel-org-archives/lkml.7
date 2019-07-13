Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5D7C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 03:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66D3208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 03:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="H+3dgelz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfGMDWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 23:22:47 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:52676 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfGMDWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 23:22:46 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6D3LCS2001105;
        Sat, 13 Jul 2019 12:21:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6D3LCS2001105
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562988073;
        bh=1IdPDx4QX0euUr4uIRn/uQ11mnE9aURyo1Zm0ZEzzSs=;
        h=From:To:Cc:Subject:Date:From;
        b=H+3dgelzRhySedQpLwoncmnFJlhOAC6smKw42tgxGW66g4TX+fG+zinNh4AGqdkBV
         sDGCcJP/3jlpIUG+9H4jbL5ashVrZTqBN9PoDIP1bG9kY/0MaTaWYJ4vBpWTxX4Omf
         RqW5HPyA59GEjvtFZ1wcuentYVv5NNZkFEWlYZ9ZehokwLXXZUshr7g+PqbMuvcy50
         SzPi5sTmajRUbguE4yWfcNru+V6pjhCXQaux7lpKlKU9UnUp/SKGF9Fj6AQYfpeOG8
         YIUYRITsvVlb8B8NQYEZJcn7roPqrgX41eu2sOvXQ7hqe6g0yNBm2702TTuTtq5KU+
         bWX8tcpizGxbg==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
Date:   Sat, 13 Jul 2019 12:21:06 +0900
Message-Id: <20190713032106.8509-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KBUILD_ARFLAGS addition in arch/powerpc/Makefile has never worked
in a useful way because it is always overridden by the following code
in the top Makefile:

  # use the deterministic mode of AR if available
  KBUILD_ARFLAGS := $(call ar-option,D)

The code in the top Makefile was added in 2011, by commit 40df759e2b9e
("kbuild: Fix build with binutils <= 2.19").

The KBUILD_ARFLAGS addition for ppc has always been dead code from the
beginning.

Nobody has reported a problem since 43c9127d94d6 ("powerpc: Add option
to use thin archives"), so this code was unneeded.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/powerpc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index c345b79414a9..46ed198a3aa3 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -112,7 +112,6 @@ ifeq ($(HAS_BIARCH),y)
 KBUILD_CFLAGS	+= -m$(BITS)
 KBUILD_AFLAGS	+= -m$(BITS) -Wl,-a$(BITS)
 KBUILD_LDFLAGS	+= -m elf$(BITS)$(LDEMULATION)
-KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
 endif
 
 cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard=tls
-- 
2.17.1

