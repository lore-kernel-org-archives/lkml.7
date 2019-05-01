Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD1EC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C7621743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfEAJA7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 05:00:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50269 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfEAJA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 05:00:59 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hLl6e-00025P-Lh; Wed, 01 May 2019 11:00:48 +0200
Date:   Wed, 1 May 2019 11:00:48 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Qian Cai <cai@lca.pw>
Cc:     dave.hansen@intel.com, bp@suse.de, tglx@linutronix.de,
        x86@kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        luto@amacapital.net, hpa@zytor.com, mingo@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC PATCH] x86/fpu: Use get_user_pages_unlocked() to fault-in pages
Message-ID: <20190501090048.emqugoplr4sajnqc@linutronix.de>
References: <1556657902.6132.13.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1556657902.6132.13.camel@lca.pw>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using get_user_pages() seems to be problematic: KASAN reports
use-after-free in LTP's signal06 testcase.
The test invokes the signal handler with a provided stack and changes
the RW/WO page flags of the stack while the signal is invoked.  A crash
due to a NULL pointer has also been observed.

get_user_pages() may be invoked (or so I assumed) without holding the
mmap_sem for pre-faulting. KASAN probably slows down processing that we
can observe the user-after-free while page-flags are changed. It does
not happen without KASAN.

Use get_user_pages_unlocked() which holds the mm_sem around while
paging-in user memory.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

While this fixes the problem and the crash later on, I would like to
hear from MM folks if it is intended to invoke get_user_pages() without
holding the mmap_sem. Without passing lockde & pages we only do:
  __get_user_pages_locked()
    - __get_user_pages()
    - if (!pages)
	/* If it's a prefault don't insist harder
	 */
	return ret;
Which was my intention. 
The comment above faultin_page() says "mmap_sem must be held on entry"
so this makes me thing that one must hold it…

 arch/x86/kernel/fpu/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index eaddb185cac95..3a94e3d2e3bdf 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -172,8 +172,8 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 		aligned_size = offset_in_page(buf_fx) + fpu_user_xstate_size;
 		nr_pages = DIV_ROUND_UP(aligned_size, PAGE_SIZE);
 
-		ret = get_user_pages((unsigned long)buf_fx, nr_pages,
-				     FOLL_WRITE, NULL, NULL);
+		ret = get_user_pages_unlocked((unsigned long)buf_fx, nr_pages,
+					      NULL, FOLL_WRITE);
 		if (ret == nr_pages)
 			goto retry;
 		return -EFAULT;
-- 
2.20.1

