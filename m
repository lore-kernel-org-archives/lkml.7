Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB58C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BD422CBD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LuEiCvOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391148AbfGYKnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:43:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33730 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390947AbfGYKnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:43:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id x3so34275363lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XpjNV+NMvqH+LpxRr8zkgoFmR2noH7509JIlqZCM7Jo=;
        b=LuEiCvOTvkInrAJWj0qXwyO7s1XERMW8pSHDK9VY8URGrgn87S6FUMVEr2HzEseoOu
         zaDVbiiW9I23Fgh2QSHf1EZlrKDkmPx7Wq6kJDhk7VFAK1wcZIOVxD6ap20Fu/3yRdRx
         /TWUX7b+bStIY8r7lf8sa1a0ZlHkmTSqACVxT8uWuzocM59uEODdNdLVaX6XRsII+FsG
         m+IZuwTahGkX8H94lXNw5tuJTVviQyqconFH/rt08Asg49Y8RKcYpimAhkcIUM70Deb9
         I0D+N6VMKBzMvzBkcjj9UVykkwPty3g7gzMTfs+i03HK4dOv4ND6qXSMzfG2oxGwnOZF
         4Wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XpjNV+NMvqH+LpxRr8zkgoFmR2noH7509JIlqZCM7Jo=;
        b=DaEnwHikqtmCfFwj6fA6gPC0JPE6RW72eBiooGISWIdUa5e3cnpgufbF06UIkovEo5
         4kOiZtD1JfpWeOaXiq1+bLMbaV4vv04Azo6MQfzNpF9CqLGvEkTmrAfFZZKn569dGKX4
         w8nU7IwUuWJI5oo54q985luRGCK1Kw4cxrk8AvKy5dWmtTvFdDASi+/r2etm4FJwNVCl
         6gQie83MEAHBS70dkXExZX/87wc9g/OXcKEyqGJbfILPTh+7SMaNNTnjUhuYSo0cNmUX
         sRsYHGCHgdhozJq5cgjoLy0gDKoihTlf3Ea8KpiZ8ZWVh2CaESSUMQd7a7w4WXjWFcFW
         NaAQ==
X-Gm-Message-State: APjAAAWZ5guDr1Jyj00QaHy/RLwb/Lb4UCepaWG7Jqw+iy2AmAEpour6
        W3qcPVtvApZkT+k3oJD7Eyv9Mb/oFzE=
X-Google-Smtp-Source: APXvYqx5mS7anbigc+++QypZ2if88kYGJ0a5LKp93fOIM3Eqx9brqMfs5/1ZEsgOU46pHJraeSucHQ==
X-Received: by 2002:ac2:4d02:: with SMTP id r2mr39615965lfi.138.1564051390847;
        Thu, 25 Jul 2019 03:43:10 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-44-230.bbcust.telenor.se. [83.226.44.230])
        by smtp.gmail.com with ESMTPSA id 63sm9139580ljs.84.2019.07.25.03.43.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:43:10 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 14/14] arm64: defconfig: enable CONFIG_ARM_QCOM_CPUFREQ_NVMEM
Date:   Thu, 25 Jul 2019 12:41:42 +0200
Message-Id: <20190725104144.22924-15-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725104144.22924-1-niklas.cassel@linaro.org>
References: <20190725104144.22924-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_ARM_QCOM_CPUFREQ_NVMEM.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3e7618818250..9b0cc49f5fe8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -84,6 +84,7 @@ CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
 CONFIG_ARM_SCPI_CPUFREQ=y
 CONFIG_ARM_IMX_CPUFREQ_DT=m
+CONFIG_ARM_QCOM_CPUFREQ_NVMEM=y
 CONFIG_ARM_RASPBERRYPI_CPUFREQ=m
 CONFIG_ARM_TEGRA186_CPUFREQ=y
 CONFIG_ARM_SCPI_PROTOCOL=y
-- 
2.21.0

