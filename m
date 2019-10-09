Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EF8ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E739218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgLRRZYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfJIIwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:52:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34853 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbfJIIwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:52:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so1787638wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 01:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kIXSgqPot/VtHtCYhdqESFswgKhZA/r+U2HQFD+JPgo=;
        b=YgLRRZYuoAZwYcthuxRPzBi/noASE7Z6NQeQ7wPn8AHqgTR+fv5F10cz4dKU2NoQPm
         7Fj65EDd4DgPh134OONDT8GVKQl2hxntl7NXFSprLnO+p6TmNePG8ONMtpWWdPBm4jSY
         Z7xE9r9SEYM74vEdRM8527c1BFS9G6Hc2kMIQi5aAPG2Cxl0kmB+Ke9ECuR4RgHA91F8
         BBoerfCgxKA9SqihRnDE7WNg0PvVDkyDeUjNoeHZr3NPr02DEjl608ylnIrs37R4em8M
         8KJYPecHqgo1x3qJSXalEBlzMeJ0GER0xRuqKpV+PYhEJ8PBs7zD7EruPCcTkz7girvK
         UUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kIXSgqPot/VtHtCYhdqESFswgKhZA/r+U2HQFD+JPgo=;
        b=F6GPIbsqRGNnOcZ3EwWbuXnARLoqmufQzcByuwMZZNgjgROKP3cnrn3vPRlzjgdxeT
         xwyiuXNP+5mw05HpTuGT+YkUMyeHeVaaj/TeKK7NQBDHStNRtfKTV0ltKwex59Ep0gyr
         V6wsAI5qCuETrEYyI+OGKY2X4LcrH50DyJ8WO7LuEoNjKVf+1KlLfULWLNa4Q3/0M3Nx
         9ZcCaNjuh71BAO5RFsFIHIw5nNFvmB/ITMRdNDl2UaRBcbX387alyxma2EyjL6p7iXxW
         +CDdMPR5E7j+tHvIqZNJ3nz65n92SYHKFGKHr2PfiFnPt+nY7vqK0/60qyqp1xVhqiQg
         7YGw==
X-Gm-Message-State: APjAAAVo4wy4ahnwXl9ErzrGroicUDaN8QABCAEucSV0pRVLIq+dpj8W
        KXoPvWoCaSFvV1zZCLcKR+7ATQ==
X-Google-Smtp-Source: APXvYqws1ottQYgV2u6n6BCavAvLpJrmB3BJnOxpCU3FGnq8IrsHlRBrn75l3yq5qrftbTvHq7ZAOQ==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr2052521wrv.141.1570611117411;
        Wed, 09 Oct 2019 01:51:57 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b144sm2476291wmb.3.2019.10.09.01.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 01:51:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     spapothi@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, vkoul@kernel.org,
        pierre-louis.bossart@linux.intel.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v7 0/2] ASoC: codecs: Add WSA881x Smart Speaker amplifier support
Date:   Wed,  9 Oct 2019 09:51:06 +0100
Message-Id: <20191009085108.4950-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support to WSA8810/WSA8815 Class-D Smart Speaker
Amplifier which is SoundWire interfaced.

This patchset along with DB845c machine driver and WCD934x codec driver
has been tested on SDM845 SoC based DragonBoard DB845c with two
WSA8810 and Lenovo YOGA C630 Laptop based on SDM850 with WSA8815
speaker amplifiers.

Most of the code in this driver is rework of Qualcomm downstream drivers
used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

TODO:
        Add thermal sensor support in WSA881x.

Thanks,
srini

Changes since v6:
	- Added reviewed-by tag from Pierre and Rob
	- Removed udelay argument as suggested by Pierre.
	- Added device id for WSA8815
	- rebased on sound-next

Srinivas Kandagatla (2):
  dt-bindings: ASoC: Add WSA881x bindings
  ASoC: codecs: add wsa881x amplifier support

 .../bindings/sound/qcom,wsa881x.yaml          |   62 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wsa881x.c                    | 1113 +++++++++++++++++
 4 files changed, 1187 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
 create mode 100644 sound/soc/codecs/wsa881x.c

-- 
2.21.0

