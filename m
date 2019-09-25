Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06CBC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81546222C8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439587AbfIYP27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:28:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:20433 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727489AbfIYP27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:28:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 08:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; 
   d="scan'208";a="196032269"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Sep 2019 08:28:57 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 0/6] Support XSAVES supervisor states
Date:   Wed, 25 Sep 2019 08:10:16 -0700
Message-Id: <20190925151022.21688-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two types of XSAVE-managed states (xstates): user and supervisor.
This series introduces the supervisor xstate support in preparation for new
features that will make use of supervisor xstates.

This series has been separated for ease of review from the series that add
supervisor xstate features [3].

In current and near future generations of Intel processors there are three
classes of objects that can be managed as supervisor xstates:

- Processor Trace (PT):
    Linux already supports PT, but PT xstates are not saved to the FPU
    context and not context-switched by the kernel.  There are no plans to
    integrate PT into XSAVES supervisor states.

- ENQCMD Process Address Space ID (MSR_IA32_PASID):
    ENQCMD is a new instruction and will be introduced shortly in a
    separate series [2].

- Control-flow Enforcement Technology (CET):
    CET is being reviewed on the LKML [2] [3].

Supervisor xstates can be accessed only from the kernel (PL-0) with XSAVES/
XRSTORS instructions.  They cannot be accessed with other XSAVE*/XRSTOR*
instructions.  MSR_IA32_XSS sets enabled supervisor xstates, while XCR0
sets enabled user xstates.

This series separates the two xstate types by declaring new macros for each
type.  The kernel finds all available features during system initialization
and stores them in xfeatures_mask_all.  It then retrieves perspective
xstate type with xfeatures_mask_supervisor()/xfeatures_mask_user() for
handling signals and PTRACE.

[1] Detailed information on supervisor xstates can be found in "Intel 64
    and IA-32 Architectures Software Developer's Manual":

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] Detailed information on CET, the ENQCMD instruction and MSR_IA32_PASID
    can be found in "Intel Architecture Instruction Set Extensions and
    Future Features Programming Reference":

    https://software.intel.com/sites/default/files/managed/c5/15/
    architecture-instruction-set-extensions-programming-reference.pdf

[3] CET patches:

    https://lkml.kernel.org/r/20190813205225.12032-1-yu-cheng.yu@intel.com/
    https://lkml.kernel.org/r/20190813205359.12196-1-yu-cheng.yu@intel.com/

Fenghua Yu (3):
  x86/fpu/xstate: Define new macros for supervisor and user xstates
  x86/fpu/xstate: Define new functions for clearing fpregs and xstates
  x86/fpu/xstate: Rename validate_xstate_header() to
    validate_xstate_header_from_user()

Yu-cheng Yu (3):
  x86/fpu/xstate: Fix small issues before adding supervisor xstates
  x86/fpu/xstate: Separate user and supervisor xfeatures mask
  x86/fpu/xstate: Introduce XSAVES supervisor states

 arch/x86/include/asm/fpu/internal.h |   5 +-
 arch/x86/include/asm/fpu/xstate.h   |  46 ++++++----
 arch/x86/kernel/fpu/core.c          |  32 ++++---
 arch/x86/kernel/fpu/init.c          |   3 +-
 arch/x86/kernel/fpu/regset.c        |   2 +-
 arch/x86/kernel/fpu/signal.c        |  21 +++--
 arch/x86/kernel/fpu/xstate.c        | 131 ++++++++++++++++------------
 arch/x86/kernel/process.c           |   2 +-
 arch/x86/kernel/signal.c            |   2 +-
 9 files changed, 149 insertions(+), 95 deletions(-)

-- 
2.17.1

