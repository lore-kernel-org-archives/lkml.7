Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA38C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38EE205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GtBJBi17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfEGUt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:49:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43895 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfEGUt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:49:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id c6so4062957pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=16ni+8UEniYJYlMiaLm9MTZL5f4uI05QVZvXY8kGkyE=;
        b=GtBJBi17Nvcq1G7rVZ9uJaeHxN4bn4kXoaDa6iTX8XSeUFAicrKXpkEgXGf3y81kvf
         5mT8XP9qGfozJM+DJlH2PiPHjL8scDu/V6aO++md4LgoYQ6eaGaD41a2YFFVxDS16Hzj
         AfaZDXtfrRnyP36FduMmBoEotVSb6OqRnajcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=16ni+8UEniYJYlMiaLm9MTZL5f4uI05QVZvXY8kGkyE=;
        b=MHQhFiddupFxLmtLih89vuHPJmXa/8+WmnM5EU+ALPTBOIbFI378VsjhnLDldkueka
         vCUNv797/+mqRPaSfcK6i8Bnf7e+7T9g8zg7FSyI5YqQ6eKTdnRlzl/3V6cGqp3XCo61
         NT3igLEi7KZRlAwa4nuQRKmZoNIBBesihEknCYne8n+Vs0jd0+a2xQdSSkMOFVKitR96
         Z0GlTgQ8ZH6y84wLITss4QUzkXKadwepNCoaCBajg2NQMdz9/8Gvuy3+E1R90vJ6oMr7
         /qWAwYOPj5PnB9KHsJxMgKxNqH3E5weQJkRE/Oluxi5g3nHqYcEmiawQh4Q6p9gVJI8v
         9gyw==
X-Gm-Message-State: APjAAAU5oKHHxhnmWbOmh8LMiStpdrMblCe/GJyzA/BYy4Ir1plw/oxj
        yOzhSK4J7kAoxKbYwnm3ZASsNg==
X-Google-Smtp-Source: APXvYqzq46xNr1WmdaRR59uTuZVU09D1ZwcWwdDjivzpxshj1SH+qs20Hl2kkBUMpFYjGgNqsTbWWA==
X-Received: by 2002:a63:9d8d:: with SMTP id i135mr25594688pgd.245.1557262197357;
        Tue, 07 May 2019 13:49:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id x19sm8312796pga.4.2019.05.07.13.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 13:49:56 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>, hal@halemmerich.com,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clk: rockchip: Use clk_hw_get_rate() in MMC phase calculation
Date:   Tue,  7 May 2019 13:49:35 -0700
Message-Id: <20190507204935.256982-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calculating the MMC phase we can just use clk_hw_get_rate()
instead of clk_get_rate().  This avoids recalculating the rate.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/clk/rockchip/clk-mmc-phase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-mmc-phase.c b/drivers/clk/rockchip/clk-mmc-phase.c
index 026a26bb702d..07526f64dbfd 100644
--- a/drivers/clk/rockchip/clk-mmc-phase.c
+++ b/drivers/clk/rockchip/clk-mmc-phase.c
@@ -55,7 +55,7 @@ static unsigned long rockchip_mmc_recalc(struct clk_hw *hw,
 static int rockchip_mmc_get_phase(struct clk_hw *hw)
 {
 	struct rockchip_mmc_clock *mmc_clock = to_mmc_clock(hw);
-	unsigned long rate = clk_get_rate(hw->clk);
+	unsigned long rate = clk_hw_get_rate(hw);
 	u32 raw_value;
 	u16 degrees;
 	u32 delay_num = 0;
@@ -86,7 +86,7 @@ static int rockchip_mmc_get_phase(struct clk_hw *hw)
 static int rockchip_mmc_set_phase(struct clk_hw *hw, int degrees)
 {
 	struct rockchip_mmc_clock *mmc_clock = to_mmc_clock(hw);
-	unsigned long rate = clk_get_rate(hw->clk);
+	unsigned long rate = clk_hw_get_rate(hw);
 	u8 nineties, remainder;
 	u8 delay_num;
 	u32 raw_value;
-- 
2.21.0.1020.gf2820cf01a-goog

