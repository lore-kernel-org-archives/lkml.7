Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEF0C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027E62086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ALAHy9Qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfFEIdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:33:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40931 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfFEIdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:33:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so13687453wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vdptXZpu4LSX12pCYwIuZQ7IZAANQVexuK981Stg0C8=;
        b=ALAHy9QmYv7XXWye+P3GXr5WU1UBM7bpcAsb7JjMhGfhzFK3WTSgq/gW44X6s9DOOU
         Gw8HELrnNrL9ZOQJmWNOqcViKXL7Sd5viTsVA0Q5MLVLthX6g58h35/3DmaK2HPZzhhD
         sje7iHdviQdSy+B6RipLN3FM/ZGi/OGTDeMW/LLtCHO3pEaDn9BXkyJFbNgNdrS3PHt+
         /3/jMj2U55oO5OsWSC7R7Ca48Z64cAhsmLCy6essSLonYiZTtEPIudofmZIksO1TMmNf
         V/Z9D2Vv22H/lyRMEl2a24fB5kF7oMk30DEakRsmq5XN2pFxO7VScBTMlTSG7p8I8SYM
         k5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vdptXZpu4LSX12pCYwIuZQ7IZAANQVexuK981Stg0C8=;
        b=C4q/Wy+pyRj7V3E72UO8P371NzdYLghwi+lxV5QPCbClE3nOokb4r00pDcAd1hwkGF
         CqfsdB9I0Q9SM7dvlGpH/mC6ym4d0YIgY1peThMnZXSU0R0rolz1+tmtc6SwIY78VtZ2
         3gTpg0+ttsxbe8CINI6ZWvo5VupEhmiRU7D/51voqiETHJXaMqdE+IKDg89fep5C9jK2
         bGW2FTkzCyV1F2K1N1TVq80P7eiFcfH9zuGtlg5Qlq9fNHF4ycLa8wX3+VIIo/iFhM5D
         xvl9EulRWO33Z1QOibY4qA3MO/TTxsQId2ByfCcIejhoke/ZEhz/37z97ODBaS5klaVu
         ZWZQ==
X-Gm-Message-State: APjAAAXKx8zs905UwyXFLu4VMhXddLkywrF4sY+z7/K0zBJO8vI4BZcY
        x/DjMb/H4IRn+atwYkry9wjbKQ==
X-Google-Smtp-Source: APXvYqyotqt2GSUVfKt41uOpAW3PK5kR7ACoXfTM+FsjWd3orDAWwl5xXL8dCNOr84ImWYJtqfdXbQ==
X-Received: by 2002:a5d:5186:: with SMTP id k6mr7551716wrv.30.1559723618540;
        Wed, 05 Jun 2019 01:33:38 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b5sm15274471wrx.22.2019.06.05.01.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 01:33:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RFC v3 0/2] clocksource: davinci-timer: new driver
Date:   Wed,  5 Jun 2019 10:33:32 +0200
Message-Id: <20190605083334.22383-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is another version of the new davinci clocksource driver. After much
discussion this contains many changes to simplify and improve the driver.

v1 -> v2:
- changed the format of the copyright notice
- removed all mentiones of the periodic timer setting
- added caching of the TCR register value so that its updating doesn't
  require a read
- split the timer configuration for clock events into the
  set_state_oneshot() and set_state_shutdown() callbacks

v2 -> v3:
- tim34, if used, should run in periodic mode for clocksource, now fixed
- dropped all the configuration variables from struct davinci_clockevent
  as clockevent always uses tim12
- dropped caching of the TCR register with the following reasoning: on
  systems using tim34 for clocksource, the TCR register is only touched
  by the clock driver and we know that we need to keep tim34 in periodic
  mode; on da830 the RTOS running on the DSP may modify the TCR register
  but we on the other hand never change its settings when only using tim12
- subsequently the whole routine for TCR updating was dropped
- dropped the shift variable from most places
- added separate routines for initializing clocksource for da830 and all
  other systems
- sprinkled a bunch of comments all over the driver to explain things
  that caused confusion before

Bartosz Golaszewski (2):
  clocksource: davinci-timer: add support for clockevents
  clocksource: timer-davinci: add support for clocksource

 drivers/clocksource/Kconfig         |   5 +
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-davinci.c | 370 ++++++++++++++++++++++++++++
 include/clocksource/timer-davinci.h |  44 ++++
 4 files changed, 420 insertions(+)
 create mode 100644 drivers/clocksource/timer-davinci.c
 create mode 100644 include/clocksource/timer-davinci.h

-- 
2.21.0

