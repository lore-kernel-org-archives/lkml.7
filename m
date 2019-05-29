Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891C7C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 05:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6CA2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 05:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfE2Fh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 01:37:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:52060 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfE2Fh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 01:37:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 22:37:56 -0700
X-ExtLoop1: 1
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by fmsmga007.fm.intel.com with ESMTP; 28 May 2019 22:37:55 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH v7 0/3] x86: Add the support of ACRN guest under x86
Date:   Wed, 29 May 2019 13:33:54 +0800
Message-Id: <1559108037-18813-1-git-send-email-yakui.zhao@intel.com>
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

v6->v7: Add the missing header file of asm/apic.h in acrn.c
        Remove the definition of ACRN hypercall as it is not used in this
        patch set.


Zhao Yakui (3):
  x86/Kconfig: Add new config symbol to unify conditional definition of
    hv_irq_callback_count
  x86: Add the support of Linux guest on ACRN hypervisor
  x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for ACRN guest upcall vector

 arch/x86/Kconfig                  | 16 +++++++++
 arch/x86/entry/entry_64.S         |  5 +++
 arch/x86/include/asm/acrn.h       | 11 +++++++
 arch/x86/include/asm/hardirq.h    |  2 +-
 arch/x86/include/asm/hypervisor.h |  1 +
 arch/x86/kernel/cpu/Makefile      |  1 +
 arch/x86/kernel/cpu/acrn.c        | 69 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/hypervisor.c  |  4 +++
 arch/x86/kernel/irq.c             |  2 +-
 arch/x86/xen/Kconfig              |  1 +
 drivers/hv/Kconfig                |  1 +
 11 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/asm/acrn.h
 create mode 100644 arch/x86/kernel/cpu/acrn.c

-- 
2.7.4

