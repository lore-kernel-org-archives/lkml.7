Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BODY_QUOTE_MALF_MSGID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1F9C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1D420820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SQ6TfzgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407806AbfIWXF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 19:05:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36079 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404332AbfIWXF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 19:05:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so3139pgb.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 16:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=8GW2ZAMOExxQqbATbwezF6NgpB/8s7Vd0S2JE2TvzMw=;
        b=SQ6TfzgVKHsPa7qoO3x2FDRQuqXM4QHm//nv6NynsbpMmNYceMtAQsFaQQVyoBHset
         9H0APDmWw4HYH9TAKK2yf5A985926S2pXXSqQbak1HRPUpfledqEV38BL2uP2IxOBZbw
         bC1pea9EbLfFy5YIKRQGluCeU3Nawbszh/aoNnRKJXnU6tx+5WzGZ/tXqVrGJcvDVBuv
         66Tc96u+TWxKN/xonY7+q2c4MHUHDZEwWZKz2l76b3GscGbqRV92cbDGldMOqPriLm6U
         6yeMxturyRTjr1mAtaoxYEf6mIOEB7EBJc08zlTbw8Ug81ZbT4iJ/pHvmgMqaliIesty
         QcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=8GW2ZAMOExxQqbATbwezF6NgpB/8s7Vd0S2JE2TvzMw=;
        b=Czh4tFjIBsfOnCJ+E6WuCMP09uReGL/wf+DGsktc8Mu34/wtsXKLfYt2eScqC0gbIN
         1uKssQTHWBSyOUFIwKp1ZC+wf/5PNvQbXuOmtB3kfn0fnepOxdaza0B/2E5RECsY02/C
         srkZVOF/VDDID3GMsf3q9I5l6fw3foBX79HeUGHTt2j1aQKqw5ML8ndnDMt674mC9Irm
         t+ODFakQ9GqJ3eDmogFgJpkRSpdYN3Dfx68QXxkviRoTdItnnHLreaH7S3iVGTTwZsj3
         2epsXo4UYKfzWWvpMmeS572qRIaJ1SvrJg1chboHq/AtZnYhlVEOtgjXKlygZrd8TmAB
         i1Gw==
X-Gm-Message-State: APjAAAViNipo5S/YxT7yA//vuYxa5Bz/qFCf43cb9h5RU2DxOGe/g+90
        rmS263MtaD7AR2WGoG+7ccLcau9gUegHmw==
X-Google-Smtp-Source: APXvYqx0gLhUcmUCEl8p/O2UANVWsKSq7sWSDFzQkpaYnf5dq8qLsX8LzUCGfvg79At1wAoIZLhYvg==
X-Received: by 2002:a17:90b:903:: with SMTP id bo3mr2035155pjb.52.1569279956601;
        Mon, 23 Sep 2019 16:05:56 -0700 (PDT)
Received: from dell ([12.157.10.118])
        by smtp.gmail.com with ESMTPSA id q2sm15061006pfg.144.2019.09.23.16.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Sep 2019 16:05:55 -0700 (PDT)
Date:   Tue, 24 Sep 2019 00:05:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Backlight for v5.4
Message-ID: <20190923230554.GA4469@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Enjoy!

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.4

for you to fetch changes up to c0b64faf0fe6ca2574a00faed1ae833130db4e08:

  backlight: pwm_bl: Set scale type for brightness curves specified in the DT (2019-09-02 15:55:15 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Obtain scale type through sysfs

 - New Functionality
   - Provide Device Tree functionality; rave-sp-backlight
   - Calculate if scale type is (non-)linear; pwm_bl

 - Fix-ups
   - Simplify code; lm3630a_bl
   - Trivial rename/whitespace/typo fixes; lms283gf05
   - Remove superfluous NULL check; tosa_lcd
   - Fix power state initialisation; gpio_backlight
   - List supported file; MAINTAINERS

 - Bug Fixes
   - Kconfig - default to not building unless requested; {LED,BACKLIGHT}_CLASS_DEVICE

----------------------------------------------------------------
Andy Shevchenko (1):
      backlight: lm3630a: Switch to use fwnode_property_count_uXX()

Christophe JAILLET (1):
      backlight: lms283gf05: Fix a typo in the description passed to 'devm_gpio_request_one()'

Geert Uytterhoeven (1):
      video: backlight: Drop default m for {LCD,BACKLIGHT_CLASS_DEVICE}

Lucas Stach (1):
      backlight: rave-sp: Leave initial state and register with correct device

Matthias Kaehlcke (4):
      MAINTAINERS: Add entry for stable backlight sysfs ABI documentation
      backlight: Expose brightness curve type through sysfs
      backlight: pwm_bl: Set scale type for CIE 1931 curves
      backlight: pwm_bl: Set scale type for brightness curves specified in the DT

Peter Ujfalusi (1):
      backlight: gpio-backlight: Correct initial power state handling

Wolfram Sang (1):
      video: backlight: tosa_lcd: drop check because i2c_unregister_device() is NULL safe

 Documentation/ABI/testing/sysfs-class-backlight | 26 ++++++++++++++++++
 MAINTAINERS                                     |  2 ++
 drivers/video/backlight/Kconfig                 |  2 --
 drivers/video/backlight/backlight.c             | 19 ++++++++++++++
 drivers/video/backlight/gpio_backlight.c        | 24 ++++++++++++++---
 drivers/video/backlight/lm3630a_bl.c            |  3 +--
 drivers/video/backlight/lms283gf05.c            |  2 +-
 drivers/video/backlight/pwm_bl.c                | 35 ++++++++++++++++++++++++-
 drivers/video/backlight/rave-sp-backlight.c     | 10 +++++--
 drivers/video/backlight/tosa_lcd.c              |  3 +--
 include/linux/backlight.h                       |  8 ++++++
 11 files changed, 120 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
