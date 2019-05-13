Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81CAC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82BD208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pSLMC7V2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfEMKAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:00:19 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63502 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfEMKAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:00:18 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 452bsR61QVz9v1jP;
        Mon, 13 May 2019 12:00:11 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=pSLMC7V2; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id laj-TVpyDV73; Mon, 13 May 2019 12:00:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 452bsR47p3z9v1jF;
        Mon, 13 May 2019 12:00:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557741611; bh=7BTEEM+fWZP7D+ZAJLkxi+yNPxZ6hOf02JrDoJz+wok=;
        h=From:Subject:To:Cc:Date:From;
        b=pSLMC7V21X3M2Qjio/MFQS4XnWRy89zm8AxvXWHNx6u2phqBSCYHDo5PPhqKnZzGM
         WCK3IYSgGGeZ4nWRUm3h7MsiRd+wCz7ygUsdhD7Dv6RU7u07Pju3vo+jZV8gJpoKI5
         5VO3OycYEGFkyQJB2iNlmgQBXA7vkyH84W9b4X2Y=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BE5148B895;
        Mon, 13 May 2019 12:00:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nHk28pMR5pLm; Mon, 13 May 2019 12:00:15 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CC82B8B896;
        Mon, 13 May 2019 12:00:14 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 69A5567402; Mon, 13 May 2019 10:00:14 +0000 (UTC)
Message-Id: <7496da89e027e563cb8e62dc89548525cf53b57e.1557741292.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/2] powerpc/lib: fix redundant inclusion of quad.o
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 13 May 2019 10:00:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

quad.o is only for PPC64, and already included in obj64-y,
so it doesn't have to be in obj-y

Fixes: 31bfdb036f12 ("powerpc: Use instruction emulation infrastructure to handle alignment faults")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index c55f9c27bf79..17fce3738d48 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -49,7 +49,7 @@ obj64-$(CONFIG_KPROBES_SANITY_TEST)	+= test_emulate_step.o \
 obj-y			+= checksum_$(BITS).o checksum_wrappers.o \
 			   string_$(BITS).o
 
-obj-y			+= sstep.o ldstfp.o quad.o
+obj-y			+= sstep.o ldstfp.o
 obj64-y			+= quad.o
 
 obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
-- 
2.13.3

