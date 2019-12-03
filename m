Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A5BC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE68E20656
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414004;
	bh=2n4Pb1VYk1er3LK3e5A/i6LbB5hD/TGvKe6nzGWYQxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DZAGBcyrbymUmA6MhZr0CvzxrQWlj3GLMBd8x0ejccnXlLk7cuiFRRUDHrFKl1lEn
	 Aula2nrFEcOOjtMLywASU+4X0WWKehhVv5YtMroz5EL1Kx7JzUgUgi+IAoGEdRGxSF
	 rX95KCLoScWAQkPyEk+3KdJ3adcuUzepTIeDfRA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfLCXAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:00:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730649AbfLCW62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:58:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 097322053B;
        Tue,  3 Dec 2019 22:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413907;
        bh=2n4Pb1VYk1er3LK3e5A/i6LbB5hD/TGvKe6nzGWYQxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bj8QEm5uxifWExK/wOV5q5LA3o3csU1J0AH/WIBgiMOo0IjtFR3XpZQQvpWTk3PXu
         GvJkJjiPRfU7TO/PvdeD8sk4Fk8MP6m+/roJgWKHUiec1g1XPN+wGW1NdGUaTe/mkV
         O9ibWBz0SRzOmizqZwnXkEY8zH8X0fS7SwUpl+vM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 4.19 309/321] clk: stm32mp1: fix HSI divider flag
Date:   Tue,  3 Dec 2019 23:36:15 +0100
Message-Id: <20191203223443.222565848@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

commit d3f2e33c875de5052e032a9eefa64c897a930ed1 upstream.

The divider of HSI (clk-hsi-div) is power of two divider.

Fixes: 9bee94e7b7da ("clk: stm32mp1: Introduce STM32MP1 clock driver")
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/clk-stm32mp1.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1655,8 +1655,8 @@ static const struct stm32_mux_cfg ker_mu
 
 static const struct clock_config stm32mp1_clock_cfg[] = {
 	/* Oscillator divider */
-	DIV(NO_ID, "clk-hsi-div", "clk-hsi", 0, RCC_HSICFGR, 0, 2,
-	    CLK_DIVIDER_READ_ONLY),
+	DIV(NO_ID, "clk-hsi-div", "clk-hsi", CLK_DIVIDER_POWER_OF_TWO,
+	    RCC_HSICFGR, 0, 2, CLK_DIVIDER_READ_ONLY),
 
 	/*  External / Internal Oscillators */
 	GATE_MP1(CK_HSE, "ck_hse", "clk-hse", 0, RCC_OCENSETR, 8, 0),


