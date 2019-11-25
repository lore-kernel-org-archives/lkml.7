Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AF5C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D3E2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfKYTbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 14:31:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:22629 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfKYTbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 14:31:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 11:31:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,242,1571727600"; 
   d="scan'208";a="216994573"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 25 Nov 2019 11:31:11 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "David Laight" <David.Laight@ACULAB.COM>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 0/4] Fix some 4-byte vs. 8-byte alignment issues in atomic bit operations
Date:   Mon, 25 Nov 2019 11:43:00 -0800
Message-Id: <1574710984-208305-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A split lock is an unaligned atomic operation that spans two cache
lines. The split lock access needs to hold bus lock and will
degrade performance.

Accessing one split lock long can take over one thousand extra cycles
than atomically accessing one unaligned long within one cache line.
And while the split lock access holds the bus lock, any other
memory accesses are not allowed and the overall memory access performance
is degraded.

Because badly performance impact by split lock, this patch series
solve the split lock issues instead of other alignment issues.

These parts are all simple fixes which are a necessary pre-cursor 
before we can enable #AC traps for split lock access. But they 
are also worthwhile performance fixes in their own right. So 
no sense in holding them back while we discuss the merits of 
the rest of the series. 

The alignment issues may be fixed by changing the atomic bit operations
APIs e.g. new set_bit_32() for 4-byte alignment. But the fixes will
be complex because they touch a lot of call sites and architectures.

Change Log:
v2:
- Remove patch 1 and 3 in v1 because they are in the tip tree already.
- Add new patches 2-4 per David Laight's comments:
https://lore.kernel.org/lkml/e7c75de9191847ed98c573f9ad871518@AcuMS.aculab.com/
Running "grep -r --include '*.[ch]' '_bit([^(]*, *([^)]*\*)' ."
returns about 200 results. Most of them don't have split lock issues.

Fenghua Yu (3):
  xen-pcifront: Align address of flags to size of unsigned long
  mtd: rawnand: fsmc: Change to non-atomic bit operations
  x86/mce: Force alignment for atomic bit operations

Peter Zijlstra (1):
  drivers/net/b44: Change to non-atomic bit operations

 arch/x86/include/asm/mce.h          | 3 ++-
 drivers/mtd/nand/raw/fsmc_nand.c    | 4 ++--
 drivers/net/ethernet/broadcom/b44.c | 4 ++--
 include/xen/interface/io/pciif.h    | 7 +++++--
 4 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.19.1

