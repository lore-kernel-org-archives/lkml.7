Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61260C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C91520855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s74VQzUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfDDFJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:09:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41130 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDFJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:09:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id d1so541769plj.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 22:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RmLw52QFU499QKVl87l87i+PamhSMMPdT6L4OvZV0xs=;
        b=s74VQzUV6jI0Up6hSBwt3N5+5HN5nhbt6HGjVf4SCrSEAZReV6gHPJoU7RHozRreXc
         lEsT8cR2bdDQsJeQOm9v5PtFp+vu/hXbw4Qb2gAbmRNPkCuIcp4E8htdEm6NLVMT8YOq
         EDiUySLXP69T8O9zIphOwFrJXkzbIcFzWIIowjJZAnZs96/MZUk3p2NFJ0T9OSEkiyKw
         MIV0e3shFgOPYTHVay9iqdB5I/qaAnrAaN9mm20rfvRomG+9+YMDOcKkVDgoPYwLSA1q
         kcsy1WazMxNReWyKRzx1NL3yvmFQJozYDVljgudNVhV2RnudxyMsY7mG7GNIKsYBeRT0
         l0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RmLw52QFU499QKVl87l87i+PamhSMMPdT6L4OvZV0xs=;
        b=tUbyoMBJ1da/SzH5S0TOA9SrgxXqIkz8xHOlQHMA1J5Fph+ukaa8dExjEq/Bs5tCFK
         MAgy1uNEkG8D/p4UlkXteIzhACYMG6geCW74Q9py/7+ZV1hlC7ohaOGHa/94UnLUS9fP
         BNFVb4GyCPEofSbZGUVCe0vcRmsWQ4E6OVwShgmU3LZeZ/ctqBYmAVfN2T+acZCDRqbf
         OcO3USVA8IwCmYSkkZ+3OmKeJpH/quZxTlxHR9Hgjyi2ECvh17jdJtE4q9KIOGJOKrkL
         7CVcsaGUlr1RqpP0uh6mx8uNsU9cLjAKWQXdAr0ikjsiUmHgULWKZBUbs2n4YwvS5kFY
         Mkxw==
X-Gm-Message-State: APjAAAUxvG01K4WK+uFyPDweW9X9WHCzbQSa+zN6gBl9yHf9/bmssMJj
        T2l7FMC+IfjfteRBhmqCChLnEg==
X-Google-Smtp-Source: APXvYqxqN+KLVFxYgy264UzIeI1iplNzLTXCtrNlt8hHPZTOfHToDJQ6bYVRjOTpjn30vi7VCnBW4Q==
X-Received: by 2002:a17:902:9a83:: with SMTP id w3mr4256626plp.241.1554354583598;
        Wed, 03 Apr 2019 22:09:43 -0700 (PDT)
Received: from centauri.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id a129sm50589089pfa.152.2019.04.03.22.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 22:09:42 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jorge.ramirez-ortiz@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        devicetree@vger.kernel.org
Subject: [RFC PATCH 0/9] Add support for QCOM Core Power Reduction
Date:   Thu,  4 Apr 2019 07:09:21 +0200
Message-Id: <20190404050931.9812-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a first RFC for Core Power Reduction (CPR), a form of
Adaptive Voltage Scaling (AVS), found on certain Qualcomm SoCs.

Since this is simply an RFC, things like MAINTAINERS hasn't
been updated yet.

CPR is a technology that reduces core power on a CPU or on other device.
It reads voltage settings from efuses (that have been written in production),
it uses these voltage settings as initial values, for each OPP.

After moving to a certain OPP, CPR monitors dynamic factors such as
temperature, etc. and adjusts the voltage for that frequency accordingly
to save power and meet silicon characteristic requirements.

This driver is based on an RFC by Stephen Boyd[1], which in turn is
based on work by others on codeaurora.org[2].

[1] https://lkml.org/lkml/2015/9/18/833
[2] https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.10/tree/drivers/regulator/cpr-regulator.c?h=msm-3.10


Jorge Ramirez-Ortiz (3):
  drivers: regulator: qcom_spmi: enable linear range info
  cpufreq: qcom: support qcs404 on nvmem driver
  cpufreq: Add qcs404 to cpufreq-dt-platdev blacklist

Niklas Cassel (5):
  cpufreq: qcom: create a driver struct
  dt-bindings: opp: Add qcom-opp bindings with properties needed for CPR
  dt-bindings: power: avs: Add support for CPR (Core Power Reduction)
  power: avs: Add support for CPR (Core Power Reduction)
  arm64: dts: qcom: qcs404: Add CPR and populate OPP tables

Sricharan R (1):
  cpufreq: qcom: Re-organise kryo cpufreq to use it for other nvmem
    based qcom socs

 ...ryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} |   16 +-
 .../devicetree/bindings/opp/qcom-opp.txt      |   24 +
 .../bindings/power/avs/qcom,cpr.txt           |  119 ++
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  152 +-
 drivers/cpufreq/Kconfig.arm                   |    4 +-
 drivers/cpufreq/Makefile                      |    2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |    1 +
 ...om-cpufreq-kryo.c => qcom-cpufreq-nvmem.c} |  197 +-
 drivers/power/avs/Kconfig                     |   15 +
 drivers/power/avs/Makefile                    |    1 +
 drivers/power/avs/qcom-cpr.c                  | 1777 +++++++++++++++++
 drivers/regulator/qcom_spmi-regulator.c       |    7 +
 12 files changed, 2234 insertions(+), 81 deletions(-)
 rename Documentation/devicetree/bindings/opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} (97%)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
 create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
 rename drivers/cpufreq/{qcom-cpufreq-kryo.c => qcom-cpufreq-nvmem.c} (52%)
 create mode 100644 drivers/power/avs/qcom-cpr.c

-- 
2.20.1

