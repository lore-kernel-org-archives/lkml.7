Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FF0C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EB221738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4XVy0A1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfDVTSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:18:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35388 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfDVTSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:18:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id j20so9775258lfh.2;
        Mon, 22 Apr 2019 12:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Va5MfqaQPyI3pbl3+krd4uj6AxljIhu5+njvICROMz8=;
        b=U4XVy0A12b6oc95eDI839UQlfXv4gkVUjZ2z1SsbQ40Fh48HS8nsgVawyuLjslV+TZ
         g9cAzMER6zKc2b5Omu526toB89a4uIvoumSHccN7XjIzGp5cS0pHFstfBN7mT4DgtZ06
         e5L2PlmAMya8DfLqZN+NNL6n2GOfE9+lrSvAJUGgwGa1/dKT5G0Ww3iU6ZrkvRqIBhNf
         oISadXxw6WnYH1HQKbjRu4EfSbJcXHLZVUnYvgaVTO2psaGOVU+f9cKi2dkSDqt5lOXk
         3R4d+IfiU+oMQHOpr/4BPsnErG2ms9exQ29vkB5SFikg9yu7PTlPAGAB/Ab7DH6bEDs1
         mXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Va5MfqaQPyI3pbl3+krd4uj6AxljIhu5+njvICROMz8=;
        b=e1LaDTEkvIIoQak7m6xh0auI4l7sPS7LMByOe1AisZ9GYA4Iv+75llx3pt6NjSnEKJ
         Hn6IU7wf6RfyHAwt/gQMrm8Xx2yqwnGweLxKXmUryx6ZLQ5csBehJWZM8BSTg6qHj4S7
         zkX1dIic6m7FOrtzP7fL7rxpwYt7oonUr4q5HgobKvB8kR8az0btgikjqkGZM4e0/7R8
         fo3+Ot43Nus2RkkzBWUaVMOO6kshcepvjda90pcsAHfVhnS0cWzPFGTf4QLyUk4SHpPA
         vz5uzJJeHT3nf4tUC9q1r3b5RdO800LUqRolB6tOcVSLfhJJ0Y7mOGxuf2uO2pEaQuLD
         h9zQ==
X-Gm-Message-State: APjAAAUrH5/CYYXNWbuo5Ze5zTudtCN3Lillr9T0pwCq6MOrRGjc6Hre
        HIMsFu1DxWLOKbYgysL80Kg=
X-Google-Smtp-Source: APXvYqzJTwdkeZtWvspq1Myg0wadGtcRthHdZt5Q/irvAx8hYUwHv8rU6/00RrBvOxEzehMa01/GGA==
X-Received: by 2002:ac2:4312:: with SMTP id l18mr11925117lfh.80.1555960729740;
        Mon, 22 Apr 2019 12:18:49 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l13sm2848762lji.39.2019.04.22.12.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 12:18:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] Add support for Maxim 77663 MFD
Date:   Mon, 22 Apr 2019 22:13:43 +0300
Message-Id: <20190422191350.27527-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds support for the Maxim 77663 chip that provides PMIC, RTC,
GPIO and watchdog timer functionality. The hardware is very similar to the
Maxim 77620/20024 hardware units that are already supported by the kernel,
hence we will reuse the existing drivers for 77663. The GPIO, regulator,
RTC and watchdog timer functionality was tested on a Nexus 7 tablet that
has the Max77663 chip, everything is working perfectly fine. I'm looking
at upstreaming support for that tablet device and Max77663 is one of the
core components that are currently missing in the upstream kernel.

Changelog:

v2: Added PINCTRL sub-device to Max77663 MFD as it looks compatible with
    77620.

    Added new "maxim,system-power-controller" OF property.

    Patch "Support device-tree properly" now doesn't remove driver's
    "id_table" since potentially it could have some use in the downstream
    kernel forks and it doesn't hurt to keep it around.

Dmitry Osipenko (7):
  mfd: max77620: Fix swapped FPS_PERIOD_MAX_US values
  mfd: max77620: Support Maxim 77663
  regulator: max77620: Support Maxim 77663
  dt-bindings: mfd: max77620: Add compatible for Maxim 77663
  dt-bindings: mfd: max77620: Add maxim,system-power-controller property
  mfd: max77620: Support device-tree properly
  mfd: max77620: Provide system power-off functionality

 .../devicetree/bindings/mfd/max77620.txt      |   7 +-
 drivers/mfd/max77620.c                        | 117 +++++++++++++++++-
 drivers/regulator/max77620-regulator.c        |  26 +++-
 include/linux/mfd/max77620.h                  |   5 +-
 4 files changed, 150 insertions(+), 5 deletions(-)

-- 
2.21.0

