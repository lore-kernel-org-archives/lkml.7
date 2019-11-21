Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2630C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21F72070B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FbuxulM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKURFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:05:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50891 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKURFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:05:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id l17so4585380wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0re8rXYMHSap6XKSlx//AGDnlKypYxFmsmkqmIjzSJk=;
        b=FbuxulM5yi+hVol+ybHml76SOIXCFpVSfUVI7FkgIJfAy4G5Dkxc/0uXITJkNm+ph/
         FJoiCsdtojx+p2fSqm0IUy57itLCU/W25l8GqlQfv9JGPdHob42uR4nLZE5dnDRKr+kr
         Zdsut67NOhbt1vtaGEvI3Kyj/yBB0avfekXvrjNMnB6VGp0FZ9kSIJ4JoVoYrL1GSCx5
         kUrEw8ohglRcxHNKmx4zGEUl7l4wKOC1C8WwuqYHupsws7nsYwHZ410Hu22ZJ9dcL842
         DMkikLjtOXVCbAzrDHkd7nAi1xHyijbx9Ij4dh0kG5zl4dL4LdEd7/XCkJCA4khhwUpj
         ZDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0re8rXYMHSap6XKSlx//AGDnlKypYxFmsmkqmIjzSJk=;
        b=kClUH/VqNO31QPtyOg6wgnKqUb/WodQHj0NzDQsWNxe4BlonuUhoxgw63P5LQiwS7F
         IIeV2Xpk9YzBIYhS7kKj/9un+4Lsch2LPDUGVZltxF5fR7a4CRBhWq6lF9hVi/Q2qdZ2
         pebXrkYKHpK8C95MhpMs7SDPJfJWMT/xMRTqdc/5vqAeFAcZBhEYbb0Bi6hQc/exH4Ae
         7rD4Okk7MZ2Omcbq3bS0E28w0CiA5i5ScEr9LIw9ZzDLYCF+Sob5/dIta3T0WEN1uyGK
         N4hY0fXWK18Kia0p/yWFb4ZrBZlvqv5l4OUIKV5CrQ83/5U7OJH5y1gY7MpZ49TROShP
         FWbQ==
X-Gm-Message-State: APjAAAVIVw8LVIyigoKDRhSpU3yUvOASMFRLexxHoiFu4FsEdfi5e0Nd
        xhArHNexyJ4+bpt2Hzmox6zwrw==
X-Google-Smtp-Source: APXvYqz1k9UzXGgWztdeaaFoXm5e8fMfaN17EMD2CppOmZAXz30rABTGh6tv/m9gZZZq0G4gpP9jJg==
X-Received: by 2002:a1c:2846:: with SMTP id o67mr11366521wmo.7.1574355937815;
        Thu, 21 Nov 2019 09:05:37 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id i71sm4423731wri.68.2019.11.21.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 09:05:36 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh@kernel.org, broonie@kernel.org, lee.jones@linaro.org,
        linus.walleij@linaro.org
Cc:     vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 00/12] ASoC: Add support to WCD9340/WCD9341 codec
Date:   Thu, 21 Nov 2019 17:04:57 +0000
Message-Id: <20191121170509.10579-1-srinivas.kandagatla@linaro.org>
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


Changes since v3:
 - Added new SLIMBus common bindings suggested by Rob.
 - renamed microvolts to microvolt in bindings as suggested by Rob
 - dumped pinctrl driver and added new simple gpio driver
 - few cosmetic cleanups in mfd driver.

Srinivas Kandagatla (12):
  dt-bindings: SLIMBus: add slim devices optional properties
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
 .../devicetree/bindings/slimbus/bus.txt       |   10 +
 .../devicetree/bindings/sound/qcom,sdm845.txt |    5 +-
 .../bindings/sound/qcom,wcd934x.yaml          |  163 +
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
 16 files changed, 6399 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
 create mode 100644 drivers/gpio/gpio-wcd934x.c
 create mode 100644 drivers/mfd/wcd934x.c
 create mode 100644 include/linux/mfd/wcd934x/registers.h
 create mode 100644 include/linux/mfd/wcd934x/wcd934x.h
 create mode 100644 sound/soc/codecs/wcd934x.c

-- 
2.21.0

