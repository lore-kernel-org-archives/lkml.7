Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5BCC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625EA21739
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWoQEcDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfK1Quw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:50:52 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43403 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfK1QuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id b1so13124559pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=as0Dyqn9IW+Ib7FMH96nGeZ/5dUyDxEzw1IqFd6RcLM=;
        b=LWoQEcDUQHLetfKW6rW+t+LDD68rLNVYtb+J/5JvQjwdW2aCkD/yjcH+jbfyVtvH1P
         B+MXWFYRYwnd2grVFtyCK+NLuTWUPp1CmRnK1PxI/7J2Wet8vuP/tJwaPXyOeZfxp7Ji
         ZGgpo5WHMLI1xBw4tmsfd68A6ZnNXU/qJWUVCMaZFYsDsJlKGlnEjQzSGBjQFJac7zMB
         OFMCPKhQ3B6QDBzyULAvAf0RMWkl1CqZZo+beISxzWF4HTJLMQw8m+3FOr8RT6Ho7QIJ
         hu2J9gKiVLmU5Pj2CQO7JTKe/GIPgLr/gGT4FzH6qh6IzCdis72ohSNzRZTtpnVdQOJD
         lTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=as0Dyqn9IW+Ib7FMH96nGeZ/5dUyDxEzw1IqFd6RcLM=;
        b=iCUlTpH78BB/u96yqs79GNs0LBgTMlfvkS6pPzkS3D658b6RUdh/ejqlJRCw4ShXu+
         4z6NOslGnUv6awa0YZ9k0dlOVLnv2q7JMU/piELufAlYBVoab9zBzuUOclKKOkozeLaE
         UOMen76+khra9CVcnDSc76+rH8arFoixGQqriOsGBlO9yo2ueqXzHOYYrNA33NJypyul
         ierZTDI9QxnFBZJ5QLriV5NtGeNTL6ejrtfZdh8mLAPM1/jvOjaZcFS6HItC4Va6l4Ms
         y6LeZ2h9RF0GfN5s5JX64MI8kRRjiGuN91n5RbrQZHvvBc69jzizO0AwJom6y4581wjd
         /hfw==
X-Gm-Message-State: APjAAAXqXf9oforEfbwKZpA3IurG4wwBkv0AEUox+CO+sYDRc19dWQXq
        7b+6ZKvpnW0kXn8hqhc8udRrPw==
X-Google-Smtp-Source: APXvYqwOnLS/7vwFXdBkF6U47M0v/d+v//XHzDBLADouTpgt0wZSZX1ch2wKxZSEtHp3izvH+R2zKw==
X-Received: by 2002:a63:cc05:: with SMTP id x5mr12334748pgf.141.1574959810877;
        Thu, 28 Nov 2019 08:50:10 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:10 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 07/17] clk: stm32mp1: fix HSI divider flag
Date:   Thu, 28 Nov 2019 09:49:52 -0700
Message-Id: <20191128165002.6234-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128165002.6234-1-mathieu.poirier@linaro.org>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

commit d3f2e33c875de5052e032a9eefa64c897a930ed1 upstream

The divider of HSI (clk-hsi-div) is power of two divider.

Fixes: 9bee94e7b7da ("clk: stm32mp1: Introduce STM32MP1 clock driver")
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/clk/clk-stm32mp1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index a907555b2a3d..d602ae72eb81 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1655,8 +1655,8 @@ static const struct stm32_mux_cfg ker_mux_cfg[M_LAST] = {
 
 static const struct clock_config stm32mp1_clock_cfg[] = {
 	/* Oscillator divider */
-	DIV(NO_ID, "clk-hsi-div", "clk-hsi", 0, RCC_HSICFGR, 0, 2,
-	    CLK_DIVIDER_READ_ONLY),
+	DIV(NO_ID, "clk-hsi-div", "clk-hsi", CLK_DIVIDER_POWER_OF_TWO,
+	    RCC_HSICFGR, 0, 2, CLK_DIVIDER_READ_ONLY),
 
 	/*  External / Internal Oscillators */
 	GATE_MP1(CK_HSE, "ck_hse", "clk-hse", 0, RCC_OCENSETR, 8, 0),
-- 
2.17.1

