Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2868DC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26BA2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5q+0xMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfKOWev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:34:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38664 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfKOWeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:34:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id c13so7336752pfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XjmHZ2r/4EcW1pjM4Rd69/tyPSpvDzWdjKn2vf5w1qY=;
        b=a5q+0xMs8tIeJh8UJ8TVx8rZWUYZ16E5HxEnB0bRUqdlVxfqcyrfWViLr9Pn7dJisY
         VqRFpH8/EN3p18o/KhB6P43Ky8JCimROhKeXLcPYbCV9IN4oJ2CVylJtMtP7qfwro7o7
         SxdF13uvII4gAOlurEJrm50rCXFufEWhRyX+jcjvLDDHPbDNOBjiwTeiV6mHv4gY2lCf
         v6zbwJPxmKb/vDqIU9Wohh6rRB9E8a5QwUHIEM0ATxuwA7uLwKPIO6cIdiBE5ysfdmSV
         afv+gI97KSg+6usaoQb/OTeraFQQt+e/l1ahp52XQnTElIh1w5nC/Zk54P7lMFFDyeem
         GE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XjmHZ2r/4EcW1pjM4Rd69/tyPSpvDzWdjKn2vf5w1qY=;
        b=S+p9kivv5dSk6HrPg2gYiKxqc3HMl9JZRRslvy0pny+ZUes05NhtJ3opAqOoFLRc8S
         gGPTZXAxReQR305Ei9lTY+whfrwu32XY/IxiqBsIgxx0YlDKyF2bFVebWY0B/QG1/6u2
         Cf8gGC0a0eZ1SVRkObZfAjxsc0AiN2Niyd3qqOSJbsSZeQ/PE/DaiP07+S16qxbGVd1n
         l2BT7lS1nTo2M98pO3DRwcZ8KF3s7QpGhlV2yvvfghYO2iJXmZOggt31Y09+OKfMRrkd
         H0ddUkJNnpgorhwI37dfP0oWhBViYsfSTSrtbPene2/6zoMBX23QRqzqr2jnNxW7mseJ
         3cEg==
X-Gm-Message-State: APjAAAVRQ3TpWtUkc6h3AiQ+oS6qatIxGqay8LPDlrADu41/gdXpCcKL
        3DgZ4P8RMXowsqgkih0zm0XDBDPyzMc=
X-Google-Smtp-Source: APXvYqx5QjFoyTLodbBskheBnK+zVxbguR/K9b4TV6wtQaQaNjBS6bpq3F/W36BhzlJQbuO0lG4qiQ==
X-Received: by 2002:a63:181f:: with SMTP id y31mr18239880pgl.186.1573857245156;
        Fri, 15 Nov 2019 14:34:05 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m15sm11699724pfh.19.2019.11.15.14.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:34:04 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19+][PATCH 09/20] clk: stm32mp1: fix HSI divider flag
Date:   Fri, 15 Nov 2019 15:33:45 -0700
Message-Id: <20191115223356.27675-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115223356.27675-1-mathieu.poirier@linaro.org>
References: <20191115223356.27675-1-mathieu.poirier@linaro.org>
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
Cc: stable <stable@vger.kernel.org> # 4.19+
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

