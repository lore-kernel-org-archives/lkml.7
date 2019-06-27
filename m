Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1FBC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127962063F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6SlpeiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfF0WWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:22:32 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:35290 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0WWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:22:32 -0400
Received: by mail-pl1-f201.google.com with SMTP id bb9so2220679plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 15:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oX4nX7Je7bFeJ+xtEsKgjynmAqj73RNM30dvkWhgvsQ=;
        b=u6SlpeiCjQGV5rE4yogrmSSkVZ43A8E5N6bKYKjy5TX4t8pbsrRRF9GSDcsxe+5XzD
         waGb2JTgqg+tTulN5BPPf+VqpjEptpmBs6DdyVgw7RfwK8PF8bmfqu8pLJofZoU5PIEb
         Kj3FKoiC/6L/gkMotLHT4aB/DGPvtBb9jGk8MY+tUS3gOocY4PEemi6MUJKx1H992F5K
         GSVi99x53zSc0+lXP6Fn6Mi7G5UJ+v4x0VjuC3Nw/zsJxN0mgrCZgcSVGvpqvlvYJkGH
         IM3Zt9xGBETZoaCBOmfbhevkuZjxNEaJ0Qm++R6L/06tU/5xVQglwV6olNEjSZMU+Eqr
         I7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oX4nX7Je7bFeJ+xtEsKgjynmAqj73RNM30dvkWhgvsQ=;
        b=HsWvj8SmSkiBykIQMrVL8+QL/acJ61fnsRJtyXYVevrH9SuW/XuhKhYyiFPrCTiPKN
         +1aGUX6fgTK33197+WhMtIfTxmVSFH6zzhtS2Kt4SXLJ55/3WufmbNva01Xij+pwBY1S
         oRJ4RV7OgWNEt4DK21HhDQHeeOylRnAzk3vbr4rXQbr0El494JoMNJ9p5wxp5DNIPuM0
         2NLaDRWvboEcSNwgBU9xw/A6aYU+ZwY2m/RNwS7aELVkZHt5mIsmXZg+eFwiwtm+uZYs
         1wDFhFdh308D4Nvc1RVDr8p7v8a2PpPEPZCGWC7k5QrsyUWPFtWKvtty9S0ksGt0/Xl4
         Uycw==
X-Gm-Message-State: APjAAAWlQkWCwPWXPgT2EHYsKISZfvVyut1gI/9FLwCja122fCu60KEF
        PEtkZKCXwwH48ApUNP/sB/DYn4bYlQ==
X-Google-Smtp-Source: APXvYqwHdCQ9FmNfXU+U4FhmBmrMgqd++q8o9kCPOcsO7E5yJTw5lhpjjg+JoI0rSKl+FpJ1fCN7HC5W5Q==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr5812268pgq.399.1561674151183;
 Thu, 27 Jun 2019 15:22:31 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:22:20 -0700
Message-Id: <20190627222220.89175-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] clk: rockchip: Fix -Wunused-const-variable
From:   Nathan Huckleberry <nhuck@google.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, heiko@sntech.de,
        andy.yan@rock-chips.com, zhangqing@rock-chips.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang produces the following warning

drivers/clk/rockchip/clk-rv1108.c:125:7: warning: unused variable
'mux_pll_src_3plls_p' [-Wunused-const-variable]
PNAME(mux_pll_src_3plls_p)      = { "apll", "gpll", "dpll" };

Looks like this variable was never used. Deleting it to remove the
warning.

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/524
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/clk/rockchip/clk-rv1108.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
index 96cc6af5632c..5947d3192866 100644
--- a/drivers/clk/rockchip/clk-rv1108.c
+++ b/drivers/clk/rockchip/clk-rv1108.c
@@ -122,7 +122,6 @@ PNAME(mux_usb480m_pre_p)	= { "usbphy", "xin24m" };
 PNAME(mux_hdmiphy_phy_p)	= { "hdmiphy", "xin24m" };
 PNAME(mux_dclk_hdmiphy_pre_p)	= { "dclk_hdmiphy_src_gpll", "dclk_hdmiphy_src_dpll" };
 PNAME(mux_pll_src_4plls_p)	= { "dpll", "gpll", "hdmiphy", "usb480m" };
-PNAME(mux_pll_src_3plls_p)	= { "apll", "gpll", "dpll" };
 PNAME(mux_pll_src_2plls_p)	= { "dpll", "gpll" };
 PNAME(mux_pll_src_apll_gpll_p)	= { "apll", "gpll" };
 PNAME(mux_aclk_peri_src_p)	= { "aclk_peri_src_gpll", "aclk_peri_src_dpll" };
-- 
2.22.0.410.gd8fdbe21b5-goog

