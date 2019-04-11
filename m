Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AC3C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC13320850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Px0T0NZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfDKR7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:59:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40956 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKR7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:59:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so3871781pgl.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fM6RWzAbIFr1PsVvrEclHdq1XDLHiApauiaIfSN88Kg=;
        b=Px0T0NZaiEDpf0XprSK8iOu0q39xE9pJuDaKI0b/3DD48jGm5GIxXgKgV0iyLiBCnE
         OaZ+KNASuZc+xot57LWBwkpaqr51qomxaQfINeA/gr48vDikzcFuvA+md/bVHKxRrdWr
         DnZa03lFZY33IQz5sOMY/HuKbSxXc66AUDzX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fM6RWzAbIFr1PsVvrEclHdq1XDLHiApauiaIfSN88Kg=;
        b=lhdU6hnNhYi/fGCgsj3+rCvjoURCo9xcRSDFZW7oVEVcdaFnRI4PRmmCh5gwtHlBCN
         coFNyDP+5kUUe8LkK6FdAZ8NpbT2d/pydH0uyv7b2aZ5oDl3Cf14gXxHZPWdYXHciTpS
         8zNh+Re9OFmAaRcmBv2IDM32NVFFOUps5GLX7Y5dLOs9603deFYz7MYAaV9oc1pBw/fu
         NLERAZI8PpuC887BTWoDIBqRCjaXH1CajvTwwyteVqCqoZlwR8zxm5WuFWl3O0IQMCN+
         KqydX7whfL2T0kiBzvHxbsOH3H3r7zGq6cFmTwISPKq4zE9unRiRsS7pz5/h+uKim2U3
         K2xg==
X-Gm-Message-State: APjAAAWNABRKrGlMATx48KLNTsTgC8GWX1YxJRoxIon8h7kEJ85Hi/G6
        yZ75HE2XlBrnRO6dqFAnPTZV+w==
X-Google-Smtp-Source: APXvYqy0hVx1MoV5iIQ0mm5Ph4f3eCbTXpoZFbj78KHkGPPDUfTJAXD1a8MKC4K2zT3LsThydTahlg==
X-Received: by 2002:a63:5149:: with SMTP id r9mr46486539pgl.177.1555005562196;
        Thu, 11 Apr 2019 10:59:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g67sm60773947pfg.94.2019.04.11.10.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 10:59:21 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] clk: rockchip: rk3288: Limit use of USB PHY clock to USB
Date:   Thu, 11 Apr 2019 10:59:17 -0700
Message-Id: <20190411175917.173566-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB PHY clock can be configured as (grand) parent of uart0_sclk and
sclk_gpu. It has been observed that UART0 doesn't work reliably in high
speed mode with the PHY clock as input when certain USB devices are
plugged to the USB HOST1 port (see https://crrev.com/c/320543).

Prefix the name of the PHY clock with a '.' in the non-USB muxes to
effectively remove the clock as input from these muxes.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/clk/rockchip/clk-rk3288.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 5a67b7869960..677bc5485201 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -200,8 +200,8 @@ PNAME(mux_aclk_cpu_src_p)	= { "cpll_aclk_cpu", "gpll_aclk_cpu" };
 PNAME(mux_pll_src_cpll_gpll_p)		= { "cpll", "gpll" };
 PNAME(mux_pll_src_npll_cpll_gpll_p)	= { "npll", "cpll", "gpll" };
 PNAME(mux_pll_src_cpll_gpll_npll_p)	= { "cpll", "gpll", "npll" };
-PNAME(mux_pll_src_cpll_gpll_usb480m_p)	= { "cpll", "gpll", "usbphy480m_src" };
-PNAME(mux_pll_src_cpll_gll_usb_npll_p)	= { "cpll", "gpll", "usbphy480m_src", "npll" };
+PNAME(mux_pll_src_cpll_gpll_usb480m_p)	= { "cpll", "gpll", ".usbphy480m_src" };
+PNAME(mux_pll_src_cpll_gll_usb_npll_p)	= { "cpll", "gpll", ".usbphy480m_src", "npll" };
 
 PNAME(mux_mmc_src_p)	= { "cpll", "gpll", "xin24m", "xin24m" };
 PNAME(mux_i2s_pre_p)	= { "i2s_src", "i2s_frac", "ext_i2s", "xin12m" };
-- 
2.21.0.392.gf8f6787159e-goog

