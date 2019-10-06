Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525ADC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0302087E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383594;
	bh=WluHTX10qG7RAA57oEeBHSjMqLz0IzntlDMWX8RpLdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WjimrqCq1LC02m+HaXewMcWYw+JkBXXXYm//l7xUuAmzUwHNWqvOqpCkj0MDqg5ku
	 N+JIZASdBdu9cYeSDXQrhM82iK5xQcAoV/aGhrGerJ5pB2ecO/ibunxbpMwew1tJvP
	 7Tg98uOqsDHdT0teuBq5Kb+tAWK5W/BjGFyuBnrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbfJFRju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730849AbfJFRjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:39:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 728BC2080F;
        Sun,  6 Oct 2019 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383587;
        bh=WluHTX10qG7RAA57oEeBHSjMqLz0IzntlDMWX8RpLdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p0+Rm69TjsofC4kxjGYVprVUCPSZpeLJsQc5xCUnqtxlHPAVsECdZBe8CeQpBoZke
         lLMduJr2DGDNFYgLKAIBFD+BvqdUM+Z8QEb+EAs3U5BHlhTE+UitSEkHHiyC8vzYOB
         alaI8xgbAsRVwFHzG/saL3iUqDIHMlTljobqKAak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 021/166] clk: imx8mq: Mark AHB clock as critical
Date:   Sun,  6 Oct 2019 19:19:47 +0200
Message-Id: <20191006171214.987602009@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

[ Upstream commit 9b9c60bed562c3718ae324a86f3f30a4ff983cf8 ]

Initially, the TMU_ROOT clock was marked as critical, which automatically
made the AHB clock to stay always on. Since the TMU_ROOT clock is not
marked as critical anymore, following commit:

"clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TMU_ROOT"

all the clocks that derive from ipg_root clock (and implicitly ahb clock)
would also have to enable, along with their own gate, the AHB clock.

But considering that AHB is actually a bus that has to be always on, we mark
it as critical in the clock provider driver and then all the clocks that
derive from it can be controlled through the dedicated per IP gate which
follows after the ipg_root clock.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Tested-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx8mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index d407a07e7e6dd..e07c69afc3594 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -406,7 +406,8 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	clks[IMX8MQ_CLK_NOC_APB] = imx8m_clk_composite_critical("noc_apb", imx8mq_noc_apb_sels, base + 0x8d80);
 
 	/* AHB */
-	clks[IMX8MQ_CLK_AHB] = imx8m_clk_composite("ahb", imx8mq_ahb_sels, base + 0x9000);
+	/* AHB clock is used by the AHB bus therefore marked as critical */
+	clks[IMX8MQ_CLK_AHB] = imx8m_clk_composite_critical("ahb", imx8mq_ahb_sels, base + 0x9000);
 	clks[IMX8MQ_CLK_AUDIO_AHB] = imx8m_clk_composite("audio_ahb", imx8mq_audio_ahb_sels, base + 0x9100);
 
 	/* IPG */
-- 
2.20.1



