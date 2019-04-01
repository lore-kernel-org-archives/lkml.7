Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2136C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01CD20870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vqq89Tgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDAEOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:14:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41962 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDAEOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:14:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so3866928pfd.8;
        Sun, 31 Mar 2019 21:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+aNBpE7BPQcdIr2xYC8qKz37GE8FM53sN8t5czBmbk=;
        b=Vqq89Tgj+ajrsHlJISZLIIK0T8N+RWbz/PYnothZSoS1c3eezRBQ/uTRl9ccrSRsCl
         Zat20QT5cK822uRcTginFQB1iO58zUgZckERYx+KYvORjyXcoYhbeiOdYTCwk3gBmNYS
         WKhmV5wImgBWW7Hzo60+LUR3YMcmxL/U1D84omAoWgZHwldJCIrdDtQVjF7XyP9eIHUE
         SobZxWC49UPVW6GR+GAiTOkJIVJLs0tSnrLGgj7B5e38JMkwxu1XrIM3l8TDWuZfHSSx
         MNUDL6RvU4JB2u9xE3MiQ70qgQKMw5kql5/ZgMjmlVJKsb7aH4do4iBeiv5ZXFpPDJ0u
         +fyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+aNBpE7BPQcdIr2xYC8qKz37GE8FM53sN8t5czBmbk=;
        b=d7xPXDXX0NHVSqsuceozjmzjZfF+T214SDffw0GD3QrXXoi0SniLI5Jef0icFXhv8f
         GTcc8CeZtFoPPbOWdAm2FhEH69J+ofUYxYSNjYFz/SgKXz5HHWgRZQUc6nlbywZoM4YB
         hp0eyTf7xL9jesBiyThgq4R6X0LPLRK6wnnuGEVILfRmo7IREYBQEoyRJmffH/FjXRhh
         4sXD78PtReRDvB0HVEqCf4SON47Af/uMtUtR7Bpu4cw+h11lphBHRcnhc17XqfHONpkH
         x9DxaTcYtnjUouBJOldCIItc2a5c3TvBXAfM9Az1nLQ+XxDSNDhNpbFXJjpPf/Af4TG1
         XJDQ==
X-Gm-Message-State: APjAAAUeAkztcckuzct6AkgQpeKgzXgsom1xwVAbGXsiEJxfuDi8/ISR
        n93E8Uxv2Vbg5HcE6piHReJOMMCw
X-Google-Smtp-Source: APXvYqyhFAEdxjobZmOzIN05bN+BdjYHkk7/Zm1flSmPcTw1FafCu1Xro5vaMglhb2igXX581x/iLQ==
X-Received: by 2002:a63:1048:: with SMTP id 8mr35236715pgq.70.1554092072966;
        Sun, 31 Mar 2019 21:14:32 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a12sm9968504pgq.21.2019.03.31.21.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:14:31 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/13] QorIQ TMU multi-sensor and HWMON support
Date:   Sun, 31 Mar 2019 21:14:05 -0700
Message-Id: <20190401041418.5999-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series contains patches adding support for HWMON integration, bug
fixes and general improvements (hopefully) for TMU driver I made while
working on it on i.MX8MQ.

Feedback is welcome!

Thanks,
Andrey Smirnov

Changes since [v2]

    - Patches rebased on v5.1-rc1

Changes since [v1]

    - Rebased on "linus" branch of
      git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
      that included latest chagnes adding multi-sensors support

    - Dropped

	thermal: qoriq: Add support for multiple thremal sites
	thermal: qoriq: Be more strict when parsing
	thermal: qoriq: Simplify error handling in qoriq_tmu_get_sensor_id()

      since they are no longer relevant

    - Added

	thermal: qoriq: Don't store struct thermal_zone_device reference
	thermal: qoriq: Add local struct qoriq_sensor pointer
	thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
	thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly

      to simplify latest codebase

    - Changed "thermal: qoriq: Do not report invalid temperature
      reading" to use regmap_read_poll_timeout() to make sure that
      tmu_get_temp() waits for fist sample to be ready before
      reporting it. This case is triggered on my setup if
      qoriq_thermal is compiled as a module

[v1] lore.kernel.org/lkml/20190218191141.3729-1-andrew.smirnov@gmail.com
[v2] lore.kernel.org/lkml/20190222200508.26325-1-andrew.smirnov@gmail.com

Andrey Smirnov (13):
  thermal: qoriq: Remove unnecessary DT node is NULL check
  thermal: qoriq: Add local struct device pointer
  thermal: qoriq: Don't store struct thermal_zone_device reference
  thermal: qoriq: Add local struct qoriq_sensor pointer
  thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
  thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
  thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
  thermal: qoriq: Convert driver to use devm_ioremap()
  thermal: qoriq: Convert driver to use regmap API
  thermal: qoriq: Enable all sensors before registering them
  thermal: qoriq: Do not report invalid temperature reading
  thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
  thermal: qoriq: Add hwmon support

 drivers/thermal/qoriq_thermal.c | 274 ++++++++++++++++----------------
 drivers/thermal/thermal_hwmon.c |  28 ++++
 drivers/thermal/thermal_hwmon.h |   7 +
 3 files changed, 169 insertions(+), 140 deletions(-)

-- 
2.20.1

