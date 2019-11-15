Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCBEC33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DE32072A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfKOGsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:48:14 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:54920 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727096AbfKOGsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:48:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Ti7ujx6_1573800472;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0Ti7ujx6_1573800472)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Nov 2019 14:48:08 +0800
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: [RFC PATCH v3 7/7] x86/unwind/orc: remove run-time ORC unwind tables sort
Date:   Fri, 15 Nov 2019 14:47:50 +0800
Message-Id: <20191115064750.47888-8-shile.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191115064750.47888-1-shile.zhang@linux.alibaba.com>
References: <20191115064750.47888-1-shile.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The orc_unwind and orc_unwind_ip tables are sorted in vmlinux link phase
at build time, just remove the run-time sort.

Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
 arch/x86/kernel/unwind_orc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 332ae6530fa8..280da6fa9922 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -273,9 +273,11 @@ void __init unwind_init(void)
 		return;
 	}
 
-	/* Sort the .orc_unwind and .orc_unwind_ip tables: */
-	sort(__start_orc_unwind_ip, num_entries, sizeof(int), orc_sort_cmp,
-	     orc_sort_swap);
+	/*
+	 * Note, orc_unwind and orc_unwind_ip tables has been sorted in
+	 * vmlinux link phase by sorttable tool at build time.
+	 * Its ready for binary search now.
+	 */
 
 	/* Initialize the fast lookup table: */
 	lookup_num_blocks = orc_lookup_end - orc_lookup;
-- 
2.24.0.rc2

