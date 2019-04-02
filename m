Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0685C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D31120882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="kjofzvdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbfDBJIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:08:46 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:27027 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729891AbfDBJIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:08:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44YNfx2Pndz9v0Zq;
        Tue,  2 Apr 2019 11:08:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=kjofzvdN; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id uEIFnVA0Kcdi; Tue,  2 Apr 2019 11:08:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44YNfx1LgBz9v0ZY;
        Tue,  2 Apr 2019 11:08:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1554196121; bh=Ywo5YJrI3LgNFe1Z6eAleyQ7tq3VuI8VEmtkgnA2mts=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=kjofzvdNyl1O7rOA6BfLLYQkm8QtaZEMWRaMEmMtIruzljl9sqWlLIVXffgl3KYz8
         gix3kIXo7Jq7IAaSVoUcmFPfjhcuZxHq3OR45sLJdbLO+0++dIH/e1SIZ0yRgJzJ5L
         U6VvyYc21bWNiweF7NInHeAiPudwrQ7ZtzE90aHM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C8358B8C4;
        Tue,  2 Apr 2019 11:08:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4NbIs-r8Pfvv; Tue,  2 Apr 2019 11:08:42 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2429E8B8C3;
        Tue,  2 Apr 2019 11:08:42 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 04B27661D9; Tue,  2 Apr 2019 09:08:42 +0000 (UTC)
Message-Id: <5afa3240df486cfaf29d46a3c59546171c4c4799.1554195798.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554195798.git.christophe.leroy@c-s.fr>
References: <cover.1554195798.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 7/9] powerpc: add capability to prepend default command line
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org
Date:   Tue,  2 Apr 2019 09:08:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch activates the capability to prepend default
arguments to the command line.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2972348e52be..22d6a48bd2ca 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -860,6 +860,12 @@ config CMDLINE_EXTEND
 	  The default kernel command string will be appended to the
 	  command-line arguments provided during boot.
 
+config CMDLINE_PREPEND
+	bool "Prepend bootloader kernel arguments"
+	help
+	  The default kernel command string will be prepend to the
+	  command-line arguments provided during boot.
+
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
 	help
-- 
2.13.3

