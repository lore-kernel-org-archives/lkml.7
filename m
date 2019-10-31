Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7156CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E5620862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Xo2jF187"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfJaAcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 20:32:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51992 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfJaAcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 20:32:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id q70so4069446wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 17:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DYhACg+zO53SUeLC5iAmeJtmmamitSVr5JjCgBatEmk=;
        b=Xo2jF187UE1MGGGjZ8wN0vNAH7wPPEVfI4ZvaURxYjN1pWSFx+8HdyvTcP3FzTn987
         08YzzHq6OGkCXz6Im4EZfJbwBJNjKtnt3kBbs0JwsG41sI9SdnEErK9HVKIuV5ytBAAd
         jnU/gdaLBryLQcmiUDOmHH8SzYQxepk523nE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYhACg+zO53SUeLC5iAmeJtmmamitSVr5JjCgBatEmk=;
        b=MOtuUxeNfopy6SYifbdllJhMzNkB/0KGqAd3eq9Tve5YuQCUoWqukgpXs9FTWmfLAj
         orgnQZ4CtrdFUBTh3kJ5i7uNmtuMqR8K3ddClfQ6YaqQwJKMXv8zkP98W6zs09bycb6u
         juoDD+1GB3j/CyZDrUf3J88Dim6sI8WwnxDvliiY/Uij1y4/h+SHiQtsXA9JilZwCKlE
         pfwOABb7C7E1PGWguTFGNQw+1aqSmtnTNj1ECxAbm1U9yDi0moG66/K5Pve6aRrGPMHK
         UdWFvuLTK/DLvz2urXKgAcuVIpsZXVsI3Q3DNJ3zzEjSGyZLSIrgB3MoGkWwrlMTLblD
         WhsQ==
X-Gm-Message-State: APjAAAVHNZvcdy8mCGLU2bHPUNSFhj2Lvj1Elb5vQEW1Agaj9/AzzaRM
        Y0dNHvxA84zVpqP9oQtpy9jaDA==
X-Google-Smtp-Source: APXvYqwpa/vkgm/Kk2t0MioAGkOHz3mAV7KnDHWGDzc5LpYTw6AEGiA6IRzxyLwSWzDsy21QG8gMPw==
X-Received: by 2002:a05:600c:cd:: with SMTP id u13mr2099609wmm.133.1572481923964;
        Wed, 30 Oct 2019 17:32:03 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id r13sm2357111wra.74.2019.10.30.17.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 17:32:03 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 3/5] powerpc: move pci_iounmap() from iomap.c to pci-common.c
Date:   Thu, 31 Oct 2019 01:31:52 +0100
Message-Id: <20191031003154.21969-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As preparation for making iowrite32 and friends static inlines, move
the definition of pci_iounmap() from iomap.c to pci-common.c. This
definition of pci_iounmap() is compiled in when
!CONFIG_PPC_INDIRECT_PIO && CONFIG_PCI - we're just interchanging
which condition is in the Kbuild logic and which is in the .c file.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/kernel/iomap.c      | 13 -------------
 arch/powerpc/kernel/pci-common.c | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c
index 5ac84efc6ede..b22fa8db5068 100644
--- a/arch/powerpc/kernel/iomap.c
+++ b/arch/powerpc/kernel/iomap.c
@@ -182,16 +182,3 @@ void ioport_unmap(void __iomem *addr)
 }
 EXPORT_SYMBOL(ioport_map);
 EXPORT_SYMBOL(ioport_unmap);
-
-#ifdef CONFIG_PCI
-void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
-{
-	if (isa_vaddr_is_ioport(addr))
-		return;
-	if (pcibios_vaddr_is_ioport(addr))
-		return;
-	iounmap(addr);
-}
-
-EXPORT_SYMBOL(pci_iounmap);
-#endif /* CONFIG_PCI */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 1c448cf25506..d89a2426b405 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -34,6 +34,7 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
+#include <asm/isa-bridge.h>
 #include <asm/byteorder.h>
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
@@ -295,6 +296,18 @@ int pcibios_vaddr_is_ioport(void __iomem *address)
 	return ret;
 }
 
+#ifndef CONFIG_PPC_INDIRECT_PIO
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{
+	if (isa_vaddr_is_ioport(addr))
+		return;
+	if (pcibios_vaddr_is_ioport(addr))
+		return;
+	iounmap(addr);
+}
+EXPORT_SYMBOL(pci_iounmap);
+#endif /* CONFIG_PPC_INDIRECT_PIO */
+
 unsigned long pci_address_to_pio(phys_addr_t address)
 {
 	struct pci_controller *hose;
-- 
2.23.0

