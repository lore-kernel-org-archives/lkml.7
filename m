Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A05C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC39208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfFLNiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:38:19 -0400
Received: from outgoing2.flk.host-h.net ([188.40.0.84]:45811 "EHLO
        outgoing2.flk.host-h.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfFLNiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:38:19 -0400
Received: from www31.flk1.host-h.net ([188.40.1.173])
        by antispam3-flk1.host-h.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1hb3SA-0002cQ-MP; Wed, 12 Jun 2019 15:38:15 +0200
Received: from [130.255.73.16] (helo=v01.28459.vpscontrol.net)
        by www31.flk1.host-h.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1hb3S9-0008Fs-BR; Wed, 12 Jun 2019 15:38:13 +0200
From:   Justin Swartz <justin.swartz@risingedge.co.za>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Justin Swartz <justin.swartz@risingedge.co.za>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: rockchip: select hdmiphy clock source for rk3228
Date:   Wed, 12 Jun 2019 13:33:43 +0000
Message-Id: <20190612133343.28309-1-justin.swartz@risingedge.co.za>
X-Mailer: git-send-email 2.11.0
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear (ClamAV 0.100.3/25478/Wed Jun 12 10:14:54 2019)
X-Originating-IP: 188.40.1.173
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00816725645638)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0Q9DGisTdy29Heef28Cu3sipSDasLI4SayDByyq9LIhVhdOhMLyqSpQF
 5/Hc0ZQ9uUTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K7uDjV/sFUXQr+CDrNQuIHgQg
 mAX8Bxy/iUu0ThNZg0h/RxVysY5Ye6+GGw0VqdJD7ren9RtRNyYim5e3GD8LGfWrcbYvelpuN/Pk
 qhBpvAyWwieZyauFYqHkIbFa+ipFJdVl2Qo16OdG/SgJyrKdw0Znvotuy3L4aSJjqFExmwGwvf6h
 PQx0fYKjNC9VXDo4KyWWo0k/XI0fGv8bNm7IfazUKrTRmPfW13HBdTouyUQiTqTLnMPwSR2klzqa
 C1hRfn6HuUe9L0a5vwf8PHac6dlnibl3vcBqVmvQB4A18af9beWOg5a9y6QIDD3Rzcr8mH6eQvWp
 DWTULXV1jJ5bfceEJeNruLKdflVX7oFNsdHVhnpudkCyIg6Nob+f0OfCg2lBMt3xu9nbye2CdJLN
 jSo1M+TSg3TNDI3/M5s9/ot3ko3rrae7IifWc6pL546YUVQwaYLh3di89W/ji5iahyCgJgyv93tC
 61cbiLYl3RCqADG/Ryndzp4OfbK7c6EqHwlqvaI+zok/BsKQK4gft4+8sY8CNaDDoRMm0CGce/fp
 WUXurEbGCiZ0ePvZjCuJdbYb9IXfYGRpVS/0hA4Mwkg/wxsjmSXwdCAtc5U5IMGqr3wBwEeX6Ai5
 5FPRpzhbYqsuNEW45+y/2kiUpWy9c957+6R4kroQiAThpzOdFqFvbdRuq0FZjQOwDKXnhaC6dkwF
 9ybSMhHO+IPM0C985aNe1vwE2plJLdOGZ2rsAWflnmUXwJv1R9bnj+xoJG4VhUotTJ0/e5GmrorL
 FK/ZMFLi1pbAdLCagrvjp/Q1JFXRjdK3JtbOY4V5u4SqNrbdxyGLEIoLEuuC4P/fyEEgA3CnflZn
 bjDB2+RGRgaXth2/9YEbMsGSn6owqJN0kS7MUpAEhFoAxikOdx3ALFboD0vMokt+4lO8Qp33tUy6
 u+yjs2RdT0IB6AsIr4ufP+vb+wzRyy9zrSTy9lnigQ7EuDwJWw42swm4bO6gacpMpzJ5RNWFoIkg
 vLC7uMZSLKkLPlzqsPnNmrTFfBI+gCHkFgyh9jAE9PwtDurXCCybWAnihjA708Lg3Y2gXyaf+rIt
 vvthbyiMZOAfvJjwL84MO4Vozqbzv/NmqBexmg1oMlu3UCyNNO7qENlLqkRemjF1A1q3g0ZrubFa
 n/xi+AGXOIO97ttnHrPmGyC6rR21+9c=
X-Report-Abuse-To: spam@antispammaster.host-h.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unless explictly configured by a bootloader, the hdmiphy clock parent
defaults to the xin24m clock source. This configuration does not yield
any HDMI video output, so let hdmiphy_phy (the HDMI PHY output clock)
be the parent instead.

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 drivers/clk/rockchip/clk-rk3228.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index 1c5267d134ee..00a195e6c014 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -699,6 +699,9 @@ static void __init rk3228_clk_init(struct device_node *np)
 		return;
 	}
 
+	/* Let hdmiphy_phy be the parent of the hdmiphy clock. */
+	writel_relaxed(HIWORD_UPDATE(0, 1, 13), reg_base + RK2928_MISC_CON);
+
 	ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
 	if (IS_ERR(ctx)) {
 		pr_err("%s: rockchip clk init failed\n", __func__);
-- 
2.11.0

