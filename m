Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB02C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AF8217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ahGUkq0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfDQIuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:50:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57750 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfDQIuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:50:15 -0400
Received: from zn.tnic (p200300EC2F112E000C2D4197130645E8.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:c2d:4197:1306:45e8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F84C1EC04CD;
        Wed, 17 Apr 2019 10:50:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555491013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=Agt5mFRMnVWGgmmfPL7gPuUc6pRfbTwS8vO0+jLpWZM=;
        b=ahGUkq0mLkRAnyiYuMCMEO17Jkyv8ywx0KvcbsKwyFUNj8ci+I03MNIUh8X6813aHRQqC/
        BMEOuZ+wuf2Tpebw/xxcT0DQYd7TzwfFUYasoGZLFeur7QrH1px/bIzUXcBeLKX3E35WKE
        S/ZjZCXaIn/LluFPAQBtunPMq1BqGgA=
Date:   Wed, 17 Apr 2019 10:50:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Matz <matz@suse.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] asm/io: Correct output operand specification of the MMIO
 write* routines
Message-ID: <20190417085008.GB20492@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I'm looking at

  c1f64a58003f ("x86: MMIO and gcc re-ordering issue")

and trying to figure out was there any particular reason the address to
the MMIO write routines had to be an input operand?

Because if not, please have a look at the patch below. It boots here and
from the couple of resulting asm I looked at, it doesn't change. But
there might be some other aspect I'm missing so...

Thx.

---
From: Borislav Petkov <bp@suse.de>

Currently, all the MMIO write operations specify the output @addr
operand as an input operand to the extended asm statement. This works
because the asm statement is marked volatile and "memory" is on the
clobbered list, preventing gcc from optimizing around an inline asm
without output operands.

However, the more correct way of writing this is to make the target MMIO
write address an input *and* output operand so that gcc is aware that
modifications have happened through it.

Now, one could speculate further and say, the memory clobber could be
dropped:

  *P;   // (1)
  mmio_write("..." : "+m" (whatever));  // no memory clobber
  *P;   // (2)

but then gcc would at -O2 optimize the access in (2) by replacing it
with its value from (1), which would be wrong.

The solution would be sticking a memory barrier after (1) but then that
puts the onus on the programmer to make sure it doesn't get forgotten,
and that is the wrong approach: generic interfaces like that should
JustWork(tm) so let's leave the "memory" clobber.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Michael Matz <matz@suse.de>
---
 arch/x86/include/asm/io.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 686247db3106..33c4d8776b47 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -49,10 +49,11 @@ static inline type name(const volatile void __iomem *addr) \
 { type ret; asm volatile("mov" size " %1,%0":reg (ret) \
 :"m" (*(volatile type __force *)addr) barrier); return ret; }
 
-#define build_mmio_write(name, size, type, reg, barrier) \
-static inline void name(type val, volatile void __iomem *addr) \
-{ asm volatile("mov" size " %0,%1": :reg (val), \
-"m" (*(volatile type __force *)addr) barrier); }
+#define build_mmio_write(name, size, type, reg, barrier)	\
+static inline void name(type val, volatile void __iomem *mem)	\
+{ asm volatile("mov" size " %1,%0"				\
+		: "+m" (*(volatile type __force *)mem)		\
+		: reg (val) barrier); }
 
 build_mmio_read(readb, "b", unsigned char, "=q", :"memory")
 build_mmio_read(readw, "w", unsigned short, "=r", :"memory")
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
