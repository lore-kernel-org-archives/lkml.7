Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E4FC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302A320644
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BjvDh5X0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEILIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:08:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36292 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEILIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:08:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id j187so2655638wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=SUcgVx2gMtKScGw6caSu3L4u/yj/AAj0Lf7xRwh9xWI=;
        b=BjvDh5X0biBT2GHajzhOi+ywIukzReQjICaRlWxIf+yTNkklNGCr1ai2fJ0miOG2hd
         ZvE+UQoINpfJPrxch20fEFH69amQa6+dHF8Knn5vYD/KL61ZorLfSC7kA9Bo8K22PJ0N
         LQPwb5xNuesw4IiBj9gKL/J3g204bTGHqa7P1uGg+WlF29ODQW+hriZL5it+tlrfyZVd
         XoU6g5iioOBXrn0JgKE2eKXTydnqwdENaPtqRmOHgwFvDduYZlfup8NP7CemLsPmppAV
         NrerpbaTXWeK2oK/AQvF2JCs7HUbvLdY4jiunCRNza/BgoDBjfATgSI5VblqtDjnScUE
         4jdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SUcgVx2gMtKScGw6caSu3L4u/yj/AAj0Lf7xRwh9xWI=;
        b=t7Iz5BwuljZNvL/DZTDXdbiilj0JsgQid11m5rq0bdBhm/DmV9sFqn6Pnm+96XBbx3
         THWietaDR8Bah5bM1NrkBvIrnTGZEhE2XLtFbw1hDfi7+/g+feQFWZZysrbrHNgx9mi8
         X98dI9EnIQnlSIdJ38CV0SMW+vi4LSZyxmeh5j6qt/sOuTm2TstT0BVqGnUSYI8nWWG9
         Kdk7hemzKJB26rNf54hwR+PY7dxQdUrSF7Vo7T1zcwwfYLjv2vJWynsE0xAmBKtfSwZZ
         PzZNxhcM0GRZapX4vHqTsYuuZTAxZg1Cqw6YJnrbVShgKcAHq0nd7GYJ0K/3R4py/N+0
         gWow==
X-Gm-Message-State: APjAAAXTuk1u2d0HjLx0Txi7TCHWT+Er8ZzaUlOvK4Yozuso4nx9c3lr
        j855W3wSkb1ULaglKt9ZRSlYObfV0GM=
X-Google-Smtp-Source: APXvYqyLBYL2TGo47RM9bpbju4eVQO+k/LBVm75XqRxomFq9EPqvkx/UODnDPvGJVIqNfFMeQoPzGA==
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr2651378wmq.31.1557400083726;
        Thu, 09 May 2019 04:08:03 -0700 (PDT)
Received: from [141.115.39.235] ([141.115.39.235])
        by smtp.googlemail.com with ESMTPSA id m8sm3288985wrg.18.2019.05.09.04.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:08:03 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Joseph Lo <josephl@nvidia.com>,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for 5.2
Message-ID: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
Date:   Thu, 9 May 2019 13:08:00 +0200
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

Hi Thomas,

here a (late) pull request for the changes on 5.2.

 - Add compatible string for suniv for sun4i (Mesih Kilinc)

 - Add COMPILE_TEST option for sp804 (David Abdurachmanov)

 - Replace the compensation time when suspend happens on tegra with the one
   provided by the generic framework (Joseph Lo)

 - Cleanup, shutdown and oneshot mode fix on milbeaut timer (Sugaya Taichi)

 - Atmel TCB rework to fix boot failure on boards without PIT or misfunction
   on system using a preempt-rt kernel (Alexandre Belloni)

Thanks!

  -- Daniel


The following changes since commit 67d06e6efa41c4135cfc4c4c5c9b55d5e3a9b6f7:

  dt-bindings: timer: Add Allwinner suniv timer (2019-05-02 21:55:58 +0200)

are available in the Git repository at:

  http://git@git.linaro.org/people/daniel.lezcano/linux.git tags/timers-v5.2

for you to fetch changes up to 8c9374068ef6dc3fdf244484b4711a6e10c84d1a:

  misc: atmel_tclib: Do not probe already used TCBs (2019-05-02 21:55:58
+0200)

----------------------------------------------------------------
 - Add compatible string for suniv for sun4i (Mesih Kilinc)

 - Add COMPILE_TEST option for sp804 (David Abdurachmanov)

 - Replace the compensation time when suspend happens on tegra with the one
   provided by the generic framework (Joseph Lo)

 - Cleanup, shutdown and oneshot mode fix on milbeaut timer (Sugaya Taichi)

 - Atmel TCB rework to fix boot failure on boards without PIT or misfunction
   on system using a preempt-rt kernel (Alexandre Belloni)

----------------------------------------------------------------
Alexandre Belloni (8):
      ARM: at91: move SoC specific definitions to SoC folder
      clocksource/drivers/tcb_clksrc: Stop depending on atmel_tclib
      clocksource/drivers/tcb_clksrc: Use tcb as sched_clock
      ARM: at91: Implement clocksource selection
      clocksource/drivers/tcb_clksrc: Move Kconfig option
      clocksource/drivers/timer-atmel-pit: Rework Kconfig option
      clocksource/drivers/tcb_clksrc: Rename the file for consistency
      misc: atmel_tclib: Do not probe already used TCBs

David Abdurachmanov (1):
      clocksource/drivers/sp804: Add COMPILE_TEST to CONFIG_ARM_TIMER_SP804

Joseph Lo (1):
      clocksource/drivers/tegra: Rework for compensation of suspend time

Mesih Kilinc (1):
      clocksource/drivers/sun4i: Add a compatible for suniv

Sugaya Taichi (3):
      clocksource/drivers/timer-milbeaut: Fix to enable one-shot timer
      clocksource/drivers/timer-milbeaut: Add shutdown function
      clocksource/drivers/timer-milbeaut: Cleanup common register accesses

kbuild test robot (1):
      clocksource/drivers/timer-atmel-tcb: Convert
tc_clksrc_suspend|resume() to static

 arch/arm/mach-at91/Kconfig                              |  23
+++++++++++++++
 drivers/clocksource/Kconfig                             |  14 +++++++--
 drivers/clocksource/Makefile                            |   2 +-
 drivers/clocksource/{tcb_clksrc.c => timer-atmel-tcb.c} | 130
+++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
 drivers/clocksource/timer-milbeaut.c                    |  66
++++++++++++++++++++++++++++++------------
 drivers/clocksource/timer-sun4i.c                       |   5 +++-
 drivers/clocksource/timer-tegra20.c                     |  63
+++++++++++++---------------------------
 drivers/misc/Kconfig                                    |  24
---------------
 drivers/misc/atmel_tclib.c                              |   5 +++-
 drivers/pwm/pwm-atmel-tcb.c                             |   2 +-
 include/{linux/atmel_tc.h => soc/at91/atmel_tcb.h}      |   4 +--
 11 files changed, 201 insertions(+), 137 deletions(-)
 rename drivers/clocksource/{tcb_clksrc.c => timer-atmel-tcb.c} (79%)
 rename include/{linux/atmel_tc.h => soc/at91/atmel_tcb.h} (99%)


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

