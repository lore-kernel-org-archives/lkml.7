Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBBDC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C7E2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="llwcE/vo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfFSOUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:20:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55974 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfFSOUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:20:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so2019338wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xe8Z7G8xOvRe6JhL6dXMu61WRA0y1QcBsLv7BXFLXu8=;
        b=llwcE/vozsWWrzWhJC9CO+SJiPMgZWnVaC4ILiC18AVKVObOtbHqSSD55EKh2GLEEr
         yW9kTMVwvXP0MW/YcvnEzOedwNkcQ2D6Cxmo+AS0urgcS1z0zlUcceMrzXx2kxIcjkSe
         rg0kUNgaJK0dkzvGoo3D8exmVpbm6fWRJy4NnAcO/IwjxmoZ1uk2SjFKEcmvTM1uZ9xv
         yWPWThjFu9RrEyhJQztu3gNLR0VQhk5HqJBiUqcFL8ffaWx1BlPizsHiRlsW2nPl5iyA
         QKRJyQJuHOE0l/qMKvWfFtsaYJ0knEMonny7dmoUcVIIV9Xu6mn+9Sc+psaIdyOuFPsd
         bCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xe8Z7G8xOvRe6JhL6dXMu61WRA0y1QcBsLv7BXFLXu8=;
        b=M8JI8hi+haQur/tdv9LR6vbALjW2dl9B/VG5gSaE6i16c/cUXu22JalXpjsD/eJ8n3
         mzV13DbnoJDDgDgZJHeEbM7hJQneKNGbAbWwk28Y67/2fpwrlupgWGLHw9KVuU5m04vY
         wJTXhj0QdHaVssFRK1X0gVExKz1zFZrYCLjLvD0QYfc2evzPOEOatT3HOolMZ5Mro1NL
         a1rXgaixnNjcQ+Zq+xoEp05XPPoXPkC1Uwxs7KiZPU1RKJRYqMbklozogjW72Djn4IBE
         c7Sr+XwPzZ5nna/evuHZgWy6I5BRJng8h5H0q8dd5cmNhMK0Z10eOjoGCZzUcXhRc8bn
         kYJg==
X-Gm-Message-State: APjAAAVMjfVKx1cgeAkGG9NDTs4n1ZpEIRVpTr5nMlWGgY4sITXZAYKk
        bCpgvA3pG5mSJwErluH1eeYBKEyHoy4=
X-Google-Smtp-Source: APXvYqzUYdb3XhMJ78/mGb9h4pNZliClNr3lXrzr0m0AXlFqRlXutMI0MOSuI04PSQl09GOwpUpkgQ==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr8111575wmc.22.1560954017792;
        Wed, 19 Jun 2019 07:20:17 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id o20sm24209979wrh.8.2019.06.19.07.20.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 07:20:17 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v4 0/7] mt6392: Add support for MediaTek MT6392 PMIC
Date:   Wed, 19 Jun 2019 16:20:06 +0200
Message-Id: <20190619142013.20913-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims at bringing support for the MediaTek MT6392 PMIC. This
PMIC is used on the MT8516 Pumpkin board.

This patch series adds support for the following features:
 * PMIC keys
 * regulator
 * RTC

Fabien Parent (7):
  dt-bindings: regulator: add support for MT6392
  dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
  dt-bindings: input: mtk-pmic-keys: add MT6392 binding definition
  mfd: mt6397: Add support for MT6392 pmic
  regulator: mt6392: Add support for MT6392 regulator
  input: keyboard: mtk-pmic-keys: add MT6392 support
  arm64: dts: mt6392: Add PMIC mt6392 dtsi

 .../bindings/input/mtk-pmic-keys.txt          |  11 +-
 .../devicetree/bindings/mfd/mt6397.txt        |  12 +-
 .../bindings/regulator/mt6392-regulator.txt   | 220 ++++++++
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      | 208 ++++++++
 drivers/input/keyboard/mtk-pmic-keys.c        |  14 +
 drivers/mfd/mt6397-core.c                     |  47 ++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mt6392-regulator.c          | 490 ++++++++++++++++++
 include/linux/mfd/mt6392/core.h               |  42 ++
 include/linux/mfd/mt6392/registers.h          | 487 +++++++++++++++++
 include/linux/regulator/mt6392-regulator.h    |  40 ++
 12 files changed, 1575 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6392-regulator.txt
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
 create mode 100644 drivers/regulator/mt6392-regulator.c
 create mode 100644 include/linux/mfd/mt6392/core.h
 create mode 100644 include/linux/mfd/mt6392/registers.h
 create mode 100644 include/linux/regulator/mt6392-regulator.h

-- 
2.20.1

