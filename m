Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F82C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FDE20863
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ao1wM6gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfEUGVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:21:30 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:52625 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfEUGVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:21:30 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x4L6KfO9017528;
        Tue, 21 May 2019 15:20:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x4L6KfO9017528
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558419643;
        bh=hQU20tBPY0tCKEI+/rW5SbOU7f/0aV9pyzzzCywRl24=;
        h=From:To:Cc:Subject:Date:From;
        b=ao1wM6gx4mu0ggKfyb93Mg8zXiKe1nAo2J2ApVQVk6fD3SJyAAvPZ7lcaBf+0uFPz
         KkNHi4xzr0DRnrwueNzY474MA7za/QBTMpn0sjg8dQScHsBWafCl8jME0gpSUruIP2
         E5eO1ivIkkjDxFwacat++WFjHjGK7IzluTz3BbKtlX7NCUCncg2uOFBmh7bzgUQoSW
         c+Z+B2MhVQCvPIn2PfASGFS2+wGdTdjIvsJyHhmdgO9jyapQwAvtqb5uGLlQ8ybI3p
         7gLgSVqys2uzKErXfXRi6oE3om2mnqn2Fs1wx2ESdJlc1h583s9M2XHJewEUfuFYvQ
         L2MCK35UsK/BA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: mark ginvt() as __always_inline
Date:   Tue, 21 May 2019 15:20:39 +0900
Message-Id: <20190521062039.21492-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To meet the 'i' (immediate) constraint for the asm operands,
this function must be always inlined.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/include/asm/ginvt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/ginvt.h b/arch/mips/include/asm/ginvt.h
index 49c6dbe37338..6eb7c2b94dc7 100644
--- a/arch/mips/include/asm/ginvt.h
+++ b/arch/mips/include/asm/ginvt.h
@@ -19,7 +19,7 @@ _ASM_MACRO_1R1I(ginvt, rs, type,
 # define _ASM_SET_GINV
 #endif
 
-static inline void ginvt(unsigned long addr, enum ginvt_type type)
+static __always_inline void ginvt(unsigned long addr, enum ginvt_type type)
 {
 	asm volatile(
 		".set	push\n"
-- 
2.17.1

