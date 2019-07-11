Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB10C74A41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 03:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEDD21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 03:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eD7rAs8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfGKDIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 23:08:25 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:48355 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfGKDIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 23:08:25 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x6B37G9W027198;
        Thu, 11 Jul 2019 12:07:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x6B37G9W027198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562814437;
        bh=wDYz/yHhx6nItjKqfKQXfYFVLdaXf3nRB8CNeDF+UBU=;
        h=From:To:Cc:Subject:Date:From;
        b=eD7rAs8EKGC5P51XykS2mWVAA94CATwbNmy2EGX9wxCsfnZ2N+nX82uNV1oXLNDRJ
         hmE5opz4u7WIYBodpMeAswa/Tbt5fDbu1a1ohzDOay944iuA6+8yap8X90hT59kXZc
         Fh2HLRrFOOjtR/N5WRWq/i/YKNJ2av8OqB1bA/riW2PhZjb+VbZdwhDbQgCnIFHJmQ
         va6W9Uoebfkr/qqXPb9dDqk9/PPUupQhM035ktw9Bb1RJxhO8zSDYd4+/XBArLmrar
         9zlpsgXZKC3NoMiOz3oKNCT/pQEX37SA1g+4IPZdJQcF6ykrijwfaDw415a1DZD4AA
         yzRDl1ctAij2A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     arm@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: fix O= building with CONFIG_FPE_FASTFPE
Date:   Thu, 11 Jul 2019 12:07:12 +0900
Message-Id: <20190711030713.4447-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use Fastfpe, a user is supposed to enable CONFIG_FPE_FASTFPE
and put downstream source files into arch/arm/fastfpe/.

It is not working for O= build because $(wildcard arch/arm/fastfpe)
checks if it exists in $(objtree), not in $(srctree).

Add the $(srctree)/ prefix to fix it.

While I was here, I slightly refactored the code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

KernelVersion: 5.2

 arch/arm/Makefile | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index f863c6935d0e..792f7fa16a24 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -271,14 +271,9 @@ endif
 
 export	TEXT_OFFSET GZFLAGS MMUEXT
 
-# Do we have FASTFPE?
-FASTFPE		:=arch/arm/fastfpe
-ifeq ($(FASTFPE),$(wildcard $(FASTFPE)))
-FASTFPE_OBJ	:=$(FASTFPE)/
-endif
-
 core-$(CONFIG_FPE_NWFPE)	+= arch/arm/nwfpe/
-core-$(CONFIG_FPE_FASTFPE)	+= $(FASTFPE_OBJ)
+# Put arch/arm/fastfpe/ to use this.
+core-$(CONFIG_FPE_FASTFPE)	+= $(patsubst $(srctree)/%,%,$(wildcard $(srctree)/arch/arm/fastfpe/))
 core-$(CONFIG_VFP)		+= arch/arm/vfp/
 core-$(CONFIG_XEN)		+= arch/arm/xen/
 core-$(CONFIG_KVM_ARM_HOST) 	+= arch/arm/kvm/
-- 
2.17.1

