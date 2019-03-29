Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D81CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C514218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pYS1Spzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfC2Pdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:33:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33667 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbfC2Pdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:33:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so9973901wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FWfQp5+ZZrqhqHBdYBd1fS5YgiYNyIDWJS2WXanIlaU=;
        b=pYS1SpzwcqPn03mG5ybxNzW305QTPzPCQZN263IXlWMguaxWwsEMBYjnXbcCHLgUwE
         fPH+js9vlzVc2+Eu+zV/J/qRA2bEk7q7ZGQdJK7o556F7K76c5LkxkgpOASIB0NUdQbo
         mwNZ4bd+82iSvruITeR0gIhLo/Zg5LWPo2ZSFNTOCXeyqJs6mAPBtKgR7D/WxPExfndZ
         YmhxNF4OX1zYm07GCzwBHvtIslQSb2pZ1GZzwoXlBmtQX+p2/oDSS/8+KhAmDjqy7zcV
         O4U85x6VYdjnzcXit5A3CNCMdKSTa4OyR1sqhu0DdOejiZISh2hua7PuBgqjTwmwbVY5
         PENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWfQp5+ZZrqhqHBdYBd1fS5YgiYNyIDWJS2WXanIlaU=;
        b=KWxmCL3yuOiOpausecs0tDuM0vb/n/XPsD4QhTcUudh+Zv62kAILXYa/J6NNlMftTw
         jgxf1ZV/zyCFTlbN/xFHYss7saawUKuHVJuBPiYvm5+I5JWqleCnR6B/CouoZKBQfGGu
         GcTz2uvjB07lTTXTcbQTelHolanSS1cSyM6whz3WZd+69gxB+6LL+YMFmDvjcZuaz1tf
         +vo3fx5jYHUzc0pYJArkMz3i4qVxgL/EtAL29SVrw2BMzRQsRLSmzPb09Bs21DCJKODV
         SeBid64CXMMpUhW/S9n+YESCtQbrp55j/g7sW/MTS3xGbiZJn4VGSt0pSPgdNPXGsTsK
         Oh8g==
X-Gm-Message-State: APjAAAXl8m80FMGpN66tiK+st4jirjwbz3F9sz4WABU1FVIN1uPCunDI
        S45oraiT1ILd4anLyrpyQKW0sw==
X-Google-Smtp-Source: APXvYqykcHi1Bbu3B94IurmTjSfeqUhpdghDB5ixIbNF4oVr9EDQj4dbbKldpJNI4UMntOaj0KmBnQ==
X-Received: by 2002:a1c:e70b:: with SMTP id e11mr3828070wmh.17.1553873615975;
        Fri, 29 Mar 2019 08:33:35 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id s18sm1930173wmc.41.2019.03.29.08.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 08:33:35 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] clk: meson: gxbb: no spread spectrum on mpll0
Date:   Fri, 29 Mar 2019 16:33:24 +0100
Message-Id: <20190329153325.23869-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329153325.23869-1-jbrunet@baylibre.com>
References: <20190329153325.23869-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation says there is an SSEN bit on mpll0 but, after testing
it, no spread spectrum function appears to be enabled by this bit on any
of the MPLLs.

Let's remove it until we know more

Fixes: 1f737ffa13ef ("clk: meson: mpll: fix mpll0 fractional part ignored")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 04df2e208ed6..17d4e85bde65 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -679,11 +679,6 @@ static struct clk_regmap gxbb_mpll0_div = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.ssen = {
-			.reg_off = HHI_MPLL_CNTL,
-			.shift   = 25,
-			.width	 = 1,
-		},
 		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
-- 
2.20.1

