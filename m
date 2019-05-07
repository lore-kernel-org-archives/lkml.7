Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49623C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139FF20825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="MH+KXfIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfEGWo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 18:44:26 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:58468 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGWoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 18:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1557269062; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eFU2eTkf+brbMeSQB+txh2lG96YUt9akc3uqFs2EylM=;
        b=MH+KXfIhzF4WYTBwz6U53xf9y+q58MvwTHBlqNFgbw+6mBOq2w9bQ5JJlKbtC29wpoNnp7
        YtJRxxhiMUz/rp9U4udOdkj8BWBoqQE/ElBefl47rnjvpl/PQQHvRKQZSPSSw9sbxAUZVs
        /AuH4alH0tbjh6BNBHNULVPaC69hVoc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     od@zcrc.me, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] MIPS: Decode config3 register on Ingenic SoCs
Date:   Wed,  8 May 2019 00:43:57 +0200
Message-Id: <20190507224357.23778-2-paul@crapouillou.net>
In-Reply-To: <20190507224357.23778-1-paul@crapouillou.net>
References: <20190507224357.23778-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XBurst misses a config2 register, so config3 decode was skipped in
decode_configs().

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/kernel/cpu-probe.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index fdb73c1b0cd7..ed240cdfef46 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1960,9 +1960,17 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
+
+	/*
+	 * XBurst misses a config2 register, so config3 decode was skipped in
+	 * decode_configs().
+	 */
+	decode_config3(c);
+
 	/* XBurst does not implement the CP0 counter. */
 	c->options &= ~MIPS_CPU_COUNTER;
 	BUG_ON(!__builtin_constant_p(cpu_has_counter) || cpu_has_counter);
+
 	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_XBURST:
 		c->cputype = CPU_XBURST;
-- 
2.21.0.593.g511ec345e18

