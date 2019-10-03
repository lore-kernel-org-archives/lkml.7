Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83820C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6481F20865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbfJCRst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:48:49 -0400
Received: from foss.arm.com ([217.140.110.172]:52756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbfJCRst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:48:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2E7E1000;
        Thu,  3 Oct 2019 10:48:48 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79DDD3F739;
        Thu,  3 Oct 2019 10:48:47 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, ard.biesheuvel@linaro.org,
        ndesaulniers@google.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, luto@kernel.org
Subject: [PATCH v5 0/6] arm64: vdso32: Address various issues
Date:   Thu,  3 Oct 2019 18:48:32 +0100
Message-Id: <20191003174838.8872-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is meant to address the various compilation issues
reported recently for arm64 vdso32 [1].

From v4, the series contains a cleanup of lib/vdso Kconfig as well since
CROSS_COMPILE_COMPAT_VDSO is not required anymore by any architecture.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

[1] https://www.spinics.net/lists/kernel/msg3260702.html

---

v5:
  - Add a check on empty CROSS_COMPILE_COMPAT

v4:
  - Drop __arm64__ workaround
  - Remove COMPAT_CC_IS_GCC check
  - Remove unused configuration parameter from lib/vdso
  - Address Review Comments

v3:
  - Exposed COMPATCC
  - Addressed Review Comments
 
v2:
  - Fixed binutils detection
  - Addressed review comments

Vincenzo Frascino (6):
  arm64: vdso32: Fix syncconfig errors.
  arm64: vdso32: Detect binutils support for dmb ishld
  arm64: Remove gettimeofday.S
  arm64: vdso32: Remove jump label config option in Makefile
  arm64: Remove vdso_datapage.h
  lib: vdso: Remove CROSS_COMPILE_COMPAT_VDSO

 arch/arm64/Kconfig                           |  5 ++-
 arch/arm64/Makefile                          | 18 +++--------
 arch/arm64/include/asm/vdso/compat_barrier.h |  2 +-
 arch/arm64/include/asm/vdso_datapage.h       | 33 --------------------
 arch/arm64/kernel/vdso/gettimeofday.S        |  0
 arch/arm64/kernel/vdso32/Makefile            | 14 ++++++---
 lib/vdso/Kconfig                             |  9 ------
 7 files changed, 19 insertions(+), 62 deletions(-)
 delete mode 100644 arch/arm64/include/asm/vdso_datapage.h
 delete mode 100644 arch/arm64/kernel/vdso/gettimeofday.S

-- 
2.23.0

