Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B9CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 02:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDC42075B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 02:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfCBCyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 21:54:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:61568 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfCBCwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 21:52:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 18:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,430,1544515200"; 
   d="scan'208";a="148572592"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 01 Mar 2019 18:52:27 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, kvm@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 02/17] drivers/net/b44: Align pwol_mask to unsigned long for better performance
Date:   Fri,  1 Mar 2019 18:44:56 -0800
Message-Id: <1551494711-213533-3-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bit in pwol_mask is set in b44_magic_pattern automatically by set_bit.
set_bit sets the bit in a single unsigned long location. Since pwol_mask
may not be aligned to unsigned long, the location may cross two cache
lines and accessing the location degradates performance. On x86, accessing
two cache lines in locked instruction in set_bit is called split lock and
can cause overall performance degradation.

To avoid to impact performance by accessing two cache lines in set_bit,
align pwol_mask to unsigned long.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/net/ethernet/broadcom/b44.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 97ab0dd25552..bc544b6b9c3a 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -1547,7 +1547,8 @@ static void b44_setup_pseudo_magicp(struct b44 *bp)
 	u32 val;
 	int plen0, plen1, plen2;
 	u8 *pwol_pattern;
-	u8 pwol_mask[B44_PMASK_SIZE];
+	/* Align to unsigned long for better performance in set_bit() */
+	u8 pwol_mask[B44_PMASK_SIZE] __aligned(sizeof(unsigned long));
 
 	pwol_pattern = kzalloc(B44_PATTERN_SIZE, GFP_KERNEL);
 	if (!pwol_pattern)
-- 
2.7.4

