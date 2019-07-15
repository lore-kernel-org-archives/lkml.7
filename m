Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7CFC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35282206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfGOLht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:37:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:52770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729847AbfGOLhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:37:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 996C8ADBF;
        Mon, 15 Jul 2019 11:37:44 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Alok Kataria <akataria@vmware.com>
Subject: [PATCH 0/2] Remove 32-bit Xen PV guest support
Date:   Mon, 15 Jul 2019 13:37:37 +0200
Message-Id: <20190715113739.17694-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The long term plan has been to replace Xen PV guests by PVH. The first
victim of that plan are now 32-bit PV guests, as those are used only
rather seldom these days. Xen on x86 requires 64-bit support and with
Grub2 now supporting PVH officially since version 2.04 there is no
need to keep 32-bit PV guest support alive in the Linux kernel.
Additionally Meltdown mitigation is not available in the kernel running
as 32-bit PV guest, so dropping this mode makes sense from security
point of view, too.

Juergen Gross (2):
  x86/xen: remove 32-bit Xen PV guest support
  x86/paravirt: remove 32-bit support from PARAVIRT_XXL

 arch/x86/entry/entry_32.S                   |  93 --------
 arch/x86/entry/vdso/vdso32/vclock_gettime.c |   1 +
 arch/x86/include/asm/paravirt.h             | 105 +--------
 arch/x86/include/asm/paravirt_types.h       |  20 --
 arch/x86/include/asm/pgtable-3level_types.h |   5 -
 arch/x86/include/asm/proto.h                |   2 +-
 arch/x86/include/asm/segment.h              |   2 +-
 arch/x86/include/asm/traps.h                |   2 +-
 arch/x86/kernel/cpu/common.c                |   8 -
 arch/x86/kernel/paravirt.c                  |  17 --
 arch/x86/kernel/paravirt_patch_32.c         |  36 +--
 arch/x86/xen/Kconfig                        |   3 +-
 arch/x86/xen/Makefile                       |   4 +-
 arch/x86/xen/apic.c                         |  17 --
 arch/x86/xen/enlighten_pv.c                 |  45 +---
 arch/x86/xen/mmu_pv.c                       | 326 +++-------------------------
 arch/x86/xen/p2m.c                          |   4 -
 arch/x86/xen/setup.c                        |  44 +---
 arch/x86/xen/smp_pv.c                       |  19 +-
 arch/x86/xen/xen-asm.S                      |  14 --
 arch/x86/xen/xen-asm_32.S                   | 207 ------------------
 arch/x86/xen/xen-head.S                     |   6 -
 arch/x86/xen/xen-ops.h                      |   5 -
 drivers/xen/Kconfig                         |   4 +-
 24 files changed, 57 insertions(+), 932 deletions(-)
 delete mode 100644 arch/x86/xen/xen-asm_32.S

-- 
2.16.4

