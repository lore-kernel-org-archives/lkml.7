Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3128C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D24214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbfIPWkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 18:40:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:58611 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728232AbfIPWkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 18:40:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 15:40:00 -0700
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="198493545"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 15:40:00 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>, "Ingo Molnar" <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, "H Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Radim Krcmar" <rkrcmar@redhat.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 0/3] Fix some 4-byte vs. 8-byte alignment issues
Date:   Mon, 16 Sep 2019 15:39:55 -0700
Message-Id: <20190916223958.27048-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1560897679-228028-1-git-send-email-fenghua.yu@intel.com>
References: <1560897679-228028-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is made up of three patches from Fenghua Yu's "Split lock"
series last posted here:

https://lore.kernel.org/kvm/1560897679-228028-1-git-send-email-fenghua.yu@intel.com/

Part 3 has been fixed to use a union to force alignment per
feedback from Thomas.

These parts are all simple fixes which are a necessary pre-cursor
before we can enable #AC traps for split lock access. But they
are also worthwhile performance fixes in their own right. So
no sense in holding them back while we discuss the merits of
the rest of the series.

Fenghua Yu (2):
  x86/common: Align cpu_caps_cleared and cpu_caps_set to unsigned long
  x86/split_lock: Align the x86_capability array to size of unsigned
    long

Peter Zijlstra (1):
  drivers/net/b44: Align pwol_mask to unsigned long for better
    performance

 arch/x86/include/asm/processor.h    | 10 +++++++++-
 arch/x86/kernel/cpu/common.c        |  5 +++--
 drivers/net/ethernet/broadcom/b44.c |  4 ++--
 3 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.20.1

