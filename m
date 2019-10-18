Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA77CA9ECA
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A824321D80
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMvfUq56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503835AbfJRAT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:19:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52850 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503766AbfJRAT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:19:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id r19so4305398wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/QAhBLGy3kJwx9AVjnikoQwMK78+wDfkG0Z+oCWFsgc=;
        b=iMvfUq56WMjSs6BbLFNNjBqk4R/wA7XWiEqQ5cOoA5jxbcoXhfFQzScHibNauAjSWt
         vh7jyvGFEwk4+A3kZ8DRk7o+dl4KexvSALP2OuqduSs5hobn3C3fLqKz+xr4NEFaYnTY
         hIl2XGSrJC0TdMPqJm5+jJ5CPFzZ0d9nEYQaaPXfxf6PxYoeKHaE91yJBMBacMwqysc1
         nO5Mk/ZqTq235Rp2qG5WrkXLcfLBfiCNWIwIj+NtG9IvhUjTRONgo3UFTYYjgi6nQ/jd
         oO5YkCHmVkEyZovZgc9WkbFYmSSqQonesPomVRhwoU3nEwO86woGSE8KHwWr2ATwbUr4
         lWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/QAhBLGy3kJwx9AVjnikoQwMK78+wDfkG0Z+oCWFsgc=;
        b=LIYeWmJqAkew9ofrpsa/liNqyayUFlcBQ88G0ZyUcldNR9yJgcfYZ+PbyvlCqZhIgC
         dsvJQie/YaMOY4woLdmibeMDq353J6kFIvuzzzHO5ihTI0J2jfy1kSWXsAhT8u6tKTEk
         XOWUdff37lpL0rJFlJKvn6B4akF5yS8OlmBIBgJBvoFa5SclcEJ2L5rPOru808OZhzho
         8noCDHG6Fy4Pv/156nAHxFAgsbWcuAZCop18MoSwmm1Q+aSbAlTix/d8dgxLkq5QbNFx
         oOiREYccslLbT+sfW+QY42L2q3/e5V7F1JlSE9pm2Y+TKufEtuYrVTEUkFyyJGIJg2Pb
         L3Hg==
X-Gm-Message-State: APjAAAVGcNwS9FHMgWbi4YZfByiIoEl/AyfACNKUdXZj97DWJJFdRF0m
        P0lpJuYnJ3PM30suPrVwkjCp/A==
X-Google-Smtp-Source: APXvYqwed+8BHWLv8haNNmapLa2e4SIyZOujwERahm2qLxkUJRKuCwY14eI+b08j5yOWgBtWBOCrGA==
X-Received: by 2002:a7b:c652:: with SMTP id q18mr760429wmk.148.1571357996011;
        Thu, 17 Oct 2019 17:19:56 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z189sm4851248wmc.25.2019.10.17.17.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 17:19:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh@kernel.org, broonie@kernel.org, linus.walleij@linaro.org,
        lee.jones@linaro.org
Cc:     vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 00/11] ASoC: Add support to WCD9340/WCD9341 codec
Date:   Fri, 18 Oct 2019 01:18:38 +0100
Message-Id: <20191018001849.27205-1-srinivas.kandagatla@linaro.org>
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

Pin Controller patch does not have any link dependency, it can go by its own.

Most of the code in this driver is rework of Qualcomm downstream drivers
used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

If anyone is interested to try, here are working set of patches on top of rc3.
https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=audio/v5.4-rc3-YOGA-C630
alsa ucm files:
https://git.linaro.org/people/srinivas.kandagatla/alsa-lib.git/log/?h=DB845c

Thanks,
srini

Changes since v1:
- Code cleanup and convert to proper dpcm widgets where possible.
- converted to mfd driver.
- added pinctrl driver to this series
- added dts changes in this series
- bindings converted to yaml.

Srinivas Kandagatla (10):
  ASoC: dt-bindings: add dt bindings for WCD9340/WCD9341 audio codec
  mfd: wcd934x: add support to wcd9340/wcd9341 codec
  ASoC: wcd934x: add support to wcd9340/wcd9341 codec
  ASoC: wcd934x: add basic controls
  ASoC: wcd934x: add playback dapm widgets
  ASoC: wcd934x: add capture dapm widgets
  ASoC: wcd934x: add audio routings
  dt-bindings: pinctrl: qcom-wcd934x: Add bindings for gpio
  ASoC: dt-bindings: Add compatible for DB845c and Lenovo Yoga
  ASoC: qcom: sdm845: add support to DB845c and Lenovo Yoga

Yeleswarapu Nagaradhesh (1):
  pinctrl: qcom-wcd934x: Add support to wcd934x pinctrl driver.

 .../pinctrl/qcom,wcd934x-pinctrl.yaml         |   51 +
 .../devicetree/bindings/sound/qcom,sdm845.txt |    5 +-
 .../bindings/sound/qcom,wcd934x.yaml          |  169 +
 drivers/mfd/Kconfig                           |    8 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/wcd934x.c                         |  330 ++
 drivers/pinctrl/qcom/Kconfig                  |    7 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-wcd934x-gpio.c   |  365 ++
 include/linux/mfd/wcd934x/registers.h         |  529 ++
 include/linux/mfd/wcd934x/wcd934x.h           |   24 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wcd934x.c                    | 5218 +++++++++++++++++
 sound/soc/qcom/sdm845.c                       |   71 +-
 15 files changed, 6789 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,wcd934x-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
 create mode 100644 drivers/mfd/wcd934x.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-wcd934x-gpio.c
 create mode 100644 include/linux/mfd/wcd934x/registers.h
 create mode 100644 include/linux/mfd/wcd934x/wcd934x.h
 create mode 100644 sound/soc/codecs/wcd934x.c

-- 
2.21.0

