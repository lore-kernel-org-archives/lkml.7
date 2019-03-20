Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC8CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C59E2186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="JxhGkzxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfCTKH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:07:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37117 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbfCTKGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:06:54 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44PQZ350x5z9vC03;
        Wed, 20 Mar 2019 11:06:51 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=JxhGkzxj; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bAZmZiKkuzdg; Wed, 20 Mar 2019 11:06:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44PQZ33ZNHz9vByx;
        Wed, 20 Mar 2019 11:06:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553076411; bh=XrFU9+s19I/PqLJ/l7h2r2P99TknaN3XNHVH3vsvpHs=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=JxhGkzxjvxTnveWNajGUdv0VyQXqq1IsoO2cRLyzpBescLwmKkXofRl8K/W6mE2PF
         /3O60BRFb6TKM00KgAXGK7j83A8/egD6BEO5GgiZt9w4cnp4ksIzR5+4hFragd1oBL
         BK78O9L7aKYuX41cvs6T2KZZpR+aX+10dZhyuo0E=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 99DD08B918;
        Wed, 20 Mar 2019 11:06:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id S0y-DllwjSTs; Wed, 20 Mar 2019 11:06:52 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7EE458B911;
        Wed, 20 Mar 2019 11:06:52 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5BC1663AEF; Wed, 20 Mar 2019 10:06:52 +0000 (UTC)
Message-Id: <b7dd61051c1cb959a78a57566bba44edd3003d50.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 16/27] powerpc/mm: move hugetlb_disabled into asm/hugetlb.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Mar 2019 10:06:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to have this in asm/page.h, move it into asm/hugetlb.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hugetlb.h | 2 ++
 arch/powerpc/include/asm/page.h    | 1 -
 arch/powerpc/kernel/fadump.c       | 1 +
 arch/powerpc/mm/hash_utils_64.c    | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index fd5c0873a57d..84598c6b0959 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -13,6 +13,8 @@
 #include <asm/nohash/32/hugetlb-8xx.h>
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
+extern bool hugetlb_disabled;
+
 void flush_dcache_icache_hugepage(struct page *page);
 
 int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index ed870468ef6f..0c11a7513919 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -29,7 +29,6 @@
 
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_HUGETLB_PAGE
-extern bool hugetlb_disabled;
 extern unsigned int HPAGE_SHIFT;
 #else
 #define HPAGE_SHIFT PAGE_SHIFT
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 45a8d0be1c96..25f063f56ec5 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -36,6 +36,7 @@
 #include <linux/sysfs.h>
 #include <linux/slab.h>
 #include <linux/cma.h>
+#include <linux/hugetlb.h>
 
 #include <asm/debugfs.h>
 #include <asm/page.h>
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0a4f939a8161..16ce13af6b9c 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -37,6 +37,7 @@
 #include <linux/context_tracking.h>
 #include <linux/libfdt.h>
 #include <linux/pkeys.h>
+#include <linux/hugetlb.h>
 
 #include <asm/debugfs.h>
 #include <asm/processor.h>
-- 
2.13.3

