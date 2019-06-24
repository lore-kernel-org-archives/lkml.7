Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177B3C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DD320663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfFXUgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:36:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:25682 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbfFXUgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:36:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 13:36:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="312828574"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga004.jf.intel.com with ESMTP; 24 Jun 2019 13:36:20 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH] x86/resctrl: Cleanup cbm_ensure_valid()
Date:   Mon, 24 Jun 2019 13:34:27 -0700
Message-Id: <15ba03856f1d944468ee6f44e3fd7aa548293ede.1561408280.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent fix to the cbm_ensure_valid() function left
some coding style issues that are now addressed:
- Follow reverse fir tree ordering of variable declarations
- Use if (!val) instead of if (val == 0)
- Return a value instead of using a function parameter as input and
output

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b63e50b1a096..e63cef0a09cc 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2496,21 +2496,21 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
  * modification to the CBM if the default does not satisfy the
  * requirements.
  */
-static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
+static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
 {
-	unsigned long val = *_val;
 	unsigned int cbm_len = r->cache.cbm_len;
 	unsigned long first_bit, zero_bit;
+	unsigned long val = _val;
 
-	if (val == 0)
-		return;
+	if (!val)
+		return 0;
 
 	first_bit = find_first_bit(&val, cbm_len);
 	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
 
 	/* Clear any remaining bits to ensure contiguous region */
 	bitmap_clear(&val, zero_bit, cbm_len - zero_bit);
-	*_val = (u32)val;
+	return (u32)val;
 }
 
 /*
@@ -2563,7 +2563,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
 	 * Force the initial CBM to be valid, user can
 	 * modify the CBM based on system availability.
 	 */
-	cbm_ensure_valid(&d->new_ctrl, r);
+	d->new_ctrl = cbm_ensure_valid(d->new_ctrl, r);
 	/*
 	 * Assign the u32 CBM to an unsigned long to ensure that
 	 * bitmap_weight() does not access out-of-bound memory.
-- 
2.17.2

