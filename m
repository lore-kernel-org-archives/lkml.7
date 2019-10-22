Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E968CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D584B20679
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AAJh7JIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388515AbfJVInZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:43:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34313 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388042AbfJVInZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:43:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so11886605wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2vhZ1SfzcYNiDdElZtSQt3l3Cz+Qu9oLpAHMunMVCdo=;
        b=AAJh7JIjFp1Z9dxop/8X5n37zrU/890hVyGA2W4WC8M7YCO7WkH08lzDQhWmn18y9T
         ETxsbV1XFfLtE1uQnmi3HG8TJaG2dfoQQ1ylH0ymif8JcK5NZvn1SpgWfh6cRL8AKJQw
         GjJLae1xkOr6ue76TAPicbRLgQthO++1f2uuj4GaUGn1Od26Gw6OZUKVDPH4UBVK04Je
         f8tX8T84KlQU1nQAd3gBAzDM0L95VzDwYsSmdz/VQmClFR8F5CcjRVQVS3rkxhqRxAQo
         b5d3pdXsOWZ1sJczh0U6tvOMPutwqwU9Yuk1UYP/puD39XTfAqD0UK5UZV1Rxnhj/WWS
         5Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2vhZ1SfzcYNiDdElZtSQt3l3Cz+Qu9oLpAHMunMVCdo=;
        b=HigvDVx9ieKXmN5WuZsqhDOn68i46DiCku6Pak3GVt12DgLcn4S6zDKbVS/EHWImaW
         rRvzmmv6IEedUfReUqkU/og5He/CLDw7jeFBpnhkG8oxX8S87v6Oi0oEDkxKjFCQBjEY
         zP+E3Bg6yRIvdEcuL3jozh703I0yFNKpFTsmMpXAsiCsHK3LVrCGp4Bt8r95h90Fy6f/
         7b7AP3yaQGKAQ2S48LHLDdLkoriztMTWZAv2UYcbS0dnapbzntCqRlcx9wwCWTNuQL3Q
         9pJ+svL0a0ElETlvKtb8uRVvZ7bgCLsxws9JmNs19/5vMmaeyZD3Xb86bSw492Q/w5yU
         FmWw==
X-Gm-Message-State: APjAAAVOc6vTjHCQaP5VQ2O4Iuhmjd/AonCgxPliOsPBhOZwWr3dneLg
        u4FBFq+klY3maRZyMldyHkKLcQ==
X-Google-Smtp-Source: APXvYqzsCMDE+YFvmJRJslx0T60zeeblL7s7qMRBkyLbMjANM+hKlWzwOyzWUbrtdzcICjCqUStwIQ==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr2463395wrw.206.1571733803424;
        Tue, 22 Oct 2019 01:43:23 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id q25sm477231wra.3.2019.10.22.01.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 01:43:22 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v3 0/8] drivers: add new variants of devm_platform_ioremap_resource()
Date:   Tue, 22 Oct 2019 10:43:10 +0200
Message-Id: <20191022084318.22256-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Note: resending with Arnd's review tags and rebased on top of char-misc-next

The new devm_platform_ioremap_resource() helper has now been widely
adopted and used in many drivers. Users of the write-combined ioremap()
variants could benefit from the same code shrinkage. This series provides
a write-combined version of devm_platform_ioremap_resource() and uses it in a
relevant driver with the assumption that - just like was the case
previously - a coccinelle script will be developed to ease the transition
for others.

There are also users of platform_get_resource_byname() who call
devm_ioremap_resource() next, so provide another variant that they can use
together with two examples.

v1 -> v2:
- dropped everything related to nocache ioremap as this is going away

v2 -> v3:
- don't call platform_get_resource() as an argument of devm_ioremap_resource(),
  it actually decreases readability
- add devm_platform_ioremap_resource_byname() as another variant

Bartosz Golaszewski (8):
  Documentation: devres: add missing entry for
    devm_platform_ioremap_resource()
  lib: devres: prepare devm_ioremap_resource() for more variants
  lib: devres: provide devm_ioremap_resource_wc()
  drivers: platform: provide devm_platform_ioremap_resource_wc()
  misc: sram: use devm_platform_ioremap_resource_wc()
  drivers: provide devm_platform_ioremap_resource_byname()
  gpio: mvebu: use devm_platform_ioremap_resource_byname()
  gpio: tegra186: use devm_platform_ioremap_resource_byname()

 .../driver-api/driver-model/devres.rst        |  4 ++
 drivers/base/platform.c                       | 39 +++++++++++-
 drivers/gpio/gpio-mvebu.c                     | 19 +++---
 drivers/gpio/gpio-tegra186.c                  |  4 +-
 drivers/misc/sram.c                           | 28 +++------
 include/linux/device.h                        |  2 +
 include/linux/platform_device.h               |  6 ++
 lib/devres.c                                  | 62 +++++++++++++------
 8 files changed, 108 insertions(+), 56 deletions(-)

-- 
2.23.0

