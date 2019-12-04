Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD1CC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB842073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482581;
	bh=7Okz4y6hrxVIRsklu/VZlG95BXottGN8NoHpUOaltx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vhP3pwWDh+3uJyA+rG86VUWzM3/mFP/jhmKdv84oEzz/5KZudK5eBZNen7ei+E2Up
	 Ly6FGo6yCLeu3E7C4jJdan7NI+GyDpx9tc4KwDbWTlX9fhAd0oS3KcnwMrHEi7ajc6
	 /JTOcbgi6IoBhmZGFRpVPu/S6o/8wYnxX4XN2pig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfLDSDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:03:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:45804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729443AbfLDSC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:02:56 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9914E215B2;
        Wed,  4 Dec 2019 18:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482576;
        bh=7Okz4y6hrxVIRsklu/VZlG95BXottGN8NoHpUOaltx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Doex8UUPimkis/pEEnagFMDmZ2SZuWeqS+9M7AABExkGJS9TTaRTlvLKsbC4bV5U
         WKuzkIYC6vPOKZVC3rObNw69ehq+fM6KBPsPSSw3LgV+uQ91lOEmEVFvBuX2lOqHVP
         sWliRIm1UPlH+7WzjHB6mrhvfOlC+g5sH9edxVyY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 009/209] clk: sunxi-ng: a80: fix the zeroing of bits 16 and 18
Date:   Wed,  4 Dec 2019 18:53:41 +0100
Message-Id: <20191204175322.233475031@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit cdfc2e2086bf9c465f44e2db25561373b084a113 ]

The zero'ing of bits 16 and 18 is incorrect. Currently the code
is masking with the bitwise-and of BIT(16) & BIT(18) which is
0, so the updated value for val is always zero. Fix this by bitwise
and-ing value with the correct mask that will zero bits 16 and 18.

Addresses-Coverity: (" Suspicious &= or |= constant expression")
Fixes: b8eb71dcdd08 ("clk: sunxi-ng: Add A80 CCU")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
index 8936ef87652c0..c14bf782b2b33 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
@@ -1231,7 +1231,7 @@ static int sun9i_a80_ccu_probe(struct platform_device *pdev)
 
 	/* Enforce d1 = 0, d2 = 0 for Audio PLL */
 	val = readl(reg + SUN9I_A80_PLL_AUDIO_REG);
-	val &= (BIT(16) & BIT(18));
+	val &= ~(BIT(16) | BIT(18));
 	writel(val, reg + SUN9I_A80_PLL_AUDIO_REG);
 
 	/* Enforce P = 1 for both CPU cluster PLLs */
-- 
2.20.1



