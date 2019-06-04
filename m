Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40696C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 22:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A48620684
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 22:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a6SMCfW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfFDWcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 18:32:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41005 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfFDWcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 18:32:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id s24so8761576plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7LrsWOu9H08D9VnyWoK4aMKFSqz39fLtN0sqw4NiYmE=;
        b=a6SMCfW3Grszq2AuhWerX+Qret6+CW6/s7WM7ae6WCeNv1pzOjPcAAjhxtm4SMJcGw
         bep+z6ve4HsBKKv2+9WzO3L68i4ehYfGyamPfhQOqc4dcrn70qgWiT9PBsSdV4ohOYs5
         63QbziAKVPMzQ/8C7IHZCEsYkvSNHeIsA6E/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7LrsWOu9H08D9VnyWoK4aMKFSqz39fLtN0sqw4NiYmE=;
        b=OhkMqWSkN4Qr3oiK4doofyLGnvX6M3g60ynqb1kyDHbwoUzT1Dd+cSGqzqTKjRVTex
         +7PdRO2L6abpW9tVZpyQSnKxNrtQ6/EIBgGAMTB1RGz6FOdJ1xVlCnAijE7q66ElB54V
         8gRDiAaLcSMS9k+ZU5Vwq3AZgjCjdT7g1Aa4Adcbe5IwJWXRiqW503R4dZJ4msJUThz3
         ZJsCeKiY8gE8CH12h8nMlILPLwK43lBtU4ZuJZc7SR3EkSDGUQpJDygJkkFBVlefMu0c
         1dWbenFzDfP72CiyKOxc5YTbs18MdpjdTpFxpHDIX1I3sWXbUqdLJyNkeVSCiJgdUCvF
         VZew==
X-Gm-Message-State: APjAAAXX0iJK1BU+pnO3zFqzFUFOOg2cx0ptbJ5UoPZcE1xOD0qX+6D6
        CIcXQcczZQ4Zy4wyiPkf9btHEQ==
X-Google-Smtp-Source: APXvYqyP3mL6L3hXGIHj9/i/mpdSFQYcVM5JqdDzD0ZqHoQlEFBlN2xJ2cgV7XcUdPhRNGofv0hBsw==
X-Received: by 2002:a17:902:6ac4:: with SMTP id i4mr37076584plt.75.1559687531967;
        Tue, 04 Jun 2019 15:32:11 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id i5sm642508pjj.8.2019.06.04.15.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 15:32:11 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Stephen Boyd <sboyd@kernel.org>, mka@chromium.org,
        seanpaul@chromium.org, Urja Rannikko <urjaman@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clk: rockchip: Remove 48 MHz PLL rate from rk3288
Date:   Tue,  4 Jun 2019 15:31:59 -0700
Message-Id: <20190604223200.345-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 48 MHz PLL rate is not present in the downstream chromeos-3.14
tree.  Looking at history, it was originally removed in
<https://crrev.com/c/265810> ("CHROMIUM: clk: rockchip: expand more
clocks support") with no explanation.  Much of that patch was later
reverted in <https://crrev.com/c/284595> ("CHROMIUM: clk: rockchip:
Revert more questionable PLL rates"), but that patch left in the
removal of 48 MHz.  What I wrote in that patch:

> Note that the original change also removed the rate (48000000, 1,
> 64, 32) from the table.  I have no idea why that was squashed in
> there, but that rate was invalid anyway (it appears to have an out
> of bounds NO).  I'm not putting that rate in.

Reading the TRM I see that NO is defined as
- NO: 1, 2-16 (even only)
...and furthermore only 4 bits are assigned for NO-1, which means that
the highest NO we could even represent is 16.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/clk/rockchip/clk-rk3288.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 152a22a69b04..51a26ff600a1 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -101,7 +101,6 @@ static struct rockchip_pll_rate_table rk3288_pll_rates[] = {
 	RK3066_PLL_RATE( 216000000, 1, 72, 8),
 	RK3066_PLL_RATE( 148500000, 2, 99, 8),
 	RK3066_PLL_RATE( 126000000, 1, 84, 16),
-	RK3066_PLL_RATE(  48000000, 1, 64, 32),
 	{ /* sentinel */ },
 };
 
-- 
2.22.0.rc1.311.g5d7573a151-goog

