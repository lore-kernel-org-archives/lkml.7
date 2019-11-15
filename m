Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF871C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1BD2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbiYZOTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfKOMSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:18:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40739 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfKOMSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:18:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2so10483625ljg.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 04:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mduOSCKauFb3j3r6hILUAiEYXazQDNKgF2SjQXFQbkI=;
        b=vbiYZOTeqUAVzVDgDlbIZVeaduxvSlDcxM60I4FonIbaAMu8P1XdQ24NQzaBi3asR3
         u3A1xmlhOe/B0S+IlzLwr52sd0EYyMHb2AVYfpo31GnafFeOuR7uad/sLjQJFNhKhtbv
         Yy99j1Uq+jKfq8n509b9D0vOWHyKRHOvqOcC568u+z9SZXIF7s3RgGR8b4H6qljKQeJt
         nDeAamnSSRzVVc9l4sWNHvo7p1A/PNrNMqrYN6AgbAxqAPjKLOa4yhqY0z0bkgFjzz9S
         +NFd54bGysbeoI0hAaRlIwDD02f6Ll6SpMD4PBWcl7TqXUID02nqZ/yOTkVLBsfDbE9A
         UZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mduOSCKauFb3j3r6hILUAiEYXazQDNKgF2SjQXFQbkI=;
        b=YFzFL8goepCflVww7aNWeC80Wj2ICWu72aE/3ZxnTjHieMasQQvDmavrTQ5whJTLsz
         1j1kBroYXLWiIfpkG0yvUAfL2bF2QAQyPGm6pA90Te8yvJFALs3KgGSXpUJNRRITef5c
         +DhTHrcisxK0O8AEOT87ZDaVixH4pc6z6X12QthdS1vgpb06/mhWHbvGM8bFkH+qaopQ
         eJkp3JZmKmDj48aV05pjrSNZpz4MvENcNpM78ckSk8sdbQ5kYspGV6QxKsABM3NSCIpG
         McGRY8dKoAfZXmubL85rwERJS548A+WlSHbs0R6hf7ET5gIoN/aafkfYnKVTpwiG0sui
         zabw==
X-Gm-Message-State: APjAAAUGH5BiyAuuBvP5OE0KKGf7rD/jamrrFX6TthdcLq+xwOdCkmWK
        6c5Nilt2ADZP5VDJyRmBoA61Xqb+nzgbGw==
X-Google-Smtp-Source: APXvYqxbUCkeTtglgl2HCSMgv4Zcw5rQ0kPuIS3uqC18GHonYnsqTN47gEHHRwZaQT7gbr1LIyHSPw==
X-Received: by 2002:a2e:97d3:: with SMTP id m19mr8405280ljj.56.1573820282063;
        Fri, 15 Nov 2019 04:18:02 -0800 (PST)
Received: from centauri.lan (ua-84-217-220-205.bbcust.telenor.se. [84.217.220.205])
        by smtp.gmail.com with ESMTPSA id c16sm331070lfp.93.2019.11.15.04.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 04:18:01 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 5/5] arm64: defconfig: enable CONFIG_ARM_QCOM_CPUFREQ_NVMEM
Date:   Fri, 15 Nov 2019 13:15:42 +0100
Message-Id: <20191115121544.2339036-6-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115121544.2339036-1-niklas.cassel@linaro.org>
References: <20191115121544.2339036-1-niklas.cassel@linaro.org>
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

