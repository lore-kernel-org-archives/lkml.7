Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733D6C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 12:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0AB21841
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 12:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfFOMrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 08:47:33 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:51004 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfFOMrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 08:47:32 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45Qy1G5lFZz1rD9d;
        Sat, 15 Jun 2019 14:47:30 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45Qy1G52mJz1qqkq;
        Sat, 15 Jun 2019 14:47:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id OuZhr5AH4Xcv; Sat, 15 Jun 2019 14:47:29 +0200 (CEST)
X-Auth-Info: lR6vEGEjQp+5pJ18oak+YQGQ7QwRBmFU2NVjtItvVEU28hsAjcy4lojTPelqUle0
Received: from igel.home (ppp-46-244-181-62.dynamic.mnet-online.de [46.244.181.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 15 Jun 2019 14:47:29 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 0F8512C0C9A; Sat, 15 Jun 2019 14:47:29 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mm/32s: only use MMU to mark initmem NX if STRICT_KERNEL_RWX
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
        <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
X-Yow:  ...It's REAL ROUND..  And it's got a POINTY PART right in the MIDDLE!!
 The shape is SMOOTH..  ..And COLD.. It feels very COMFORTABLE on my
 CHEEK..  I'm getting EMOTIONAL..
Date:   Sat, 15 Jun 2019 14:47:29 +0200
In-Reply-To: <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
        (Christophe Leroy's message of "Thu, 21 Feb 2019 19:08:49 +0000
        (UTC)")
Message-ID: <8736kb9fry.fsf_-_@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If STRICT_KERNEL_RWX is disabled, never use the MMU to mark initmen
nonexecutable.

Also move a misplaced paren that makes the condition always true.

Fixes: 63b2bc619565 ("powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX")
Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/mm/pgtable_32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index d53188dee18f..3935dc263d65 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -360,9 +360,11 @@ void mark_initmem_nx(void)
 	unsigned long numpages = PFN_UP((unsigned long)_einittext) -
 				 PFN_DOWN((unsigned long)_sinittext);
 
-	if (v_block_mapped((unsigned long)_stext) + 1)
+#ifdef CONFIG_STRICT_KERNEL_RWX
+	if (v_block_mapped((unsigned long)_stext + 1))
 		mmu_mark_initmem_nx();
 	else
+#endif
 		change_page_attr(page, numpages, PAGE_KERNEL);
 }
 
-- 
2.22.0

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
