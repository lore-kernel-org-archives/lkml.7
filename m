Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD5FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39321217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639660;
	bh=WQpS+fRauMMgJLnanTA/0cSISLnXN00vNZWmvrFuKg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NvgfCM2n0bcJvxBhoD9TBc6usMi2LUMjP83Xoq0ukvMFcq62hnnV+FMDN9Vxda9Ci
	 nKHFUNQunDpB9Z4DdnuwHfGAUg52Mh/JCF6ziluy9bh2IsLadojba2RAZ3+y+PM5nw
	 u5fw62mfqJB1mdCDN0oUm7inqKRBP5T/4aPaIN6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391627AbfEWT1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390968AbfEWT1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:27:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 446B220879;
        Thu, 23 May 2019 19:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639653;
        bh=WQpS+fRauMMgJLnanTA/0cSISLnXN00vNZWmvrFuKg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+dpl1FzPYYVIx9+mg7Kp8I86A4Mo+5cr8zo0bb8idiD464tGT3W21mHGZrSpRhBf
         ATULcDwOSyhcn3uANsIevX5BmaCOxX0m43RmLZctEvrHTTaCf2lGt5RRHQLDbOQogo
         Gv9QW8/smxbnEOb/Wuu0yBmv13ftdHtZifYKYpA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 5.1 029/122] parisc: Add memory barrier to asm pdc and sync instructions
Date:   Thu, 23 May 2019 21:05:51 +0200
Message-Id: <20190523181708.685861475@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit 2d94a832e246ac00fd32eec241e6f1aa6fbc5700 upstream.

Add compiler memory barriers to ensure the compiler doesn't reorder memory
operations around these instructions.

Cc: stable@vger.kernel.org # v4.20+
Fixes: 3847dab77421 ("parisc: Add alternative coding infrastructure")
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/include/asm/cache.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/parisc/include/asm/cache.h
+++ b/arch/parisc/include/asm/cache.h
@@ -56,10 +56,10 @@ void parisc_setup_cache_timing(void);
 #define asm_io_fdc(addr) asm volatile("fdc %%r0(%0)" \
 			ALTERNATIVE(ALT_COND_NO_DCACHE, INSN_NOP) \
 			ALTERNATIVE(ALT_COND_NO_IOC_FDC, INSN_NOP) \
-			: : "r" (addr))
+			: : "r" (addr) : "memory")
 #define asm_io_sync()	asm volatile("sync" \
 			ALTERNATIVE(ALT_COND_NO_DCACHE, INSN_NOP) \
-			ALTERNATIVE(ALT_COND_NO_IOC_FDC, INSN_NOP) :: )
+			ALTERNATIVE(ALT_COND_NO_IOC_FDC, INSN_NOP) :::"memory")
 
 #endif /* ! __ASSEMBLY__ */
 


