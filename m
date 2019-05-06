Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD6FC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB9A206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="X4CqR5N6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfEFGVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 02:21:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23979 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfEFGVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 02:21:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44yCKh0S3yz9v0Rq;
        Mon,  6 May 2019 08:20:56 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=X4CqR5N6; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PwqE9ZO0j2sv; Mon,  6 May 2019 08:20:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44yCKg6R8fz9v0Rp;
        Mon,  6 May 2019 08:20:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557123655; bh=T2y5RvizxeKaeEDPVcmW21IX3UnoXTZqaQGex3Df6Vw=;
        h=From:Subject:To:Cc:Date:From;
        b=X4CqR5N6iz8nOWDG2cdrQ/5ykBiqej4aF83INg/6fCLe5+HCY0VaymnI5O6Faen6E
         blxTtODznZXaiMt+dL2LgCB9yP3nKOeqH/0fvPEfsAYm6GrKgHeRhPnjGQasU++mY2
         kmrj5strfcbM1l049cc92ATzxdF+2le2JRKrviuo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5EA878B7F7;
        Mon,  6 May 2019 08:21:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id khgIi3ZiQrc7; Mon,  6 May 2019 08:21:00 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4664B8B74F;
        Mon,  6 May 2019 08:21:00 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2CAFF6728F; Mon,  6 May 2019 06:21:00 +0000 (UTC)
Message-Id: <421c0ebaf1287af30cc89389c9de57387b8a1a6f.1557123375.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/kasan: add missing/lost Makefile
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  6 May 2019 06:21:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For unknown reason, the new Makefile added via the KASAN suppot patch
didn't land into arch/powerpc/mm/kasan/

This patch restores it.

Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/kasan/Makefile | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 arch/powerpc/mm/kasan/Makefile

diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
new file mode 100644
index 000000000000..6577897673dd
--- /dev/null
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+KASAN_SANITIZE := n
+
+obj-$(CONFIG_PPC32)           += kasan_init_32.o
-- 
2.13.3

