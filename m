Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0004C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2202077B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vy1vJB4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfKOMSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:18:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35089 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfKOMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:18:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id r7so10486776ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 04:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EKKyPkgTIrUgJLfJdMi3ez4CUNaFpld4hIHRZMCg8t8=;
        b=vy1vJB4N1Afx8NhpJeEBnSR0cw/HleAoP92rEem7iYYrvxLZnzNIXlWVL5HWZV2Unq
         VN0Oh0tPfXotXABobmT2vd2sB6RRYvHlGRi4PJBCLt8aEYiF644ZRUwGpdiRjN+bRx1R
         xXYvYVsusGIMVYU1E53jvUhQg8Ulsuuzle+kgSYZ2GGofnQZYE4tlVffFUrAhG+YslzW
         mt+IF3G8GGbVGJpJWrimUxPKQ9ZhqlwfJsaySAQSz9p45HEmf0Qi17HYAr18XZWDAIG/
         AD1iM7XZ4RGsomT8OKw3stAH7P71rqqufUvrkSjGzD4Z+TzolbGjwgmn0DB0iygicw6H
         G2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EKKyPkgTIrUgJLfJdMi3ez4CUNaFpld4hIHRZMCg8t8=;
        b=EqpOBSo4s6KkrmEML8kv0ddhwoGWMbNCzppJIxjNW6WN5YtBljaqPZ4+Q4WOKyW4Mh
         kO0uvOrAUZ/TnVL7pmQLn6xJRBGozYkpBcQ8mUCdxeWT4jw2mtRQs3KweQZD3av0J5nx
         WkjIO/8R4LJeTuup0MY1hIWRpZLop9ibAuYn6X9dlGpYmJHsKkUqmBdTUWsgnHSxIDL3
         SpPmlCyWfhc2xO6YS82eapV3ZeTGoIHm+audcz1tIxZWnlAlvlFmdYJbGqrkEfcVk4ri
         wY03tSfup5cwq6lllhs8uRpz06H5E/i/xXRu2/M+8fWPKTiS4tqSOtgddmX210elxawM
         Cz3Q==
X-Gm-Message-State: APjAAAULllmZBvfUan869wDEe3veoc4fcltCQk+yWMGGw+SmmsrIf9Lv
        BGEDeZf4FlrBpxDKRMI2B1DuIt3nqGe1OQ==
X-Google-Smtp-Source: APXvYqyc7/njB2TOHQ/xxoQ3GlfB7ZlZuoZFAdFYf7PUCmHsOp/ClIPMEE+HE5YoWIok2S22oIMusQ==
X-Received: by 2002:a05:651c:20f:: with SMTP id y15mr4870369ljn.31.1573820280621;
        Fri, 15 Nov 2019 04:18:00 -0800 (PST)
Received: from centauri.lan (ua-84-217-220-205.bbcust.telenor.se. [84.217.220.205])
        by smtp.gmail.com with ESMTPSA id c16sm331070lfp.93.2019.11.15.04.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 04:17:59 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 4/5] arm64: defconfig: enable CONFIG_QCOM_CPR
Date:   Fri, 15 Nov 2019 13:15:41 +0100
Message-Id: <20191115121544.2339036-5-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115121544.2339036-1-niklas.cassel@linaro.org>
References: <20191115121544.2339036-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_QCOM_CPR.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
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

