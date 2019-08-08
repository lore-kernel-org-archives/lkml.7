Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762D7C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E88C21882
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xS/2nlZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732900AbfHHOp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:45:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40169 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732477AbfHHOp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:45:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so95160565wrl.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 07:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLpi2SDrc2znQNHPwAZliuGZd7W6XSprQ25LlaiC9Uk=;
        b=xS/2nlZprXdtEBLiGBUpjV5rlh11ZEu2Nuwixb9ksnlj+Rw441FmPXat9qBfqLoE/h
         3jdXGYqvLxETaqpHmQnFFGWwdC5q4a8vnu4SYuswuGPfqQL/cftMQPO5VzF4+xS0Er45
         aAeKkZvLT+LCd4L6N2MjfnRQdr0Axt/YapOfLE5vmgKeTtDGKIy/kxeIFXR/wnU5bK+P
         I2h7bQnYRnLbBVVpseEBf4//8cwaTrPnaa23hYNYNZeU3RmhO6KPp9jOGCDBcF9T6OAr
         +QBUn6g5Q3x/gmSVbtJ0OmOpD6NDd55MDcUd8c9V9cDEomKCXAWG3T30jwKKdheI7o9u
         l3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLpi2SDrc2znQNHPwAZliuGZd7W6XSprQ25LlaiC9Uk=;
        b=FOCiTHItg9QARba4++bVkRJJJZRdJV9tJ63aK0hjMlTk7O5AGj94Z6ZUsW8nvMWwEi
         Tik7zOL4bXDNHegHqOYbdnndUZAWSQllcQNYmwNxun9Bx24OOafvZngj15ozPUV/opP0
         SRLMRoVHsC1yVzksbCZ+CSFr6XwN0brtHiKg7OqSVchntDIQe2eQsNFn+xxdLnzCMpC0
         M4cewQHip4zsKUEnYfAqnzV5eGEiI0SzlMeHfiZqKWhRKky0tQ5Uym/8UdjhhZUgT/BP
         QJ+QEa3pgrNSU2l/swnOr4WUI6hHWNAtk9BgZBFV7UrF2/Exl+iJxEkW1M21YGW3rFYc
         uk5Q==
X-Gm-Message-State: APjAAAUhxPVDjpLjpK4R5T18+w4alvDls9w28xaSgkWe/p4uGFRHZ+lH
        Nt5sHwswGhMJAnHmQsHs7OWRqA==
X-Google-Smtp-Source: APXvYqxGi/2lzaPlzG3WSRB3FQSrUSGckOdWNhEK1yAlz6qCO91d2lpbJo0TQvJ26p/tCNbAwWf2sw==
X-Received: by 2002:adf:de8e:: with SMTP id w14mr17439418wrl.79.1565275524077;
        Thu, 08 Aug 2019 07:45:24 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id g15sm2009060wrp.29.2019.08.08.07.45.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 07:45:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, broonie@kernel.org
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/4] ASoC: codecs: Add WSA881x Smart Speaker amplifier support
Date:   Thu,  8 Aug 2019 15:45:00 +0100
Message-Id: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
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

This patchset also depends on the soundwire Kconfig patch
https://lkml.org/lkml/2019/7/18/834 from Pierre

Thanks,
srini

Changes since v1 RFC:
- bindings document renamed to slave.txt
- fix error code from dt slave parsing

Srinivas Kandagatla (4):
  dt-bindings: soundwire: add slave bindings
  soundwire: core: add device tree support for slave devices
  dt-bindings: ASoC: Add WSA881x bindings
  ASoC: codecs: add wsa881x amplifier support

 .../bindings/sound/qcom,wsa881x.txt           |   27 +
 .../devicetree/bindings/soundwire/slave.txt   |   46 +
 drivers/soundwire/bus.c                       |    2 +
 drivers/soundwire/bus.h                       |    1 +
 drivers/soundwire/slave.c                     |   47 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wsa881x.c                    | 1160 +++++++++++++++++
 8 files changed, 1295 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.txt
 create mode 100644 Documentation/devicetree/bindings/soundwire/slave.txt
 create mode 100644 sound/soc/codecs/wsa881x.c

-- 
2.21.0

