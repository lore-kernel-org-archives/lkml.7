Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD34C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B7521904
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfDHPth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:49:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50568 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfDHPth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:49:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C678215AB;
        Mon,  8 Apr 2019 08:49:36 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.196.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0500C3F557;
        Mon,  8 Apr 2019 08:49:34 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 0/7] clocksource/arm_arch_timer: Removing the static branch on errata handling
Date:   Mon,  8 Apr 2019 16:49:00 +0100
Message-Id: <20190408154907.223536-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static key used to deal with the errata workaround that plague a
significant number of arm64 systems (who thought that building a timer
was that hard?) has proved to be a disaster when dealing with
lockdep. We try to activate it in contexts that were never expected,
and things break pretty loudly.

This series takes the easy way out and removes the static key
altogether. It always looked like premature optimisation anyway, and
some of the hooks can be implemented in saner ways. To get there, some
unrelated bits have to be fixed first: the 32bit vdso as well as some
of the arm64 stuff.

Marc Zyngier (7):
  ARM: vdso: Remove dependency with the arch_timer driver internals
  watchdog/sbsa: Use arch_timer_read_counter instead of
    arch_counter_get_cntvct
  arm64: Use arch_timer_read_counter instead of arch_counter_get_cntvct
  clocksource/arm_arch_timer: Direcly assign set_next_event workaround
  clocksource/arm_arch_timer: Drop use of static key in
    arch_timer_reg_read_stable
  clocksource/arm_arch_timer: Remove use of workaround static key
  clocksource/arm_arch_timer: Use arch_timer_read_counter to access
    stable counters

 arch/arm/include/asm/arch_timer.h    |  18 ++++-
 arch/arm/include/asm/cp15.h          |   2 +
 arch/arm/vdso/vgettimeofday.c        |   5 +-
 arch/arm64/include/asm/arch_timer.h  |  78 +++++++++++++-----
 arch/arm64/kernel/traps.c            |   4 +-
 drivers/clocksource/arm_arch_timer.c | 115 +++++++++++++--------------
 drivers/watchdog/sbsa_gwdt.c         |   2 +-
 7 files changed, 139 insertions(+), 85 deletions(-)

-- 
2.20.1

