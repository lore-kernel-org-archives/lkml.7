Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B94CC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052E82063F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfFQVWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:22:35 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:51939 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729135AbfFQVW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:22:26 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45SPLR482Fz1rWT1;
        Mon, 17 Jun 2019 23:22:23 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45SPLR3Sk9z1qql7;
        Mon, 17 Jun 2019 23:22:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Ofi2Vk0dQod8; Mon, 17 Jun 2019 23:22:22 +0200 (CEST)
X-Auth-Info: kxoQWfsuvJNGfuKCoxPyz8lu9v+YflcEBGhwLMkqB17xmmElfILuca/iqbizjt6/
Received: from igel.home (ppp-46-244-166-202.dynamic.mnet-online.de [46.244.166.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 17 Jun 2019 23:22:22 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 852962C1101; Mon, 17 Jun 2019 23:22:20 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mm/32s: fix condition that is always true
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
        <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
X-Yow:  ..  I have a VISION!  It's a RANCID double-FISHWICH on an ENRICHED BUN!!
Date:   Mon, 17 Jun 2019 23:22:20 +0200
In-Reply-To: <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
        (Christophe Leroy's message of "Thu, 21 Feb 2019 19:08:49 +0000
        (UTC)")
Message-ID: <87muif52lv.fsf_-_@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move a misplaced paren that makes the condition always true.

Fixes: 63b2bc619565 ("powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX")
Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/mm/pgtable_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index d53188dee18f..35cb96cfc258 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -360,7 +360,7 @@ void mark_initmem_nx(void)
 	unsigned long numpages = PFN_UP((unsigned long)_einittext) -
 				 PFN_DOWN((unsigned long)_sinittext);
 
-	if (v_block_mapped((unsigned long)_stext) + 1)
+	if (v_block_mapped((unsigned long)_stext + 1))
 		mmu_mark_initmem_nx();
 	else
 		change_page_attr(page, numpages, PAGE_KERNEL);
-- 
2.22.0

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
