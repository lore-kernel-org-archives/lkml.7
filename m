Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E17C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5148A204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hMAayp2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfFXNOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:14:04 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:45643 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfFXNOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:14:03 -0400
Received: by mail-wr1-f52.google.com with SMTP id f9so13834375wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B+oomzOAjO98XLvoEbiqoPvmm7twt6bFPtAYlt6Hi1o=;
        b=hMAayp2UQdANcARpsGk4OKb2NvkK80e/RLWe4sGNTFGNjnzPHOr66W9tTCseB6kK91
         +z78X02QLPBbWk7jpBwfH4cXuZJ3pRRAYHBZFKWrf7iB24nWOqdNlJONx2egfuhXh8v2
         7Nij2e31zxzsRHKCM2BdZJlKWhi8C8luIKv4ofb2RSiceC899WPS1w+c0tmCEogWHt3c
         VsGAahOSSVwNLne26KOpLaFmR9vwRM0J7wPlgHwZ9hN6fAR/ulFf3YRif5rGR42Nm+uD
         o9Gp85pqhlaj4wKDo6cvwHxvbGK31HpQb2+Vvl3Js09MWh8cc48hU4TM1XKtoFiJp851
         W5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B+oomzOAjO98XLvoEbiqoPvmm7twt6bFPtAYlt6Hi1o=;
        b=qs9Ic8fLCqadb70CptNpZtgijeTK2mRAUSnEngLN5MQrWbDkor0mvQdIfo4s/nKi/Y
         nvbphsUNMveqQrkH7+fpdwbaVrFt2RfaPDYCP6f1nYfiuZo86zderCWr5zkfDedjr8fa
         9N02sY3c4a0W6s5ymC4hPUj730wSDojJdeHTPagb78R8Ou4MZxkeTOohGE9Cq6eYm9M/
         Jse5S+/LTW88Rrpey63b+j3qHWUEYe7bO9oMjuCIhzu1eUH+WzZo8HmnNVuJWmV4M8sK
         eEHKlZ3mCnk+rh05BTrjfQrUuY8FVLyQXzr17vbjjLhaFubwd2qf2S2iVcDd42bS18uD
         5+WQ==
X-Gm-Message-State: APjAAAWUFc5rLQtDAdCuCZoADJyBAbW7rGEuJSAELd001g0ZV44Z+oAO
        MTBwXoZw/8J//586cnCssdYkuQ==
X-Google-Smtp-Source: APXvYqxl4eykzFe6CYTPiNlEmYQ0qHeH12pFnrSjRcCW0j/dYnT5i9nw/Ayhvc4HKR/lSsuV5WcmFw==
X-Received: by 2002:adf:edcd:: with SMTP id v13mr31650518wro.210.1561382041611;
        Mon, 24 Jun 2019 06:14:01 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id y2sm9535526wrl.4.2019.06.24.06.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:14:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 00/10] ARM: davinci: use the new clocksource driver
Date:   Mon, 24 Jun 2019 15:13:41 +0200
Message-Id: <20190624131351.3732-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Sekhar,

once the clocksource driver is in some upstream branch, you can pick this
series up - it contains the platform code necessary to use the new module.

Tested on da850-evm/lcdk, da830-evm and dm365-evm.

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

