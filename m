Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07330C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3052148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZR3xCwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfDXGsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:48:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42216 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbfDXGsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:48:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id x15so4419919pln.9;
        Tue, 23 Apr 2019 23:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:rom
         :content-transfer-encoding;
        bh=cHNHzxFl3pBm7zowposqf0VENFpqrPUSZ0MV7d2yTWc=;
        b=dZR3xCwFGy+G9TuBLh7IB3dN3T7/rcLjg3v++sdD1Mv87H6K0iCKRTPZq6b8IpM6sv
         VoD9Oz6Cef2m4zHVWJRN0UA1xMg1hpLus+ywt6UFJLEMhDoqPvYZn9hB4VU8FwfaXpUZ
         RpCpKnSHjMvnmevyHOUeVjLZ6oSm4mRXGS/qp+9oooGcP60waunOBPM1m5ONgBgJqFWh
         +vidswB61Isc1T17AroCCiFF9DszqKl4oFeJAEDFZq069OItshvXpt9NlutDQqmtXEOu
         kQjFwO0KUwJUpize/MuY8APgVq2x5XqjHoCdkvon+NSBXWhCfQBmOu9sAym6Cuh7NYh7
         wVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :rom:content-transfer-encoding;
        bh=cHNHzxFl3pBm7zowposqf0VENFpqrPUSZ0MV7d2yTWc=;
        b=EOzIbJJApdqA7zzo6x9hPr6fkR3kHKLJeJydehEoEs04T5Cu0A7YpZrczZRriWw9nQ
         QO9R8mvzDqnfxrbuevoP0TIrFRP/tGRnTiXp1eAvSzjxbEcHwgMe9VVurXZDrtWngVX/
         BzdekHe/cfH3kTDzFy3Ruu6oW0GX0zS9ISB1rOpWxKaRvk6E+cBUFSqC5xM0qJS6TgP+
         KA8kLh27ItPH7BccX9Xk3tb+BEGmi0jHSzNL8EqO9c5oksKz4L8Vl0o9OCa5hcmaypcL
         MOMSNJsWmsl7dOOqV1+uXkU4+pfTzzkADMAHgMJuElLVzOxQnPwRlRCoqGVntjMIPOcE
         1hGA==
X-Gm-Message-State: APjAAAXm9rNpGxYh/zet97O7etIcYw3laY2HBFCVfgdcf2B2ozx4fN8x
        1veswRm3DTEFDSL+9RfXzwkw0aA/af0=
X-Google-Smtp-Source: APXvYqwcyWhhpGZTHtbAuRAy9DZ3ZhzSFw1kIyKv3iyj3zLQxm9WDGQRsOZIEUxUbgzO72Y/b/4TpA==
X-Received: by 2002:a17:902:7241:: with SMTP id c1mr9853499pll.326.1556088516386;
        Tue, 23 Apr 2019 23:48:36 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e13sm26332457pgb.37.2019.04.23.23.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 23:48:35 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/12] QorIQ TMU multi-sensor and HWMON support
Date:   Tue, 23 Apr 2019 23:48:18 -0700
Message-Id: <20190424064830.18179-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
rom:    Andrey Smirnov <andrew.smirnov@gmail.com>
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

Changes since [v4]

    - Collected Tested-by from Lucas
    
    - Collected Reviewed-by from Daniel

    - Converted "thermal: qoriq: Enable all sensors before registering
      them" to use if instead of switch statement for error checking

Changes since [v3]

    - Series reabse on top of [rfc]
    
    - Fixed incorrect goto label in "thermal: qoriq: Pass data to
      qoriq_tmu_calibration()"
      
    - Added REGS_TRITSR() register description to "thermal: qoriq: Do
      not report invalid temperature reading"
      
    - Reworded commit message of "thermal: qoriq: Remove unnecessary
      DT node is NULL check"

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
[v3] lore.kernel.org/lkml/20190401041418.5999-1-andrew.smirnov@gmail.com
[v4] lore.kernel.org/lkml/20190413082748.29990-1-andrew.smirnov@gmail.com
[rfc] lore.kernel.org/lkml/20190404080647.8173-1-daniel.lezcano@linaro.org

Andrey Smirnov (12):
  thermal: qoriq: Remove unnecessary DT node is NULL check
  thermal: qoriq: Add local struct device pointer
  thermal: qoriq: Don't store struct thermal_zone_device reference
  thermal: qoriq: Drop per-sensor data
  thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
  thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
  thermal: qoriq: Convert driver to use devm_ioremap()
  thermal: qoriq: Convert driver to use regmap API
  thermal: qoriq: Enable all sensors before registering them
  thermal: qoriq: Do not report invalid temperature reading
  thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
  thermal: qoriq: Add hwmon support

 drivers/thermal/qoriq_thermal.c | 282 +++++++++++++++-----------------
 drivers/thermal/thermal_hwmon.c |  28 ++++
 drivers/thermal/thermal_hwmon.h |   7 +
 3 files changed, 168 insertions(+), 149 deletions(-)

-- 
2.20.1

