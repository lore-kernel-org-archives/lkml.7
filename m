Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0832CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07ED208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJDi1GQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfJ3Pb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:31:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45800 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfJ3Pbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:31:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id q13so2787014wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bOpYqI7qFNfEuie9b9D0+Pfm6dLM4BfsV3Kxbb6E+qA=;
        b=uJDi1GQ/rwsgNK2XboHkBzba0ZbgnV1d3dt4JwIvwhCO4QpwTE1L8ATIb6ZX/EGgBk
         zdfZ01Ga0g4iHu0tIt0+WeYHMaxJI70fQjBKoCRiry+ouUXv7DpXlBjlXx4UQPVyBgVU
         CEdjfoE7b6mPJ2uLJnA6gROvG8wNy+UKJOhYn4eqbgTI79wrRAi7FZrMg6Y/tH4VNrtM
         EBUWx2OSOCFLCdkr6Qyy8DQh+HEkRG5UihSPDdkkqb9QO94e1+Fy17kqhjJ/05HEp7mZ
         PS8x/0du51vEhcz2Q0MftXD9v4hCOdbLEcz9qku9sCPi0i6p/80haBYUcLLqb5J8bUfM
         MMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bOpYqI7qFNfEuie9b9D0+Pfm6dLM4BfsV3Kxbb6E+qA=;
        b=ejgUmA5kXR3LSeqWNg1+cYGpBVy2njfDZ4qtkPYJ+5jLs6lYXOFSfwXwtGB4HFekf0
         dEBHprk0sZHtDx/p/JVeGsOWBucz8zICVLdbTGqBRpeK6DpO4/ccLbaux13VESNpia0D
         5po8CmE5F98jIqbs6hlxXSMUboJSnPFM/nDQu9FbTBLPbLcnq2y/L+wuoyEpW0/Syb6M
         YU29qUoLwk0o3ajJ4j5aFKFHbLLiBkdJ/5lQ/XpgQMoN3Rd9+NVRntmcYMeJuXweVZ5d
         r7FeBAdNqtUQ+6+4mi7O8EsChWN4kBK+RwD9su/lZBSygWJDFFGk98wPw0AzWTlfJPCR
         Utpw==
X-Gm-Message-State: APjAAAUhSHwG9fD8xHqzPPXwezferKqN8PNAi4J7J/3FOInCLJhAwTGU
        o2wIqRQVC+xbMePKtz3QwuuQhQ==
X-Google-Smtp-Source: APXvYqzekYVE+wOXaEjpNAHPVvz/iQyW28UjNldThsXJfbsdUIglMZqJba4lrHUhWU3R38B4gwvcMw==
X-Received: by 2002:adf:f685:: with SMTP id v5mr446677wrp.246.1572449513381;
        Wed, 30 Oct 2019 08:31:53 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u21sm417329wmu.27.2019.10.30.08.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 08:31:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh@kernel.org, vkoul@kernel.org
Cc:     broonie@kernel.org, bgoswami@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 0/2] soundwire: Add support to Qualcomm SoundWire master
Date:   Wed, 30 Oct 2019 15:31:48 +0000
Message-Id: <20191030153150.18303-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing the v3 patchset.
Here is new patchset addressing all the comments from v3

This patchset adds support for Qualcomm SoundWire Master Controller
found in most of Qualcomm SoCs and WCD audio codecs.

This driver along with WCD934x codec and WSA881x Class-D Smart Speaker
Amplifier drivers is tested on on DragonBoard DB845c based of SDM845
SoC and Lenovo YOGA C630 Laptop based on SDM850.

SoundWire controller on SDM845 is integrated in WCD934x audio codec via
SlimBus interface.

Currently this driver is very minimal and only supports PDM.

Most of the code in this driver is rework of Qualcomm downstream drivers
used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

TODO:
	Test and add PCM support.

Thanks,
srini

Changes since v3:
- Updated bindings as suggested by Rob.
- Fixed sdw_disable/unprepare order.
- removed setting stream_name as suggested by Pierre 
- removed v1.5.0 controller support for now, will be added after testing.

Srinivas Kandagatla (2):
  dt-bindings: soundwire: add bindings for Qcom controller
  soundwire: qcom: add support for SoundWire controller

 .../bindings/soundwire/qcom,sdw.txt           | 179 ++++
 drivers/soundwire/Kconfig                     |   9 +
 drivers/soundwire/Makefile                    |   4 +
 drivers/soundwire/qcom.c                      | 904 ++++++++++++++++++
 4 files changed, 1096 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
 create mode 100644 drivers/soundwire/qcom.c

-- 
2.21.0

