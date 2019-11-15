Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C14BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0262E20740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/IeUVq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfKOMRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:17:42 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45299 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfKOMRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:17:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id v8so7827684lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 04:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwPMwB2RiSUmNRM4skEo53AFmHsnpLdRklqrJ7M1CGM=;
        b=R/IeUVq5jtooBozJfg6+vEOzIjVyKvh8ynV9jDhQlqMMrafkBHAo9kMd1uOsX/2V8p
         Pkr8FRF4tISl0WyhLaYSn0aMjMS5mYul2MGQtCK/kcZ5lqD8IvaNBjBJG9SRCrZ8Pgku
         DQOAvCi0qK8sMpttXEY21rDRg4GLYIKzZnHPRmSd9z4t7pWzNtH/TeGA/+ixM/T/dwhU
         H44oJZBrBFx7nLUxam9Oj3M+pTkxSS6Gs+YvEMKh4kdjMWl278P8ROhCU/r7c7FpR13d
         iycN9Ma2jf0rlvPDGTQgfJGrEW+2O/jInKuYeVVGZDTUmN2lCXbcvZj6UIMoCGb00M0s
         66pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwPMwB2RiSUmNRM4skEo53AFmHsnpLdRklqrJ7M1CGM=;
        b=FnLeUq84fnwHN5UmjVAPfP4zEZwoCkb4K8GO+z6HIk9AOzTED5a0OZ00tX6zAulPvC
         RdJtfdkDlYTEaNnK6tcmh8Jyx92af+niex7+tkEQkz8BSecdISWJVO9FzAulyAUo9Iq4
         ZwELHL/BLTXkFSdmDe5qB5yVTFK2sl6EyVxQyQLFJdqq+UCQGBL9Q54isi/Hs6wd0meN
         3kYKE2iP3deCumX7gsmlOBNfm81XXXi94OoPNLrWZ0b/FaNaH3cOdlvfIcoeva2YbSTm
         6Tb0c+6SHRW4gXLcMKKJHTKd4xU95s9jZIgWvXNDapMLeW5qHwTSvZ5Z11rLPEwSJ2ie
         MGWg==
X-Gm-Message-State: APjAAAXpvw9HgNB+Hg5UV5++0C76h7K6mp3EfIuGFO0TveDR2UsC3m8W
        jwgaemIyErZqQsCyMcdET09a+w==
X-Google-Smtp-Source: APXvYqzdc5fuKqfou46ifmV2Mw6UXjuQyNPexWnBdQPEUi4aFQIDIPm0q0tNU5Y3xbZP1CVo6yViyg==
X-Received: by 2002:a19:c514:: with SMTP id w20mr11215839lfe.143.1573820258087;
        Fri, 15 Nov 2019 04:17:38 -0800 (PST)
Received: from centauri.lan (ua-84-217-220-205.bbcust.telenor.se. [84.217.220.205])
        by smtp.gmail.com with ESMTPSA id y18sm4107961lja.12.2019.11.15.04.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 04:17:37 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     amit.kucheria@linaro.org, sboyd@kernel.org, vireshk@kernel.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/5] Add support for QCOM Core Power Reduction
Date:   Fri, 15 Nov 2019 13:15:37 +0100
Message-Id: <20191115121544.2339036-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Core Power Reduction (CPR), a form of
Adaptive Voltage Scaling (AVS), found on certain Qualcomm SoCs.

This series is based on top of the qcs404 cpufreq patch series that
hasn't landed yet:
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=173423
as well as that series' matching device tree changes:
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=165457

CPR is a technology that reduces core power on a CPU or on other device.
It reads voltage settings from efuses (that have been written in
production), it uses these voltage settings as initial values, for each
OPP.

After moving to a certain OPP, CPR monitors dynamic factors such as
temperature, etc. and adjusts the voltage for that frequency accordingly
to save power and meet silicon characteristic requirements.

This driver has been developed together with Jorge Ramirez-Ortiz, and
is based on an RFC by Stephen Boyd[1], which in turn is based on work
by others on codeaurora.org[2].

[1] https://lkml.org/lkml/2015/9/18/833
[2] https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.10/tree/drivers/regulator/cpr-regulator.c?h=msm-3.10

Changes since V4:
Implemented review comments from Stephen Boyd.
Removed suspend()/resume(), since they did the same things as ->power_on()/
->power_off() genpd callbacks.

Niklas Cassel (5):
  dt-bindings: power: avs: Add support for CPR (Core Power Reduction)
  power: avs: Add support for CPR (Core Power Reduction)
  arm64: dts: qcom: qcs404: Add CPR and populate OPP table
  arm64: defconfig: enable CONFIG_QCOM_CPR
  arm64: defconfig: enable CONFIG_ARM_QCOM_CPUFREQ_NVMEM

 .../bindings/power/avs/qcom,cpr.txt           |  130 ++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  132 +-
 arch/arm64/configs/defconfig                  |    2 +
 drivers/power/avs/Kconfig                     |   15 +
 drivers/power/avs/Makefile                    |    1 +
 drivers/power/avs/qcom-cpr.c                  | 1755 +++++++++++++++++
 7 files changed, 2035 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
 create mode 100644 drivers/power/avs/qcom-cpr.c

-- 
2.23.0

