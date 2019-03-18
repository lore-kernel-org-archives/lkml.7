Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D44C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087692085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XNoXjBkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfCRMLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:11:14 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:35491 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfCRMLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:11:14 -0400
Received: by mail-wm1-f43.google.com with SMTP id 81so5237783wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 05:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OATtkI/guzwk7jff6aAB4UFhNL1u85hJ22zQ1YU1uSA=;
        b=XNoXjBkp0etDY4WhFdw1whuLV90MuRzlKtSf0qq/AkGb6ZeVCiAxzka5XrTTOmAuOT
         b68Qia6rKCIPY6kfTzfQLhxLkmzqtZsYWS/UQc7Beeh8sCiUFe/kn6jl+4b+9eFWBRPq
         n5rZWJcEFctMgHS2GvUlZa3Hnb2ZSf7vhYM3leTkHF8yeNhg2K1RgPTbUfekyRJvKVdw
         4IfV2eDvnCjRH2hXH9cJYFkAnnfeNcklrfr0nSLgeVdDFP8O87/+I1HvvTvLN4unbZqX
         Ujl5v5BMJUEmDAuKZ1TBb7MfqhjKWh3s4e0LDC19dyloKtjKdO4GkS2ZACdFp7uixukB
         82bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OATtkI/guzwk7jff6aAB4UFhNL1u85hJ22zQ1YU1uSA=;
        b=bIpPOFzJMtyY+Py0Xqk/8uTCGGOFAVfGWHJ0VNQGdrBYOQ52UJcRLyBB4wVUozMxgH
         Bdl3QNW1s/uOSP6fjySPXEhIi8H99oRgXpHdRg0amVlulR0BrKLOg+rcuxIbj1KbidQy
         qOYANcJCFY33malHwoDNRnoojAZn0SGjHqKLQ/DDNB4Q9mXZ0K0hVhri0a3n7qS1a7Cc
         bqzs1wCSucXSLkVo4BDcNISurVBgQY/Yz24xcARLwunEmrVk8WI24wKqihFFVZYPmQuf
         a7hCWoEiBhPVUeqDDfDG21Sbk/77rnp2NpwqMRsG5i4CYJra6O6a86LrNcxBbIqQfaMF
         Q+3Q==
X-Gm-Message-State: APjAAAVIj114ZiUBIdTs/6eHcJVkOboqnLQJ0EI4F/2kewc6LHL3xGVm
        IxXwi6y0mmvOXFFBhkDgH3nkquE24ss=
X-Google-Smtp-Source: APXvYqxW+wJsvAosJf6tVOvPTR5HCUoLirthnQ9X1WlhTGu/98/dVGesoWtoymJBUuRzGel0n2T2zw==
X-Received: by 2002:a1c:6042:: with SMTP id u63mr10800672wmb.92.1552911070693;
        Mon, 18 Mar 2019 05:11:10 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id n13sm8220132wrw.67.2019.03.18.05.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 05:11:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 00/11] ARM: davinci: modernize the timer support
Date:   Mon, 18 Mar 2019 13:10:49 +0100
Message-Id: <20190318121100.28132-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series removes the legacy timer code from mach-davinci in favor of
a new clocksource driver it introduces.

Patch 1 adds a new clocksource driver for davinci.

Patch 2 enables the new driver for device-tree based systems.

Patch 3 adds a WARN_ON() to the machine code of all davinci boards
which is triggered if clk_get() for the timer clock fails. This is needed
as the new driver expects the clock to be functional and doesn't check it.

Patches 4-5 and 7-10 switch the board files to using the new
clocksource driver while patch 6 moves some necessary defines to
a different place since we'll be removing the file that contains them.

Patch 11 removes legacy timer code.

v1 -> v2:

- changed the license to GPL-only
- dropped regmap usage due to the additional code paths making the
  code too slow
- minor code rearrangement
- fixed the da830 timer configuration
- correctly assign the timer halves to clocksource and clockevent
- sqashed the commits adding WARN() when clk_get() fails
- used WARN_ON() and added a return when clk_get() fails to avoid
  entering the timer driver without a valid clock
- request the register range before iomapping it
- simplified the configuration structure (dropped the additional
  cmp struct)

v2 -> v3:

- use readl/writel_relaxed() instead of __raw variants in the clocksource
  driver
- request the memory region before remapping it
- add explanatory comments
- fixed licensing
- used pr_fmt macro
- correctly assign the clocksource name
- use DEFINE_RES_x macros when defining resources to avoid off-by-one
  bugs in resource's size
- tweak the commit messages
- don't delete the comments describing the timer usage
- other minor improvements
- rebased on top of Sekhar's soc branch
- dropped patch fixing the clocksource interrupts in device tree (already
  upstream)

v3 -> v4:
- fixed formatting of error messages
- fixed comments all around the place
- rebased on top of v5.1-rc1

Bartosz Golaszewski (11):
  clocksource: davinci-timer: new driver
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
 arch/arm/mach-davinci/da830.c               |  45 +-
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
 arch/arm/mach-davinci/time.c                | 414 ------------------
 drivers/clocksource/Kconfig                 |   5 +
 drivers/clocksource/Makefile                |   1 +
 drivers/clocksource/timer-davinci.c         | 438 ++++++++++++++++++++
 include/clocksource/timer-davinci.h         |  44 ++
 18 files changed, 598 insertions(+), 588 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/time.h
 delete mode 100644 arch/arm/mach-davinci/time.c
 create mode 100644 drivers/clocksource/timer-davinci.c
 create mode 100644 include/clocksource/timer-davinci.h

-- 
2.20.1

