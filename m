Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EC8C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B6A214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbfLLVVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:21:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:25359 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730971AbfLLVVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:21:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 13:20:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,307,1571727600"; 
   d="scan'208";a="226062825"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga002.jf.intel.com with ESMTP; 12 Dec 2019 13:20:48 -0800
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
Subject: [PATCH v2 0/3] Fix small issues in XSAVES
Date:   Thu, 12 Dec 2019 13:08:52 -0800
Message-Id: <20191212210855.19260-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rebase v1 to Linux v5.5-rc1.  This supersedes the previous version, but
does not have any functional changes.

The first two patches in this series are split from my supervisor xstate
patches [2].  The third is to fix a vital issue in __fpu_restore_sig(),
and more RFC than the others.  All three are not directly related to
supervisor xstates or CET, split them out and submit first.  I will
re-submit supervisor xstate patches shortly.

When__fpu_restore_sig() fails, partially cleared FPU registers still belong
to the previous owner task.  That causes that task to use corrupted xregs.
Fix it by doing __cpu_invalidate_fpregs_state() in functions that copy into
fpregs.  Further details are in the commit log of patch #3.

[1] v1 of this series:
    https://lkml.kernel.org/r/20191205182648.32257-1-yu-cheng.yu@intel.com/

[2] Support XSAVES supervisor states
    https://lkml.kernel.org/r/20190925151022.21688-1-yu-cheng.yu@intel.com/

[3] CET patches:
    https://lkml.kernel.org/r/20190813205225.12032-1-yu-cheng.yu@intel.com/
    https://lkml.kernel.org/r/20190813205359.12196-1-yu-cheng.yu@intel.com/

Yu-cheng Yu (3):
  x86/fpu/xstate: Fix small issues before adding supervisor xstates
  x86/fpu/xstate: Make xfeature_is_supervisor()/xfeature_is_user()
    return bool
  x86/fpu/xstate: Invalidate fpregs when __fpu_restore_sig() fails

 arch/x86/include/asm/fpu/internal.h | 14 ++++++++++++++
 arch/x86/kernel/fpu/core.c          | 16 ++++++++++++++--
 arch/x86/kernel/fpu/xstate.c        | 18 ++++++++----------
 3 files changed, 36 insertions(+), 12 deletions(-)

-- 
2.17.1

