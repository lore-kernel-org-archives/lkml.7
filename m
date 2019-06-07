Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF86C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA66208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UtFYE8HX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfFGI5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:57:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37427 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfFGI5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:57:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id 22so1102985wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 01:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6oaxDiNI3V3Y1FcG5gCLYWig+jTKPdpgP/iJOfNbmxQ=;
        b=UtFYE8HXQeDyMoOUEyIiC8jHexlyvpIeLNTRUprfHZT1sLKojwFJIAAQcXaz3MtAVW
         Fk8CHPEf0eKC3aTQBxmsvbwWqHwHK+K5ppaxYz53eJb5SGUiiXgcUUj/Z/ePSsvuifhO
         pDw96ayeUi3yqpur5/U+VIDZGlmLK70TFOTXU+JEbQ3uBvyHbItfjIQagS3TCeh5/Q7J
         cMYanxgK42yIq9X7rbZvUOGbebPci6MBgt+3PM74c1XLBwAubEQU+iVsaLk2kU3iC51d
         BXviQ4+Pkn/vC4vRDZ3LO6aQCjXEtEp4Vd/Db7f696mklhwzUVIB2E7VMSnsSiktCgHd
         /M6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6oaxDiNI3V3Y1FcG5gCLYWig+jTKPdpgP/iJOfNbmxQ=;
        b=RaSH2A0oxfmaQ7vHGNXczBGKatPrh2z/3lrZPpPo7wHhUeePyHcXXqw82G1t30pheG
         XeRSgHvv8kNJoHmf9MsidrbVmju2r5TizSz5+k3HElJqGWa9HPTLci1u1n9kx7KdVJId
         +6Uql+TOumXI7mehTHhKnRmQJYwRK/hJKpAA8xFcoDUsS4qGIeO6LbjmPCECCjHMEvTd
         9oIIuU1RPgFrUcV9KLJ8XYYWZZL1hn8ui2bpAJovHnb6twAOMaYP5AKxG6D4vxyn3Svq
         bKtwGZ2W2Tgc9OoBnaVXD/iFO7C3uDbw4QsQyjyh3mTrM1iafWZYznFFPYHKhl0C+WaZ
         oIVQ==
X-Gm-Message-State: APjAAAV5pTug59O6lHx9FVET9qSZXm6Ao33K4UYOIF7wrKZVW6y9vaTH
        /mwM5X3DdRodyXzmpelF0J6EVg==
X-Google-Smtp-Source: APXvYqwLMDVCNl5uQgvplPXCm62/RRTWw4niXyTJwh05YHHXxpnhloJtxM8sGpE1uyEofQ+ZzKOsGA==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr2642243wmk.99.1559897827098;
        Fri, 07 Jun 2019 01:57:07 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id d10sm2035308wrh.91.2019.06.07.01.57.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 01:57:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 0/6] soundwire: Add support to Qualcomm SoundWire master
Date:   Fri,  7 Jun 2019 09:56:37 +0100
Message-Id: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All, 

This patchset is very first version of Qualcomm SoundWire Master Controller
found in most of Qualcomm SoCs and WCD audio codecs.

This driver along with WCD934x codec and WSA881x Class-D Smart Speaker Amplifier
drivers is on DragonBoard DB845c based of SDM845 SoC.
WCD934x and WSA881x patches will be posted soon.

SoundWire controller on SDM845 is integrated in WCD934x audio codec via
SlimBus interface.

Currently this driver is very minimal and only supports PDM.

Most of the code in this driver is rework of Qualcomm downstream drivers
used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

TODO:
	Test and add PCM support.

Thanks,
srini

Srinivas Kandagatla (5):
  ASoC: core: add support to snd_soc_dai_get_sdw_stream()
  soundwire: core: define SDW_MAX_PORT
  soundwire: stream: make stream name a const pointer
  dt-bindings: soundwire: add bindings for Qcom controller
  soundwire: qcom: add support for SoundWire controller

Vinod Koul (1):
  soundwire: Add compute_params callback

 .../bindings/soundwire/qcom,swr.txt           |  62 ++
 drivers/soundwire/Kconfig                     |   9 +
 drivers/soundwire/Makefile                    |   4 +
 drivers/soundwire/qcom.c                      | 983 ++++++++++++++++++
 drivers/soundwire/stream.c                    |  11 +-
 include/linux/soundwire/sdw.h                 |   7 +-
 include/sound/soc-dai.h                       |  10 +
 7 files changed, 1083 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,swr.txt
 create mode 100644 drivers/soundwire/qcom.c

-- 
2.21.0

