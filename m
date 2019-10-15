Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD432ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28D320650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DONTslug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfJORam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:30:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38216 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbfJORak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:30:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3so5639633pgt.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 10:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qGTmzDxe583R/v3aUC27S2QW45EmLA5xRgdHBmdZQi8=;
        b=DONTslugMGlqg9iBy9hmK9+7DEX/oNOpdshb8MJixifpM3883pIwAXkZJP1899eOOe
         csSfbo+FfCUiV+kVq7hiQ6pfbD6C87oLMXyDBdhV1/GSBdsQlOFUXMCGmLBgSxaz8gVO
         aq5UY0uVYcnU2VSFQ6oY4dt8Tp8J1z42id9np5S3hIk0vE1uwM3DsdKmQW1R/7aLH8jG
         q0S2ackCH3BX/uK8e8Yuc1GGllaGYLaTzYn9Koq29PK7q2/q3L2zUh7SxdkvQU/6ZEXI
         I6iu/jFbMxnwHYX1qP1OeSzoTYe0Sdg3Dnx8IWPp3RvJj1kQ4gTKKM6YsmrjLX56IHwk
         PeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qGTmzDxe583R/v3aUC27S2QW45EmLA5xRgdHBmdZQi8=;
        b=DRMp6pm07Xx8+erNry2o2Zf6KCq9w4EVYg6xrKYtZqoZgZ3jfp2VSIPhfYg++OO1mF
         QVgdcWElSop0vBxeslR6KjsxJV8cqIlCNa1MMetBiPM7TzoTCw0lfoxY/S2wdqw+2MLa
         +pk9ktZrOhMEaGwquwOc+QSWnnnicD9NkHKBhgKTwxjyXxqTdYs46fo/ZQmlP2wLx1yf
         Cr5GDRAXFbDJJFddmhl7YWzjZ57N1ocUyVbl8oAHjNqfFvb/ujsvBChA9i0OWqdZa7fz
         x035AcwLSY+ERRPrfEzkCdoymcanXXYZxD+fkRnTfyyyYBxWXLxd4rStsoVlfC3pg+9i
         Vz8A==
X-Gm-Message-State: APjAAAXUjprsDtWoje7mOArQkFLXAB1VIJAv9S6CBMUrVrQkMzw4pUvJ
        tknHnbIZmzkbHFyzviA/n5Wina/tvw==
X-Google-Smtp-Source: APXvYqwu/2hvE2QpunG0Cb+S5rWtvqa1YDgqbHA1dUUgRwBSbSv1CfKKSL1Lqvwq3gQUc0UEbDlZjw==
X-Received: by 2002:a63:1f52:: with SMTP id q18mr40306261pgm.35.1571160639901;
        Tue, 15 Oct 2019 10:30:39 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6003:7cb8:25e8:2c45:fab2:b0c7])
        by smtp.gmail.com with ESMTPSA id w11sm28033563pfd.116.2019.10.15.10.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:30:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, orsonzhai@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/4] Add GPIO support for RDA8810PL SoC
Date:   Tue, 15 Oct 2019 23:00:22 +0530
Message-Id: <20191015173026.9962-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds GPIO controller support for RDA Micro RDA8810PL
SoC. This SoC has 4 GPIO controllers and each handles 32 GPIOs. Except
GPIOC, all controllers are capable of generating edge/level interrupts
from first 8 GPIO lines. The pinctrl part for this SoC will be added
later.

This driver has been validated on 96Boards OrangePi i96 board from
Shenzhen Xunlong Software Co.,Limited with libgpiod.

Thanks,
Mani

Changes in v2:

As per the review by Bartosz:

* Dropped the not implemented gpio_request/free callbacks.
* Used device_* helper to fetch ngpios.

Manivannan Sadhasivam (4):
  dt-bindings: gpio: Add devicetree binding for RDA Micro GPIO
    controller
  ARM: dts: Add RDA8810PL GPIO controllers
  gpio: Add RDA Micro GPIO controller support
  MAINTAINERS: Add entry for RDA Micro GPIO driver and binding

 .../devicetree/bindings/gpio/gpio-rda.yaml    |  50 +++
 MAINTAINERS                                   |   2 +
 arch/arm/boot/dts/rda8810pl.dtsi              |  48 +++
 drivers/gpio/Kconfig                          |   8 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-rda.c                       | 315 ++++++++++++++++++
 6 files changed, 424 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-rda.yaml
 create mode 100644 drivers/gpio/gpio-rda.c

-- 
2.17.1

