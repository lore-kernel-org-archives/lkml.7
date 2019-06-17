Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA794C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8135A208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfFQSJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:09:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:62757 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfFQSJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:09:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 11:09:51 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jun 2019 11:09:51 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Christopherson Sean J" <sean.j.christopherson@intel.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Radim Krcmar" <rkrcmar@redhat.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 0/2] x86/cpufeatures: Re-arrange a few features and enumerate AVX512 BFLOAT16 intructions
Date:   Mon, 17 Jun 2019 11:00:14 -0700
Message-Id: <1560794416-217638-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enumerate AVX512 BFLOAT16 feature CPUID.7.1:EAX[5] and other future
features in CPUID.7.1:EAX, Boris suggests to create a new pure feature
bits word.

Boris further suggests to re-define word 11 as a scattered features word
and move the four X86_FEATURE_CQM_* features in existing word 11 and
word 12 into the new word 11. Then use word 12 to hold features in
CPUID.7.1:EAX including AVX512 BFLOAT16 instructions.

Change Log:
v2:
- Remove patch 0001 and keep x86_cache_max_rmid and x86_cache_occ_scale
  in cpuinfo_x86 per Thomas Gleixner's comment. 

v1:
Address all comments from Borislav Petkov:
- Re-define feature word 11 as a scattered features word and move the
  four X86_FEATURE_CQM_* features into the word
- Re-define feature word 12 to hold CPUID.7.1:EAX including BFLOAT16
- Name a dummy leaf 12 in cpuid_leafs in patch 0002 to avoid bisect
  error
- Simplify code to get number of rmid and monitoring scale in
  rdt_get_mon_l3_config()

Fenghua Yu (2):
  x86/cpufeatures: Combine word 11 and 12 into new scattered features
    word 11
  x86/cpufeatures: Enumerate new AVX512 BFLOAT16 instructions

 arch/x86/include/asm/cpufeature.h  |  4 +--
 arch/x86/include/asm/cpufeatures.h | 18 ++++++----
 arch/x86/kernel/cpu/common.c       | 56 ++++++++++++++++--------------
 arch/x86/kernel/cpu/cpuid-deps.c   |  4 +++
 arch/x86/kernel/cpu/scattered.c    |  4 +++
 arch/x86/kvm/cpuid.h               |  2 --
 6 files changed, 51 insertions(+), 37 deletions(-)

-- 
2.19.1

