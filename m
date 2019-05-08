Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85352C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6293F21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfEHREV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:04:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:5319 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbfEHRDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:03:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 10:03:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,446,1549958400"; 
   d="scan'208";a="169697543"
Received: from chang-linux-3.sc.intel.com ([172.25.66.171])
  by fmsmga002.fm.intel.com with ESMTP; 08 May 2019 10:03:02 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 00/18] x86: Enable FSGSBASE instructions
Date:   Wed,  8 May 2019 03:02:15 -0700
Message-Id: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates from v6 [6]:
* Fix ptracer-induced FS/GSBASE write behavior (Andy)
* Fix GSBASE handling in the NMI path
* Remove local_irq_save/restore() from switch_to()
* Separate things into new patches (from 12th to 9th and 10th)
* Add GSBASE handling in the documentation
* Add more comments for entry changes
* Edit changelog (multiple patches)
(all points by Thomas if not mentioned)

Previous versions: [1-5]

[1] Version 1: https://lore.kernel.org/patchwork/cover/934843
[2] Version 2: https://lore.kernel.org/patchwork/cover/912063
[3] Version 3: https://lore.kernel.org/patchwork/cover/1002725
[4] Version 4: https://lore.kernel.org/patchwork/cover/1032799
[5] Version 5: https://lore.kernel.org/patchwork/cover/1038035
[6] Version 6: https://lore.kernel.org/patchwork/cover/1051240

Andi Kleen (3):
  x86/fsgsbase/64: Add intrinsics for FSGSBASE instructions
  x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2
  x86/fsgsbase/64: Add documentation for FSGSBASE

Andy Lutomirski (4):
  x86/fsgsbase/64: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
  x86/fsgsbase/64: Preserve FS/GS state in __switch_to() if FSGSBASE is
    on
  selftests/x86/fsgsbase: Test WRGSBASE
  x86/fsgsbase/64: Enable FSGSBASE by default and add a chicken bit

Chang S. Bae (11):
  x86/fsgsbase/64: Fix ARCH_SET_FS/GS behaviors for a remote task
  selftests/x86/fsgsbase: Test ptracer-induced GSBASE write
  kbuild: Raise the minimum required binutils version to 2.21
  x86/fsgsbase/64: Enable FSGSBASE instructions in the helper functions
  x86/fsgsbase/64: When copying a thread, use the FSGSBASE instructions
  x86/entry/64: Add the READ_MSR_GSBASE macro
  x86/entry/64: Switch CR3 before SWAPGS on the paranoid entry
  x86/fsgsbase/64: Introduce the FIND_PERCPU_BASE macro
  x86/fsgsbase/64: GSBASE handling with FSGSBASE in the paranoid path
  x86/fsgsbase/64: Document GSBASE handling in the paranoid path
  selftests/x86/fsgsbase: Test ptracer-induced GSBASE write with
    FSGSBASE

 Documentation/admin-guide/kernel-parameters.txt |   2 +
 Documentation/process/changes.rst               |   6 +-
 Documentation/x86/entry_64.txt                  |  17 +++
 Documentation/x86/fsgs.txt                      | 103 ++++++++++++++
 arch/x86/entry/calling.h                        |  49 +++++++
 arch/x86/entry/entry_64.S                       | 142 ++++++++++++++++---
 arch/x86/include/asm/fsgsbase.h                 |  45 ++++--
 arch/x86/include/asm/inst.h                     |  15 ++
 arch/x86/include/uapi/asm/hwcap2.h              |   3 +
 arch/x86/kernel/cpu/common.c                    |  22 +++
 arch/x86/kernel/process_64.c                    | 132 +++++++++++++----
 arch/x86/kernel/ptrace.c                        |  14 +-
 tools/testing/selftests/x86/fsgsbase.c          | 179 +++++++++++++++++++++++-
 13 files changed, 660 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/x86/fsgs.txt

--
2.7.4

