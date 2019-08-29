Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732A2C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8692189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfH2LS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:18:59 -0400
Received: from foss.arm.com ([217.140.110.172]:42722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfH2LS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:18:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 843BF1570;
        Thu, 29 Aug 2019 04:18:57 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13D983F59C;
        Thu, 29 Aug 2019 04:18:55 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com,
        tglx@linutronix.de, salyzyn@android.com, 0x7f454c46@gmail.com,
        luto@kernel.org
Subject: [PATCH 0/7] vdso: Complete the conversion to 32bit syscalls
Date:   Thu, 29 Aug 2019 12:18:36 +0100
Message-Id: <20190829111843.41003-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a follow up to "lib/vdso, x86/vdso: Fix fallout
from generic VDSO conversion" [1].

The main purpose is to complete the 32bit vDSOs conversion to use the
legacy 32bit syscalls as a fallback. With the conversion of all the
architectures present in -next complete, this patch series removes as
well the conditional choice in between 32 and 64 bit for 32bit vDSOs.

This series has been rebased on linux-next/master.

[1] https://lkml.org/lkml/2019/7/28/86

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (7):
  arm64: compat: vdso: Expose BUILD_VDSO32
  lib: vdso: Build 32 bit specific functions in the right context
  mips: compat: vdso: Use legacy syscalls as fallback
  lib: vdso: Remove VDSO_HAS_32BIT_FALLBACK
  arm64: compat: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
  mips: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
  x86: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK

 .../include/asm/vdso/compat_gettimeofday.h    |  2 +-
 arch/mips/include/asm/vdso/gettimeofday.h     | 43 +++++++++++++++++++
 arch/mips/vdso/config-n32-o32-env.c           |  1 +
 arch/x86/include/asm/vdso/gettimeofday.h      |  2 -
 lib/vdso/gettimeofday.c                       | 14 ++----
 5 files changed, 49 insertions(+), 13 deletions(-)

-- 
2.23.0

