Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4247C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA616218A3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iV/bDXXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfGEJ5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:57:47 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34018 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfGEJ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:57:46 -0400
Received: by mail-lf1-f66.google.com with SMTP id b29so5977553lfq.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jfb8N34fRP1vMCo/Q4EmvhjgMM4QUZHFL/DkTTJzvfw=;
        b=iV/bDXXGIF2SCjKP+mvbagzIEpJnRgeHAciZAGW4BAO+x7mUbVcnb6ujCII0qEIvag
         B+9nuDksqPI0mCEFf75sXKlOCwbGaD06VAJKLym1HR6+vEmcMdSgMufD1qQ/UigCRXAc
         ptdXpUj40ht00oZMamy9VwDHzoqUG68PoDxL4ROV3wu5aCujWyY/WunfDhJQCaz9ynJl
         N/1kQdYUCXSx9Fm84Zt8RYZkiAtS9DpsG2O3kzNO9PkNVw3QFS+N6aIUajmN8tWvEanV
         HZ6NUpwwyn1yxwN8ZDmnb1hLDsHVF3pcTl+e2zwIfycP/z9LpD7+CsDS58kkqjo2//QY
         wm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jfb8N34fRP1vMCo/Q4EmvhjgMM4QUZHFL/DkTTJzvfw=;
        b=MphmVGct3Ce7nwXAUmJzbPcnIWJYuompzZLUL2E8aLwPqvGjFNGZZG8pVT4NrH97WZ
         LoB0SknNg9JdwgXEfJZfGBTy2CddFi8uGHnHWwnKmV9lkoIxeVCX1XULVpMVabuaeCY9
         inEeScNrLnc2McqN/Bm7U4+ClDj0h2C/LA75cbpGtayNz6Av5irjkBAIbE9J3w33NTMY
         rr9J+HRMQQ1SRKp9EcKqwqVt/VMD/DSE5vUJM6y1gXB0bDbKT2H9cEeUVZ8b40hxBvm4
         97ZdAaDE1bHN3LfH7dSZDD5KD10sugO7I9phoL4fhalim06tCDiwV6R7fCN/+V1jdeNG
         2Ghg==
X-Gm-Message-State: APjAAAX2BERUTbWXvToriWBIChzBJo0ZGCxURFrJInUaqkGZBErotTc5
        9mdQMtsh2aCQ7HYwOBKqwk4YFQ==
X-Google-Smtp-Source: APXvYqx9EhPfIFQ2thFYyWS7eAeKd9dHNJjeDKHsaKcMgIIIDNLz6k1LLpbOBztfQBHbBqX0PbK42g==
X-Received: by 2002:a19:9111:: with SMTP id t17mr1532125lfd.113.1562320664397;
        Fri, 05 Jul 2019 02:57:44 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-34-119.bbcust.telenor.se. [83.226.34.119])
        by smtp.gmail.com with ESMTPSA id q2sm1298364lfj.25.2019.07.05.02.57.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 02:57:43 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/13] Add support for QCOM Core Power Reduction
Date:   Fri,  5 Jul 2019 11:57:11 +0200
Message-Id: <20190705095726.21433-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
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
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=137809

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

Jorge Ramirez-Ortiz (1):
  cpufreq: Add qcs404 to cpufreq-dt-platdev blacklist

Niklas Cassel (10):
  dt-bindings: cpufreq: qcom-nvmem: Make speedbin related properties
    optional
  cpufreq: qcom: Refactor the driver to make it easier to extend
  dt-bindings: cpufreq: qcom-nvmem: Support pstates provided by a power
    domain
  cpufreq: qcom: Add support for qcs404 on nvmem driver
  dt-bindings: opp: Add qcom-opp bindings with properties needed for CPR
  dt-bindings: power: avs: Add support for CPR (Core Power Reduction)
  power: avs: Add support for CPR (Core Power Reduction)
  arm64: dts: qcom: qcs404: Add CPR and populate OPP table
  arm64: defconfig: enable CONFIG_QCOM_CPR
  arm64: defconfig: enable CONFIG_ARM_QCOM_CPUFREQ_NVMEM

Sricharan R (2):
  dt-bindings: cpufreq: Re-organise kryo cpufreq to use it for other
    nvmem based qcom socs
  cpufreq: qcom: Re-organise kryo cpufreq to use it for other nvmem
    based qcom socs

 ...ryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} |  125 +-
 .../devicetree/bindings/opp/qcom-opp.txt      |   19 +
 .../bindings/power/avs/qcom,cpr.txt           |  193 ++
 MAINTAINERS                                   |   13 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  145 +-
 arch/arm64/configs/defconfig                  |    2 +
 drivers/cpufreq/Kconfig.arm                   |    4 +-
 drivers/cpufreq/Makefile                      |    2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |    1 +
 drivers/cpufreq/qcom-cpufreq-kryo.c           |  249 ---
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |  351 ++++
 drivers/power/avs/Kconfig                     |   15 +
 drivers/power/avs/Makefile                    |    1 +
 drivers/power/avs/qcom-cpr.c                  | 1839 +++++++++++++++++
 14 files changed, 2692 insertions(+), 267 deletions(-)
 rename Documentation/devicetree/bindings/opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} (87%)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
 create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
 delete mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c
 create mode 100644 drivers/cpufreq/qcom-cpufreq-nvmem.c
 create mode 100644 drivers/power/avs/qcom-cpr.c

-- 
2.21.0

