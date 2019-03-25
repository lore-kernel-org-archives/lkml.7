Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CE7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A9520830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfCYIHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:07:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:50930 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729828AbfCYIHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:07:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 01:07:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="134474058"
Received: from lxy-server.sh.intel.com ([10.239.48.11])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2019 01:07:11 -0700
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
Subject: [PATCH v3 0/2] Switch MSR_MISC_FEATURES_ENABLES and one optimization
Date:   Mon, 25 Mar 2019 16:06:48 +0800
Message-Id: <20190325080650.19896-1-xiaoyao.li@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 switches MSR_MISC_FEATURES_ENABLE between host and guest to avoid
cpuid faulting and ring3mwait of host leaking to guest. Because cpuid
faulting eanbled in host may potentially cause guest boot failure, and kvm
doesn't expose ring3mwait to guest yet, it should be leaked to guest.

Patch 2 optimizes the switch of MSR_MISC_FEATURES_ENABLES by avoiding WRMSR
whenever possible to save cycles.

==changelog==
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
 arch/x86/kvm/vmx/vmx.c          | 31 +++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              | 15 ++++++++++++---
 4 files changed, 46 insertions(+), 3 deletions(-)

-- 
2.19.1

