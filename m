Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00179C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ED921479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="toJTxaY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfEJSpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 14:45:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33434 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfEJSpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:45:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so3694152pfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+ONNq5P1j2Oa2lnhO1rhLpWrLa5fRjw816TA+nIPdAY=;
        b=toJTxaY7Oi3WSP7j9XR8L1TpR/R3z4gk690EyVAx2KwpGLRgtDgPooejuD21ZFsnOF
         P41Hj8QjOONHOc6PsXvkrx3K/8EdCufd32VYzBp/FQN0SR669WirzCtDrqOxBywae7qz
         LtMRN403KkG4C3QAXJbvVA2pLbZHSGC/VvO78LBo9EjdfcOBVdNoqi9ougS9WX0WI/Hp
         ab8W+7hDM6HDhP6gbSHP9onWH07fBTK5OYA/PuTdq/mwpMomjWaJubfexpHms8tvjA8t
         7dpUYn3MJLO0u1IWK3bWB9SkFZNw0vGKNz5SxeZazWZ1MqqvFphAbNQekUGjvhw+Khpv
         NQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+ONNq5P1j2Oa2lnhO1rhLpWrLa5fRjw816TA+nIPdAY=;
        b=YyIR2mzpSBEQA9JNEAyKul00JUnL3yseakc4qFjvd/e87xPDFKaRn61YRZsebWmAx5
         KMoNZRNnucE24ra/D77y3P9ViOlvxnu1D/cB9jmiqTlUfZT0hWw15CDgAyvHzwjb4ol7
         ADZATa2hygBOsZBwPl9j8XsijiBgIL1MQv6tzbRQQXu6Fd+0cv9AxXpnv+soKvm+yG02
         9LQ14ZsX6JQx7AOxHqIJTE6HWcKmGvtG8pigPyk2ylNSMmKLMey5+QUNS6KimMBzJNlf
         e89qdNWFYwTh9oSM0dNPWLHcUH6Ze62f0HqMFuRdUQDqwKpyTkG+++dO3Z2A3K1oAVKZ
         wHYg==
X-Gm-Message-State: APjAAAUs+pQIAzYF/FkuuPm+LaXMhxfASkWduMAp7lkVuXr4QuGH9dSg
        kO4U3p8E2F+PyO4B/5UfV4KJ
X-Google-Smtp-Source: APXvYqwSxfztzhhhRo7isnL7o9KZ65ABp2JOE21/ph9rWgEgyjqSrKYtiD5FkpvLW26e3WW67DhG6A==
X-Received: by 2002:a63:6941:: with SMTP id e62mr14542253pgc.99.1557513945390;
        Fri, 10 May 2019 11:45:45 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73c1:9991:95b6:5055:2390:bf9b])
        by smtp.gmail.com with ESMTPSA id g188sm8652049pfc.151.2019.05.10.11.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 11:45:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/4] Add reset controller support for BM1880 SoC
Date:   Sat, 11 May 2019 00:15:21 +0530
Message-Id: <20190510184525.13568-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds reset controller support for Bitmain BM1880 SoC.
BM1880 SoC has only one reset controller and the reset-simple driver
has been reused here.

This patchset has been tested on 96Boards Sophon Edge board.

Thanks,
Mani

Changes in v3:

* Removed the clk-rst part as it turned out be the clock gating register set.

Changes in v2:

As per review from Philipp:

* Reused reset_simple_active_low struct instead of a new one for bm1880
* Splitted the SPDX license change to a separate commit
* Added Reviewed-by tags from Rob and Philipp

Manivannan Sadhasivam (4):
  dt-bindings: reset: Add devicetree binding for BM1880 reset controller
  arm64: dts: bitmain: Add reset controller support for BM1880 SoC
  reset: Add reset controller support for BM1880 SoC
  reset: Switch to SPDX license identifier for reset-simple

 .../bindings/reset/bitmain,bm1880-reset.txt   | 18 +++++++
 arch/arm64/boot/dts/bitmain/bm1880.dtsi       | 11 ++++
 drivers/reset/Kconfig                         |  3 +-
 drivers/reset/reset-simple.c                  |  8 ++-
 .../dt-bindings/reset/bitmain,bm1880-reset.h  | 51 +++++++++++++++++++
 5 files changed, 85 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.txt
 create mode 100644 include/dt-bindings/reset/bitmain,bm1880-reset.h

-- 
2.17.1

