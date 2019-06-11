Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B11EC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0012146E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6TxbJgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbfFKKlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:41:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37266 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfFKKlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:41:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14so12435849wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Us0ePqajLzv9F8VyyEgnx7luzsoyG4vzsDlEA+qZoA=;
        b=O6TxbJgNNzTRHvhsHcPcpFSEUN11tv3n1CNF50tCukacGTLqdUAK+DDEWaCElbVabt
         QU5pBOco5tJX+h0zDpfzd3H/8MttD0lp+YNl+n1tW3scb6cYp1Y52CS4GL173QcZvDe9
         vlXriA5EQNVgXnNONNVP5E/xr35kQmk9KzJU6KRcU8DfJcYIgitGm3jQI9fH0t2iMJSh
         oIYQAJzZJyH8UnnP/kwMuy97Jdv5Qjy94LWHpg/5MzSLC1Dsy3NpfFGuLIddsyGNONrx
         RhYU2n+dd0ezUTpaYFnf8DqqZxYnSlvR8apoS0Kj35ayKcKtbbFM6uXVsee9Yeu95JUc
         kOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Us0ePqajLzv9F8VyyEgnx7luzsoyG4vzsDlEA+qZoA=;
        b=BefBA5/m2nDpYKsn1ezK8mBo5NHKUJG0PBBjm+kILzjpt03GO9xNmVE3M79DKDOCIS
         hyo2ak8lop9zOguHUWdWBrnegbefYM99PMcfCM0G/HAiO2Ya6LsDWrZacpOgortzdcXJ
         xpkjI8JD8bvDRUyKePSlNYlVkYBTStMu05PR26g9fe3keB+TRjTSgROIPtkp1UfCcNu3
         9/bkSS911suVuYg/xn1qTisKeWPyVDxBXa5GD7MFnIDlqm0NaRO0SeVSZsgsEPj21L3y
         j89caTnQ2qby41PyKz2MtHG0r1E8+bVMZdORAJKBpTMUt5bS/mg0DffMp9rsX+umShSB
         FSfw==
X-Gm-Message-State: APjAAAXg1ARopi/sZLRWnO/FRu2xgQ7GGrQoWquKBUtrhMYMSLyi79ww
        TIH93XVgA8Vqg4+siq+VKLPopw==
X-Google-Smtp-Source: APXvYqwKnDzyF9xodu2F8D8uakDUS7/kq2b5T0SBVt6AAGazCrBBaf6zY+sVXP/lUzeZyCqpx23H9A==
X-Received: by 2002:a5d:6207:: with SMTP id y7mr29651668wru.265.1560249658630;
        Tue, 11 Jun 2019 03:40:58 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c65sm2359614wma.44.2019.06.11.03.40.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 03:40:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bgoswami@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 0/5] ASoC: codecs: Add WSA881x Smart Speaker amplifier support
Date:   Tue, 11 Jun 2019 11:40:38 +0100
Message-Id: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support to WSA8810/WSA8815 Class-D Smart Speaker
Amplifier which is SoundWire interfaced.
This also adds support to some missing bits in SoundWire bus layer like
Device Tree support and module_sdw_driver macro.

This patchset along with DB845c machine driver and WCD934x codec driver
has been tested on SDM845 SoC based DragonBoard DB845c with two
WSA8810 speakers.

Most of the code in this driver is rework of Qualcomm downstream drivers
used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

TODO:
	Add thermal sensor support in WSA881x.

Thanks,
srini

Srinivas Kandagatla (5):
  dt-bindings: soundwire: add slave bindings
  soundwire: core: add device tree support for slave devices
  soundwire: add module_sdw_driver helper macro
  dt-bindings: ASoC: Add WSA881x bindings
  ASoC: codecs: add wsa881x amplifier support

 .../bindings/sound/qcom,wsa881x.txt           |   27 +
 .../devicetree/bindings/soundwire/bus.txt     |   48 +
 drivers/soundwire/bus.c                       |    2 +-
 drivers/soundwire/bus.h                       |    1 +
 drivers/soundwire/slave.c                     |   54 +-
 include/linux/soundwire/sdw_type.h            |   11 +
 sound/soc/codecs/Kconfig                      |    9 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wsa881x.c                    | 1160 +++++++++++++++++
 9 files changed, 1312 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.txt
 create mode 100644 Documentation/devicetree/bindings/soundwire/bus.txt
 create mode 100644 sound/soc/codecs/wsa881x.c

-- 
2.21.0

