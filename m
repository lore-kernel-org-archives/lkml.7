Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DEEC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9578F21907
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="D3va8Eqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfIHNnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 09:43:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34937 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbfIHNnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:43:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id g7so11058758wrx.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P9spBEsBHUZ9g/u9RtVBlcb3OiOFBO3IyBThdfZnhU8=;
        b=D3va8EqdexPnI1YV301Nv++203bL9hC6gwxXh+dK1X5wRenRC3TfHRPf1e5JASy+Rq
         ta+CoZVk6/SrkqN6BZi5/JeiRdTnHEDdeyD3mbgS1x/ANHOA+m5f/kidvGTOAdJ0YTSP
         ++RYNZWZWx56VWpfjqXFxF3I/WW5KI4F2tG6u86x9ISHYLtDmO24gMjeFk3pAtaIeoF4
         2Y7a+oL9BaU5BZaOAlg1u/iUx2Bf8pDD8YGZ3pUIi47YqW5ZWP3j00W0qo045IBTWWfV
         q9kQu5qxY/XQyENHpAevcyqj6CaeO5EOKTCsDNLlywYtw/M5MBzGJS15AxI6NWV3OcRe
         TyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P9spBEsBHUZ9g/u9RtVBlcb3OiOFBO3IyBThdfZnhU8=;
        b=a4NomZY+tLWsKZx5R2QdYtKG3EI2tHr4EZGZgPIXoJL524BrCK4RuuTyniETA2KU/x
         s7D1PwLYyCvKto3ay2smanNyV/OfkGF36Me/krL0SE8NuQNcc5p2vvRrYy3ykaaAMWjf
         HG8qA/P+Vpr5J//XXFsKDgry0xDAWsFX4KY9etLe53HM4jfJ+PzMJnVq5z/LatsGLZ7G
         xr80AXHQewjaMt65UL8CCW9T7eZG3iIYggnozqfvfPV6SIt5Sa5SUBwAQF1e0O9gNnN/
         70QseAPaUD9EGoHD0ealQqWZ4KFTq/XvP05eWExEwoZXM+5eir2c46Ev4E+vDRmjeTDD
         qI5g==
X-Gm-Message-State: APjAAAXqdSXv8yW3JVgnS3XjLi54FJznmZ/u3syuepGvypY6kJbYa+I+
        4h6N4ZT955yOmp5EEZW3e9UJyQ==
X-Google-Smtp-Source: APXvYqytEYFBR5k51dO2xW5tElr8MGpnA540xchKrS2qKXOg2WYwyMiu0TYkC6h7nI39i2dMwEc84g==
X-Received: by 2002:a05:6000:128e:: with SMTP id f14mr14632709wrx.28.1567950186850;
        Sun, 08 Sep 2019 06:43:06 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.gmail.com with ESMTPSA id t203sm14313902wmf.42.2019.09.08.06.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Sep 2019 06:43:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, kishon@ti.com
Cc:     repk@triplefau.lt, Neil Armstrong <narmstrong@baylibre.com>,
        maz@kernel.org, linux-amlogic@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] PCI: amlogic: Fix probed clock names
Date:   Sun,  8 Sep 2019 13:42:54 +0000
Message-Id: <1567950178-4466-3-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
References: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the clock names used in the probe function according
to the bindings.

Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 541f37a6f6a5..ab79990798f8 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -250,15 +250,15 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
 	if (IS_ERR(res->port_clk))
 		return PTR_ERR(res->port_clk);
 
-	res->mipi_gate = meson_pcie_probe_clock(dev, "pcie_mipi_en", 0);
+	res->mipi_gate = meson_pcie_probe_clock(dev, "mipi", 0);
 	if (IS_ERR(res->mipi_gate))
 		return PTR_ERR(res->mipi_gate);
 
-	res->general_clk = meson_pcie_probe_clock(dev, "pcie_general", 0);
+	res->general_clk = meson_pcie_probe_clock(dev, "general", 0);
 	if (IS_ERR(res->general_clk))
 		return PTR_ERR(res->general_clk);
 
-	res->clk = meson_pcie_probe_clock(dev, "pcie", 0);
+	res->clk = meson_pcie_probe_clock(dev, "pclk", 0);
 	if (IS_ERR(res->clk))
 		return PTR_ERR(res->clk);
 
-- 
2.17.1

