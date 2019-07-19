Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E706EC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A6321849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfGSGJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 02:09:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:60150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726688AbfGSGJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 02:09:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40A02B07D;
        Fri, 19 Jul 2019 06:09:26 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes and features for 5.3-rc1
Date:   Fri, 19 Jul 2019 08:09:25 +0200
Message-Id: <20190719060925.10614-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.3a-rc1-tag

xen: fixes and features for 5.3-rc1

It contains:

- A series to introduce a common command line parameter for disabling
  paravirtual extensions when running as a guest in virtualized
  environment

- A fix for int3 handling in Xen pv guests

- Removal of the Xen-specific tmem driver as support of tmem in Xen
  has been dropped (and it was experimental only)

- A security fix for running as Xen dom0 (XSA-300)

- A fix for IRQ handling when offlining cpus in Xen guests

- Some small cleanups


Thanks.

Juergen

 Documentation/admin-guide/kernel-parameters.txt |  28 +-
 arch/x86/entry/entry_64.S                       |   1 -
 arch/x86/include/asm/hypervisor.h               |  12 +
 arch/x86/include/asm/traps.h                    |   2 +-
 arch/x86/include/asm/x86_init.h                 |   2 +
 arch/x86/include/asm/xen/hypervisor.h           |   6 +-
 arch/x86/kernel/cpu/hypervisor.c                |  19 +-
 arch/x86/kernel/jailhouse.c                     |   1 +
 arch/x86/kernel/smpboot.c                       |   3 +-
 arch/x86/kernel/x86_init.c                      |   4 +-
 arch/x86/xen/enlighten_hvm.c                    |  58 ++-
 arch/x86/xen/enlighten_pv.c                     |   3 +-
 arch/x86/xen/spinlock.c                         |   6 +-
 arch/x86/xen/xen-asm_64.S                       |   1 -
 drivers/xen/Kconfig                             |  23 -
 drivers/xen/Makefile                            |   2 -
 drivers/xen/balloon.c                           |  16 +-
 drivers/xen/events/events_base.c                |  12 +-
 drivers/xen/evtchn.c                            |   2 +-
 drivers/xen/tmem.c                              | 419 -----------------
 drivers/xen/xen-balloon.c                       |   2 -
 drivers/xen/xen-selfballoon.c                   | 579 ------------------------
 include/xen/balloon.h                           |  10 -
 include/xen/events.h                            |   3 +-
 include/xen/tmem.h                              |  18 -
 25 files changed, 112 insertions(+), 1120 deletions(-)

Juergen Gross (3):
      xen/events: fix binding user event channels to cpus
      xen: remove tmem driver
      xen: let alloc_xenballooned_pages() fail if not enough memory free

Zhenzhong Duan (7):
      Revert "x86/paravirt: Set up the virt_spin_lock_key after static keys get initialized"
      x86/xen: Mark xen_hvm_need_lapic() and xen_x2apic_para_available() as __init
      x86: Add "nopv" parameter to disable PV extensions
      xen: Map "xen_nopv" parameter to "nopv" and mark it obsolete
      x86/paravirt: Remove const mark from x86_hyper_xen_hvm variable
      x86/xen: Add "nopv" support for HVM guest
      xen/pv: Fix a boot up hang revealed by int3 self test
