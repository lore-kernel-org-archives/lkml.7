Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28965C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA4F2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfLJWoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:44:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:9123 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfLJWoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:44:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 14:44:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="413279324"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga005.fm.intel.com with ESMTP; 10 Dec 2019 14:44:18 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jun Nakajima <jun.nakajima@intel.com>
Subject: [PATCH 0/4] KVM: x86: Add checks on host-reserved cr4 bits
Date:   Tue, 10 Dec 2019 14:44:12 -0800
Message-Id: <20191210224416.10757-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM currently doesn't incorporate the platform's capabilities in its cr4
reserved bit checks and instead checks only whether KVM is aware of the
feature in general and whether or not userspace has advertised the feature
to the guest.

Lack of checking allows userspace/guest to set unsupported bits in cr4.
For the most part, setting unsupported bits will simply cause VM-Enter to
fail.  The one existing exception is OSXSAVE, which is conditioned on host
support as checking only guest_cpuid_has() would result in KVM attempting
XSAVE, leading to faults and WARNs.

57-bit virtual addressing has introduced another case where setting an
unsupported bit (cr4.LA57) can induce a fault in the host.  In the LA57
case, userspace can set the guest's cr4.LA57 by advertising LA57 support
via CPUID and abuse the bogus cr4.LA57 to effectively bypass KVM's
non-canonical address check, ultimately causing a #GP when VMX writes
the guest's bogus address to MSR_KERNEL_GS_BASE during VM-Enter.

Given that the best case scenario is a failed VM-Enter, there's no sane
reason to allow setting unsupported bits in cr4.  Fix the LA57 bug by not
allowing userspace or the guest to set cr4 bits that are not supported
by the platform.

Sean Christopherson (4):
  KVM: x86: Don't let userspace set host-reserved cr4 bits
  KVM: x86: Ensure all logical CPUs have consistent reserved cr4 bits
  KVM: x86: Drop special XSAVE handling from guest_cpuid_has()
  KVM: x86: Add macro to ensure reserved cr4 bits checks stay in sync

 arch/x86/kvm/cpuid.h   |  4 ---
 arch/x86/kvm/svm.c     |  1 +
 arch/x86/kvm/vmx/vmx.c |  1 +
 arch/x86/kvm/x86.c     | 65 +++++++++++++++++++++++++++++-------------
 4 files changed, 47 insertions(+), 24 deletions(-)

-- 
2.24.0

