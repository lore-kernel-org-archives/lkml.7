Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C238C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D4E21739
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bb++BL38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfK1QuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:50:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42713 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfK1QuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id i5so4854672pgj.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WWGEc85+KcM+sGpnyTytKb3X6CvK3FAE9bn+Wq10lGo=;
        b=bb++BL38yQuo7KNIuQMOdkHafzxGcwnlx5bZPHOIdY6ABklHc3dFnGxtGBwC02EwY2
         +vEMBkw/f3ymqZG5gg+5F4x+feO8IGCmzyBWtZ10BLuGTI3Lcid68VnHZpjz3tpappoU
         nus2CQyYFsvCqXzxXQ8z5hHfp/lQ+6G0VKKca/7ULAMmCZJclI97Vd9c9ZVg2TjZVVGH
         Pwpr1YsxzFlPUgjFuFE7KgYGWLLESq4ceWMXNOnKPO1h9G9QK38u1pVmAHIDV+IQYC7H
         IvMQDLqlQfbw4QrD0nGQZWsYZ8UJC+/7kNv0JEHAf/WtrnwcWL6Pye1Xsz/x+JrptJyz
         DqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WWGEc85+KcM+sGpnyTytKb3X6CvK3FAE9bn+Wq10lGo=;
        b=EHVf1UPd/xMKMN1q5xAdb4yLnnXY4bw4bqPme7VtYKy4lYcE2wtZJRooFJj0uOa9bS
         NaMWqLdXgzn61GY7lomtDliPyIxZ/N1Wt90NIdaNtAB/Pq4jZWXJtzEYLYjtcfgUWrik
         cWYTciG+nlmyAohDG7iu9cju5hbIDtYZE/x7bNTkUaINVFGcGDap6IJjmqroK3RqmG+u
         LAK6/Hr8oWqp7ZFejSQD5J5YkQ2WMED2O18/HI3QqfC8aWuEkeIfDbhNpEOHIMFfyemk
         DzE5JPxV3+4z0fY+fkZDoASVm5woJnX4IQkYG7FrkKWoW1mtJytuYDbQu6FbvtefwMN2
         Q+lQ==
X-Gm-Message-State: APjAAAV3Y7MbQogjrQPHPmUX5W//EEFSrKCN2W76WJKSG8CP1+ou5NBe
        POWYQHMgkEeCmSRNwAWWwwgBSjq8ZtY=
X-Google-Smtp-Source: APXvYqzMkKzDz3Dog5p8KaalqQ3tG0sJuebo50vTJTT3XtXtN5R8NONYkk4ffIqqAFEDwHtpP0hc5w==
X-Received: by 2002:a62:ae17:: with SMTP id q23mr54443120pff.2.1574959812598;
        Thu, 28 Nov 2019 08:50:12 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:12 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 09/17] clk: stm32mp1: add CLK_SET_RATE_NO_REPARENT to Kernel clocks
Date:   Thu, 28 Nov 2019 09:49:54 -0700
Message-Id: <20191128165002.6234-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128165002.6234-1-mathieu.poirier@linaro.org>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

commit 72cfd1ad1057f16fc614861b3c271597995e57ba upstream

STM32MP1 clock IP offers lots of Kernel clocks that are shared
by multiple IP's at the same time.
Then boot loader applies a clock tree that allows to use all IP's
at same time and with the maximum of performance.
Not change parents on a change rate on kernel clocks ensures
the integrity of the system.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/clk/clk-stm32mp1.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 851fb4e9ac44..8e25ed62f67b 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1286,10 +1286,11 @@ _clk_stm32_register_composite(struct device *dev,
 	MGATE_MP1(_id, _name, _parent, _flags, _mgate)
 
 #define KCLK(_id, _name, _parents, _flags, _mgate, _mmux)\
-	     COMPOSITE(_id, _name, _parents, CLK_OPS_PARENT_ENABLE | _flags,\
-		  _MGATE_MP1(_mgate),\
-		  _MMUX(_mmux),\
-		  _NO_DIV)
+	     COMPOSITE(_id, _name, _parents, CLK_OPS_PARENT_ENABLE |\
+		       CLK_SET_RATE_NO_REPARENT | _flags,\
+		       _MGATE_MP1(_mgate),\
+		       _MMUX(_mmux),\
+		       _NO_DIV)
 
 enum {
 	G_SAI1,
@@ -1952,7 +1953,8 @@ static const struct clock_config stm32mp1_clock_cfg[] = {
 	MGATE_MP1(GPU_K, "gpu_k", "pll2_q", 0, G_GPU),
 	MGATE_MP1(DAC12_K, "dac12_k", "ck_lsi", 0, G_DAC12),
 
-	COMPOSITE(ETHPTP_K, "ethptp_k", eth_src, CLK_OPS_PARENT_ENABLE,
+	COMPOSITE(ETHPTP_K, "ethptp_k", eth_src, CLK_OPS_PARENT_ENABLE |
+		  CLK_SET_RATE_NO_REPARENT,
 		  _NO_GATE,
 		  _MMUX(M_ETHCK),
 		  _DIV(RCC_ETHCKSELR, 4, 4, CLK_DIVIDER_ALLOW_ZERO, NULL)),
-- 
2.17.1

