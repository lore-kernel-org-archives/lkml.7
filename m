Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59E3C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962932084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vxr3Ka6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDIUrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:47:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41811 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfDIUr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:47:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id d1so10122911plj.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 13:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQtEpFr/2QLJJRhgfs3xG1fw3zbFUfL+gsBwRn2FRiU=;
        b=Vxr3Ka6p31s9x4dd+PrU3fntx+g16qjSfCMXIEspakxskDnqurocM5WnuYakx6KOV0
         yHe3K1tHjILdPNGwuQDwV2qP5psDPm/RbPKZdEB2FuDsoUwanlWkd9AbqgpLb/HT0Fqr
         KLLckLDp8uyS4EFkJpK6x/83eswdMi3p+4ZWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQtEpFr/2QLJJRhgfs3xG1fw3zbFUfL+gsBwRn2FRiU=;
        b=bkXM4DbPYmpJppRNl8skecWJ8HBotMl4eAK7fcz8FB6xTx9duN+JCDGfnJyh24sIth
         BRGtWa2u/ehSDetbXhqs8tiDDR1KlunE3XC68LHKfGiPsjfkzgOO7pP/hskSqYQsicg+
         JhuGDmugESDuF3LWCmLH9KJcVVqPoZCz7V/iJKN8s+9xYZ+GyeXXPxCkbCQRm/tp0iEe
         8Xo7nFE1bx4u+wY/7N/8GPEBZxem0U10xvW3uWTsWt5aYZ660Qk6+0604bALmOPWwWOJ
         lHCIdS3Jz5azneC4qAp8Pkqr8ME86241mpzIhK2OcOylK2ku8ruBGa4cZV1EKLdiObb4
         /n5g==
X-Gm-Message-State: APjAAAW5A3MWjLR9gj+tEFwmyTexWvTOaj82pOh+icwLIR7tcVFOVN8t
        XpFtRl3i3idfEF3XgmEhCyQELg==
X-Google-Smtp-Source: APXvYqyuMD3gSme+CuuouGXSlNmkP4JX+ynXAbAEWa8G9WeOBvo3pVFWxQjDCZTk5zyU9r4fD8SvMg==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr15107160pla.311.1554842848669;
        Tue, 09 Apr 2019 13:47:28 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id x28sm35014016pgl.38.2019.04.09.13.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 13:47:28 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caesar Wang <caesar.wang@rock-chips.com>,
        linux-rockchip@lists.infradead.org, mka@chromium.org,
        ryandcase@chromium.org, Elaine Zhang <zhangqing@rock-chips.com>,
        linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] Revert "clk: rockchip: mark noc and some special clk as critical on rk3288"
Date:   Tue,  9 Apr 2019 13:47:05 -0700
Message-Id: <20190409204707.150347-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190409204707.150347-1-dianders@chromium.org>
References: <20190409204707.150347-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 55bb6a633c33caf68ab470907ecf945289cb733d.

The clocks that were enabled by that patch are pretty questionable.
Specifically looking at what has been shipping on rk3288-veyron
Chromebooks almost all of these clocks are safely turned off and cause
no apparent problems.  If some boards need these clocks turned on for
some reason then it seems like we should figure out how to do that at
a board level.

NOTE: turning these clocks off doesn't seem to do a whole lot in terms
of power savings (checking the power on the logic rail).  It appears
to save maybe 1-2mW.  ...but still it seems like we should turn the
clocks off if they aren't needed.

Digging into the clocks here to describe why they shouldn't need to be
left on:

atclk: No documentation about this clock other than that it goes to
the CPU.  CPU functions fine without it on.

jtag: Presumably this clock is only needed if you're debugging with
JTAG.  It doesn't seem like it makes sense to waste power for every
rk3288 user.  Perhaps this could be turned on with a CONFIG option?

pclk_dbg, pclk_core_niu: On veyron Chromebooks we turn these two
clocks on only during kernel panics in order to access some coresight
registers.  Since nothing in the upstream kernel does this we should
be able to leave them off safely.

hsicphy12m_xin12m: There is no indication of why this clock would need
to be turned on for boards that don't use HSIC.

pclk_ddrupctl[0-1], pclk_publ0[0-1]: On veyron Chromebooks we turn
these 4 clocks on only when doing DDR transitions and they are off
otherwise.  I see no reason why they'd need to be on in the upstream
kernel which doesn't support DDRFreq.

pmu_hclk_otg0: A "chip design defect" is mentioned in the original
patch but no details.  This clock has always been gated in shipping
veyron Chromebooks so presumably this chip defect doesn't affect all
boards.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/clk/rockchip/clk-rk3288.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 5a67b7869960..06287810474e 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -313,13 +313,13 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	COMPOSITE_NOMUX(0, "aclk_core_mp", "armclk", CLK_IGNORE_UNUSED,
 			RK3288_CLKSEL_CON(0), 4, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3288_CLKGATE_CON(12), 6, GFLAGS),
-	COMPOSITE_NOMUX(0, "atclk", "armclk", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "atclk", "armclk", 0,
 			RK3288_CLKSEL_CON(37), 4, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3288_CLKGATE_CON(12), 7, GFLAGS),
 	COMPOSITE_NOMUX(0, "pclk_dbg_pre", "armclk", CLK_IGNORE_UNUSED,
 			RK3288_CLKSEL_CON(37), 9, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3288_CLKGATE_CON(12), 8, GFLAGS),
-	GATE(0, "pclk_dbg", "pclk_dbg_pre", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_dbg", "pclk_dbg_pre", 0,
 			RK3288_CLKGATE_CON(12), 9, GFLAGS),
 	GATE(0, "cs_dbg", "pclk_dbg_pre", CLK_IGNORE_UNUSED,
 			RK3288_CLKGATE_CON(12), 10, GFLAGS),
@@ -647,7 +647,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	INVERTER(SCLK_HSADC, "sclk_hsadc", "sclk_hsadc_out",
 			RK3288_CLKSEL_CON(22), 7, IFLAGS),
 
-	GATE(0, "jtag", "ext_jtag", CLK_IGNORE_UNUSED,
+	GATE(0, "jtag", "ext_jtag", 0,
 			RK3288_CLKGATE_CON(4), 14, GFLAGS),
 
 	COMPOSITE_NODIV(SCLK_USBPHY480M_SRC, "usbphy480m_src", mux_usbphy480m_p, 0,
@@ -656,7 +656,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	COMPOSITE_NODIV(SCLK_HSICPHY480M, "sclk_hsicphy480m", mux_hsicphy480m_p, 0,
 			RK3288_CLKSEL_CON(29), 0, 2, MFLAGS,
 			RK3288_CLKGATE_CON(3), 6, GFLAGS),
-	GATE(0, "hsicphy12m_xin12m", "xin12m", CLK_IGNORE_UNUSED,
+	GATE(0, "hsicphy12m_xin12m", "xin12m", 0,
 			RK3288_CLKGATE_CON(13), 9, GFLAGS),
 	DIV(0, "hsicphy12m_usbphy", "sclk_hsicphy480m", 0,
 			RK3288_CLKSEL_CON(11), 8, 6, DFLAGS),
@@ -837,12 +837,6 @@ static const char *const rk3288_critical_clocks[] __initconst = {
 	"pclk_alive_niu",
 	"pclk_pd_pmu",
 	"pclk_pmu_niu",
-	"pclk_core_niu",
-	"pclk_ddrupctl0",
-	"pclk_publ0",
-	"pclk_ddrupctl1",
-	"pclk_publ1",
-	"pmu_hclk_otg0",
 };
 
 static void __iomem *rk3288_cru_base;
-- 
2.21.0.392.gf8f6787159e-goog

