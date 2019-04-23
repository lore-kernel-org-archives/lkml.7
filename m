Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50681C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F966206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Q1F13NSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbfDWDvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:51:50 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:38927 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730536AbfDWDvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 23:51:47 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x3N3o2cG023044;
        Tue, 23 Apr 2019 12:50:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x3N3o2cG023044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555991415;
        bh=7qo1vbhArO2n/LZF4sYuHYL1/6J0V//9VqfNxacUkeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1F13NSrcvF2A8qD58k2kFX20pyFSYFFSEFXfst6MemH5nI+ogQbTVZV3rS+GsNcQ
         KHXD/9fjRv22l68l7IfxbcQnjZxs4/S6S0aDRad5BGjZ9TbVEhTGuuTtQqcH3vZlMa
         Siw+84dNlAlVVzvfSrMI067rafVMa4BZHPnzWNsDgdS02CdcDMajkswexssLpGT01t
         l2AFzuHdfvAep6hvoUoVEMXRoVxLbpZN+6DdicEMa0CRcEk/LeolZuI3xJ3MSFXuaj
         MiCbwlnKTnNt1QTVHluGORCKmpwIjnHxYZ/R8g+wKMdXrh00H0Yb3w3Ov8DaBB5Rkt
         tvc2mqgRywIIg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [RESEND PATCH v3 08/11] powerpc/prom_init: mark prom_getprop() and prom_getproplen() as __init
Date:   Tue, 23 Apr 2019 12:49:56 +0900
Message-Id: <20190423034959.13525-9-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423034959.13525-1-yamada.masahiro@socionext.com>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

If it is enabled for powerpc, the following modpost warnings are
reported:

WARNING: vmlinux.o(.text.unlikely+0x20): Section mismatch in reference from the function .prom_getprop() to the function .init.text:.call_prom()
The function .prom_getprop() references
the function __init .call_prom().
This is often because .prom_getprop lacks a __init
annotation or the annotation of .call_prom is wrong.

WARNING: vmlinux.o(.text.unlikely+0x3c): Section mismatch in reference from the function .prom_getproplen() to the function .init.text:.call_prom()
The function .prom_getproplen() references
the function __init .call_prom().
This is often because .prom_getproplen lacks a __init
annotation or the annotation of .call_prom is wrong.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2:
  - split into a separate patch

 arch/powerpc/kernel/prom_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index f33ff4163a51..241fe6b7a8cc 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -501,14 +501,14 @@ static int __init prom_next_node(phandle *nodep)
 	}
 }
 
-static inline int prom_getprop(phandle node, const char *pname,
-			       void *value, size_t valuelen)
+static inline int __init prom_getprop(phandle node, const char *pname,
+				      void *value, size_t valuelen)
 {
 	return call_prom("getprop", 4, 1, node, ADDR(pname),
 			 (u32)(unsigned long) value, (u32) valuelen);
 }
 
-static inline int prom_getproplen(phandle node, const char *pname)
+static inline int __init prom_getproplen(phandle node, const char *pname)
 {
 	return call_prom("getproplen", 2, 1, node, ADDR(pname));
 }
-- 
2.17.1

