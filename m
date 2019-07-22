Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F3DC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161AF21921
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="k0Ep9b5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfGVNRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:17:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45999 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfGVNRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:17:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so39355628wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r8dtFoRhBpigWERBQKB7RKr+G3hdahRNY7VfLFlm934=;
        b=k0Ep9b5d+hXmZSpgKuvoYMdbAdVCoXikVnVzcf1jr16GpOeWLDelaUPkyFVQhUSlFe
         4IMjFGbJ74DQ4J8pfxFV7n/3zpaWo4HxYI6DATKTQ4MP1rsF9CmgHBtgJpLYMlJfedcx
         BbeErbRvJR71se1UG12WDyrEO2pUETmZB+Cysy2ezfTrzIJRrXkVoG78GV0mHY1RKu8Q
         6drD2eU0v6xt4e5z9/gBRryREh1NbmsefzugoL5Y7BY5Hc0pH2G4D7mjrRJ3pQel9v21
         NjddSHY8nA+lcnvufIVk3qbzkQYUjW7SayEFDotgJYV5ANSHdCRahfULrLosE0TsE8qi
         Suzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r8dtFoRhBpigWERBQKB7RKr+G3hdahRNY7VfLFlm934=;
        b=Gh+6GXAkn/8Y8w1Z4t4bQhhCYDymiwy/1wu2NDKrQkvfG2chRvFfolt2h9lBt+lsSd
         U0e/UL4ClhK8TirP6EkT3jyxwhUzON3cJvTtrpSuzXlKoy/XGF3yuvV1UUR6z9qlPtoy
         fjYU+Un9mzrSTqQaoikKRUfN3q/FWDf94VwPE0wj9yQf7/NkjnkD5JKy8NWEzC9QSrda
         QeSjQ8w6gWdG3Ad1laG6lxeoMHdk45osDO9yRq/akIq3KRNGtf1tIwmuuxHX9eKgjUE+
         7rge/ksXKQpDohcr3QwPw1dCUXouXmcifAgdi9V8ksJ8f9nZb0lCGT1X4bAiFdkOekeD
         JSEQ==
X-Gm-Message-State: APjAAAVfgf7MRNulipwLuih7E/RC9QZ2KgJqgdMO5Nm4J4Iw6Sg24Mx+
        e1vImaqPxwo9oU85zxUhZBY=
X-Google-Smtp-Source: APXvYqybdlKkio8X0I7thfnjMnR06j54Hl+09d0TurnmlzJw4kX/FDdPMDPRp/ecKywk5Y9KcE+ZFw==
X-Received: by 2002:adf:eacf:: with SMTP id o15mr78392762wrn.171.1563801471830;
        Mon, 22 Jul 2019 06:17:51 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id z6sm34156657wrw.2.2019.07.22.06.17.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:17:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 00/10] ARM: davinci: use the new clocksource driver
Date:   Mon, 22 Jul 2019 15:17:38 +0200
Message-Id: <20190722131748.30319-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Sekhar,

the following patches switch DaVinci to using the new clocksource driver which
is now upstream. They are rebased on top of v5.3-rc1. Additionally the
following two patches were reverted locally due to a regression in v5.3-rc1
about which the relevant maintainers have been already notified:

  2eef1399a866 modules: fix BUG when load module with rodata=n
  93651f80dcb6 modules: fix compile error if don't have strict module rwx

Bartosz Golaszewski (10):
  ARM: davinci: enable the clocksource driver for DT mode
  ARM: davinci: WARN_ON() if clk_get() fails
  ARM: davinci: da850: switch to using the clocksource driver
  ARM: davinci: da830: switch to using the clocksource driver
  ARM: davinci: move timer definitions to davinci.h
  ARM: davinci: dm355: switch to using the clocksource driver
  ARM: davinci: dm365: switch to using the clocksource driver
  ARM: davinci: dm644x: switch to using the clocksource driver
  ARM: davinci: dm646x: switch to using the clocksource driver
  ARM: davinci: remove legacy timer support

 arch/arm/Kconfig                            |   1 +
 arch/arm/mach-davinci/Makefile              |   3 +-
 arch/arm/mach-davinci/da830.c               |  45 +--
 arch/arm/mach-davinci/da850.c               |  50 +--
 arch/arm/mach-davinci/davinci.h             |   3 +
 arch/arm/mach-davinci/devices-da8xx.c       |   1 -
 arch/arm/mach-davinci/devices.c             |  19 -
 arch/arm/mach-davinci/dm355.c               |  28 +-
 arch/arm/mach-davinci/dm365.c               |  26 +-
 arch/arm/mach-davinci/dm644x.c              |  28 +-
 arch/arm/mach-davinci/dm646x.c              |  28 +-
 arch/arm/mach-davinci/include/mach/common.h |  17 -
 arch/arm/mach-davinci/include/mach/time.h   |  35 --
 arch/arm/mach-davinci/time.c                | 414 --------------------
 14 files changed, 110 insertions(+), 588 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/time.h
 delete mode 100644 arch/arm/mach-davinci/time.c

-- 
2.21.0

