Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F091EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCEB2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="r9PZXAbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbfEWM6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:58:19 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:40716 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730284AbfEWM6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:58:18 -0400
Received: by mail-wm1-f50.google.com with SMTP id 15so5674042wmg.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o/wtiYR2xsTC11waSO0yQUkZ4S3S31FqfgaPX+rcr4s=;
        b=r9PZXAbFtJJPPvfQKRF6s1VHnG3klpb3OOQ9YbAaVc30OrfbyFjPcDaG8WTk7KnD/L
         wk6pIuXqTf4vOm2od99w7Gexv/tKuwTYb/vvCeEwIvK80SqkgbvRsJ9FHuQDWtuoG53H
         OZS6AEaWh89rv6PE3k7On3pIorUmC1ToiWFgTxcPTKuwsTx145B0OMOU5GVR61icBFtY
         dTNkQTBVq+F2qSfvgl6CUyFZqUFozzzOLBmPlmw/h2zLtgvG4ulfOqeRzAFhGIymUDff
         1H4lDDPPZt+UeupJvdXu8X7wV/wRH75j9sWdmyEAu2GXXQZ39U0OI6mZ4Mq4Ryu8vwLF
         jWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o/wtiYR2xsTC11waSO0yQUkZ4S3S31FqfgaPX+rcr4s=;
        b=UHqaQNzQil85Rwj1wKY5+0GlikCpNuroFAH/eoRzvfnCZz/NHYkx86Wp2PKc1XCqhd
         /erMjhYAzvoe959m9thN+XrEzqjiIVE03S5246aThlIOiH8BrSu9vdX8IaTHPtFY2Xcs
         djqPHkHxQX05WvJryHe8ApUzGIeoSV3YM85t78Z6VW2tEwTSUpcvzK4LfR+IQ2vseK3/
         CNcCN+9P51RAeuSNsLhAwPJK5bH3ZHT+8+0EDiO/qrwxT7RykdjcNX4c8rJm9Wqm4xRB
         G9Mts3nYNM2WZFxcZ8lzcgEHIHBDvNwr9H25ccyQDlxPOWLb5F7qHeIfFDmha6d5nfGx
         cvJA==
X-Gm-Message-State: APjAAAXeOgd0xkUqqvjIYlPZw4zev4jsRDDHDdUHtk+d0RAw11+7kpsx
        nsiHEj/uYGbQIhi40tPxI1hKQQ==
X-Google-Smtp-Source: APXvYqwK7EF3A/sETDYJqJjEvH+9WhzGaBLe8eflWij1cL5o/3OTIchEO4ol0wDyLjpwfdW/vL7BGQ==
X-Received: by 2002:a1c:a958:: with SMTP id s85mr11479598wme.144.1558616296604;
        Thu, 23 May 2019 05:58:16 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s13sm9876118wmh.31.2019.05.23.05.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:58:15 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RFC v2 0/2] clocksource: davinci-timer: new driver
Date:   Thu, 23 May 2019 14:58:11 +0200
Message-Id: <20190523125813.29506-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Daniel,

this is another try at the davinci clocksource driver. Changes in
regard to v1 listed below. As before, the driver is split into two
parts (one for clockevent and one for clocksource).

v1 -> v2:
- changed the format of the copyright notice
- removed all mentiones of the periodic timer setting
- added caching of the TCR register value so that its updating doesn't
  require a read
- split the timer configuration for clock events into the
  set_state_oneshot() and set_state_shutdown() callbacks

Bartosz Golaszewski (2):
  clocksource: davinci-timer: add support for clockevents
  clocksource: timer-davinci: add support for clocksource

 drivers/clocksource/Kconfig         |   5 +
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-davinci.c | 355 ++++++++++++++++++++++++++++
 include/clocksource/timer-davinci.h |  44 ++++
 4 files changed, 405 insertions(+)
 create mode 100644 drivers/clocksource/timer-davinci.c
 create mode 100644 include/clocksource/timer-davinci.h

-- 
2.21.0

