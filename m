Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F13AC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3DC214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388372AbfIPWkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 18:40:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:58611 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388283AbfIPWkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 18:40:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 15:40:02 -0700
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="198493589"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 15:40:01 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Tony Luck <tony.luck@intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Radim Krcmar" <rkrcmar@redhat.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>
Subject: [PATCH 3/3] x86/split_lock: Align the x86_capability array to size of unsigned long
Date:   Mon, 16 Sep 2019 15:39:58 -0700
Message-Id: <20190916223958.27048-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916223958.27048-1-tony.luck@intel.com>
References: <1560897679-228028-1-git-send-email-fenghua.yu@intel.com>
 <20190916223958.27048-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

The x86_capability array in cpuinfo_x86 is defined as u32 and thus is
naturally aligned to 4 bytes. But, set_bit() and clear_bit() require
the array to be aligned to size of unsigned long (i.e. 8 bytes in
64-bit).

To fix the alignment issue, align the x86_capability array to size of
unsigned long by using unnamed union and 'unsigned long array_align'
to force the alignment.

Changing the x86_capability array's type to unsigned long may also fix
the issue because the x86_capability array will be naturally aligned
to size of unsigned long. But this needs additional code changes.
So choose the simpler solution by setting the array's alignment to size
of unsigned long.

Suggested-by: David Laight <David.Laight@aculab.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/processor.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 6e0a3b43d027..c073534ca485 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -93,7 +93,15 @@ struct cpuinfo_x86 {
 	__u32			extended_cpuid_level;
 	/* Maximum supported CPUID level, -1=no CPUID: */
 	int			cpuid_level;
-	__u32			x86_capability[NCAPINTS + NBUGINTS];
+	/*
+	 * Align to size of unsigned long because the x86_capability array
+	 * is passed to bitops which require the alignment. Use unnamed
+	 * union to enforce the array is aligned to size of unsigned long.
+	 */
+	union {
+		__u32		x86_capability[NCAPINTS + NBUGINTS];
+		unsigned long	x86_capability_alignment;
+	};
 	char			x86_vendor_id[16];
 	char			x86_model_id[64];
 	/* in KB - valid for CPUS which support this call: */
-- 
2.20.1

