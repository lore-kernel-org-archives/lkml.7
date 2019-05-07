Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23963C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E241E214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="HzyApLXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEGWSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 18:18:06 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:33142 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGWSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 18:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1557267484; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=KH3jCfJuzcTYKs4a3+eHRZa00RZObnheYuXmYtkiQnE=;
        b=HzyApLXt1y6VWTnZv+m9zAarDjA8AqZ1pM/VaEqUHv/x39jfjlBWfh8I8EULo7tSDOtmxi
        q4L6ogTG5SMVuEtEYVJdzmhuDTdjl3JAydpLMl7V8BgNG7ep/TXKqmHsS8fmAaR6CNp6ew
        C9GEdjGGwjZsIeooLM6qtLFxjzJSfDw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     od@zcrc.me, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2] MIPS: Fix Ingenic SoCs sometimes reporting wrong ISA
Date:   Wed,  8 May 2019 00:17:55 +0200
Message-Id: <20190507221755.3396-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config0 register in the Xburst CPUs with a processor ID of
PRID_COMP_INGENIC_D0 report themselves as MIPS32r2 compatible,
but they don't actually support this ISA.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Apply fix according to the PRID

 arch/mips/kernel/cpu-probe.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index d5e335e6846a..6126b77d5a62 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1973,6 +1973,14 @@ static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
 		panic("Unknown Ingenic Processor ID!");
 		break;
 	}
+
+	/*
+	 * The config0 register in the Xburst CPUs with a processor ID of
+	 * PRID_COMP_INGENIC_D0 report themselves as MIPS32r2 compatible,
+	 * but they don't actually support this ISA.
+	 */
+	if ((c->processor_id & PRID_COMP_MASK) == PRID_COMP_INGENIC_D0)
+		c->isa_level &= ~MIPS_CPU_ISA_M32R2;
 }
 
 static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
-- 
2.21.0.593.g511ec345e18

