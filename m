Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A913C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F12E21921
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jDRY8s9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbfGVNol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:44:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38123 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbfGVNol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:44:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so39498139wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6OE2vgUPZ5yWbUkDxF2/EfNu3Dftuv+SUPLz3txgSn0=;
        b=jDRY8s9DB/0Rdp9EuXO3MDPJTyhubw2FhY+I8rkA7gKejbLftYHvixid1ZPoPkn7ts
         A9Nt0ELbEQ+/mnmPAbuZJmaKi0ux4J1MO9XL/EyAnVRDeRvZfwqvUc++Ubl3EYf8e3Sy
         5kQgt3VZWaBETd569WwmaFNrKER5ta73sPjxhbRBvYk4TMIt9TU1tH/jJx/xRDpxl6ND
         cqVIo0A69rGe/3GNQFG+6aa4luSVqjzMBWjvzxHiwouptlDVdrwOcKzz1Xa7JljTKa+m
         /AEYM3KnHHCq1RbWGM9tJ6BQTPX5Jy7r16BNc/owfeuNU3e+zArBIS8uq8uVLMstI3w2
         M4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6OE2vgUPZ5yWbUkDxF2/EfNu3Dftuv+SUPLz3txgSn0=;
        b=RKxfIhvZUMprbI4MyvA3iJLObHJsnBp/UBuqZJUomHwst0n2Rv3Y0FIBa4LLRWurAE
         VVZoGwIVXpjoX29jqj1Z9pLj/QtP2tY2oTpwHnCu6mmzrg9GcJtqGJIMkIeSwL5LqTmL
         Xc3Wp2z4zrL9uOPlJpoQSSdslvUWpBTmzDkgin+/aCV2WVAqsBh+/vaTzRHz/7+LNXFu
         l7nkuBzKkk2ayKhU8Km9nogKY9zm+fQ+0rdRmdU+azO6cs8HHiegg2cSdgWIQFeFrTgF
         7sA98FCtCSjAraPPTqwetvP1AIxAhOiOoHiOXQ5/pY0fvlukTDJ7NBWTKGEjxSKpAdwU
         W4Bg==
X-Gm-Message-State: APjAAAVnKKjN73+lag1ezwoGvWPFx8eAv5818imoNzL0iv9ooWcnUYmQ
        1ILr4KAG6PN8iiS40LhXWW0=
X-Google-Smtp-Source: APXvYqwvf5snwzuBm1QlzKK/QuN97vn9/tXDk4UIUnMrk9mGyCSxLMLSb1VOWE60YCYGqOxJSBkzkg==
X-Received: by 2002:adf:f246:: with SMTP id b6mr47585965wrp.92.1563803079035;
        Mon, 22 Jul 2019 06:44:39 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id p6sm40652484wrq.97.2019.07.22.06.44.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:44:38 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/9] ARM: davinci: da850-evm: remove more legacy GPIO calls
Date:   Mon, 22 Jul 2019 15:44:14 +0200
Message-Id: <20190722134423.26555-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is another small step on the path to liberating davinci from legacy
GPIO API calls and shrinking the davinci GPIO driver by not having to
support the base GPIO number anymore.

This time we're removing the legacy calls used indirectly by the LCDC
fbdev driver.

First two patches enable the GPIO backlight driver in
davinci_all_defconfig.

Patch 3/12 models the backlight GPIO as an actual GPIO backlight device.

Patches 4-6 extend the fbdev driver with regulator support and convert
the da850-evm board file to using it.

Last three patches are improvements to the da8xx fbdev driver since
we're already touching it in this series.

v1 -> v2:
- dopped the gpio-backlight patches from this series as since v5.3-rc1 we
  can probe the module with neither the OF node nor platform data
- collected review and ack tags
- rebased on top of v5.3-rc1

Bartosz Golaszewski (9):
  ARM: davinci: refresh davinci_all_defconfig
  ARM: davinci_all_defconfig: enable GPIO backlight
  ARM: davinci: da850-evm: model the backlight GPIO as an actual device
  fbdev: da8xx: add support for a regulator
  ARM: davinci: da850-evm: switch to using a fixed regulator for lcdc
  fbdev: da8xx: remove panel_power_ctrl() callback from platform data
  fbdev: da8xx-fb: use devm_platform_ioremap_resource()
  fbdev: da8xx-fb: drop a redundant if
  fbdev: da8xx: use resource management for dma

 arch/arm/configs/davinci_all_defconfig  |  27 ++----
 arch/arm/mach-davinci/board-da850-evm.c |  90 +++++++++++++-----
 drivers/video/fbdev/da8xx-fb.c          | 118 +++++++++++++-----------
 include/video/da8xx-fb.h                |   1 -
 4 files changed, 141 insertions(+), 95 deletions(-)

-- 
2.21.0

