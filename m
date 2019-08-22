Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8AEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457F923401
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ew8+IDWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404871AbfHVWgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:36:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37657 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394044AbfHVWgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:36:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so6854737wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 15:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ps5fSEr1qMGUj4gJBzVj6xZCpnRrFx1jjYFeOMLoqEo=;
        b=ew8+IDWCuDX0P3zBzbl9bTTlRaF0BjyzxzUXr2A4u5xK1/1vjRmnlQsuoznfX/TRJz
         h98W/LezmoT47tSdIUXsrmmR+t0yKAEoenYnGoC2W/iQbwTBsqrE83QFkkQOeovJUs8B
         BF4mlJ3rRB4eusmQ3nFwosElKoFRF8Dtrz6BsFm7D2JOnayubL8m4n6yldfxF4O4u9Rc
         NQI0TUTQNl3MgJg7SBSkWeeckHhdkMeqqaqkZAX3WUUnM35p1ij+guS9I4PFQFB3YNH7
         e0bpPWTJyNfm1HV+9YTAU7KErnLd2q7vPz9CUpUoXuTtldjoqbgZVyK1GL2AKEdQcCc5
         sK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ps5fSEr1qMGUj4gJBzVj6xZCpnRrFx1jjYFeOMLoqEo=;
        b=t4GSHdHtezVGAZ0SISCZsGMAwPAtl9U6JeWufMFHqCrPMw8y15cs8RcwTRyh2Ewhsl
         c52jPUsJaRMO/+9HNPmbauXWdV0UE5KA21x5fGokYlQ/2RrJOha2fYczFmHdYtwXLAhf
         KQN1NCIkV0hi9J+i2ZKKCWCvlVTrMLw2p2adbjFrurXnllqgL2xHgvDJ0sVf7aj3a2U6
         brhsT86m8/xSaFUD23PdwZBzoRRa74mlNWBd1QYeu7f1sQ/D/X1/wOOTxJ/pWBbDJgUJ
         aCCmb6UTkwT9oPqahQtLMtt2db1pXU5FTN1wzayyIzRs6EXPe7yU+XA+xHiIlGkjqDVW
         De9g==
X-Gm-Message-State: APjAAAXURCgr29M91BvL2PfaA95rZG2ujOUkZARWPLQfR1O3DDLyW3fb
        c3C0WgBqG3WwWwObDXPbSjwjEg==
X-Google-Smtp-Source: APXvYqx0IIRgPoB4p4JYzy/bI4HE0dPeSOqiMsFu/NXuJ66mmtgb/OaIc1NqXxObaoj/F0XPLcPH+A==
X-Received: by 2002:a5d:678a:: with SMTP id v10mr1136982wru.116.1566513381364;
        Thu, 22 Aug 2019 15:36:21 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id m188sm1886380wmm.32.2019.08.22.15.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 15:36:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 0/4] ASoC: codecs: Add WSA881x Smart Speaker amplifier support
Date:   Thu, 22 Aug 2019 23:36:02 +0100
Message-Id: <20190822223606.6775-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing v3 patchset, here is v4 with addressing the comments in v3

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

Changes since v3:
 - updated slave bindings according to Rob's Suggestion.
 - moved bindings to yaml

Srinivas Kandagatla (4):
  dt-bindings: soundwire: add slave bindings
  soundwire: core: add device tree support for slave devices
  dt-bindings: ASoC: Add WSA881x bindings
  ASoC: codecs: add wsa881x amplifier support

 .../bindings/sound/qcom,wsa881x.yaml          |   44 +
 .../soundwire/soudwire-controller.yaml        |   75 ++
 drivers/soundwire/bus.c                       |    2 +
 drivers/soundwire/bus.h                       |    1 +
 drivers/soundwire/slave.c                     |   52 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wsa881x.c                    | 1134 +++++++++++++++++
 8 files changed, 1320 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
 create mode 100644 Documentation/devicetree/bindings/soundwire/soudwire-controller.yaml
 create mode 100644 sound/soc/codecs/wsa881x.c

-- 
2.21.0

