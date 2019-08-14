Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD5C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD73214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfHNKmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:42:03 -0400
Received: from foss.arm.com ([217.140.110.172]:52008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbfHNKl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:41:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C58AA1597;
        Wed, 14 Aug 2019 03:41:58 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 056CB3F706;
        Wed, 14 Aug 2019 03:41:56 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, akpm@linux-foundation.org,
        bigeasy@linutronix.de, bp@suse.de, catalin.marinas@arm.com,
        davem@davemloft.net, hch@lst.de, kan.liang@intel.com,
        mark.rutland@arm.com, mingo@kernel.org, peterz@infradead.org,
        riel@surriel.com, will@kernel.org
Subject: [PATCH 8/9] x86/fpu: correctly check for kthreads
Date:   Wed, 14 Aug 2019 11:41:30 +0100
Message-Id: <20190814104131.20190-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190814104131.20190-1-mark.rutland@arm.com>
References: <20190814104131.20190-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per commit:

  0cecca9d03c964ab ("x86/fpu: Eager switch PKRU state")

... switch_fpu_state() is trying to distinguish user threads from
kthreads, such that kthreads consistently use init_pkru_value. It does
do by looking at current->mm.

In general, a non-NULL current->mm doesn't imply that current is a
kthread, as kthreads can install an mm via use_mm(), and so it's
preferable to use is_kthread() to determine whether a thread is a
kthread.

For consistency, let's use is_kthread() here.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 4c95c365058a..ed3d85fa7c67 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -607,7 +607,7 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
 	 * PKRU state is switched eagerly because it needs to be valid before we
 	 * return to userland e.g. for a copy_to_user() operation.
 	 */
-	if (current->mm) {
+	if (!is_kthread(current)) {
 		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
 		if (pk)
 			pkru_val = pk->pkru;
-- 
2.11.0

