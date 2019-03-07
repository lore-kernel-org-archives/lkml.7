Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A3C20854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfCGCEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:04:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:40332 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfCGCEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:04:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 18:04:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,450,1544515200"; 
   d="scan'208";a="132216922"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by fmsmga007.fm.intel.com with ESMTP; 06 Mar 2019 18:04:48 -0800
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Zhao Yakui <yakui.zhao@intel.com>
Subject: [RFC PATCH 0/3] arch/x86: Add the support of ACRN hypervisor under arch/x86
Date:   Thu,  7 Mar 2019 10:04:08 +0800
Message-Id: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com>
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

Zhao Yakui (3):
  arch/x86: add ACRN hypervisor guest
  arch/x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for Acrn upcall vector
  arch/x86/acrn: add hypercall for acrn_hypervisor

 arch/x86/Kconfig                      |  8 ++++
 arch/x86/entry/entry_64.S             |  5 +++
 arch/x86/include/asm/acrn_hypercall.h | 85 +++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/acrnhyper.h      | 18 ++++++++
 arch/x86/include/asm/hardirq.h        |  2 +-
 arch/x86/include/asm/hypervisor.h     |  1 +
 arch/x86/kernel/cpu/Makefile          |  1 +
 arch/x86/kernel/cpu/acrn.c            | 75 +++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/hypervisor.c      |  4 ++
 arch/x86/kernel/irq.c                 |  2 +-
 10 files changed, 199 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/asm/acrn_hypercall.h
 create mode 100644 arch/x86/include/asm/acrnhyper.h
 create mode 100644 arch/x86/kernel/cpu/acrn.c

-- 
2.7.4

