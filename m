Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A684C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C66120656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ImAZTHHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfEIQ3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:29:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41526 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfEIQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:29:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id d12so3907601wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=xnUcq849ljF3W1PVVaGBumjDSyHUcTVt7HVj2vrbpqs=;
        b=ImAZTHHuJkcRseb3Xm8ZXczl83t2j4YUlF5xajtB6swwmxCVE+rFqGrqeSLPxSt6Nh
         5DR4zpcHG/qA3XBzGzcVQG8xCpjO4PTSA4NWFKu2BPfbTnkQXLnX4Y4wS2j/AAa6reee
         s8AKXQiSpZE31rUUZMH+Mfdm0vr+7rSmGGz6wEKeOu0/YjPUo1aAoRp3g9PNi7js2ZC1
         zcoD5rAHg2oU6rBrot11qF8DFCKp7Uc35edkIY6cMBaXJaZhvvCDtI1dSz3OP6K73bkI
         J4jdszWKQGJjWeW2k/pVLd5l5N8h7zo3F1VAiuDpxupiHlUHq+1D+Y4H91t27ZkVa6O1
         dmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xnUcq849ljF3W1PVVaGBumjDSyHUcTVt7HVj2vrbpqs=;
        b=qTNI1cu9CpEPu65RuZxVKjDMno+LdWD418Qcv+bCkq3oHwW8wSKOkQrIWk0xpRewSp
         RpBjcdDmjc7yOjJUb5HZlYHQC/OQ1n5iDf76zruWDfAzDAsLVUbq/jaiRwy431Yv46fy
         8/Qp9EtW/M4ZlGGmmfE4I1POyn4Vl0uOOUqZAqwT0Y6X6MZNheSXMUrkP2NDcr1kzksW
         AvRGPuDVK7JvnEI/FLjbwKzJK10T3NOrAChjVJSwODOTjah8KOlBOUnM6OZUQ0cfTgjy
         Hnpx4N8weEAZAbVKORQhKnxZI8OjYGh0vnEC9HKx1k2h+CyT4PmC06/9cNn0LTvt+4PU
         4SGQ==
X-Gm-Message-State: APjAAAUAB6JhBh5LyD/a8hdwvjlMmJy/tt9CRYEc0Y63nYKtH6IXY5dK
        oQdkAgbccQ8OZLm73Dty8tB2zQ==
X-Google-Smtp-Source: APXvYqz6tghhvw5ngKFutUOgPjB5QMLbIMJhbXOpnWUau29mKVkEg/a0IPmLzTZ8+PO6XTPmB4S4gw==
X-Received: by 2002:adf:b3d4:: with SMTP id x20mr4226008wrd.284.1557419341336;
        Thu, 09 May 2019 09:29:01 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.home ([2a01:cb1d:379:8b00:1910:6694:7019:d3a])
        by smtp.gmail.com with ESMTPSA id z7sm3649796wme.26.2019.05.09.09.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 09:29:00 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, khilman@baylibre.com
Cc:     jbrunet@baylibre.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] Add drive-strength in Meson pinctrl driver
Date:   Thu,  9 May 2019 18:28:53 +0200
Message-Id: <20190509162859.7001-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patchset is to add drive-strength support in meson pinconf
driver. This is a new feature that was added on the g12a. It is critical for us
to support this since many functions are failing with default pad drive-strength.

The value achievable by the SoC are 0.5mA, 2.5mA, 3mA and 4mA and the DT property
'drive-strength' is expressed in mA.
So this patch add another generic property "drive-strength-uA". The change to do so
would be minimal and could be benefit to other platforms later on.

Cheers
Guillaume

Changes since v3:
- remove dev_err in meson_get_drive_strength
- cleanup code

Changes since v2:
- update driver-strength-uA property to be compliant with DT documentation
- rework patch series for better understanding
- rework set_bias function

Changes since v1:
- fix missing break
- implement new pinctrl generic property "drive-strength-uA"

[1] https://lkml.kernel.org/r/20190314163725.7918-1-jbrunet@baylibre.com

Guillaume La Roque (6):
  dt-bindings: pinctrl: add a 'drive-strength-microamp' property
  pinctrl: generic: add new 'drive-strength-microamp' property support
  dt-bindings: pinctrl: meson: Add drive-strength-microamp property
  pinctrl: meson: Rework enable/disable bias part
  pinctrl: meson: add support of drive-strength-microamp
  pinctrl: meson: g12a: add DS bank value

 .../bindings/pinctrl/meson,pinctrl.txt        |   4 +
 .../bindings/pinctrl/pinctrl-bindings.txt     |   3 +
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    |  36 ++--
 drivers/pinctrl/meson/pinctrl-meson.c         | 180 ++++++++++++++----
 drivers/pinctrl/meson/pinctrl-meson.h         |  18 +-
 drivers/pinctrl/pinconf-generic.c             |   2 +
 include/linux/pinctrl/pinconf-generic.h       |   3 +
 7 files changed, 193 insertions(+), 53 deletions(-)

-- 
2.17.1

