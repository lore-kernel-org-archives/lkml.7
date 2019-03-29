Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B43C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B801C20651
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfC2Nyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:54:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:44836 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729666AbfC2Nyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:54:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 06:54:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,284,1549958400"; 
   d="scan'208";a="138342085"
Received: from lxy-server.sh.intel.com ([10.239.48.11])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2019 06:54:47 -0700
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        chao.gao@intel.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v4 0/2] Switch MSR_MISC_FEATURES_ENABLES and one optimization
Date:   Fri, 29 Mar 2019 21:54:20 +0800
Message-Id: <20190329135422.15046-1-xiaoyao.li@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 switches MSR_MISC_FEATURES_ENABLE between host and guest during
vcpu_{load,put} to avoid cpuid faulting and ring3mwait of host leaking
to guest. Because cpuid faulting eanbled in host may potentially cause guest
boot failure, and kvm doesn't expose ring3mwait to guest yet. 
Both two features shouldn't be leaked to guest.

Patch 2 optimizes the switch of MSR_MISC_FEATURES_ENABLES by avoiding WRMSR
whenever possible to save cycles.

==changelog==
v3->v4:
remove the helper function, and some code refine. per Sean Christopherson's
comments.

v2->v3:
- use msr_misc_features_shadow instead of reading hardware msr, from Sean
Christopherson
- avoid WRMSR whenever possible, from Sean Christopherson.

v1->v2: 
- move the save/restore of cpuid faulting bit to
vmx_prepare_swich_to_guest/vmx_prepare_swich_to_host to avoid every
vmentry RDMSR, based on Paolo's comment.

Xiaoyao Li (2):
  kvm/vmx: Switch MSR_MISC_FEATURES_ENABLES between host and guest
  x86/vmx: optimize MSR_MISC_FEATURES_ENABLES switch

 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kernel/process.c       |  1 +
 arch/x86/kvm/vmx/vmx.c          | 17 +++++++++++++++++
 arch/x86/kvm/x86.c              | 11 ++++++++---
 4 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.19.1

