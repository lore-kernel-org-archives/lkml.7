Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6267BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2547E2073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlW/Wke8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfLCFXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 00:23:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34639 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfLCFXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:23:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so1130498pgf.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 21:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dPgz2TLGaXm8AZ5IU/e4WWLoSFiMiQO40kFKZ/olifE=;
        b=RlW/Wke8DNfq5+TindW3a7DNLR09DVaesqF1xwIrlU7rF0EUhASXBKcdEv9gChCMzZ
         XYOazRvnQp5BEKikwNaDgdpOXqIZGn3q6lanaKG0VVk49ZOEbdZeDfoipfCq5ELIMQj1
         l+zmNmnCi30CeiFDdCpZFNLjVkhEZwrSF5TTeCJsP86nGSsRgQFi17NQBUwsLWN3lPG4
         XYVktpX4JahsUhum0NFi75QXwlGDhJzOsawFqpujLOvLJB5PyoyN6ODaS4V7T8uSFZTh
         //laIC4A0qj7KfbwbD+XBv++Ues5+BnYRmsODvf/kbCaKBOLc+fIzic6drSvmxvM7SDf
         z2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dPgz2TLGaXm8AZ5IU/e4WWLoSFiMiQO40kFKZ/olifE=;
        b=Da5i5HgyO1q0yr6pEZJBzlzMIDMiocfx48/x5lOlqkw3/9UIKTNsMk4hY9BgH+9mL+
         uhZgVpZL+E74VcZHN4o1Q+BxEdev4tYd+pfiI+x5pMxXyp7zbhBusKAQl5NOt48on8hJ
         /YFmjS0FTyLpgc0WxkBGdbQP8E+7+aCguA2GmJ0CU5ae5PTnJmMON85wcdSxFDLVEAoc
         or7JuanEBzAkV3Lbiz7swYa7tcd9Fskicz+WJ9fGHyILpvg6v5eG2WHDtE+VJQg94q90
         0THOULkhmiWDvEz2/Bxf4iWWM692r78VXVLZcBQTrBdDDGyQmaFQm+59riaAz5BQBn0D
         qKsw==
X-Gm-Message-State: APjAAAXDr7IJF6hFNQVplQmPfaAvl/QVF0i4D9vK5qZCrp4pKjdEeCKA
        jxNLrIOI3LauDbADUNitO6y2MJ8apxcXeg==
X-Google-Smtp-Source: APXvYqylmspoWJ46AcNlcJaiTcm8u1XOhBNgM1Yg5iDosjeRJVqyvHVAbi4h9+HiQGANGd2ojEB1+A==
X-Received: by 2002:a63:f006:: with SMTP id k6mr3420716pgh.380.1575350631471;
        Mon, 02 Dec 2019 21:23:51 -0800 (PST)
Received: from localhost ([14.96.109.134])
        by smtp.gmail.com with ESMTPSA id f10sm1388888pfd.28.2019.12.02.21.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 21:23:51 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 4/9] drivers: thermal: tsens: Release device in success path
Date:   Tue,  3 Dec 2019 10:53:25 +0530
Message-Id: <b8a2349eb80a4992d386b05fcde9a7a32bf9850b.1575349416.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't currently call put_device in case of successfully initialising
the device.

Allow control to fall thru so we can use same code to put_device and
return error.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 1cbc5a6e5b4fd..e84e94a6f1a73 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -687,8 +687,6 @@ int __init init_common(struct tsens_priv *priv)
 	tsens_enable_irq(priv);
 	tsens_debug_init(op);
 
-	return 0;
-
 err_put_device:
 	put_device(&op->dev);
 	return ret;
-- 
2.17.1

