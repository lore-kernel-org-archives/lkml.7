Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20009C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA34F2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VvmlfWfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDIUrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:47:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33505 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfDIUra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:47:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so96229pgh.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NZvMGT2vfAQYfdlzg+GPO1Jl5l+p2xxq8Y02i9suNv4=;
        b=VvmlfWfbAGZAwlcFFCzvKHbiJZNzkEPIK+l3Op/Rr2tQzR9BozgerFoRoaa3DKpaOt
         FlNZxz8uPX60+V+i4M+S7CuC6JNiMRL6xBGLdZo74MNyubswd4kG/99A1f534JHP+Vu/
         7StW/EFi1i2aQHzCsTj2lNOl/7iolEmwNsf2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NZvMGT2vfAQYfdlzg+GPO1Jl5l+p2xxq8Y02i9suNv4=;
        b=QqmWnqVizryrD34lGIR90XoqsqqENwN0vTIbPOEMHxf+BYtS0PSwFTgm9KeBFBIKKz
         735pso4eWAYFAzfz5+4jsvOkt7zMMntCCQoG5y1zuYjvg+D6NdoacEIQKzWWL0s/0l9v
         dJsq7GKN9eswNM9PIErbDAT6agSOEkyOadkhM6TAFOG4mzVGNFKeGeL12IN8LdZYSI/s
         awrhrkp7c323DjZk5KwFQGcekBHSglGeytUIhteIBUu15L2U5qDiGaBSaP4SwNK0QTFp
         TEMbfARWMtzxBo6gFT1+ofi61B7VWZ8gDQhaDt5o6JTgtJ3UycW6wiF6Rc9kzNQMJwkb
         Oq4A==
X-Gm-Message-State: APjAAAVyHEtrpUkq692WPptZdKwqjQEu1OguScn+Sp/Y6UqPA6GtNR1n
        nNYOmWCq9SbF4BEKt+kl75yjbQ==
X-Google-Smtp-Source: APXvYqybYD8fp801Ommhq+URoVUCZuUBVLC79tf/S8zjAur5ioWJhD5IFIC1+LbwIoz2ywM12DbwpQ==
X-Received: by 2002:a62:1f92:: with SMTP id l18mr39635668pfj.180.1554842849784;
        Tue, 09 Apr 2019 13:47:29 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id x28sm35014016pgl.38.2019.04.09.13.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 13:47:29 -0700 (PDT)
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
Subject: [PATCH 2/3] clk: rockchip: Make rkpwm a critical clock on rk3288
Date:   Tue,  9 Apr 2019 13:47:06 -0700
Message-Id: <20190409204707.150347-3-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190409204707.150347-1-dianders@chromium.org>
References: <20190409204707.150347-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most rk3288-based boards are derived from the EVB and thus use a PWM
regulator for the logic rail.  However, most rk3288-based boards don't
specify the PWM regulator in their device tree.  We'll deal with that
by making it critical.

NOTE: it's important to make it critical and not just IGNORE_UNUSED
because all PWMs in the system share the same clock.  We don't want
another PWM user to turn the clock on and off and kill the logic rail.

This change is in preparation for actually having the PWMs in the
rk3288 device tree actually point to the proper PWM clock.  Up until
now they've all pointed to the clock for the old IP block and they've
all worked due to the fact that rkpwm was IGNORE_UNUSED and that the
clock rates for both clocks were the same.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/clk/rockchip/clk-rk3288.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 06287810474e..c3321eade23e 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -697,7 +697,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	GATE(PCLK_TZPC, "pclk_tzpc", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 3, GFLAGS),
 	GATE(PCLK_UART2, "pclk_uart2", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 9, GFLAGS),
 	GATE(PCLK_EFUSE256, "pclk_efuse_256", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 10, GFLAGS),
-	GATE(PCLK_RKPWM, "pclk_rkpwm", "pclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(11), 11, GFLAGS),
+	GATE(PCLK_RKPWM, "pclk_rkpwm", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 11, GFLAGS),
 
 	/* ddrctrl [DDR Controller PHY clock] gates */
 	GATE(0, "nclk_ddrupctl0", "ddrphy", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(11), 4, GFLAGS),
@@ -837,6 +837,7 @@ static const char *const rk3288_critical_clocks[] __initconst = {
 	"pclk_alive_niu",
 	"pclk_pd_pmu",
 	"pclk_pmu_niu",
+	"pclk_rkpwm",
 };
 
 static void __iomem *rk3288_cru_base;
-- 
2.21.0.392.gf8f6787159e-goog

