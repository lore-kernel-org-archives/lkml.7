Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3223ACA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074DE20700
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFlXnvlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfJUGo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:44:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40159 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfJUGo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:44:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id 15so1800089pgt.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 23:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tQTXewI5i0bEVradqq9Sq1stUuXOotbi+yIpe8Hlupg=;
        b=WFlXnvlgJ+jcyIw59Uz+owZcPNPQ1HtL5w1mICzF8spJiXkhgncCcOZCpxGWl7W943
         OjBInY4itK+9A7OlbOcWgZYN3pftkP3gjDhcp/d34le6xa6Z3GmJFQSPMOHTRgnF7CaP
         HbfjsuxT7BeTqbE0HtxOuYVowBIhaxEpRi1QIkHZMknzRVVecWrC9jQfIHeV6DMLH8Mk
         SFLfvm60se9EapSFWYVNxJUphu5DpLjoR7494+LIRi2ORMRsZx3xT936fdBgsB9Ql9bO
         r9p1P4ezgnp6p4dPpHkpAUaiR1ND7w7BbMNodIjGSivaMJbRXv7WziXcEVW5sEDUS+So
         zzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tQTXewI5i0bEVradqq9Sq1stUuXOotbi+yIpe8Hlupg=;
        b=MlsGIlOg2+lLpybe+UiWpdWT17KE0EoGDTMI21e5bYQEFCeDKXQJpP2jtFCDNcQnUk
         ba+NVsl+aO9iZT5wnCU8g+ergVerGIgypRfH1HCBLSgO0qrLggmtBEpzwJ2W6i/xgT0s
         N6RUJdTH25qgRSE/YKRLBhMh6drJJWV8ywgbewXkSR+BoXY3d8N2wl+s9opQPo6OXML4
         5GL/IRkp/Bilz1x4I8YB8EnvxQSElDTqD8itcPENJ/vdOuK33SVeu4VmAdk0AgdZZbQo
         i01S2wOMYiwWqiBbPFxAeFOKWzPmy4sP6d5lcWfQzcaewHHrEFQXfnVDUUJsLbmNKAAG
         zORA==
X-Gm-Message-State: APjAAAVujl4K6koekUhtRaRFXRj7yBUuffqAAm4l1GNCsxqxw7zC4iAD
        LCde+RVYQt95hRnj21ZSLsHD
X-Google-Smtp-Source: APXvYqyG5D0ojTYQgR6SJoK4uoARccCbrx2DDzS7r4COsrTWbOcndEHVS0u6KS5oKvN+wRRK5jf8yg==
X-Received: by 2002:a62:b504:: with SMTP id y4mr21198203pfe.198.1571640265355;
        Sun, 20 Oct 2019 23:44:25 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:700f:8db6:2442:890f:ac37:8127])
        by smtp.gmail.com with ESMTPSA id d4sm13156624pjs.9.2019.10.20.23.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 23:44:24 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, orsonzhai@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/4] Add GPIO support for RDA8810PL SoC
Date:   Mon, 21 Oct 2019 12:14:09 +0530
Message-Id: <20191021064413.19840-1-manivannan.sadhasivam@linaro.org>
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

Changes in v3:

As per the review by Linus W:

* Switched to GPIO MMIO for simplifying the driver
* Elaborated the driver commit message
* Some misc changes to the driver

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
 drivers/gpio/Kconfig                          |   9 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-rda.c                       | 294 ++++++++++++++++++
 6 files changed, 404 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-rda.yaml
 create mode 100644 drivers/gpio/gpio-rda.c

-- 
2.17.1

