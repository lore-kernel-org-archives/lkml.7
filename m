Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1087C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC10020685
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDY5Z6be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfCRTlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:41:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38751 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfCRTlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:41:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id g12so18452262wrm.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f+uCN0dtjEGnlJv3pfIkjdcZRrqjbDiHnBp4IPbDmW4=;
        b=rDY5Z6beU5to+2BGAZgeIkJkgr3wfP/KjLMRUdOpcCW6YCcJ4RivVQwKnooXBtJ2dj
         7ok/tS8E0MGmIRyTmVgHPxRcJwd/tiRKSmPIbanxJm74jm/pZ3aUUI75FRp5+v5K/aTk
         vzJp68jARltyDy5MT0btgZdSjS5LTLQuLPAVaefO6yYD3maHUd2VxrlHDHVybALZ4mpK
         5TzpsvylL5K4z+4aF+zVwWWRNby21sQ+vjjhehkTawWw9y+hheExStyuzngOL6bFP6w5
         apFCKS0evYsNOvuWmCAb6rPc8eehmHkyOGdrVFROzko5ZAx02jSkcjFrS7KFWRNA+IsB
         nZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f+uCN0dtjEGnlJv3pfIkjdcZRrqjbDiHnBp4IPbDmW4=;
        b=uKiSu0426Nz6uEFtkEp0tu0JY7G6VODssCn48Cqb/EiCpTeojPH0frE5gOq9h38Grl
         10YgG3lyWDLp6GCRGe1CG/pP8u8L52IYCrUC9OzbcyTrvVwl7rF2cfAj26Kxfqi67fxT
         0TyMcqbEuZuG+Gjru5gvrMXFZ29FY7LBqKI7D2N6ulvLMgY2FWV/l9qzTMo2VEhVJoUZ
         Xv9dNjJTWV97LU8fpbXBTutTSLaLNXOGtXcS7y0lqdUXkASfuAhBVxWTMwQRskS7eqGU
         ewEhm7rtL6nN4vivBNYNpJxTg45WbVIhX4fSYsnm6DZAIph+BW9DPcBXF5TiYC5hEXJi
         j2Sg==
X-Gm-Message-State: APjAAAWmjZOuBfgkc9zzM8zz+qdDQUlZ4UWifn1M4ZWitjimnuMGtNYV
        Dac050Xt5cJbilLBX7Tk7SMHbg==
X-Google-Smtp-Source: APXvYqx+OpyuPhR9OKH2oYNzz4yUdu4KL8pJugxaOx7zkWRlZz+b/DZpiR2HE59qYxCt/JwwY6NXNQ==
X-Received: by 2002:adf:fb82:: with SMTP id a2mr4551043wrr.214.1552938061153;
        Mon, 18 Mar 2019 12:41:01 -0700 (PDT)
Received: from localhost.localdomain (cpc89244-aztw30-2-0-cust4998.18-1.cable.virginm.net. [86.31.179.135])
        by smtp.gmail.com with ESMTPSA id s10sm4583941wrv.56.2019.03.18.12.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 12:41:00 -0700 (PDT)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, p.zabel@pengutronix.de, xuwei5@hisilicon.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     john.stultz@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        yuq825@gmail.com
Subject: [PATCH v1 6/6] clk: hi6220: use CLK_OF_DECLARE_DRIVER
Date:   Mon, 18 Mar 2019 19:38:51 +0000
Message-Id: <1552937931-23050-7-git-send-email-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552937931-23050-1-git-send-email-peter.griffin@linaro.org>
References: <1552937931-23050-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As now we also need to probe in the reset driver as well.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/clk/hisilicon/clk-hi6220.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index a87809d..952ffe2 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -89,7 +89,7 @@ static void __init hi6220_clk_ao_init(struct device_node *np)
 	hisi_clk_register_gate_sep(hi6220_separated_gate_clks_ao,
 				ARRAY_SIZE(hi6220_separated_gate_clks_ao), clk_data_ao);
 }
-CLK_OF_DECLARE(hi6220_clk_ao, "hisilicon,hi6220-aoctrl", hi6220_clk_ao_init);
+CLK_OF_DECLARE_DRIVER(hi6220_clk_ao, "hisilicon,hi6220-aoctrl", hi6220_clk_ao_init);
 
 
 /* clocks in sysctrl */
-- 
2.7.4

