Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0431C47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54092087E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Dn8/QAVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfJaAcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 20:32:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50435 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfJaAcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 20:32:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id 11so4088874wmk.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 17:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tDHh+OVXKEM0h+uKC7EIERstcizYBjZxP2HUDdfEVt8=;
        b=Dn8/QAVbq0JfM6dbr7uT/LDSjMsuYs4CxFf+CS82fAkPePNSAGzb5Y0MnIf2ipZiHx
         POfZhnEE3UHOkJ9d/P4volBMryXP1/aujGfSYCD7vqeNMrU++oR+psgTkC/v689cAwcu
         FJP2RLuVzWiYM8UlzeEvwu9SX0Et8qvWQXB88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tDHh+OVXKEM0h+uKC7EIERstcizYBjZxP2HUDdfEVt8=;
        b=VucYJSHPl5td+kvz0RV1ShNzSD/sgt98CXJrJ5IUuYY2OJx09WUkG7C/A/V0GluBpo
         zqQFU4TsbuSQmUGgijO4OM7LtXVlX8oky010NkcWhhemSK1GlfsFo8DW3OyQDZEGOKUk
         H3KRDBFTMnm0jjXRW4cyTfIkkJR53D8hiVjP2+sRJl3+xT8RCEBdkDVVFTLnc9k8zb45
         xhkdAWFVSqNveYhxLW/Jd7zsW6pcxB3w+4qarjeNgP66Voy0sOJ22LrZfXE9gIypAVXC
         VdhYphLFvlBh0gzNGJkJnZf7jTw9OGw2jZZzSmV51JKUQOVCN1scP25KXoApEpQFViUI
         GhMA==
X-Gm-Message-State: APjAAAVjgJ8gQ1YDmA47bF4iA/BR14O80xmbKGajCeWVwHcIiy5gT3TQ
        pMbXpwzA8pRQ6W9qUDvy14Tq2g==
X-Google-Smtp-Source: APXvYqz3VwKmyFrg0snFjZE++GwOdD4oDrvjFS6yyK5iarkJGuhLRfN5MmMf7SAZIOqcSO0W8SJCNw==
X-Received: by 2002:a7b:c01a:: with SMTP id c26mr2165585wmb.45.1572481924905;
        Wed, 30 Oct 2019 17:32:04 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id r13sm2357111wra.74.2019.10.30.17.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 17:32:04 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 4/5] powerpc: make pcibios_vaddr_is_ioport() static
Date:   Thu, 31 Oct 2019 01:31:53 +0100
Message-Id: <20191031003154.21969-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of pcibios_vaddr_is_ioport() is in pci-common.c, so we
can make it static and move it into the same #ifndef block as its
caller.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/include/asm/pci-bridge.h | 9 ---------
 arch/powerpc/kernel/pci-common.c      | 4 ++--
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index ea6ec65970ef..deb29a1c9708 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -283,14 +283,5 @@ extern struct pci_controller *pcibios_alloc_controller(struct device_node *dev);
 extern void pcibios_free_controller(struct pci_controller *phb);
 extern void pcibios_free_controller_deferred(struct pci_host_bridge *bridge);
 
-#ifdef CONFIG_PCI
-extern int pcibios_vaddr_is_ioport(void __iomem *address);
-#else
-static inline int pcibios_vaddr_is_ioport(void __iomem *address)
-{
-	return 0;
-}
-#endif	/* CONFIG_PCI */
-
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_PCI_BRIDGE_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index d89a2426b405..928d7576c6c2 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -277,7 +277,8 @@ static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 #endif
 }
 
-int pcibios_vaddr_is_ioport(void __iomem *address)
+#ifndef CONFIG_PPC_INDIRECT_PIO
+static int pcibios_vaddr_is_ioport(void __iomem *address)
 {
 	int ret = 0;
 	struct pci_controller *hose;
@@ -296,7 +297,6 @@ int pcibios_vaddr_is_ioport(void __iomem *address)
 	return ret;
 }
 
-#ifndef CONFIG_PPC_INDIRECT_PIO
 void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
 	if (isa_vaddr_is_ioport(addr))
-- 
2.23.0

