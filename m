Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8EAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA2421582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfLQVcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:32:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:17437 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbfLQVco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:32:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 13:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="227639443"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga002.jf.intel.com with ESMTP; 17 Dec 2019 13:32:42 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] KVM: x86: X86_FEATURE bit() cleanup
Date:   Tue, 17 Dec 2019 13:32:37 -0800
Message-Id: <20191217213242.11712-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small series to add build-time protections on reverse CPUID lookup (and
other usages of bit()), and to rename the misleading-generic bit() helper
to something that better conveys its purpose.

I don't love emulator changes in patch 1 as adding one-off helpers is a
bit silly, but IMO it's the lesser of two evils, e.g. adding dedicated
helpers is arguably less error prone than manually encoding a CPUID
lookup, and the helpers approach avoids having to include cpuid.h in the
emulator code.

v2:
  - Rework the assertions to use the reverse_cpuid table instead of
    using the last cpufeatures word (which was not at all intuitive).

Sean Christopherson (5):
  KVM: x86: Add dedicated emulator helpers for querying CPUID features
  KVM: x86: Move bit() helper to cpuid.h
  KVM: x86: Add CPUID_7_1_EAX to the reverse CPUID table
  KVM: x86: Expand build-time assertion on reverse CPUID usage
  KVM: x86: Refactor and rename bit() to feature_bit() macro

 arch/x86/include/asm/kvm_emulate.h |  4 +++
 arch/x86/kvm/cpuid.c               |  5 ++--
 arch/x86/kvm/cpuid.h               | 41 +++++++++++++++++++++++++----
 arch/x86/kvm/emulate.c             | 21 +++------------
 arch/x86/kvm/svm.c                 |  4 +--
 arch/x86/kvm/vmx/vmx.c             | 42 +++++++++++++++---------------
 arch/x86/kvm/x86.c                 | 18 +++++++++++++
 arch/x86/kvm/x86.h                 |  5 ----
 8 files changed, 87 insertions(+), 53 deletions(-)

-- 
2.24.1

