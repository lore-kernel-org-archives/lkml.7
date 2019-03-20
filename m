Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A122C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACC22175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="EwI3Ojuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfCTKGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:06:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56767 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfCTKGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:06:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44PQYl507Tz9vC00;
        Wed, 20 Mar 2019 11:06:35 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=EwI3Ojuk; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id juJjm4Lwl1kv; Wed, 20 Mar 2019 11:06:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44PQYl3klVz9vByx;
        Wed, 20 Mar 2019 11:06:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553076395; bh=kIQ5rK5h2H8yjZ42iGKBgk/GXUmRuZIgLz9zU3XqFOs=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=EwI3OjukfKzYb81KMKchegESYYsXjFFyujtQawfFLPoO7miLHVFUYQgf+h0Uofek0
         zhUAfvKPSIVFg3P0hXNz2pZ1IIuwjyZuBqMqfPFkEW0eq9S4OWtmb8QOupjPpcndTc
         JITeGqZPplJ5pv/mTDduNTFRVESZRdqnLtRAVenY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9FEBE8B918;
        Wed, 20 Mar 2019 11:06:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yXLsfSSYsgaZ; Wed, 20 Mar 2019 11:06:36 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7BDDA8B911;
        Wed, 20 Mar 2019 11:06:36 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 72BEC63AEF; Wed, 20 Mar 2019 10:06:36 +0000 (UTC)
Message-Id: <9d6b0fe78346ff8e81a969a75a616bab59bc5cf5.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 01/27] powerpc/mm: Don't BUG() in hugepd_page()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Mar 2019 10:06:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't BUG(), just warn and return NULL.
If the NULL value is not handled, it will get catched anyway.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hugetlb.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 8d40565ad0c3..48c29686c78e 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -14,7 +14,8 @@
  */
 static inline pte_t *hugepd_page(hugepd_t hpd)
 {
-	BUG_ON(!hugepd_ok(hpd));
+	if (WARN_ON(!hugepd_ok(hpd)))
+		return NULL;
 	/*
 	 * We have only four bits to encode, MMU page size
 	 */
@@ -42,7 +43,8 @@ static inline void flush_hugetlb_page(struct vm_area_struct *vma,
 
 static inline pte_t *hugepd_page(hugepd_t hpd)
 {
-	BUG_ON(!hugepd_ok(hpd));
+	if (WARN_ON(!hugepd_ok(hpd)))
+		return NULL;
 #ifdef CONFIG_PPC_8xx
 	return (pte_t *)__va(hpd_val(hpd) & ~HUGEPD_SHIFT_MASK);
 #else
-- 
2.13.3

