Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFB7C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4162082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="EVyjXNAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfEFIKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:10:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5430 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfEFIKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:10:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44yFmH1dz8z9v1Pf;
        Mon,  6 May 2019 10:10:39 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=EVyjXNAR; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id TO0FP1mGXTrP; Mon,  6 May 2019 10:10:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44yFmH0bjkz9v1Pd;
        Mon,  6 May 2019 10:10:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557130239; bh=Of2RhhubGl1Te2nzFxMAnUU+f2d0/2ySlpMz5ZHw1cs=;
        h=From:Subject:To:Cc:Date:From;
        b=EVyjXNARxDDVmsSgNDq15PUEktCyj18VKtPeAESAkSXR96TV1vVuajC5zPMrHW5QG
         wU6FT0LeTWOuQONovHidvc6wJdWYBvCwie6VvWFOP0Fs/3/wcWVHWSoOSEciwtvsAO
         F7URvwxMhQAUuic2dJ23CN9LOTyznf2VLmH52Pnk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 90B5B8B8A4;
        Mon,  6 May 2019 10:10:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kmaPqq4R6FZK; Mon,  6 May 2019 10:10:43 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6627F8B74F;
        Mon,  6 May 2019 10:10:43 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 54E7F672A7; Mon,  6 May 2019 08:10:43 +0000 (UTC)
Message-Id: <3a330ee8d98fce60c08c3d26054d2f0f8f53b66a.1557130203.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: fix section mismatch for setup_kup()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  6 May 2019 08:10:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b28c97505eb1 ("powerpc/64: Setup KUP on secondary CPUs")
moved setup_kup() out of the __init section. As stated in that commit,
"this is only for 64-bit". But this function is also used on PPC32,
where the two functions called by setup_kup() are in the __init
section, so setup_kup() has to either be kept in the __init
section on PPC32 or marked __ref.

This patch marks it __ref, it fixes the below build warnings.

  MODPOST vmlinux.o
WARNING: vmlinux.o(.text+0x169ec): Section mismatch in reference from the function setup_kup() to the function .init.text:setup_kuep()
The function setup_kup() references
the function __init setup_kuep().
This is often because setup_kup lacks a __init
annotation or the annotation of setup_kuep is wrong.

WARNING: vmlinux.o(.text+0x16a04): Section mismatch in reference from the function setup_kup() to the function .init.text:setup_kuap()
The function setup_kup() references
the function __init setup_kuap().
This is often because setup_kup lacks a __init
annotation or the annotation of setup_kuap is wrong.

Fixes: b28c97505eb1 ("powerpc/64: Setup KUP on secondary CPUs")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/init-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 6ea5607fc564..3bcae9e5e954 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -45,7 +45,7 @@ static int __init parse_nosmap(char *p)
 }
 early_param("nosmap", parse_nosmap);
 
-void setup_kup(void)
+void __ref setup_kup(void)
 {
 	setup_kuep(disable_kuep);
 	setup_kuap(disable_kuap);
-- 
2.13.3

