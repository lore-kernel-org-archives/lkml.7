Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D395C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709F4229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NifUXO46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390013AbfGYNUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:20:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50764 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387789AbfGYNUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:20:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so45007898wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UlHPQbgyQYfGZ3NYNuBRx+Lr52kdbe694moegnICIVc=;
        b=NifUXO46j7w7Famst0qSTWA+/NAM63+P3EEYOVDutdfzQG+lK0vxeP1W9KJl2ETjQ7
         JYP0quRtoQLFtAnCn7C6Pc3FPDxtA/BAwt2L8CF4rT2eLsfFPOexvuzSo5aEgUenXEKF
         0xJD1ZPaQUgYskYoku7SCxlDucpHqt4XuP4VpktEH/xgT+qb9NxNwqJ6vKAo+oM+K7qJ
         p4pv+z98jk9nWshsZwikW5iH3QZiYecYIXm8id5dC6AdA6RFNy94z/9qQA1s7rRTS9S7
         o0jU6sDTrVHcIz8qEpotKPocMOYRC8+R1o2j3d6Xj22b4M+z7IhWR0RELbV6dSxIxFfI
         Ojmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UlHPQbgyQYfGZ3NYNuBRx+Lr52kdbe694moegnICIVc=;
        b=JZBKJek9Jgwxh6Icy97dyrgk6pISFvfAyV+OSRhaGvORsSm2wIhTzP0z6X8UBb27LK
         z56drvVe4T/WpfiZXcjOu7GSNjM8KMi5h3PhO8lh5SYyhBenVlZNBp5rL9qZ08Xd5Sb3
         diyurzuFnP73vktRdVL6j0tRW9SUm0NXuKiuoLNozZ16qXvIMOeb8Qbad82ZFyNbSAtZ
         tv9OD52DAQkXhtv1KyBbwupOoxffRxZvQaqe+SNU6UP8wXveVoTjHtL6FCoEGl7yNMhj
         im2AN02eYk7eBTyZYrkG5CrhVaZ4Vguo8KjlqQmPi9wMyvn+eh1ve5JRpCj3Pt4+p+1G
         lNJQ==
X-Gm-Message-State: APjAAAXdh4ZBwa/k1mYzuVbZ8eZi0NToKpSasTjg2gj13nla6aSjW9nH
        RluZQg9AK04TPZeXgmymKCrsTzFx
X-Google-Smtp-Source: APXvYqwY8Li4ENYOTTDLqaDLIZqrJmGdo/DsVkKI6zl4K5u/ERvtsF3kWAQdjUnv/c82L9w7qWyNag==
X-Received: by 2002:a05:600c:204c:: with SMTP id p12mr79503703wmg.121.1564060382076;
        Thu, 25 Jul 2019 06:13:02 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id z7sm47119735wrh.67.2019.07.25.06.13.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 06:13:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/5] ARM: make DaVinci part of the ARM v5 multiplatform build
Date:   Thu, 25 Jul 2019 15:12:52 +0200
Message-Id: <20190725131257.6142-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series makes DaVinci part of the multiplatform build for ARM v5.

First three patches fix build errors spotted and fixed by Arnd with v1.

The fourth patch adds necessary bits and pieces for davinci to support
multiplatform build and the last one actually adds all davinci boards
to multi_v5_defconfig.

Tested on da850-lcdk with both multi_v5 as well as davinci_all defconfigs.

v1 -> v2:
- added patches from Arnd that fix build errors spotted when building
  random configurations (much appreciated)
- rebased on top of v5.3-rc1

Arnd Bergmann (3):
  staging: media/davinci_vpfe: fix pinmux setup compilation
  media: davinci-vpbe: remove obsolete includes
  davinci: fix sleep.S build error on ARMv4

Bartosz Golaszewski (2):
  ARM: davinci: support multiplatform build for ARM v5
  ARM: multi_v5_defconfig: make DaVinci part of the ARM v5 multiplatform
    build

 arch/arm/Kconfig                              | 21 -------------------
 arch/arm/configs/davinci_all_defconfig        |  5 +++++
 arch/arm/configs/multi_v5_defconfig           | 12 +++++++++++
 arch/arm/mach-davinci/Kconfig                 | 17 +++++++++++----
 arch/arm/mach-davinci/Makefile                |  2 ++
 arch/arm/mach-davinci/sleep.S                 |  1 +
 drivers/media/platform/davinci/vpbe_display.c |  4 ----
 drivers/media/platform/davinci/vpbe_osd.c     |  5 -----
 drivers/media/platform/davinci/vpbe_venc.c    |  5 -----
 drivers/staging/media/davinci_vpfe/Makefile   |  5 -----
 .../staging/media/davinci_vpfe/dm365_isif.c   |  8 +++----
 .../staging/media/davinci_vpfe/dm365_isif.h   |  2 --
 drivers/staging/media/davinci_vpfe/vpfe.h     |  2 ++
 13 files changed, 38 insertions(+), 51 deletions(-)

-- 
2.21.0

