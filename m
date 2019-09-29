Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEECCC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 07:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F50218DE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 07:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfI2Hki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 03:40:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:63856 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfI2Hki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 03:40:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Sep 2019 00:40:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,562,1559545200"; 
   d="scan'208";a="204547592"
Received: from zhangjun-desktop.sh.intel.com ([10.239.154.83])
  by fmsmga001.fm.intel.com with ESMTP; 29 Sep 2019 00:40:35 -0700
From:   jun.zhang@intel.com
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        bo.he@intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        zhang jun <jun.zhang@intel.com>, he@vger.kernel.org
Subject: [PATCH] x86/PAT: priority the PAT warn to error to highlight the developer
Date:   Sun, 29 Sep 2019 15:20:31 +0800
Message-Id: <20190929072032.14195-1-jun.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang jun <jun.zhang@intel.com>

Documentation/x86/pat.txt says:
set_memory_uc() or set_memory_wc() must use together with set_memory_wb()

if break the PAT attribute, there are tons of warning like:
[   45.846872] x86/PAT: NDK MediaCodec_:3753 map pfn RAM range req
write-combining for [mem 0x1e7a80000-0x1e7a87fff], got write-back
and in the extremely case, we see kernel panic unexpected like:
list_del corruption. prev->next should be ffff88806dbe69c0,
but was ffff888036f048c0

so it's better to priority the warn to error to highlight to
remind the developer.

Signed-off-by: zhang jun <jun.zhang@intel.com>
Signed-off-by: he, bo <bo.he@intel.com>
---
 arch/x86/mm/pat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index d9fbd4f69920..43a4dfdcedc8 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -897,7 +897,7 @@ static int reserve_pfn_range(u64 paddr, unsigned long size, pgprot_t *vma_prot,
 
 		pcm = lookup_memtype(paddr);
 		if (want_pcm != pcm) {
-			pr_warn("x86/PAT: %s:%d map pfn RAM range req %s for [mem %#010Lx-%#010Lx], got %s\n",
+			pr_err("x86/PAT: %s:%d map pfn RAM range req %s for [mem %#010Lx-%#010Lx], got %s!!!\n",
 				current->comm, current->pid,
 				cattr_name(want_pcm),
 				(unsigned long long)paddr,
-- 
2.17.1

