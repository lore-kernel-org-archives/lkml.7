Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F390CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFE42465E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641573;
	bh=DQ1t5NSkAs3iDrmgUYCvkHzmGg7so4JXkx8GcNJykn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PPXMDNUDW5sU4aDUJDGE5DE0Y+mW6SCjer+v8MUJ8n8BNAiqU1Db8tMq747izMsmA
	 N6IemlFZDYr964UbIEYfmZGb3BYgkWnxYX5g8FakHJaYpXRPw3PIV7vSbYtK1mnN9/
	 RSAHtBDbEvyAW/9ZLnza2rIbH9x2rjJF3M3A/PIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbfL2RqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:46:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731006AbfL2RqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:46:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD387207FD;
        Sun, 29 Dec 2019 17:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641569;
        bh=DQ1t5NSkAs3iDrmgUYCvkHzmGg7so4JXkx8GcNJykn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fD4tkbvmcCZ/ZMBZfCP3iT8iG/BZ4ju6AMqrqEakQr4IWLFQjoctTVvjxfvQ0WF2V
         wBDdEl/uJlR4ZU4fLP/2avG5XwZfc/hlZ8JC59hbT1W3ljlB+SiYa1m6w4yvGynhj8
         HCGHD6v1wX8QYrAk3s0jlTrhWMszraIAWF/5AYvc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 103/434] hwrng: omap3-rom - Call clk_disable_unprepare() on exit only if not idled
Date:   Sun, 29 Dec 2019 18:22:36 +0100
Message-Id: <20191229172708.446804963@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit eaecce12f5f0d2c35d278e41e1bc4522393861ab ]

When unloading omap3-rom-rng, we'll get the following:

WARNING: CPU: 0 PID: 100 at drivers/clk/clk.c:948 clk_core_disable

This is because the clock may be already disabled by omap3_rom_rng_idle().
Let's fix the issue by checking for rng_idle on exit.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Adam Ford <aford173@gmail.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Fixes: 1c6b7c2108bd ("hwrng: OMAP3 ROM Random Number Generator support")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/omap3-rom-rng.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/omap3-rom-rng.c b/drivers/char/hw_random/omap3-rom-rng.c
index 38b719017186..648e39ce6bd9 100644
--- a/drivers/char/hw_random/omap3-rom-rng.c
+++ b/drivers/char/hw_random/omap3-rom-rng.c
@@ -121,7 +121,8 @@ static int omap3_rom_rng_remove(struct platform_device *pdev)
 {
 	cancel_delayed_work_sync(&idle_work);
 	hwrng_unregister(&omap3_rom_rng_ops);
-	clk_disable_unprepare(rng_clk);
+	if (!rng_idle)
+		clk_disable_unprepare(rng_clk);
 	return 0;
 }
 
-- 
2.20.1



