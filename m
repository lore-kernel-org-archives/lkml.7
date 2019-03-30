Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC22C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61876218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="B/ejelnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfC3LUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 07:20:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57370 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbfC3LUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 07:20:24 -0400
Received: from zn.tnic (p200300EC2F148A00C43C95AA310C833A.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:c43c:95aa:310c:833a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 985EF1EC097D;
        Sat, 30 Mar 2019 12:20:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553944822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kvXuBzmsasK7ocQNmzt/nz4NOf7YXO9rvlmFEFzWe5I=;
        b=B/ejelnTKIqqw0nMbzNDAYB0GmYwAq5MHzvCVdBgrpJzyaQqaFawa2LKJSdP5Vviz9KEqI
        r3/aMZrtgyoXVRHSoAsNf77RnENxe6/QPSqLdkBlak6SEIv04RXM5xFx6g3j5AidJVc9/T
        FHy3QAYsfdUsz2PoKyaNuYs4vpgLj7E=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: [PATCH 1/5] x86/asm: Clarify static_cpu_has()'s intended use
Date:   Sat, 30 Mar 2019 12:20:18 +0100
Message-Id: <20190330112022.28888-2-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190330112022.28888-1-bp@alien8.de>
References: <20190330112022.28888-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Clarify when one should use static_cpu_has() and when one should use
boot_cpu_has().

Requested-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
---
 arch/x86/include/asm/cpufeature.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 30cf12c81db3..1d337c51f7e6 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -156,9 +156,12 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 #else
 
 /*
- * Static testing of CPU features.  Used the same as boot_cpu_has().
- * These will statically patch the target code for additional
- * performance.
+ * Static testing of CPU features. Used the same as boot_cpu_has(). It
+ * statically patches the target code for additional performance. Use
+ * static_cpu_has() only in fast paths, where every cycle counts. Which
+ * means that the boot_cpu_has() variant is already fast enough for the
+ * majority of cases and you should stick to using it as it is generally
+ * only two instructions: a RIP-relative MOV and a TEST.
  */
 static __always_inline bool _static_cpu_has(u16 bit)
 {
-- 
2.21.0

