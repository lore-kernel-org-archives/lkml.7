Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFFCC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E7F214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388272AbfIPWkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 18:40:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:58611 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728232AbfIPWkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 18:40:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 15:40:01 -0700
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="198493564"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 15:40:01 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Radim Krcmar" <rkrcmar@redhat.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>
Subject: [PATCH 2/3] drivers/net/b44: Align pwol_mask to unsigned long for better performance
Date:   Mon, 16 Sep 2019 15:39:57 -0700
Message-Id: <20190916223958.27048-3-tony.luck@intel.com>
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

From: Peter Zijlstra <peterz@infradead.org>

A bit in pwol_mask is set in b44_magic_pattern() by atomic set_bit().
But since pwol_mask is local and never exposed to concurrency, there is
no need to set bit in pwol_mask atomically.

set_bit() sets the bit in a single unsigned long location. Because
pwol_mask may not be aligned to unsigned long, the location may cross two
cache lines. On x86, accessing two cache lines in locked instruction in
set_bit() is called split locked access and can cause overall performance
degradation.

So use non atomic __set_bit() to set pwol_mask bits. __set_bit() won't hit
split lock issue on x86.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/net/ethernet/broadcom/b44.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 97ab0dd25552..5738ab963dfb 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -1520,7 +1520,7 @@ static int b44_magic_pattern(u8 *macaddr, u8 *ppattern, u8 *pmask, int offset)
 
 	memset(ppattern + offset, 0xff, magicsync);
 	for (j = 0; j < magicsync; j++)
-		set_bit(len++, (unsigned long *) pmask);
+		__set_bit(len++, (unsigned long *)pmask);
 
 	for (j = 0; j < B44_MAX_PATTERNS; j++) {
 		if ((B44_PATTERN_SIZE - len) >= ETH_ALEN)
@@ -1532,7 +1532,7 @@ static int b44_magic_pattern(u8 *macaddr, u8 *ppattern, u8 *pmask, int offset)
 		for (k = 0; k< ethaddr_bytes; k++) {
 			ppattern[offset + magicsync +
 				(j * ETH_ALEN) + k] = macaddr[k];
-			set_bit(len++, (unsigned long *) pmask);
+			__set_bit(len++, (unsigned long *)pmask);
 		}
 	}
 	return len - 1;
-- 
2.20.1

