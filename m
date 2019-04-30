Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F652C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2DE2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbfD3DsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 23:48:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:54863 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729933AbfD3DsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:48:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 20:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,412,1549958400"; 
   d="scan'208";a="138598234"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by orsmga008.jf.intel.com with ESMTP; 29 Apr 2019 20:48:17 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH v6 0/4] x86: Add the support of ACRN guest under x86
Date:   Tue, 30 Apr 2019 11:45:22 +0800
Message-Id: <1556595926-17910-1-git-send-email-yakui.zhao@intel.com>
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
work with the following patch set to manage the Linux guest on ACRN hypervisor. It
includes the detection of ACRN hypervisor, upcall notification vector from
hypervisor, hypercall. The hypervisor detection is similar to Xen/VMWARE/Hyperv.
ACRN also uses the upcall notification mechanism similar to that in Xen/Microsoft
HyperV when it needs to send the notification to Linux guest. The hypercall provides
the mechanism that can be used to query/configure the ACRN hypervisor by Linux guest.

Following this patch set, we will send acrn driver part, which provides the interface
that can be used to manage the virtualized CPU/memory/device/interrupt for other guest
OS after the ACRN hypervisor is detected.

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

v3-v4:  Rename the file name of acrnhyper.h to acrn.h
	Refine the commit log and some other minor changes(more comments and 
redundant ifdef in acrn.h, sorting the header file in acrn.c)

v4->v5: Minor changes of comments/commit log in patch 04
	Use _ASM_X86_ACRN_HYPERCALL_H instead of _ASM_X86_ACRNHYPERCALL_H.
	Use the "VMCALL" mnemonic in comment/commit log.
	Uppercase r8/rdi/rsi/rax for hypercall parameter register in comment.

v5->v6: Remove the explicit register variable for inline assembly
	Add the "extern" for the function declaration in acrn.h
	Add comments about acking ACPI EOI in acrn_hv_callback_handler
	Minor changes for comments/commit log in patch 03/04


Zhao Yakui (4):
  x86/Kconfig: Add new config symbol to unify conditional definition of
    hv_irq_callback_count
  x86: Add the support of Linux guest on ACRN hypervisor
  x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for ACRN guest upcall vector
  x86/acrn: Add hypercall for ACRN guest

 arch/x86/Kconfig                      | 16 +++++++
 arch/x86/entry/entry_64.S             |  5 +++
 arch/x86/include/asm/acrn.h           | 11 +++++
 arch/x86/include/asm/acrn_hypercall.h | 84 +++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/hardirq.h        |  2 +-
 arch/x86/include/asm/hypervisor.h     |  1 +
 arch/x86/kernel/cpu/Makefile          |  1 +
 arch/x86/kernel/cpu/acrn.c            | 68 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/hypervisor.c      |  4 ++
 arch/x86/kernel/irq.c                 |  2 +-
 arch/x86/xen/Kconfig                  |  1 +
 drivers/hv/Kconfig                    |  1 +
 12 files changed, 194 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/asm/acrn.h
 create mode 100644 arch/x86/include/asm/acrn_hypercall.h
 create mode 100644 arch/x86/kernel/cpu/acrn.c

-- 
2.7.4

