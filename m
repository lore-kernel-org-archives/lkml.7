Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8A6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FE920868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDOe9qJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfDPMpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:45:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39554 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfDPMpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:45:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so26862742wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=89mNLYyVETcDIF7eFdnKpj3ZEZYRkLWJw++cCoTtYqE=;
        b=vDOe9qJ/RKcFDQaBuk2sXGW74MnA+UFlOuYO1sFBi4ohF6uX8MX+gsrStpfN2/wDRf
         odxyyGBPZoR7C5oQ5Uobz98OOouX0PqUaKrGVFqri0HTn+Nu1DDRf0AUBq8NSK+QX5va
         ivkdocO4zLU9VU5M8G+tFekAICVt3vFgA8r3bMVDsaOxokzivaF5ezI6/bLBGJjIgfiW
         kr+v45NkQVDXVw31o2XlYb27njdvHWlRD1/E3mUWdK/jriAXM4UiUy2/qDZB8hNZwWsX
         9gDlFrTEBkhAlBJd0BcwC790txqSTrv35iTobrFCe9UyjGyq34+5n2zA7HzfR1nFotxN
         DOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=89mNLYyVETcDIF7eFdnKpj3ZEZYRkLWJw++cCoTtYqE=;
        b=X03DftBfDTJ3d8JLNcj7r96lGuYOKg90SFicbkJJc8T42sOIocRD3MFKw63zuf36Eu
         ItevrbFazrNCsEwsT/zvb/J6n3EUqC8PFClcHmscZdkNwb0x4yT4/liBM8CnBvtH6ddu
         MeG8DGq0zhN6UPMAbxy4xo4LtgiVymdgYNlH8jEvqvKibSFTTNj/LU7MhhXAHoQCAIv+
         qM1szAgbeDDWpmGQRxZ0AngU9wUGPqQDJi5wLXEX/SJyNHdSmJa/HltUrf1tf/lxjE0a
         5IDldobzrgne7zXFqo4EZFOWGWNr7GxveYClI2dlTiuhNksEEPo2g3cEff0e398CRlEn
         Ws/w==
X-Gm-Message-State: APjAAAXEx/cqCtX0XEwxV30HhzcQ/oWCkNdmgmhJR/h/2iARVJqbKcJ2
        CvC4YdLpXM+P7/z/BccyK9UK3akyuNI=
X-Google-Smtp-Source: APXvYqwTX9eO6pGN4v4WrD++ti2de8hdQhGAs5vk4mkCmXR3h1hxASUlGFoGfHjTlvKsY+gMsJHfxQ==
X-Received: by 2002:adf:ec11:: with SMTP id x17mr15421952wrn.120.1555418749731;
        Tue, 16 Apr 2019 05:45:49 -0700 (PDT)
Received: from [192.168.0.41] (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.googlemail.com with ESMTPSA id u14sm47876076wrr.1.2019.04.16.05.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 05:45:48 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd.bergmann@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] clockevents / clocksource fixes for 5.1
Message-ID: <92427592-507b-e280-01bf-763d795c8a2f@linaro.org>
Date:   Tue, 16 Apr 2019 14:45:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 07d7e12091f4ab869cc6a4bb276399057e73b0b3:

  alarmtimer: Return correct remaining time (2019-04-10 15:23:26 +0200)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git
tags/timers-v5.1-rc6

for you to fetch changes up to 4d86c9f73c5a9a7c3c0661e922509c2c51801671:

  clocksource/drivers/timer-ti-dm: Remove omap_dm_timer_set_load_start
(2019-04-16 14:26:54 +0200)

----------------------------------------------------------------
Clockevent / clocksource fixes update for v5.1-rc6

 - Fix TIMER_OF missing option dependency for npcm (Arnd Bergmann)

 - Remove a pointless macro call for arm_arch_timer (Yangtao Li)

 - Fix wrong compatible string for oxnas (Neil Armstrong)

 - Fix compilation warning by removing a dead function on omap (Nathan
Chancellor)

----------------------------------------------------------------
Arnd Bergmann (1):
      clocksource/drivers/npcm: select TIMER_OF

Nathan Chancellor (1):
      clocksource/drivers/timer-ti-dm: Remove omap_dm_timer_set_load_start

Neil Armstrong (1):
      clocksource/drivers/oxnas: Fix OX820 compatible

Yangtao Li (1):
      clocksource/drivers/arm_arch_timer: Remove unneeded pr_fmt macro

 drivers/clocksource/Kconfig           |  1 +
 drivers/clocksource/arm_arch_timer.c  |  5 +----
 drivers/clocksource/timer-oxnas-rps.c |  2 +-
 drivers/clocksource/timer-ti-dm.c     | 28 ----------------------------
 4 files changed, 3 insertions(+), 33 deletions(-)

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

