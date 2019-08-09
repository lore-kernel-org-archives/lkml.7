Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC91BC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF255214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yu0o583l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436495AbfHINeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:34:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37097 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406662AbfHINeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:34:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id b3so5883661wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 06:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSHE3Aj4iM6gYhcmQoszjlvxEipz13Xj0eMmdWnUjX4=;
        b=Yu0o583lxOO+XUf2AITZ1N5l0tYfk1WvYSXvAR3SFKvigp3L3PzzRmfYRfdQZqsQ9O
         E5CvPLOQGwPhPHlGVGzSVJI15zrAVCAwNG/a7tQWfE0fAGNI02zATJQcNs3mOL1b5Cmt
         E98z36FIDVVoKrvjZhf9t1RdI52O8xp5Peapj6eKbtkSHjHJrldSLtp6P3SsPrA7JiPo
         YQQO9HnnzIx3S8E4AGcLFLCh/MYqAPXNPI6oIY/4ksmEjR+Tlun7oLoQMu8yFyISoqWp
         GI1IVYQuLfTM6ivInkNP8FJFhXQnD7I/ddTsPCXvTdAL1tLjzebQ5YMMhHqR1mNGAqRB
         02wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSHE3Aj4iM6gYhcmQoszjlvxEipz13Xj0eMmdWnUjX4=;
        b=D3popDL8qWkYUoo3oNZV0b0q5yHWv7q1Xv7c8rcr4rcVlgoIZBXn1IgIaQkWHcSBdl
         ynO6vQcimtlikG7QA7viY1XpAQUiyNSsLbLuz673iq4kgGmO8Iq9P30KtuY9bMjZ7h11
         8M/FGHE2obUj10C/7ARYF8zIyA2Z90gFHVtdtLolHwbwQjDGrL2Pg/7wBpiTW87+Noxc
         OkR7RDTYzA9UW0wRXIcEGWGFTWIR6jTxjMreP3sepJ1kMcM6UMsVv3LjcGvxoDxD/DR8
         vc89KrPL0wq2cqcn2WfdytEXQaiw0EV+4CUQSwVUXkbuTWzmiqs+IOJoc52Enbth464l
         0kYA==
X-Gm-Message-State: APjAAAXvtUkd+Bi+W3QJdEVjDOTG7bAK6HzTbmEvf+gZUq/9Zl+NaKcQ
        0jSgEk8sP5U+L9c+ePM8jye6bA==
X-Google-Smtp-Source: APXvYqwNQlOjhdPJDabvXd+VV6Zz3w7TyVWQM5OdLcX6FI7/n+FZYKjSAvVJLzJ9hcSUKvagWbXgrQ==
X-Received: by 2002:a5d:52c5:: with SMTP id r5mr23636282wrv.146.1565357660850;
        Fri, 09 Aug 2019 06:34:20 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id y18sm5674641wmi.23.2019.08.09.06.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2019 06:34:19 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, broonie@kernel.org
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/4] ASoC: codecs: Add WSA881x Smart Speaker amplifier support
Date:   Fri,  9 Aug 2019 14:34:03 +0100
Message-Id: <20190809133407.25918-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing v2 patchset, here is v3 with addressing the comments in v2.

This patchset adds support to WSA8810/WSA8815 Class-D Smart Speaker
Amplifier which is SoundWire interfaced.
This also adds support to some missing bits in SoundWire bus layer like
Device Tree support.

This patchset along with DB845c machine driver and WCD934x codec driver
has been tested on SDM845 SoC based DragonBoard DB845c with two
WSA8810 speakers.

Most of the code in this driver is rework of Qualcomm downstream drivers
used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

TODO:
	Add thermal sensor support in WSA881x.

Thanks,
srini

Changes since v2:
- Updated compatible string to include LinkID.
- udpdated wsa driver to not register/unregister component in SoundWire
 status callbacks.
- Updated few minor coding style review comments.

Changes since v1 RFC:
- bindings document renamed to slave.txt
- fix error code from dt slave parsing

Srinivas Kandagatla (4):
  dt-bindings: soundwire: add slave bindings
  soundwire: core: add device tree support for slave devices
  dt-bindings: ASoC: Add WSA881x bindings
  ASoC: codecs: add wsa881x amplifier support

 .../bindings/sound/qcom,wsa881x.txt           |   24 +
 .../devicetree/bindings/soundwire/slave.txt   |   51 +
 drivers/soundwire/bus.c                       |    2 +
 drivers/soundwire/bus.h                       |    1 +
 drivers/soundwire/slave.c                     |   44 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wsa881x.c                    | 1134 +++++++++++++++++
 8 files changed, 1268 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.txt
 create mode 100644 Documentation/devicetree/bindings/soundwire/slave.txt
 create mode 100644 sound/soc/codecs/wsa881x.c

-- 
2.21.0

