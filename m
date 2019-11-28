Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F6CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46B02176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9vBY1rj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfK1OqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:46:02 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:38452 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfK1OqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:46:01 -0500
Received: by mail-wr1-f50.google.com with SMTP id i12so31530303wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=5Gj++q7Gl6lutTMuXchBThumet67S2kjmbwxcEaMigk=;
        b=I9vBY1rj0oCO70iMKu6cnPiP2K+4X+JPSah+EFDn9cqeB0TPt+N7vNY0WkBSxnTrVo
         aUusO9ygyrbmh17EMqRN8nidjVHU5m7r1EUiqk5lhqoN2/SgWyIxEyxnGJ1Ay5WzUheV
         YXe8vtj5k3BteWXIyAOrDXQJI9+PXwSsLZApSDWafS59Gz+zsklLSUBMwrFd8C2N3xIn
         dc0ht+clYJ0YNCEi9tEd6/vejdP0u+GKFaEbb8JrS9d7pTRDbjxQv1U7cPCWbdtBEoHp
         wIk4DehzmjXtxQvZWDXj+dWwRobO8mqddr5BIW6111dnirR2bQlMGnnySJYOlD74CKKg
         tHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=5Gj++q7Gl6lutTMuXchBThumet67S2kjmbwxcEaMigk=;
        b=TUApczI7AMbbqt+rw5enLTOfhf71wy14xQNnztuF3T6eprPpu/mvhAt0llDx0cuQI6
         SCY9DQIy5XOjEuAe2N1l49W842oQc4LK6FZicVqItJ/JhQ9//32XlbfjHWOFUwTgQqlN
         NvhNEAeFvqDoUn2MaXIrgymt37ZvaeRk9WHxZqjOWp6uqvFqfI/2EoFi/kvsQOGvznCJ
         YhPIK1KDZaFlzHaojY+1Q6h9BaCwhYzs9ANPmfh3dmHV7NjEvAfgMcCPAz1u3yPCy6lr
         r98RxGXJf4X1DMwGiRRBo5lzotFUVXBUlg0o4GEJYcNsG5Uj/7x3duvOe0gUGAVKJz8u
         sqiw==
X-Gm-Message-State: APjAAAWYvmbR3Oji3+Kkmjg/Ne7O5z8vD13UoG32B3jYkZDQi4i/ukcG
        E/0OPiMCqsFccuoq50Al+7/ppgutnbE=
X-Google-Smtp-Source: APXvYqxmE/m5YpY1t9w0jzll9hMb+oDwvmFKGNC5NTrR/xHLFom3XWtcKOlP4Wa4U83gW8h3eRyp1w==
X-Received: by 2002:adf:ec8f:: with SMTP id z15mr31383520wrn.128.1574952357209;
        Thu, 28 Nov 2019 06:45:57 -0800 (PST)
Received: from dell ([2.31.167.254])
        by smtp.gmail.com with ESMTPSA id a2sm24388280wrt.79.2019.11.28.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:45:56 -0800 (PST)
Date:   Thu, 28 Nov 2019 14:45:44 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Backlight for v5.5
Message-ID: <20191128144511.GA14416@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.5

for you to fetch changes up to 102a1b382177d89f75bc49b931c329a317cf531f:

  backlight: qcom-wled: Fix spelling mistake "trigged" -> "triggered" (2019-11-13 11:31:52 +0000)

----------------------------------------------------------------
 - New Functionality
   - Add support for an enable GPIO; lm3630a_bl
   - Add support for short circuit handling; qcom-wled
   - Add support for automatic string detection; qcom-wled

 - Fix-ups
   - Update Device Tree bindings; lm3630a-backlight, led-backlight, qcom-wled
   - Constify; ipaq_micro_bl
   - Optimise for CPU cycles; pwm_bl
   - Coding style fix-ups; pwm_bl
   - Trivial fix-ups (white space, comments, renaming); pwm_bl,
		gpio_backlight, qcom-wled
   - Kconfig dependency hacking; LCD_HP700
   - Rename, refactor and add peripherals; pm8941-wled => qcom-wled
   - Make use of GPIO look-up tables; tosa_bl, tosa_lcd
   - Remove superfluous code; gpio_backlight
   - Adapt GPIO direction handling; gpio_backlight
   - Remove legacy use of platform data; gpio_backlight

 - Bug Fixes
   - Provide modules aliases; lm3630a_bl

----------------------------------------------------------------
Andreas Kemnade (4):
      backlight: lm3630a: Fix module aliases
      dt-bindings: backlight: lm3630a: Add enable-gpios to describe HWEN pin
      backlight: lm3630a: Add an enable gpio for the HWEN pin
      dt-bindings: backlight: lm3630a: Fix missing include

Arnd Bergmann (1):
      video: backlight: tosa: Use GPIO lookup table

Bartosz Golaszewski (9):
      backlight: gpio: Remove unneeded include
      backlight: gpio: Remove stray newline
      backlight: gpio: Explicitly set the direction of the GPIO
      sh: ecovec24: add additional properties to the backlight device
      backlight: gpio: Simplify the platform data handling
      sh: ecovec24: don't set unused fields in platform data
      backlight: gpio: Remove unused fields from platform data
      backlight: gpio: Use a helper variable for &pdev->dev
      backlight: gpio: Pull gpio_backlight_initial_power_state() into probe

Colin Ian King (1):
      backlight: qcom-wled: Fix spelling mistake "trigged" -> "triggered"

Jean-Jacques Hiblot (1):
      dt-bindings: backlight: Add led-backlight binding

Kiran Gunda (8):
      backlight: qcom-wled: Rename pm8941-wled.c to qcom-wled.c
      backlight: qcom-wled: Restructure the qcom-wled bindings
      backlight: qcom-wled: Add new properties for PMI8998
      backlight: qcom-wled: Rename PM8941* to WLED3
      backlight: qcom-wled: Restructure the driver for WLED3
      backlight: qcom-wled: Add support for WLED4 peripheral
      backlight: qcom-wled: Add support for short circuit handling
      backlight: qcom-wled: Add auto string detection logic

Matthias Kaehlcke (2):
      backlight: pwm_bl: Don't assign levels table repeatedly
      backlight: pwm_bl: Add missing curly branches in else branch

Nishka Dasgupta (1):
      backlight: ipaq_micro: Make structure micro_bl_props constant

Rasmus Villemoes (4):
      backlight: pwm_bl: Fix cie1913 comments and constant
      backlight: pwm_bl: Eliminate a 64/32 division
      backlight: pwm_bl: Drop use of int_pow()
      backlight: pwm_bl: Switch to power-of-2 base for fixed-point math

Thomas Gleixner (1):
      backlight: Kconfig: jornada720: Use CONFIG_PREEMPTION

 .../bindings/leds/backlight/led-backlight.txt      |   28 +
 .../bindings/leds/backlight/lm3630a-backlight.yaml |    6 +
 .../bindings/leds/backlight/pm8941-wled.txt        |   42 -
 .../bindings/leds/backlight/qcom-wled.txt          |  154 +++
 arch/arm/mach-pxa/include/mach/tosa.h              |   15 -
 arch/arm/mach-pxa/tosa.c                           |   22 +
 arch/sh/boards/mach-ecovec24/setup.c               |   33 +-
 drivers/video/backlight/Kconfig                    |   12 +-
 drivers/video/backlight/Makefile                   |    2 +-
 drivers/video/backlight/gpio_backlight.c           |  128 +-
 drivers/video/backlight/ipaq_micro_bl.c            |    2 +-
 drivers/video/backlight/lm3630a_bl.c               |   13 +-
 drivers/video/backlight/pm8941-wled.c              |  424 -------
 drivers/video/backlight/pwm_bl.c                   |   39 +-
 drivers/video/backlight/qcom-wled.c                | 1296 ++++++++++++++++++++
 drivers/video/backlight/tosa_bl.c                  |   10 +-
 drivers/video/backlight/tosa_bl.h                  |    8 +
 drivers/video/backlight/tosa_lcd.c                 |   28 +-
 include/linux/platform_data/gpio_backlight.h       |    3 -
 19 files changed, 1653 insertions(+), 612 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
 delete mode 100644 drivers/video/backlight/pm8941-wled.c
 create mode 100644 drivers/video/backlight/qcom-wled.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
