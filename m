Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18322C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0499218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbyX0JA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfDMI2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:28:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41288 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfDMI2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:28:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id f6so6279892pgs.8;
        Sat, 13 Apr 2019 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w7PzrdiD8M39A2YeY9pwinOAmcfvaic+M3PQMjUplmA=;
        b=lbyX0JA3PC7mhgsXoFv4MHrZ35xTdM/opJQ2ea9nBAJe0zKlP9BEEg6CAgKQyfvV5M
         FXmQNWdOo/8tTOyH/2tF+sdRAxIcBcW2HmjsL8nBIuFrJMinfQsNwQU74LxsC6WnCZN3
         Y7asVGuf/F9cpXTjMemeCu04EB6eA7Llx/hYLlGT4I2iaHXxRi8CjCiZmJKog7deVktZ
         14pgVTJJCvbd0ygX4vW3Hy7Aj1ZQ1bWHUisCuCxicoHtL5EIzm5HXFfO7j0CnCkKir1F
         nUNGN72WXq6Z8y2NzVe8BeiQ5CA5z22IPdL1p31TlmbjfRoJrdpoHvkmXAN6DxCUL8Y5
         hwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w7PzrdiD8M39A2YeY9pwinOAmcfvaic+M3PQMjUplmA=;
        b=mQBPuTaq136RYO0CFQmfTit0YYqOvlkcTT/B2DV1bzuvuKNkQcmtRvIvQh/gRhMbaj
         bhG8m67FymkwdH/nRWSPOceC9wxyNNpLNmdJ4FJrc0PNS4enTNnvJ7aXLeqh5/jY22od
         6gLH2IqlnGKf9pb6QmMt2suWKjFVmqwDOcBQGBx3VPA2ypD6qYCoiTgxrA63LqaOtXN5
         Y8LhWO+hQbh3Cv/HL14SE+U2xSXEHBD0tbrpIX0svjwEp06RcQB8pcVCncQH4CwwRdIL
         dl0HjkQsC/KWdtomOJXfbZ7PivL0fp7qVmGOsRUI2/k8FMXQXwaMrDmm/4gmZ2mcLAQi
         woAw==
X-Gm-Message-State: APjAAAWB6ZUoys7jKsw3JoNJ9LDbar2qZo7g34ZH2xohgqVFubt4Or8u
        c2Qv9n+wzFdFqWspS01DjVHL/5tq
X-Google-Smtp-Source: APXvYqwIE++srivWk3omdWrXgGXzHUpwHtQ2kDTmxIpmClq9TXtLek6IJQvpoyUuFraqGRQazzEQqQ==
X-Received: by 2002:aa7:9888:: with SMTP id r8mr7721143pfl.116.1555144084771;
        Sat, 13 Apr 2019 01:28:04 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z20sm58261328pgf.70.2019.04.13.01.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 01:28:03 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/12] QorIQ TMU multi-sensor and HWMON support
Date:   Sat, 13 Apr 2019 01:27:36 -0700
Message-Id: <20190413082748.29990-1-andrew.smirnov@gmail.com>
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

 drivers/thermal/qoriq_thermal.c | 287 +++++++++++++++-----------------
 drivers/thermal/thermal_hwmon.c |  28 ++++
 drivers/thermal/thermal_hwmon.h |   7 +
 3 files changed, 171 insertions(+), 151 deletions(-)

-- 
2.20.1

