Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7A9C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA2C21882
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbfKFRHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:07:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:58093 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbfKFRH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:07:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 09:07:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="192527997"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga007.jf.intel.com with ESMTP; 06 Nov 2019 09:07:28 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>,
        David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 0/2] KVM: MMU: Fix a refcount bug with ZONE_DEVICE pages
Date:   Wed,  6 Nov 2019 09:07:25 -0800
Message-Id: <20191106170727.14457-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mini-series fixes a suspected, but technically unconfirmed, bug in
KVM related to ZONE_DEVICE pages.  The suspected issue is that KVM treats
ZONE_DEVICE pages as reserved PFNs, and so doesn't put references to such
pages when dropping references via KVM's generic kvm_release_pfn_clean().

David Hildenbrand uncovered the bug during a discussion about removing
PG_reserved from ZONE_DEVICE pages, after Dan Williams pointed out[1] that
there was a bug report from Adam Borowski[2] that was likely related to
KVM's interaction with PageReserved().

Patch 1/2 contains the actual fix, patch 2/2 is a minor cleanup that is
mostly unrelated, but dependent and prompted by the fix in patch 1/2.

The fix itself is a bit more aggressive than what was proposed by David
and Dan, but I'm fairly confident it's the right direction for the long
term, and it also plays nice with the original PG_reserved removal series
that exposed the bug.

To be 100% clear, I haven't actually confirmed this fixes the bug reported
by Adam.

[1] http://lkml.kernel.org/r/20190919115547.GA17963@angband.pl
[2] https://lkml.kernel.org/r/01adb4cb-6092-638c-0bab-e61322be7cf5@redhat.com

Sean Christopherson (2):
  KVM: MMU: Do not treat ZONE_DEVICE pages as being reserved
  KVM: x86/mmu: Add helper to consolidate huge page promotion

 arch/x86/kvm/mmu.c       | 15 +++++++++------
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 19 +++++++++++++++----
 3 files changed, 25 insertions(+), 10 deletions(-)

-- 
2.24.0

