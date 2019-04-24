Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20ECC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD102183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+43NYA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfDXWtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:49:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42237 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfDXWtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:49:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id i186so4501508lji.9;
        Wed, 24 Apr 2019 15:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gijtPULiobsGHYV3TOfcwTxfm4m5F6+46+RVKD3rH9s=;
        b=A+43NYA9AtQ3bIiQ2aNyTrNFc95ey7PkPWZXM+uc4JDbV5zwM146vx5wuicqwNIFu0
         j+gzrAmIi0dKVSSL7sGq76Uawrn6cjILMK69IKB0VIN6H7g0/RA/qY4wD5r9hhr+ToRH
         LVPAk11pY3UhfhT0LUpMSWc7OEgnEhM4Lixc3YsMm4fvUNy6R2Jw6ArEE0ce0WmYcQlR
         hMwuX25NJJwEgRKz0m3FBrU1UDIMOxY7SSJGZrzVppqp9OQ0m5A+2aL0UuxMEdaQN1gM
         /pegiZw46MscpolBqJAIPGFWpuCgwwHjfflPextb/ZpE+Bam6P5Ivfj4rJIYBjkMBaEI
         66Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gijtPULiobsGHYV3TOfcwTxfm4m5F6+46+RVKD3rH9s=;
        b=lFWkjK6Vk46GgvQZIEzyZLfRw7wK4auYFQIrZBUSM17ZX4KdjSeZopnM2RzY/r7J4n
         X8o30mDL8MI9Ydk3xjl/1XtgQjJC5V8lLBxR4BK2c/1sW6KTgBUPNpTUjuHx9HCMyHCC
         U35S9AUUlphM/JABdylnXRCbSpw/XAVP/CesXIznd9py822sDZB7q7jSUq0QqvwrEAfy
         5zrOB64Nra0ZUwENOSmKclC+tPi/74v8W3jy7IkPRmCZ3xBoxlRrBH7wQ4Lu3XIqDUiv
         kcxddTsCfEHrqWmrTzl2D8w7zfXox0bEB/NgzAtRAcHeYDjs9p+IHWUfb7VIoL7ng6CQ
         DRhg==
X-Gm-Message-State: APjAAAU/BPNEJ3dAtl3nelsI3bgqPbt8UvlhRR8zxa4J+OyIxf9tQeqN
        K3rB2lxWLniRlPHm6sDHvUh0/2u5
X-Google-Smtp-Source: APXvYqxGPvV37XRBWOmU1cGRCBPIQb4jveoxGIQGssA8+cQymAZI4xNyaDmvlDeh/orC+yze0UifCw==
X-Received: by 2002:a2e:8ec5:: with SMTP id e5mr18950288ljl.7.1556146179839;
        Wed, 24 Apr 2019 15:49:39 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id s24sm4219879ljs.30.2019.04.24.15.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:49:39 -0700 (PDT)
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
Subject: [PATCH v3 0/6] Add support for Maxim 77663 MFD
Date:   Thu, 25 Apr 2019 01:48:54 +0300
Message-Id: <20190424224900.8018-1-digetx@gmail.com>
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

v3: Dropped "Support device-tree properly" patch since turned out that
    I2C core takes care of the device-tree matching and I wasn't aware of
    it.

v2: Added PINCTRL sub-device to Max77663 MFD as it looks compatible with
    77620.

    Added new "maxim,system-power-controller" OF property.

    Patch "Support device-tree properly" now doesn't remove driver's
    "id_table" since potentially it could have some use in the downstream
    kernel forks and it doesn't hurt to keep it around.

Dmitry Osipenko (6):
  mfd: max77620: Fix swapped FPS_PERIOD_MAX_US values
  mfd: max77620: Support Maxim 77663
  regulator: max77620: Support Maxim 77663
  dt-bindings: mfd: max77620: Add compatible for Maxim 77663
  dt-bindings: mfd: max77620: Add maxim,system-power-controller property
  mfd: max77620: Provide system power-off functionality

 .../devicetree/bindings/mfd/max77620.txt      |  7 +-
 drivers/mfd/max77620.c                        | 88 ++++++++++++++++++-
 drivers/regulator/max77620-regulator.c        | 26 +++++-
 include/linux/mfd/max77620.h                  |  5 +-
 4 files changed, 121 insertions(+), 5 deletions(-)

-- 
2.21.0

