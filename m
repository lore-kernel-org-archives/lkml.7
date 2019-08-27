Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42F2C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACC2206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIgfNMS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfH0MOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:14:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41685 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729313AbfH0MOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:14:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so12603752pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4wcazYDkpL0duARs99jL9aMnOJv1Px99rhHjbxqeKAs=;
        b=cIgfNMS9Y89X0ZTePhVRGhyzjprNxkg12d7CxOIay09vvWQ7pVobVStnxSO26gJvk1
         S/MIaLSZTP/FjdrAvjSMT/AoNgVnfKrpnivkArmqpkkQHyNW8K60XuBDXLQCZBJO9Swd
         9UApfN32eAlqF7F6IeEJeJ4e6X83cl82o7L93atoHWeyrSFIFn/3EWi+ZFAjHW2a93Xs
         3TTRv0kz8QSOr/TKs9TEIl9KIZ4Y/2FS5HX+DVwbL96YoErvDA/9xS1QEu5jcFvDkMII
         Ow2mykWpg05txO9FQ/potL4EJanVMLc9b9ACki9YjX0dqUHfitZM+n65CPiNfJ4KFqNt
         VymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4wcazYDkpL0duARs99jL9aMnOJv1Px99rhHjbxqeKAs=;
        b=C2w7D7Rg3aaMGALyuqDTPZT0G4ZllcL2FrAhytBQPHqkW9vVv/c1mn+6e3Fg2b9Is/
         /7WcTC8EGATatPWrtPRmWUf+7zsYoOU8O/5/Ec5QjLbzVGCVsmneUdpSDQ17CIJmlkjD
         /JFOjPDTgFAIZ8owQTjpxXZRY4zLaI4sgK8z7tVvQglhEkZKPP7e+iYXNfzbuKqcf6mJ
         AP3eMLk5QWzLS0zXjoFrH3LTQNtVNAfCcJ9NoWkE/80H3Ylzqn2tA7gyj/TeZZWCC1hP
         oaOYAJ0ud8us81CUS3PO1wJN69kWYNTy5PF/MFgMWOl37IgxPz5Hoi6GEVMYoYYq57DG
         21Lw==
X-Gm-Message-State: APjAAAVlGLlcf+jZe+Y5F9D6quqaadDyWXYBwans+kS2DIgBIKAmA0no
        221yrKJFYqMmUyMMhY7Xe6+2xHYF22hGlQ==
X-Google-Smtp-Source: APXvYqySuJMvr50yVLa9Q+m8dsjJ0euzRJ/Qgw6e9jts/v+QxNAsjYeS/M3MgQw692ynNmbMHDFf7Q==
X-Received: by 2002:a17:90a:a00b:: with SMTP id q11mr2396118pjp.91.1566908061427;
        Tue, 27 Aug 2019 05:14:21 -0700 (PDT)
Received: from localhost ([49.248.54.193])
        by smtp.gmail.com with ESMTPSA id d3sm3148595pjz.31.2019.08.27.05.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:14:20 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        sboyd@kernel.org, masneyb@onstation.org, marc.w.gonzalez@free.fr,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 00/15] thermal: qcom: tsens: Add interrupt support
Date:   Tue, 27 Aug 2019 17:43:56 +0530
Message-Id: <cover.1566907161.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
- Collected reviews and acks
- Addressed Stephen's review comments (hopefully I got them all).
- Completely removed critical interrupt infrastructure from this series.
  Will post that separately.
- Fixed a bug in sign-extension of temperature.
- Fixed DT bindings to use the name of the interrupt e.g. "uplow" and use
  platform_get_irq_byname().

Add interrupt support to TSENS. The first 6 patches are general fixes and
cleanups to the driver before interrupt support is introduced.

This series has been developed against qcs404 and sdm845 and then tested on
msm8916 and msm8974 (Thanks Brian). Testing on msm8998 would be appreciated since I don't
have hardware handy.

Amit Kucheria (15):
  drivers: thermal: tsens: Get rid of id field in tsens_sensor
  drivers: thermal: tsens: Simplify code flow in tsens_probe
  drivers: thermal: tsens: Add __func__ identifier to debug statements
  drivers: thermal: tsens: Add debugfs support
  arm: dts: msm8974: thermal: Add thermal zones for each sensor
  arm64: dts: msm8916: thermal: Fixup HW ids for cpu sensors
  dt: thermal: tsens: Document interrupt support in tsens driver
  arm64: dts: sdm845: thermal: Add interrupt support
  arm64: dts: msm8996: thermal: Add interrupt support
  arm64: dts: msm8998: thermal: Add interrupt support
  arm64: dts: qcs404: thermal: Add interrupt support
  arm: dts: msm8974: thermal: Add interrupt support
  arm64: dts: msm8916: thermal: Add interrupt support
  drivers: thermal: tsens: Create function to return sign-extended
    temperature
  drivers: thermal: tsens: Add interrupt support

 .../bindings/thermal/qcom-tsens.txt           |   8 +
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 108 +++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  26 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  60 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  82 +--
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  42 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  88 +--
 drivers/thermal/qcom/tsens-8960.c             |   4 +-
 drivers/thermal/qcom/tsens-common.c           | 528 ++++++++++++++++--
 drivers/thermal/qcom/tsens-v0_1.c             |  11 +
 drivers/thermal/qcom/tsens-v1.c               |  29 +
 drivers/thermal/qcom/tsens-v2.c               |  13 +
 drivers/thermal/qcom/tsens.c                  |  59 +-
 drivers/thermal/qcom/tsens.h                  | 288 ++++++++--
 14 files changed, 1089 insertions(+), 257 deletions(-)

-- 
2.17.1

