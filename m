Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C88C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B334A222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9osVpQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfLSKdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:33:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53496 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfLSKdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:33:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id m24so4878927wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 02:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9IU6iI2PMO8JogASt6ZUpvqvc9+EPfynpc2LWZABp/Y=;
        b=X9osVpQ0OkinTYh3s178FgRq339JnFDDUFr1az/q1iaDBFMsakJgttrpiRS4Ql+GxC
         tw1ObLYPaGTKLznlK6Uz/vGsBNY+uYl1zs/wbc0XvuuNbvSpJ60jlgLzB3yows4TyobM
         4xxESxwN9Mvfa5sji6iN5VCOJ5+zR9qbWXgrhLTB61H+UXJLNBBnw53t1ziNkPCPUlbb
         35jNuBJSBPoFdRfJvhewNtN2m+jv8FnTnf8ZhXmQirzqO2x/omMZobq06rK2wFIoD0aV
         r4o0RrfPJil5ZHJ8YyHaDuPqLRZtf4ghc9VKwO0Vr9m+pYH5wAFEqU3b7Gr/kEiArW26
         7fpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9IU6iI2PMO8JogASt6ZUpvqvc9+EPfynpc2LWZABp/Y=;
        b=DOaJbUauhWNtRcgqpqDdnuac/c6P7GiiXrOpoLRcZMu80XNAxVRPkH5wSoLYuTW305
         QFmBoxE0NHVN0yE+xOSggMPsmDMCsvI3uJX97PE3bbZ9nu3RjFqqFY60CGbHuv9tLMM3
         z0E+wcVFs4ZCV6EHF0yJCLtYl7atfD787U5nVN9fQZH8c67MEfYGh/cgpY0Jap8Ur6UR
         MdP2+jHcxd1Q7DY0Ha11aMbM++YpOMt/peAYwg6Oht1GPM+tlvweeOZCw+18alV+PO6q
         oA5Q4nqIb3VbM4hnyWL9oB3yAFTCz2UGmbX4UIQ14yvQLuJFlhMVfIs8TFDEXMDWDFiQ
         JxcA==
X-Gm-Message-State: APjAAAUMEMIYyBz9PrFcFo1y9DQ2kBQ5avQKFIqcN9camu68FO1E7Sfv
        dnOvxws+602KqZwqu/EtZ1jDBw==
X-Google-Smtp-Source: APXvYqy+JwRWUQgmpm9nw8G5BBEcn38dMvSGvV3I2wHLJptK09xWxa3G/M1vSLRdfkKOOz28xNAaaA==
X-Received: by 2002:a1c:f303:: with SMTP id q3mr8602199wmq.98.1576751581042;
        Thu, 19 Dec 2019 02:33:01 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id i11sm5962942wrs.10.2019.12.19.02.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 02:32:59 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lee.jones@linaro.org, linus.walleij@linaro.org
Cc:     robh@kernel.org, vinod.koul@linaro.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org,
        bgoswami@codeaurora.org, linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 00/11] ASoC: Add support to WCD9340/WCD9341 codec
Date:   Thu, 19 Dec 2019 10:31:42 +0000
Message-Id: <20191219103153.14875-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support to Qualcomm WCD9340/WCD9341 Codec which
is a standalone Hi-Fi audio codec IC.
This codec supports both I2S/I2C and SLIMbus audio interfaces.
On slimbus interface it supports two data lanes; 16 Tx ports
and 8 Rx ports. It has Five DACs and seven dedicated interpolators,
Multibutton headset control (MBHC), Active noise cancellation,
Sidetone paths, MAD (mic activity detection) and codec processing engine.
It supports Class-H differential earpiece out and stereo single
ended headphones out.

This codec also has integrated SoundWire controller.
Patchset for this is already sent for review.
    
This patchset has been tested on SDM845 based DragonBoard DB845c and
Lenovo Yoga C630 laptop with WSA881x smart speaker amplifiers via
soundwire and 4 DMICs.

gpio controller patch does not have any link dependency, it can go by its own.

Most of the code in this driver is rework of Qualcomm downstream drivers
used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

Thanks,
srini

Changes since v5:
	- added correct MFD dependency to codec driver

Srinivas Kandagatla (11):
  ASoC: dt-bindings: add dt bindings for WCD9340/WCD9341 audio codec
  mfd: wcd934x: add support to wcd9340/wcd9341 codec
  ASoC: wcd934x: add support to wcd9340/wcd9341 codec
  ASoC: wcd934x: add basic controls
  ASoC: wcd934x: add playback dapm widgets
  ASoC: wcd934x: add capture dapm widgets
  ASoC: wcd934x: add audio routings
  dt-bindings: gpio: wcd934x: Add bindings for gpio
  gpio: wcd934x: Add support to wcd934x gpio controller
  ASoC: qcom: dt-bindings: Add compatible for DB845c and Lenovo Yoga
  ASoC: qcom: sdm845: add support to DB845c and Lenovo Yoga

 .../bindings/gpio/qcom,wcd934x-gpio.yaml      |   47 +
 .../devicetree/bindings/sound/qcom,sdm845.txt |    5 +-
 .../bindings/sound/qcom,wcd934x.yaml          |  175 +
 drivers/gpio/Kconfig                          |    8 +
 drivers/gpio/Makefile                         |    1 +
 drivers/gpio/gpio-wcd934x.c                   |  104 +
 drivers/mfd/Kconfig                           |   12 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/wcd934x.c                         |  306 +
 include/linux/mfd/wcd934x/registers.h         |  531 ++
 include/linux/mfd/wcd934x/wcd934x.h           |   31 +
 sound/soc/codecs/Kconfig                      |    8 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wcd934x.c                    | 5084 +++++++++++++++++
 sound/soc/qcom/sdm845.c                       |   86 +-
 15 files changed, 6399 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
 create mode 100644 drivers/gpio/gpio-wcd934x.c
 create mode 100644 drivers/mfd/wcd934x.c
 create mode 100644 include/linux/mfd/wcd934x/registers.h
 create mode 100644 include/linux/mfd/wcd934x/wcd934x.h
 create mode 100644 sound/soc/codecs/wcd934x.c

-- 
2.21.0

