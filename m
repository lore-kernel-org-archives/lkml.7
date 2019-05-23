Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B7EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430DB2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640402;
	bh=HiFtAIKrl+Yj/b7btEiQx9X+/cf8POcNBsL9C668gKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sHbOMqlS2GgMIIHabrhMlT2MKyIH+MX5j67vMJcIxZhwbw32ibmZxbqT2g9zHGIXj
	 eItDIzfvvFaAylrLKR9ERRCKmQ3hHMA1gbdskpCVaPz/6zw3FYBHZ9tI4Z8cO7458H
	 SUu6ow+RK2Tibn5t04QB/1eQVRF1XXUf8U/0rNUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390309AbfEWTVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:21:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390290AbfEWTVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:21:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACACF20863;
        Thu, 23 May 2019 19:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639293;
        bh=HiFtAIKrl+Yj/b7btEiQx9X+/cf8POcNBsL9C668gKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vRqZ8KPIOWKOwGzI8nAWoepsHZ+j/K4g9QIdG5Lx4wR8uQwxLxPd3Ao+J7UAsJHfg
         keJ0xBQ5NSt0lEfm23EyYfR1qWOfXDsTd/xns9stDwawjNAJEe/suZmQk3NYjbmtiB
         F7uzGUTx7Vcrhju0E4DI/KwR7BvEU89K1xBt/xX8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhong Kaihua <zhongkaihua@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Dong Zhang <zhangdong46@hisilicon.com>,
        Leo Yan <leo.yan@linaro.org>, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.0 051/139] clk: hi3660: Mark clk_gate_ufs_subsys as critical
Date:   Thu, 23 May 2019 21:05:39 +0200
Message-Id: <20190523181727.303517530@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
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


