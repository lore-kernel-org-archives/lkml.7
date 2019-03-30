Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BADC10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3C4218D3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="mEnTnijL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbfC3LUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 07:20:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57354 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730414AbfC3LUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 07:20:23 -0400
Received: from zn.tnic (p200300EC2F148A00C43C95AA310C833A.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:c43c:95aa:310c:833a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B387D1EC08EF;
        Sat, 30 Mar 2019 12:20:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553944821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=kNC5HD6u4D/o0+S/1Z0PUzhnjg7VtnUDwC+ggcQR8wU=;
        b=mEnTnijLc8Y2Jn14XZm9kqMBrvqtXXMybBoisz8Zs8VyuG9lhh0ileFnTVkFwf/O2WbevJ
        lKi8MONmO7BC/SjQ8n60ArJu9B5OUVIisjoigxG4tb1xuKRgyFo9uuyVrGVhJiuzx2fASI
        UIX7ihed+6M6yz5rNhTWkL2GtOPKsgk=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/5] x86/asm: Remove some static_cpu_has() usage
Date:   Sat, 30 Mar 2019 12:20:17 +0100
Message-Id: <20190330112022.28888-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

this came about after Nadav asked about static_cpu_has() and when it
should be used. The resulting converts a bunch of slow-paths to use
the plain boot_cpu_has() tester which is straight-forward and doesn't
require to be patched in by alternatives, leaving static_cpu_has() only
to the fast paths, where it should be used anyway.

Thx.

Borislav Petkov (5):
  x86/asm: Clarify static_cpu_has()'s intended use
  x86: Convert some slow-path static_cpu_has() callers to boot_cpu_has()
  x86/kvm: Convert some slow-path static_cpu_has() callers to
    boot_cpu_has()
  x86/mm: Convert some slow-path static_cpu_has() callers to
    boot_cpu_has()
  drivers/cpufreq: Convert some slow-path static_cpu_has() callers to
    boot_cpu_has()

 arch/x86/include/asm/cpufeature.h      |  9 ++++++---
 arch/x86/include/asm/fpu/internal.h    |  7 +++----
 arch/x86/kernel/apic/apic_numachip.c   |  2 +-
 arch/x86/kernel/cpu/aperfmperf.c       |  6 +++---
 arch/x86/kernel/cpu/common.c           |  2 +-
 arch/x86/kernel/cpu/mce/inject.c       |  2 +-
 arch/x86/kernel/cpu/proc.c             | 10 +++++-----
 arch/x86/kernel/ldt.c                  | 14 +++++++-------
 arch/x86/kernel/paravirt.c             |  2 +-
 arch/x86/kernel/process.c              |  4 ++--
 arch/x86/kernel/reboot.c               |  2 +-
 arch/x86/kernel/vm86_32.c              |  2 +-
 arch/x86/kvm/svm.c                     | 10 +++++-----
 arch/x86/kvm/vmx/vmx.c                 |  4 ++--
 arch/x86/mm/dump_pagetables.c          |  4 ++--
 arch/x86/mm/pgtable.c                  |  4 ++--
 arch/x86/mm/pti.c                      |  2 +-
 drivers/cpufreq/amd_freq_sensitivity.c |  2 +-
 drivers/cpufreq/intel_pstate.c         | 18 +++++++++---------
 drivers/cpufreq/powernow-k8.c          |  2 +-
 20 files changed, 55 insertions(+), 53 deletions(-)

-- 
2.21.0

