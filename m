Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D23C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A5920870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDHIOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:14:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:12779 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfDHIOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:14:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 01:14:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,324,1549958400"; 
   d="scan'208";a="147424247"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Apr 2019 01:14:03 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de,
        Zhao Yakui <yakui.zhao@intel.com>
Subject: [RFC PATCH v3 0/4] x86: Add the support of ACRN guest under arch/x86
Date:   Mon,  8 Apr 2019 16:12:07 +0800
Message-Id: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACRN is a flexible, lightweight reference hypervisor, built with real-time
and safety-criticality in mind, optimized to streamline embedded development
through an open source platform. It is built for embedded IOT with small
footprint and real-time features. More details can be found
in https://projectacrn.org/

This is the patch set that allows the Linux to work on ACRN hypervisor and it can
work with the following patch set to manage the Linux guest on acrn-hypervisor. It
includes the detection of acrn_hypervisor, upcall notification vector from
hypervisor, hypercall. The hypervisor detection is similar to Xen/VMWARE/Hyperv.
ACRN also uses the upcall notification mechanism similar to that in Xen/Microsoft
HyperV when it needs to send the notification to Linux OS. The hypercall provides
the mechanism that can be used to query/configure the acrn-hypervisor by Linux guest.

Following this patch set, we will send acrn driver part, which provides the interface
that can be used to manage the virtualized CPU/memory/device/interrupt for other guest
OS after the acrn hypervisor is detected.


v1->v2: Change the CONFIG_ACRN to CONFIG_ACRN_GUEST, which makes it easy to
understand.
        Remove the export of x86_hyper_acrn.
        Remove the unused API definition of acrn_setup_intr_handler and
acrn_remove_intr_handler.
        Adjust the order of header file
        Add the declaration of acrn_hv_vector_handler and tracing
definition of acrn_hv_callback_vector.
	Refine the comments for the function of acrn_hypercall0/1/2

v2-v3:  Add one new config symbol to unify the conditional definition
of hv_irq_callback_count
        Use the "vmcall" mnemonic to replace the hard-code byte definition
	Remove the unnecessary dependency of CONFIG_PARAVIRT for ACRN_GUEST

Zhao Yakui (4):
  x86: Add new config symbol to unify conditional definition of
    hv_irq_callback_count
  x86: Add the support of ACRN guest
  x86: Use HYPERVISOR_CALLBACK_VECTOR for acrn_guest upcall vector
  x86: Add hypercall for acrn_guest

 arch/x86/Kconfig                      | 12 +++++
 arch/x86/entry/entry_64.S             |  5 +++
 arch/x86/include/asm/acrn_hypercall.h | 82 +++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/acrnhyper.h      | 19 ++++++++
 arch/x86/include/asm/hardirq.h        |  2 +-
 arch/x86/include/asm/hypervisor.h     |  1 +
 arch/x86/kernel/cpu/Makefile          |  1 +
 arch/x86/kernel/cpu/acrn.c            | 57 ++++++++++++++++++++++++
 arch/x86/kernel/cpu/hypervisor.c      |  4 ++
 arch/x86/kernel/irq.c                 |  2 +-
 arch/x86/xen/Kconfig                  |  1 +
 drivers/hv/Kconfig                    |  1 +
 12 files changed, 185 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/asm/acrn_hypercall.h
 create mode 100644 arch/x86/include/asm/acrnhyper.h
 create mode 100644 arch/x86/kernel/cpu/acrn.c

-- 
2.7.4

