Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1ADC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7D121850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="MOXmu1mW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfCTKHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:07:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12978 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbfCTKG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:06:58 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44PQZ76ccNz9vC06;
        Wed, 20 Mar 2019 11:06:55 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=MOXmu1mW; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7Go5EndgADZn; Wed, 20 Mar 2019 11:06:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44PQZ75R8Cz9vByx;
        Wed, 20 Mar 2019 11:06:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553076415; bh=ULxgnQpCSQbiN3N1ejsuE5GZ54FA7/d869B1KN+MJkI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=MOXmu1mWORUsvnfk9ArQOo5/GugyslLynuVoI6YM9Gl4MiZSZUpS/reqPf7YbDS8D
         Ixuq8wYbc4utWiViH5e4k3+xXpQzvequ8846wZVH9a3krqDAtM8ahPgdfZqSenGnNH
         76pI/BsdJ5BkxGyHMFcof4Yl8Mj6AfXc4yZIor0U=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DBA178B918;
        Wed, 20 Mar 2019 11:06:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Kini57lOiY3W; Wed, 20 Mar 2019 11:06:56 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B5A5E8B911;
        Wed, 20 Mar 2019 11:06:56 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8B2C563AEF; Wed, 20 Mar 2019 10:06:56 +0000 (UTC)
Message-Id: <bd95b298ffe0563e6c335cd3fff9f7f72ba62961.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 20/27] powerpc/mm: remove unnecessary #ifdef CONFIG_PPC64
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Mar 2019 10:06:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For PPC32 that's a noop, but gcc is smart enough ignore it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/slice.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 99983dc4e484..f98b9e812c62 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -96,13 +96,11 @@ static int slice_high_has_vma(struct mm_struct *mm, unsigned long slice)
 	unsigned long start = slice << SLICE_HIGH_SHIFT;
 	unsigned long end = start + (1ul << SLICE_HIGH_SHIFT);
 
-#ifdef CONFIG_PPC64
 	/* Hack, so that each addresses is controlled by exactly one
 	 * of the high or low area bitmaps, the first high area starts
 	 * at 4GB, not 0 */
 	if (start == 0)
-		start = SLICE_LOW_TOP;
-#endif
+		start = (unsigned long)SLICE_LOW_TOP;
 
 	return !slice_area_is_free(mm, start, end - start);
 }
-- 
2.13.3

