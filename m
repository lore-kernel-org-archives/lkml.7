Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98560C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71651217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558638952;
	bh=HiFtAIKrl+Yj/b7btEiQx9X+/cf8POcNBsL9C668gKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k50+yWovQ0AtfDzLmqmhwmnyuFWtgozBr/frMI4TtizdFW30AdFrMAejQZ93uQZHv
	 TVxr499z7MlzDlta3DNbXkvOfOHZ547B6wiH/49MvVnUjR2puosehPwdhVZ36xveBN
	 kNYyUQV9I4gS9KiXhfrjpPgA+o+fmB9Zq2yY1zg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388623AbfEWTPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389066AbfEWTPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:15:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D590C2133D;
        Thu, 23 May 2019 19:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638946;
        bh=HiFtAIKrl+Yj/b7btEiQx9X+/cf8POcNBsL9C668gKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cAnmXq3rNl4GYGEnZ89oWrttUELBRqd1Nt00SVPEKLswghcE3lgtUMPEP22RzW8ko
         dx/qv4xcvn67z+1u1Rk/8cr5ANrizYCxKKsLzE34c1RZ/sIh9e+s1Pl9Mia1zdfLCZ
         HgyIMX6UXbkpVLWe8XwyK7w5dhrZBNCl+98IyXz8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhong Kaihua <zhongkaihua@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Dong Zhang <zhangdong46@hisilicon.com>,
        Leo Yan <leo.yan@linaro.org>, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.19 039/114] clk: hi3660: Mark clk_gate_ufs_subsys as critical
Date:   Thu, 23 May 2019 21:05:38 +0200
Message-Id: <20190523181735.310111138@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

commit 9f77a60669d13ed4ddfa6cd7374c9d88da378ffa upstream.

clk_gate_ufs_subsys is a system bus clock, turning off it will
introduce lockup issue during system suspend flow.  Let's mark
clk_gate_ufs_subsys as critical clock, thus keeps it on during
system suspend and resume.

Fixes: d374e6fd5088 ("clk: hisilicon: Add clock driver for hi3660 SoC")
Cc: stable@vger.kernel.org
Cc: Zhong Kaihua <zhongkaihua@huawei.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Suggested-by: Dong Zhang <zhangdong46@hisilicon.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/hisilicon/clk-hi3660.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/clk/hisilicon/clk-hi3660.c
+++ b/drivers/clk/hisilicon/clk-hi3660.c
@@ -163,8 +163,12 @@ static const struct hisi_gate_clock hi36
 	  "clk_isp_snclk_mux", CLK_SET_RATE_PARENT, 0x50, 17, 0, },
 	{ HI3660_CLK_GATE_ISP_SNCLK2, "clk_gate_isp_snclk2",
 	  "clk_isp_snclk_mux", CLK_SET_RATE_PARENT, 0x50, 18, 0, },
+	/*
+	 * clk_gate_ufs_subsys is a system bus clock, mark it as critical
+	 * clock and keep it on for system suspend and resume.
+	 */
 	{ HI3660_CLK_GATE_UFS_SUBSYS, "clk_gate_ufs_subsys", "clk_div_sysbus",
-	  CLK_SET_RATE_PARENT, 0x50, 21, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x50, 21, 0, },
 	{ HI3660_PCLK_GATE_DSI0, "pclk_gate_dsi0", "clk_div_cfgbus",
 	  CLK_SET_RATE_PARENT, 0x50, 28, 0, },
 	{ HI3660_PCLK_GATE_DSI1, "pclk_gate_dsi1", "clk_div_cfgbus",


