Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64C5C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFB9222BE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TnWxK91Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfJBQZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:25:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39750 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfJBQZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:25:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so20424192wrj.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y2jhf/oP0I0B2owborVP8OXRaK2yh9UzOD7ehI47lE4=;
        b=TnWxK91Y4wFzvU9QvIAxrFQEsZcO68ZTUG5zzQ5BcelNJwbKwQC5PvhiSVV9EVhYzZ
         uc2Y0m4ypWPiEdqYBLPQ5LOcZfGYWaupqFePORd1nXG8xRoBt0D2Gf5mX0jqAq6D1tOd
         eIhlNI1vji05euHzqNybratSVsoIVZgNb1iZ6Rb/0+uo6JnNQxOpEAg2ik4mUvfb2z0D
         Up1P+Whl3XrBps5B7ESaWw3kXkaGVeVYdpiSdDAthfibRLuabUo5nq+8f5O9UMCcR2qw
         4qcqxzlohhS5LdH+dM5NCQnE/QGu/W7mJHplIpv9W6/JN2hQ7TDGQfQMylacPgd3gv/y
         ViVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y2jhf/oP0I0B2owborVP8OXRaK2yh9UzOD7ehI47lE4=;
        b=U1wl5IAj0czWjpwobizZ9VbDmXx553E6P25iuqGq8H9fGmtkfJyGux8UYF6dUWPyA1
         aH8BspUdCKB9BS2Fq4aOaNzJh0WBEn58BLiO2VIEQEXFaZgeQ4+MsCRpjBg4MQhykgnI
         vH8ymhhWFLj+v78O9D+KU+cq/jW47zAg8LtviJ+aZg7FRD+gXn9GppZkrcDgltmsMAEf
         EzE2rx3dPw1YLNnEC9tFRxw98YP4N/FahR+PWzTPmUQmAcIcs0//p9fS6F/9RR3cULCT
         zBg23mA22cN/4S5H8V9kaITPAMc57l810kcnFxM1iPrf03u5jJ8pKYV4tTF1zm88qSXH
         7vwQ==
X-Gm-Message-State: APjAAAVdYrZrpS/MlSDj+mFSNNW7i0tcDOoOa5e2WXCD17UboorUvzRX
        RvEurWbCwRgI4ZpBE9AgFQzlXg==
X-Google-Smtp-Source: APXvYqzIugv5g3vDP04bEfPDbNEqTdsDd+tLzwOawLS9vL2iOnudpm9WsHszqFxHdIXBGoYMClSyIg==
X-Received: by 2002:a5d:5185:: with SMTP id k5mr3591524wrv.341.1570033538451;
        Wed, 02 Oct 2019 09:25:38 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id w9sm3482067wrt.62.2019.10.02.09.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 09:25:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/5] drivers: add a new variant of devm_platform_ioremap_resource()
Date:   Wed,  2 Oct 2019 18:25:29 +0200
Message-Id: <20191002162534.3967-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The new devm_platform_ioremap_resource() helper has now been widely
adopted and used in many drivers. Users of the write-combined ioremap()
variants could benefit from the same code shrinkage. This series provides
a write-combined version of devm_platform_ioremap_resource() and uses it in a
relevant driver with the assumption that - just like was the case
previously - a coccinelle script will be developed to ease the transition
for others.

v1 -> v2:
- dropped everything related to nocache ioremap as this is going away

Bartosz Golaszewski (5):
  Documentation: devres: add missing entry for
    devm_platform_ioremap_resource()
  lib: devres: prepare devm_ioremap_resource() for more variants
  lib: devres: provide devm_ioremap_resource_wc()
  drivers: platform: provide devm_platform_ioremap_resource_wc()
  misc: sram: use devm_platform_ioremap_resource_wc()

 .../driver-api/driver-model/devres.rst        |  3 +
 drivers/base/platform.c                       | 27 ++++++--
 drivers/misc/sram.c                           | 28 +++------
 include/linux/device.h                        |  2 +
 include/linux/platform_device.h               |  3 +
 lib/devres.c                                  | 62 +++++++++++++------
 6 files changed, 80 insertions(+), 45 deletions(-)

-- 
2.23.0

