Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3BAC282E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BD921841
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639227;
	bh=WQpS+fRauMMgJLnanTA/0cSISLnXN00vNZWmvrFuKg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JNWVrmuP4AdKq+Dvzpk3GLtrIRSl8E3DGkYLWjCJCnhhAkDTcjQGUxvc7dkJFkQ5s
	 uG1pCnCjuZ1e2InC+1+m7l8Mut9X9WlSPsFRkrkNWPIhdPCtKoUL3WWy6/UaVBvpVE
	 8Mq9KMmfgGXFd4xJaAPv1bsllMZ2RLagDm7haSxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390041AbfEWTU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:20:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390000AbfEWTUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:20:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BCFC21851;
        Thu, 23 May 2019 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639223;
        bh=WQpS+fRauMMgJLnanTA/0cSISLnXN00vNZWmvrFuKg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYdFVnpN7qIZ8NDYIDH8VsnKKKXc89vgGEdiGRSClnN2KDWJsmLhl2kyt9tBHePFS
         /H5OcCWhJEHmkdkYT/wxH/yvLFBnbe8W3lMCnyoO96BzCRGjdI7he568yVMu1j3RIK
         FKBUOOIVyjpATGLeudvYsx6qjzxWEhbD/g96kYJA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 5.0 025/139] parisc: Add memory barrier to asm pdc and sync instructions
Date:   Thu, 23 May 2019 21:05:13 +0200
Message-Id: <20190523181724.000772332@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
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
 


