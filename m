Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A6EC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABBA20854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQDjPx98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfCSJcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:32:02 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38671 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSJcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:32:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id e80so11946613ote.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iqS0mD2DkpD+ki4OIwDG5Tufv1Vltf3JG5TtzYwAJaQ=;
        b=IQDjPx98/it3WTI1P1wn4ptXAPDKpO99H8tMiZ5yS0rw6fQtDerjKjLOVE3OcB6/H7
         Y0hsSPTXZHutkEpWqLyt6pPWK7DlGrVwlQAIVFY4qle4XiMCen64rfv/kAheuvIi/KsH
         T/yq07jkbU1nPaLUtuV+QgZ1WSQoR1tFZX9VKdi7L62nuhBZUvwHnPfEW/f4ozg+z16k
         ZgaHhoEsmsR4qMEBi1ieBFuSfFytN/1ObzcyQtt2Y1TeUbCiEX/DJD0BO3B39++nIj6n
         iD6khJ4zb4g2GbBuWfilu9iMpvKBEIEN/9tip+Nu6SgdEgkxSdLhYo5O+4E+/i7EmLkl
         Cy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iqS0mD2DkpD+ki4OIwDG5Tufv1Vltf3JG5TtzYwAJaQ=;
        b=ctHTxAWUIhoyhTe6/rK+CFQtnglOqKdhm4DAPeoBi6HqCX6mwVJG26HRZx+6wal7+e
         A4mhOHxZN6n8ZzBBm0yEjcdvtOPjrgqGiAHvHzgZpsF1xIiI238hct1/2E/xClYs682E
         nlKk1klZKsk7LUjlvTAHECFqdzT4WJOYFUjlvxQpnK2X3gV2IlVmDjgCquQhNH+xQMuY
         KTcTiTjHO6gv45EKHSZWDIGw671ZnUhK38eKKAl/xV6lYEry8mYGjhh5r+cK0mpm15dT
         xeGo8sEmdeDKecbaW+sAr2wmFKubys19tDG0g8wlg8zme9J033OKxnkOqIOVRSZxkJS9
         /XzA==
X-Gm-Message-State: APjAAAUH/OshAZ8F8T/WjxJqCLIRCwboJEcy/70xCBDTC/KMmkzp2mvW
        tR9qvt+KgRFJIaLo8JYtUvs6yA==
X-Google-Smtp-Source: APXvYqywx0YgPF/s2pgrbZCRIsLrGu21OCrcWPMSUAsmF007QCmybINk51gyABh1Y2urb14uMvFM7A==
X-Received: by 2002:a9d:6857:: with SMTP id c23mr923448oto.62.1552987921852;
        Tue, 19 Mar 2019 02:32:01 -0700 (PDT)
Received: from localhost.localdomain (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id n12sm4864065otl.22.2019.03.19.02.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 02:32:01 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>, stable@vger.kernel.org,
        Zhong Kaihua <zhongkaihua@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [RESEND PATCH] clk: hi3660: Mark clk_gate_ufs_subsys as critical
Date:   Tue, 19 Mar 2019 17:31:48 +0800
Message-Id: <20190319093148.1909-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/clk/hisilicon/clk-hi3660.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
index f40419959656..32ba80181cc6 100644
--- a/drivers/clk/hisilicon/clk-hi3660.c
+++ b/drivers/clk/hisilicon/clk-hi3660.c
@@ -164,7 +164,7 @@ static const struct hisi_gate_clock hi3660_crgctrl_gate_sep_clks[] = {
 	{ HI3660_CLK_GATE_ISP_SNCLK2, "clk_gate_isp_snclk2",
 	  "clk_isp_snclk_mux", CLK_SET_RATE_PARENT, 0x50, 18, 0, },
 	{ HI3660_CLK_GATE_UFS_SUBSYS, "clk_gate_ufs_subsys", "clk_div_sysbus",
-	  CLK_SET_RATE_PARENT, 0x50, 21, 0, },
+	  CLK_SET_RATE_PARENT|CLK_IS_CRITICAL, 0x50, 21, 0, },
 	{ HI3660_PCLK_GATE_DSI0, "pclk_gate_dsi0", "clk_div_cfgbus",
 	  CLK_SET_RATE_PARENT, 0x50, 28, 0, },
 	{ HI3660_PCLK_GATE_DSI1, "pclk_gate_dsi1", "clk_div_cfgbus",
-- 
2.17.1

