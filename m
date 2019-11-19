Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80523C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5738B222CD
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oScf9xUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfKSPqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:46:51 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38343 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbfKSPqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:46:49 -0500
Received: by mail-lf1-f67.google.com with SMTP id q28so17464675lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 07:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mduOSCKauFb3j3r6hILUAiEYXazQDNKgF2SjQXFQbkI=;
        b=oScf9xUteMXLAaLWoQ9x7ikhUGemCzDuLtClzRtrvXBEdZGSuhXeNXEEdc7fM0cPZZ
         4EDzkAg1qWI22+1VoUASkJ+ROGdGPVCpN4BoYYRsCqJsN1Y9bXI2+dKM1O20J3P8j1Bq
         30GIhWMcWSrZST5tojyirpAFUaSdQuCX1JLuODW2s6UFkzU3yYaclLSC13nSNFVzOwLD
         DASJvz9uCmPLIbatmly0lQPMHleMB/YeB3OLoobHf5Frz4nc/w+vvmiydL6sp8bizT9U
         0YPAno8EssdUUfIu9+W0qmu4dwc73hHvxx5YX5H0SUH6Fj1ixhctz/jZeuDo3znjjnIl
         EG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mduOSCKauFb3j3r6hILUAiEYXazQDNKgF2SjQXFQbkI=;
        b=hq74I7MH8GEMvF5kaf14DuUpkdM6PN9uPprzg9V/D7ClAau5jgKPB7ovxK0dOKsM4s
         eiEIxRxrKZKwDvbaZXUlqoN+yeP6nJ49cOZFzzlt01UaGWtgZUzMYMaiV7H0wARQck/6
         m6iYJ7hhRTE4MShUcOOS4RTyh7rGlWcA2N4sXB9ab8QXSNh8cliRg5dW20BfzBZV85rM
         8EoeGtvpRKZCHCehsTNIZWf7dTk+O6P9AL4oRpbRbCw8ZXgMtPgKncwdYaD1ipaXC9Gu
         BrIswgwNWhHQEE+/whEzHk5YJfDOqzkj2h2mmfC5540Gj2yuapd+fObww3TdLSxL6HIA
         XCVQ==
X-Gm-Message-State: APjAAAV3oMvM2sfd8v5vnT1aJA3I92IQWSpTR75xK999Ji0vxJ5jcyi6
        kN02YIqOVbd4HyuARfixdVygRt+VgdqK6g==
X-Google-Smtp-Source: APXvYqzaxxG5ZqNc8iYg/clzpbHW2UpP3WOKI6lRquEhvqf/7jQ8UnBV+TmnjBteY/kPGirgoc7JKg==
X-Received: by 2002:ac2:434f:: with SMTP id o15mr4442152lfl.190.1574178406942;
        Tue, 19 Nov 2019 07:46:46 -0800 (PST)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e14sm10128803ljb.75.2019.11.19.07.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 07:46:46 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 5/5] arm64: defconfig: enable CONFIG_ARM_QCOM_CPUFREQ_NVMEM
Date:   Tue, 19 Nov 2019 16:46:20 +0100
Message-Id: <20191119154621.55341-6-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191119154621.55341-1-niklas.cassel@linaro.org>
References: <20191119154621.55341-1-niklas.cassel@linaro.org>
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
index 4385033c0a34..09aaffd473a0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -88,6 +88,7 @@ CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
 CONFIG_ARM_SCPI_CPUFREQ=y
 CONFIG_ARM_IMX_CPUFREQ_DT=m
+CONFIG_ARM_QCOM_CPUFREQ_NVMEM=y
 CONFIG_ARM_QCOM_CPUFREQ_HW=y
 CONFIG_ARM_RASPBERRYPI_CPUFREQ=m
 CONFIG_ARM_TEGRA186_CPUFREQ=y
-- 
2.23.0

