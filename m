Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53320C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6472054F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639652;
	bh=Eck07YnScN80rAFi0HLkukX6wfzOilhLgDStDYeWIPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XLEZRYzxImP0PLpCUNJKHFxfLnT3+IRxcx8iZHhQLKeD97LC0Pto5Zkdn7G6dC4gF
	 ymsIMmN6VFZBZ/j7Co0xV5+OqUuE0v49ObYmUEO03fbO8ALK79JD/B1lrdYymTNB+/
	 5BcEK4hHCq28lZXRfMKmvNh3WM6zE+xTIyJsin/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391607AbfEWT1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391596AbfEWT12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:27:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD599217D9;
        Thu, 23 May 2019 19:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639648;
        bh=Eck07YnScN80rAFi0HLkukX6wfzOilhLgDStDYeWIPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JdMrLK0lpSYnoTWbjNyST0lkCqnZvWJ+yuaWhyWqEnGnwE9+l26/cikC+Tpnxn6uw
         D4yfw304EPta8KZYbAGFfn1rKCuLzjSra+E5SgE/HLJuiSb5jULATmk1fYf6/qh6F1
         3lSZXTnhMXqJTTvgyttalbsC7klmave/CLmZga8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.1 027/122] parisc: Add memory clobber to TLB purges
Date:   Thu, 23 May 2019 21:05:49 +0200
Message-Id: <20190523181708.418387609@linuxfoundation.org>
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

From: John David Anglin <dave.anglin@bell.net>

commit 44224bdb99150ad17cf394973b25736cb92c246a upstream.

The pdtlb and pitlb instructions are strongly ordered. The asms invoking
these instructions should be compiler memory barriers to ensure the
compiler doesn't reorder memory operations around these instructions.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
CC: stable@vger.kernel.org # v4.20+
Fixes: 3847dab77421 ("parisc: Add alternative coding infrastructure")
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/include/asm/cache.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/parisc/include/asm/cache.h
+++ b/arch/parisc/include/asm/cache.h
@@ -44,14 +44,14 @@ void parisc_setup_cache_timing(void);
 
 #define pdtlb(addr)	asm volatile("pdtlb 0(%%sr1,%0)" \
 			ALTERNATIVE(ALT_COND_NO_SMP, INSN_PxTLB) \
-			: : "r" (addr))
+			: : "r" (addr) : "memory")
 #define pitlb(addr)	asm volatile("pitlb 0(%%sr1,%0)" \
 			ALTERNATIVE(ALT_COND_NO_SMP, INSN_PxTLB) \
 			ALTERNATIVE(ALT_COND_NO_SPLIT_TLB, INSN_NOP) \
-			: : "r" (addr))
+			: : "r" (addr) : "memory")
 #define pdtlb_kernel(addr)  asm volatile("pdtlb 0(%0)"   \
 			ALTERNATIVE(ALT_COND_NO_SMP, INSN_PxTLB) \
-			: : "r" (addr))
+			: : "r" (addr) : "memory")
 
 #define asm_io_fdc(addr) asm volatile("fdc %%r0(%0)" \
 			ALTERNATIVE(ALT_COND_NO_DCACHE, INSN_NOP) \


