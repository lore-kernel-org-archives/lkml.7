Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD301C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D5F2073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412832;
	bh=4kPvRMRLgZy/2VSwiRkaGhNj7f40GzKfVOJEh+tET2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GR+CHd/gJboWZgrltX0N5LDdQTKjVzFk3TtWRjSKp2a12Cm+nd+kb61YlWHhWaSsE
	 CBAGV8AzK5WrUsvf8BWuAqEJ3K2xYLS6TI/2IfiulQzdo+5nc8Vy7T+sWg9ppsxGDf
	 OiMUpfXk7AyoQ/Wrn/lE/9SKS5HpfvHWVZ+6NHj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfLCWka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbfLCWk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:40:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F5920684;
        Tue,  3 Dec 2019 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412826;
        bh=4kPvRMRLgZy/2VSwiRkaGhNj7f40GzKfVOJEh+tET2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXdOrqY8t7AbY4aU/csztt7ThLQJfmVwmio20rooTPT5zERJaYdWfIz7x92KEbhYD
         Md0zawZPNPSXIVWwihDdEKJzHAYsKDZc9vRMIf5nhNnhjlPgg2x7Lh0qf4z3CgtcEQ
         kHKH9OX8E19VdClZz4GESijQg9v+4P5d+2sZ3WHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 030/135] clk: sunxi-ng: a80: fix the zeroing of bits 16 and 18
Date:   Tue,  3 Dec 2019 23:34:30 +0100
Message-Id: <20191203213011.985095233@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
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
index dcac1391767f6..ef29582676f6e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
@@ -1224,7 +1224,7 @@ static int sun9i_a80_ccu_probe(struct platform_device *pdev)
 
 	/* Enforce d1 = 0, d2 = 0 for Audio PLL */
 	val = readl(reg + SUN9I_A80_PLL_AUDIO_REG);
-	val &= (BIT(16) & BIT(18));
+	val &= ~(BIT(16) | BIT(18));
 	writel(val, reg + SUN9I_A80_PLL_AUDIO_REG);
 
 	/* Enforce P = 1 for both CPU cluster PLLs */
-- 
2.20.1



