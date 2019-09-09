Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5517C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFDF2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="elru8+rT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389579AbfIIIyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:54:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40841 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfIIIyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:54:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id t9so13624938wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 01:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=93tDfN83mQsd0DPVLc0brfVYsJhwPv42JzLgK6vCzz4=;
        b=elru8+rTyxJnAkRhSgpCtGKhvAzkZlMgML1O+PjWOVzMhVAwGdF9mdMl17yIKWinbF
         Pyy6PK6nwfQV5XGO52F6rddjfLoTuo42XyaL8+vXtJxbuvOKtoETYTCgowHJU7dGBtaZ
         yDFVoVhq0NiwV8DC3DNqEKBbhS0xYPVmxfqacrxJcuOC+lqP1wI4v4jR3kpLPvkeNfgJ
         MMpU8LbFzSZ8+v+24aIyPlKotBw+kF87nnHbIrvLu9gISBhkJsGqrFJnZvT1DRHajBkP
         wPRdWm4WWfuVQYLL6SxMeATk/Z2Y1tisSr9TtcTvz8TOBWamw9eYO9oMfOZS3fCyKtdt
         pUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=93tDfN83mQsd0DPVLc0brfVYsJhwPv42JzLgK6vCzz4=;
        b=U5kCniZOZE6bqp2MFYO8aQT9FDEAg51bdUFk1dB950g7FlKgo97Y8FSLAvbuH9DBOD
         2uixeffb/IOLQaLT8z46cavXI1s32fodUeU8/rMOw0qqwPm405byn+t0NhFHSQUY7Uz7
         kLvKSmgesEjCxrRTgu+Mp2u8zLB9yYnjlXiTubyV4wbmaO5NSF5/uDjDG38UZmNMDik6
         kxlwN6AOrY8oPA8rvz54rRFEodTv/HJ7VpCW0EUMiUmQu1NDTyaHGgeKtd3KN2lJdEVC
         JBcJF+S2saUsRSBsyF1wlsjFhKs0z8Jnfk5r+0jAURtHRKkaJ3QY9uoKshVhVyUcdusX
         9vsw==
X-Gm-Message-State: APjAAAXcOixZ93znZujRbS0dSYW2z/nEsPiOukKJBooy1jWlOnUAgYFp
        XwMEpLr7aZT2/2Xn01LjpcegoQ==
X-Google-Smtp-Source: APXvYqwNLAGFJD/5uFgLmvZMGl1fB1pcIoE/EBBaGXx9m7Z80mi6LrNWXEAXrgLH7W7MUpCzjsy0oA==
X-Received: by 2002:a1c:98c9:: with SMTP id a192mr18219335wme.29.1568019274219;
        Mon, 09 Sep 2019 01:54:34 -0700 (PDT)
Received: from localhost.localdomain (69.red-83-35-113.dynamicip.rima-tde.net. [83.35.113.69])
        by smtp.gmail.com with ESMTPSA id r17sm13265220wrt.68.2019.09.09.01.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Sep 2019 01:54:33 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: qcom: fix QCS404 TuringCC regmap
Date:   Mon,  9 Sep 2019 10:54:30 +0200
Message-Id: <20190909085430.8700-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max register is 0x23004 as per the manual (the current
max_register that this commit is fixing is actually out of bounds).

Fixes: 892df0191b29 ("clk: qcom: Add QCS404 TuringCC")
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---

 v2: add Fixes tag
 
 drivers/clk/qcom/turingcc-qcs404.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/turingcc-qcs404.c b/drivers/clk/qcom/turingcc-qcs404.c
index aa859e6ec9bd..4cfbbf5bf4d9 100644
--- a/drivers/clk/qcom/turingcc-qcs404.c
+++ b/drivers/clk/qcom/turingcc-qcs404.c
@@ -96,7 +96,7 @@ static const struct regmap_config turingcc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
 	.val_bits	= 32,
-	.max_register	= 0x30000,
+	.max_register	= 0x23004,
 	.fast_io	= true,
 };
 
-- 
2.23.0

