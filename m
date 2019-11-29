Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED85C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FCB2464E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kJAnMVeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbfK2Vjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:39:48 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39311 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbfK2Vjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 16:39:46 -0500
Received: by mail-lf1-f67.google.com with SMTP id q6so542612lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 13:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0VIY072ZJlZj4z1mcJleK9agtZhmef7Eqj9dCGXoaPE=;
        b=kJAnMVeuP8snQfAobCu21qO8VB0dZHBZDPwF5pdzuZliCBWBT+7/r1Tw/t58TzPqwM
         1aa98YIogWyt2+iNcVZbXaWIIupi/Pmt+Xr0fC62sXUhkXmgmY+8c4ZreiPAW/TeXWoG
         8IzwcuIIpzDlF/3ad4TGLYYP9iY76EKv+fWvPb16UmLjI49qPVaj9BXZd+wPztIYrL90
         JYW25jtOhjy2gqXw15XYCrFv3FauXiP4hNh56HgVC7t6lAg5+2z+TNM9t9KETuSBITjy
         GHDWYit7hXxO/dGQLTO+bLl3M74QFXmppNBsE7bYL12YBUtwu7jiHCpAs3Yumc6G/IlA
         fXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0VIY072ZJlZj4z1mcJleK9agtZhmef7Eqj9dCGXoaPE=;
        b=QeiVUMekOyBBDuUkrRWnReNX5MaQFOh1Ki7w5xMuBvjFGcZkj1CzGBp9nwjdIFMjwc
         MM37aNl1K0qHlYsEmlNDXzNpUwcDgRXalHmSIOloBLhE/BQ8gmKtIyTcBMbOMWDBHfyC
         0peEKVYTsAwd8t0w8ZRKjqQDOVTI3X0aanIPg0og6wTdwEfVpZiE3lfP4ogZfn+A/8mm
         favMzPrwN9olwurdpAvUfP0H4PojrZr/E8PpgjyMMKVvbjBtfYdTFu1XWdaCmefYGFrF
         n1U4zzeEr5LbXBWk6PgD7a89+9obvUfalVK1wYoqGBA6O2eBoYzmUdX26qXCEwVvqSq7
         Xp/g==
X-Gm-Message-State: APjAAAWsQ3XU5tlNhiFgPJHccr2Udsh2u6GObWgMfXBx+tM4zDtesL39
        6OFgv7rWN/k3bOrcrQJROPZLZq7+15Dhkw==
X-Google-Smtp-Source: APXvYqyPFOJP3LbNcrnULpaVcK05GoYjbZkn25HyDBR+a/U/LXJclR53qLuaVJaE8rGEZpxPtw3NvQ==
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr36683832lfy.3.1575063582905;
        Fri, 29 Nov 2019 13:39:42 -0800 (PST)
Received: from centauri.lan (ua-84-217-220-205.bbcust.telenor.se. [84.217.220.205])
        by smtp.gmail.com with ESMTPSA id p4sm10817755lji.107.2019.11.29.13.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 13:39:42 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 4/5] arm64: defconfig: enable CONFIG_QCOM_CPR
Date:   Fri, 29 Nov 2019 22:39:14 +0100
Message-Id: <20191129213917.1301110-5-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191129213917.1301110-1-niklas.cassel@linaro.org>
References: <20191129213917.1301110-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_QCOM_CPR.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Changes since v6:
-Picked up Bjorn's and Ulf's Reviewed-by.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e76b42b25dd6..4385033c0a34 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -438,6 +438,7 @@ CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_MAX77620=y
 CONFIG_POWER_AVS=y
+CONFIG_QCOM_CPR=y
 CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_XGENE=y
-- 
2.23.0

