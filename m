Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416D3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEC320700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="YRDmE6im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfCVIJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:09:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56762 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727668AbfCVIIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:08:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44Qbrp1zCnz9v9vQ;
        Fri, 22 Mar 2019 09:08:42 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=YRDmE6im; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xaqMbFp22Bi0; Fri, 22 Mar 2019 09:08:42 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44Qbrp0p8Jz9v9vG;
        Fri, 22 Mar 2019 09:08:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553242122; bh=NlZk3dLdQ7uK/0CFab2/pH5R0GUZIcXhpgeYN8gf+0I=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=YRDmE6imCmSiaWGzq7HX5fUH4UdpTlNgAT8OyUc8DavICo4Zryg4wZ7ls6Us8XmdP
         +BH4u+HP6l4c5dItFZXT5uvyPDhr/0kk5x9FsfYWcRxui1CxajtlD90Hhpn8zQyVxv
         j0+ZE1V5cnJUoZqcVOv8pboT3ETKr3o8GalopgyQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0BB4D8B845;
        Fri, 22 Mar 2019 09:08:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TohO5wbziRZo; Fri, 22 Mar 2019 09:08:42 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E4A778B844;
        Fri, 22 Mar 2019 09:08:42 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D7BCC6CD85; Fri, 22 Mar 2019 08:08:42 +0000 (UTC)
Message-Id: <6204a4de51d9c83c22b32e519337b1e9d837a19a.1553242059.git.christophe.leroy@c-s.fr>
In-Reply-To: <a2ac33258063682558fe0cac8eedcbd28aa4a141.1553242059.git.christophe.leroy@c-s.fr>
References: <a2ac33258063682558fe0cac8eedcbd28aa4a141.1553242059.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/7] powerpc/setup: Remove unnecessary #ifdef CONFIG_ALTIVEC
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 22 Mar 2019 08:08:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU_FTR_ALTIVEC is only set when CONFIG_ALTIVEC is selected, so
the ifdef is unnecessary.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/setup-common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index a4ed9301e815..fa90585760c0 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -248,10 +248,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	else
 		seq_printf(m, "unknown (%08x)", pvr);
 
-#ifdef CONFIG_ALTIVEC
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		seq_printf(m, ", altivec supported");
-#endif /* CONFIG_ALTIVEC */
 
 	seq_printf(m, "\n");
 
-- 
2.13.3

