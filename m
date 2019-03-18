Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E39C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDD320854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfCRLno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:43:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:8128 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfCRLno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:43:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 04:43:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,493,1544515200"; 
   d="scan'208";a="126363896"
Received: from lxy-server.sh.intel.com ([10.239.48.11])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2019 04:43:41 -0700
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        chao.gao@intel.com
Subject: [PATCH v2 0/2] Avoid cpuid faulting leaking and one optimization
Date:   Mon, 18 Mar 2019 19:43:22 +0800
Message-Id: <20190318114324.14198-1-xiaoyao.li@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series avoid cpuid faulting of host leakding to guest, which may
potentially cause guest boot failure, and use hardware cpuid faulting
to remove emulation overhead.

Patch 1 avoids cpuid faulting leaking to guest through clearing cpuid faulting
bit before enter guest and restoring host's cpuid faulting bit when switch
to host.

Patch 2 enables hardware cpuid faulting for guest if it exists, to avoid
the emulation overhead.

==changelog==
v2:
- move the save/restore of cpuid faulting bit to
vmx_prepare_swich_to_guest/vmx_prepare_swich_to_host to avoid every
vmentry RDMSR, based on Paolo's comment.

==previous version==
v1: https://patchwork.kernel.org/patch/10852253/

Xiaoyao Li (2):
  kvm/vmx: avoid CPUID faulting leaking to guest
  kvm/vmx: Using hardware cpuid faulting to avoid emulation overhead

 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/vmx/vmx.c          | 45 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.h          |  2 ++
 arch/x86/kvm/x86.c              | 15 ++++++++---
 4 files changed, 61 insertions(+), 3 deletions(-)

-- 
2.19.1

