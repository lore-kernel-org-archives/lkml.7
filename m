Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3361CC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F112072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="HQBqJeCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgAIIPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:15:05 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:1261 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbgAIIPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:15:04 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 47tf6s3zYvz9v3KW;
        Thu,  9 Jan 2020 09:15:01 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=HQBqJeCO; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Gi7YKr0mKWYK; Thu,  9 Jan 2020 09:15:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47tf6s2gGzz9v3KV;
        Thu,  9 Jan 2020 09:15:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1578557701; bh=aCJX3qfRGAn+3jSeLTC1vMzfBDwGoUIdPhX/7aLEOfc=;
        h=From:Subject:To:Cc:Date:From;
        b=HQBqJeCOIdc7xFwr0PRHYkj4U7bbp7zWf3xeRiO2hJAUEtL60jYN9+P1OJF6vinSV
         nyT7rLmW2/LHPUB+CNknG8UTjGOm5SyJC9B1RNM8gBNoKgp67fzQdnkDswZf1A0CZj
         2+JzV/+Sp00UtvAhYVMkNPxsmLaHNYb2DpHj07Yg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 54C348B816;
        Thu,  9 Jan 2020 09:15:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fEx0BEfzzKAO; Thu,  9 Jan 2020 09:15:02 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0EDCA8B769;
        Thu,  9 Jan 2020 09:15:02 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id B2EB063B8D; Thu,  9 Jan 2020 08:15:01 +0000 (UTC)
Message-Id: <62477e446d9685459d4f27d193af6ff1bd69d55f.1578557581.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] init: fix misleading "This architecture does not have kernel
 memory protection" message
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Thu,  9 Jan 2020 08:15:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This message leads to think that memory protection is not implemented
for the said architecture, whereas absence of CONFIG_STRICT_KERNEL_RWX
only means that memory protection has not been selected at
compile time.

Don't print this message when CONFIG_ARCH_HAS_STRICT_KERNEL_RWX is
selected by the architecture. Instead, print "Kernel memory protection
not selected by kernel config."

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 init/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/init/main.c b/init/main.c
index 2cd736059416..fd31b15cc910 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1090,6 +1090,11 @@ static void mark_readonly(void)
 	} else
 		pr_info("Kernel memory protection disabled.\n");
 }
+#elif defined(CONFIG_ARCH_HAS_STRICT_KERNEL_RWX)
+static inline void mark_readonly(void)
+{
+	pr_warn("Kernel memory protection not selected by kernel config.\n");
+}
 #else
 static inline void mark_readonly(void)
 {
-- 
2.13.3

