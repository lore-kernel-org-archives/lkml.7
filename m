Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5861C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B4D233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dsMUqV6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfHVXiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 19:38:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43704 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfHVXiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:38:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8so6922722wrn.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 16:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mxo0eAEf3fJwKk0DHfBYnFpenezLkSgCZl+oCD3TV3M=;
        b=dsMUqV6r4O2zGkVt3hW+Fx7aIsyRgpSQErbvTBN7+ZPaKFr9tuyizHRQVNeMj8c4XL
         WFqYh1lZiXvZUF8xFPzF25S0ERpoYImdgLie7gREL490yoNp1SvV8CBy/YApGjaF1xfb
         YMQXlQfC5sVNrCpzMUAAR8I5GJpnuxwlW6wz/sOa45gwrVdGDthTfDW7U08uwMNtn/bg
         RYUxSd6OeQCpxstLos3AlTzNgqV4UDeRrK+BP8U4DIahtvTu7depDZnlMMDU8KeiSp1E
         TyATForz+R18C3S+TDdHTIV2Aw67+PvqLnMsmtOkgF6lE+Gfu7jnCB4RljVzbuI2rQik
         ta4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mxo0eAEf3fJwKk0DHfBYnFpenezLkSgCZl+oCD3TV3M=;
        b=i4oc+juaDvc42hf6GSCfGf42kkM3ckihLRXGPkNmgmNduyeCqfoPCcNsLl0geduARp
         5sJLGlP7300IzNEvgiRx7uU4wN+PhrCbNVdS2n2yjkahAAsFHy6y0Uge1dQfxa4Y/BnV
         B3i8M8oxCzONZuVj6n03yB4DY35MrqJwfuARJF26u0OKWCexBlwd6iR7yF5lz5nKqo9g
         hXEMNPEy1H9Wf8HFEBdDdBt3ESCsAWzj/cymhJ/S4oyxCZB2wzKggP2lzsu6HTbXpVQg
         Eh/G8V5XYn9Pg01oX8mdAeud95mFufdifxipRbBk+hd1+OUelztPOfMVrfnLatIShLho
         iIhw==
X-Gm-Message-State: APjAAAUTwYbN8LPuoAHhndk/F3MacB6vAww1O416tAoXL/yTfnWBXjCj
        tUFaxvb+W3//FHfvhPyg5h/+qw==
X-Google-Smtp-Source: APXvYqzVwNyXgKAoUxu6i1pDAVSMuh+VIbRZnl5lFohQGcKO7KCWaa0n9xm8Y4YFV9dQ970h6z0pmA==
X-Received: by 2002:a5d:4ec6:: with SMTP id s6mr1210862wrv.327.1566517099942;
        Thu, 22 Aug 2019 16:38:19 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f134sm1705157wmg.20.2019.08.22.16.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 16:38:19 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH v4 0/4] ASoC: codecs: Add WSA881x Smart Speaker amplifier support
Date:   Fri, 23 Aug 2019 00:37:55 +0100
Message-Id: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending this series due to a typo in yaml filename!

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
 .../soundwire/soundwire-controller.yaml       |   75 ++
 drivers/soundwire/bus.c                       |    2 +
 drivers/soundwire/bus.h                       |    1 +
 drivers/soundwire/slave.c                     |   52 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wsa881x.c                    | 1134 +++++++++++++++++
 8 files changed, 1320 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
 create mode 100644 Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
 create mode 100644 sound/soc/codecs/wsa881x.c

-- 
2.21.0

