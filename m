Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2722BC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF22F2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1fpn1wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfLQMRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:17:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38769 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfLQMRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:17:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so2895628wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 04:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvkcmzWWNz9+vvDl5lj9jSidtFGQN7sTpNsfRZj6iOc=;
        b=p1fpn1woHPX0xistfLZ2FIMnrxMkOwvBnFdqRaqUrUsBTdUGddlqaXaKDbVYA58saV
         zl4sFWG3x9FKyHmdSfAgHZmnMHwYTOqFKWgXE7npDUO++TaANqqJR5flItwqSW3BVsk+
         NIb49F2bDT/Zgn7DjYYgTL90X/8JXIZE3IfTXG7sgltuT/ypstmEu8TPxCZ7ol/6jaYm
         /pubBnp85lw3s0/l89Ume7f/ZrdoXf6EKE7r1fHAzSaDdTm/A8qV5wbjuYb27WgyUSNo
         yXR3QckcV4o3dfR3LiTUfkvLb93D0WfClTushCMklkeaH2kulnoQlxiJhckYwASPk+6+
         C2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvkcmzWWNz9+vvDl5lj9jSidtFGQN7sTpNsfRZj6iOc=;
        b=CfRFLA1Ut9iHAvPMI18ggYgvvUaq3FRns1C1wn17VEup1oSZOLB3/veBfg+jFmixP8
         J8XWAiToMTM7uIYdvBg3kFf5s3ZySc2ug0CHpKzXX/L+OuKS1a5crEdszKpKYa3ASWz7
         br17n0Qm2jd1frzulQRv3CDA3G1hMYKwxuZUeHamNHYGEQamiYg4Nme/Fqu08EruHKKH
         Asna8fQjaLQRtDR94OKKxa+BhqjVuhJoTQnkmAdBYtA+ntjlr4OFqiToZtQUosRdqTyJ
         dLmGi0gum03DsSi4v2yeE8fMuXgMLREqPXzAE0vDLhK1xAmNiKWUjdDqOyw1CFooC8vz
         DBKw==
X-Gm-Message-State: APjAAAV4IKhXKvtZO1ecnSbbhN5fNOdVjXmfFMDH57dDSMee6e6M5pfv
        LgMiWbSjw8bRk0qj8UVjSrxcXw==
X-Google-Smtp-Source: APXvYqy0Y+iBxxIqL2VTzMcQpKB1C0uzPqguqaHBeN0RjsFa/n7TfiB/n92Yqnot3rrj/anxAG05Wg==
X-Received: by 2002:a1c:7508:: with SMTP id o8mr5038469wmc.74.1576585019035;
        Tue, 17 Dec 2019 04:16:59 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f1sm25087270wru.6.2019.12.17.04.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:16:58 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh@kernel.org, broonie@kernel.org, lee.jones@linaro.org,
        linus.walleij@linaro.org
Cc:     vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 00/11] ASoC: Add support to WCD9340/WCD9341 codec
Date:   Tue, 17 Dec 2019 12:16:31 +0000
Message-Id: <20191217121642.28534-1-srinivas.kandagatla@linaro.org>
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
Patchset for this is already sent for review at
https://patchwork.kernel.org/cover/11185769/
    
This patchset has been tested on SDM845 based DragonBoard DB845c and
Lenovo Yoga C630 laptop with WSA881x smart speaker amplifiers via
soundwire and 4 DMICs.

gpio controller patch does not have any link dependency, it can go by its own.

Most of the code in this driver is rework of Qualcomm downstream drivers
used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

Thanks,
srini

Changes since v4:
 - updated microvolt bindings as suggested by Rob.
 - slimbus optional property patch already applied.

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
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wcd934x.c                    | 5084 +++++++++++++++++
 sound/soc/qcom/sdm845.c                       |   86 +-
 15 files changed, 6401 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
 create mode 100644 drivers/gpio/gpio-wcd934x.c
 create mode 100644 drivers/mfd/wcd934x.c
 create mode 100644 include/linux/mfd/wcd934x/registers.h
 create mode 100644 include/linux/mfd/wcd934x/wcd934x.h
 create mode 100644 sound/soc/codecs/wcd934x.c

-- 
2.21.0

