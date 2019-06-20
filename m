Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A741C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 05:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FC920B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 05:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbfFTFLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 01:11:24 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40273 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfFTFLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 01:11:23 -0400
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 6AFE360006;
        Thu, 20 Jun 2019 05:10:58 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH RESEND 6/8] parisc: Use mmap_base, not mmap_legacy_base, as low_limit for bottom-up mmap
Date:   Thu, 20 Jun 2019 01:03:26 -0400
Message-Id: <20190620050328.8942-7-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190620050328.8942-1-alex@ghiti.fr>
References: <20190620050328.8942-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bottom-up mmap scheme is used twice:

- for legacy mode, in which mmap_legacy_base and mmap_base are equal.

- in case of mmap failure in top-down mode, where there is no need to go
through the whole address space again for the bottom-up fallback: the goal
of this fallback is to find, as a last resort, space between the top-down
mmap base and the stack, which is the only place not covered by the
top-down mmap.

Then this commit removes the usage of mmap_legacy_base field from parisc
code.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/parisc/kernel/sys_parisc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index 5d458a44b09c..e987f3a8eb0b 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -119,7 +119,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 
 	info.flags = 0;
 	info.length = len;
-	info.low_limit = mm->mmap_legacy_base;
+	info.low_limit = mm->mmap_base;
 	info.high_limit = mmap_upper_limit(NULL);
 	info.align_mask = last_mmap ? (PAGE_MASK & (SHM_COLOUR - 1)) : 0;
 	info.align_offset = shared_align_offset(last_mmap, pgoff);
@@ -240,13 +240,11 @@ static unsigned long mmap_legacy_base(void)
  */
 void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 {
-	mm->mmap_legacy_base = mmap_legacy_base();
-	mm->mmap_base = mmap_upper_limit(rlim_stack);
-
 	if (mmap_is_legacy()) {
-		mm->mmap_base = mm->mmap_legacy_base;
+		mm->mmap_base = mmap_legacy_base();
 		mm->get_unmapped_area = arch_get_unmapped_area;
 	} else {
+		mm->mmap_base = mmap_upper_limit(rlim_stack);
 		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
 	}
 }
-- 
2.20.1

