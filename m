Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26634C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D67217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VxTDjn8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfDJWpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:45:13 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49965 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJWpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554936312; x=1586472312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8a9nFQNbKFd3//6jhM9wfTOXLMw/hQ4czkeb+c+UtjE=;
  b=VxTDjn8z2aSN2FHfF9eYrWIpUCJNfZYv6BaMD0aMNOgzHHg+9A+4M1u0
   ylS5j3W3UcgR87yVQyETSWPPzzBki75Wa+TwdSfIOy/dz+djHe8MDrXDa
   +h5p24tBZsb4AyV0Z45UaSh91iZeMKBOD+KGGpsirzy7QSG+N9HYPXKoG
   8holzr0NapPCUffPwINeN8aG0hGdYknP41vWI0PPz8AcKHI0YaMgznN48
   dKOhsDOOL+oHqyly9XKJcGL20vh+0kYXUxrPxu7DeaTZ8rBwnSaGLo+jV
   eM1dbNR1KakZP4rg9JtOIzwsLF1O33j4xDrTjJi7kFY2+zdG51kjfMBDa
   w==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; 
   d="scan'208";a="105470408"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 06:45:11 +0800
IronPort-SDR: XtYuPIB/QZ0IQatOWiN54Wa86CCQf3cuRC/cHd/LmeMUbL2j91T5RkvGYAlnSc+nRDJMyg8NsF
 E7uqN2JoYr0CL9fAApemwGFcQO9liLFOTElWr1af2QbSk2ZKO8sFEVxgYn806a52N2yy8dBFpU
 UNrDxM1vwpx9IgfFnx9uc9Be+6QjN++YKhZfcpeyG88YGVusBKOorG8xJ49vl4YjymsfBg3YCo
 rXKKe7EpPCDBTq1RYyS1871EtIYqdsCrVUqbJwQS/1RU3SGwS3R4WZt6CLlIS/NKP0yb6hmOMl
 ZnNCJM2Cl4ckXWbGy8+tYf1k
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 10 Apr 2019 15:22:05 -0700
IronPort-SDR: m/18FSUIFv2lEJf2eefSFGl4WdeRvmz0Q9jV/kflxUyi6lCOts3bODYymr211SYu9PuY7EnEkG
 gCRt+KpD4F/6+c1QJkLWDJPBGvbJvInvvERne/fbhORuResiADleeMy1dzR9KwhmIPCkoOxu5u
 L4NOkQOFioR4wF6INiDb2Pnp3rmwh0iLnAPuXUGXAMTX+Xk2+vYaxBx0C/aOPBtftQ4u0/m68j
 GVbxa7tSFTVgC5z+xh8gZ3b4MMPOPjqXoYhFoxYoayrqZAFpb3usg3vIJ6z36Y7/AFACbqV+a7
 xlw=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Apr 2019 15:45:11 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Borislav Petkov <bp@alien8.de>, Gary Guo <gary@garyguo.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-riscv@lists.infradead.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [1/3] x86: Update DEBUG_TLBFLUSH options description.
Date:   Wed, 10 Apr 2019 15:44:47 -0700
Message-Id: <20190410224449.10877-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190410224449.10877-1-atish.patra@wdc.com>
References: <20190410224449.10877-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_TLBFLUSH was added in 'commit 3df3212f9722 ("x86/tlb: add
tlb_flushall_shift knob into debugfs")' to support tlb_flushall_shift
knob. The knob was removed in 'commit e9f4e0a9fe27 ("x86/mm: Rip out
complicated, out-of-date, buggy TLB flushing")'.  However, the debug
option was never removed from Kconfig. It was reused in commit
'9824cf9753ec ("mm: vmstats: tlb flush counters")' but the commit text was
never updated accordingly.

Update the Kconfig option description as per its current usage.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/x86/Kconfig.debug | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 15d0fbe27872..c1a48d4ffebb 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -125,21 +125,12 @@ config DOUBLEFAULT
 	  hair.
 
 config DEBUG_TLBFLUSH
-	bool "Set upper limit of TLB entries to flush one-by-one"
+	bool "Save tlb flush statstics to vmstat"
 	depends on DEBUG_KERNEL
 	---help---
 
-	X86-only for now.
-
-	This option allows the user to tune the amount of TLB entries the
-	kernel flushes one-by-one instead of doing a full TLB flush. In
-	certain situations, the former is cheaper. This is controlled by the
-	tlb_flushall_shift knob under /sys/kernel/debug/x86. If you set it
-	to -1, the code flushes the whole TLB unconditionally. Otherwise,
-	for positive values of it, the kernel will use single TLB entry
-	invalidating instructions according to the following formula:
-
-	flush_entries <= active_tlb_entries / 2^tlb_flushall_shift
+	Add tlbflush statstics to vmstat. It is really helpful understand tlbflush
+	performance and behavior. It should be enabled only for debugging purpose.
 
 	If in doubt, say "N".
 
-- 
2.21.0

