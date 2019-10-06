Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E32CC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653BB2080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383712;
	bh=ufQvx7ZNex7e9L1n3iz0qxl2DPV4jX3rgvJ6+P7qKWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hYag+9mxfjfHIow3qVUnPIj/uo7pG42scYFT7QYR0lsQ43nJbEF3bzL7ZmOfH3rAq
	 WsBFVZnX/x4FLF3Jn+Wq2rtBfTHa4UfUfQ4UjpS/+CvFXcFx9um24i7/2S+AoMXwYe
	 kg/55xs8zNZKOVBzNoRowloQRO0RB7V8mij9X8Xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfJFRlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:41:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730609AbfJFRlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:41:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6A5220700;
        Sun,  6 Oct 2019 17:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383706;
        bh=ufQvx7ZNex7e9L1n3iz0qxl2DPV4jX3rgvJ6+P7qKWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SSYDMiOR3t3SufEsLMb6ZjPfbrZFdtHrAuB2UN681CPgFBML/Q5jSFcO6H7FPhi7F
         kULyAcic1T5hBZDj2saGveojzN+w5Fj0vMU5ElLOGCciWfww64Olf37zMVyGb0oLZ9
         aTsd8f61H+YMLuYHx0ETFUhmvr+zDm1+FWk27iJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 065/166] clk: qcom: gcc-sdm845: Use floor ops for sdcc clks
Date:   Sun,  6 Oct 2019 19:20:31 +0200
Message-Id: <20191006171218.762161698@linuxfoundation.org>
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

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit 5e4b7e82d497580bc430576c4c9bce157dd72512 ]

Some MMC cards fail to enumerate properly when inserted into an MMC slot
on sdm845 devices. This is because the clk ops for qcom clks round the
frequency up to the nearest rate instead of down to the nearest rate.
For example, the MMC driver requests a frequency of 52MHz from
clk_set_rate() but the qcom implementation for these clks rounds 52MHz
up to the next supported frequency of 100MHz. The MMC driver could be
modified to request clk rate ranges but for now we can fix this in the
clk driver by changing the rounding policy for this clk to be round down
instead of round up.

Fixes: 06391eddb60a ("clk: qcom: Add Global Clock controller (GCC) driver for SDM845")
Reported-by: Douglas Anderson <dianders@chromium.org>
Cc: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lkml.kernel.org/r/20190830195142.103564-1-swboyd@chromium.org
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 7131dcf9b0603..95be125c3bddf 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -685,7 +685,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_names = gcc_parent_names_10,
 		.num_parents = 5,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -709,7 +709,7 @@ static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
 		.name = "gcc_sdcc4_apps_clk_src",
 		.parent_names = gcc_parent_names_0,
 		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
-- 
2.20.1



