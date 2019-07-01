Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E05C06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0802145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jRzfrZu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfGAJOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:14:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47019 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbfGAJNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:13:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so12874891wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f/zYZrOrlfrcoTvw7mvtGdakqdn7f0Uy5ZLJztZMxJc=;
        b=jRzfrZu54oaHH9lzNLfyY2wrp+Pq4BxLB4iB1oIRVg2Ay5S0iUzODpbgfVQflutwZV
         sqiN/g0BukVBNkx/N10FPPLHfpgw1BxgaJkJCKbp+aiW+M+FQV1035udymDkdHQJBIYo
         jCzg4WWh9xAuL7MT9BD+Ep/OiajKsKphOX+6OouSNa0tlXellYT82BaB912w8mZQ2yVL
         ZfqRIG1FUamlLELYDb80kOC+J37SDrv6iF6MxRywtYDBKdohz+rQeOmBE0ADwpkuquau
         lj6OLV+SwVbBNOtBGifq0R/fn/CAMBFAuV2LZY7Yvk5xKQrJhRRu2h2ZSwcnaxnN1Wt7
         79Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f/zYZrOrlfrcoTvw7mvtGdakqdn7f0Uy5ZLJztZMxJc=;
        b=K0B19i8QNmXP1DBkhjWFZL2Z9l0GulPsevaFkth50sFFeIrkugK4ikx1YRQ9fPq3eG
         VNjWa17HSwJmDA7gjxMOQHyyOFLr4yUhVL2NIp3p22hbXI+yrdAx+t2EEw/HYakq19R/
         tVJafl/oVDvy0PC9vSI6rVK2nog8sYWDVLhPeCrBsXQyzJNaEQSvSGC5QL9KqTK6MBqo
         68Jf7q9Hud1ZIN7nmw9wS1AZxrA+2DERI08eWOLYKmibsRLoC4muJ7sQeS0+IvVPjqma
         NFzIOmm48Asygcj1TxgKRaA5vEOOn9aFl48rPU39Bq11z2yVhvyZuJAfmqhg10gPXkWr
         XS1w==
X-Gm-Message-State: APjAAAWwZ26lTibGUCIM4BXLaVghwjX8Ub46NwM6tnAQKb42iArj552A
        SXZeuPGPNsjqvBXeejcp6mRz8g==
X-Google-Smtp-Source: APXvYqyT0fpf4ZW2lN6qRHzI9//R+u71j9/hU2ekwUjUyuAJAi3E756tCjzYWkYWKgweFITAkrBOag==
X-Received: by 2002:adf:f706:: with SMTP id r6mr9088993wrp.23.1561972396951;
        Mon, 01 Jul 2019 02:13:16 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id i16sm6305659wrm.37.2019.07.01.02.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 02:13:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT v3 06/14] soc: amlogic: meson-clk-measure: add G12B second cluster cpu clk
Date:   Mon,  1 Jul 2019 11:12:50 +0200
Message-Id: <20190701091258.3870-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701091258.3870-1-narmstrong@baylibre.com>
References: <20190701091258.3870-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the G12B second CPU cluster CPU and SYS_PLL measure IDs.

These IDs returns 0Hz on G12A.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-clk-measure.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
index c470e24f1dfa..f09b404b39d3 100644
--- a/drivers/soc/amlogic/meson-clk-measure.c
+++ b/drivers/soc/amlogic/meson-clk-measure.c
@@ -324,6 +324,8 @@ static struct meson_msr_id clk_msr_g12a[CLK_MSR_MAX] = {
 	CLK_MSR_ID(84, "co_tx"),
 	CLK_MSR_ID(89, "hdmi_todig"),
 	CLK_MSR_ID(90, "hdmitx_sys"),
+	CLK_MSR_ID(91, "sys_cpub_div16"),
+	CLK_MSR_ID(92, "sys_pll_cpub_div16"),
 	CLK_MSR_ID(94, "eth_phy_rx"),
 	CLK_MSR_ID(95, "eth_phy_pll"),
 	CLK_MSR_ID(96, "vpu_b"),
-- 
2.21.0

