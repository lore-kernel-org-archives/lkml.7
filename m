Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32C5C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6076420663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfCFWdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:33:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35991 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfCFWdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:33:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x26MXBSE1911684
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Mar 2019 14:33:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x26MXAXE1911675;
        Wed, 6 Mar 2019 14:33:10 -0800
Date:   Wed, 6 Mar 2019 14:33:10 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qian Cai <tipbot@zytor.com>
Message-ID: <tip-3609e31bc8dc03b701390f79c74fc7fe92b95039@git.kernel.org>
Cc:     luto@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, cai@lca.pw
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, cai@lca.pw,
          luto@kernel.org, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20190228220155.88124-1-cai@lca.pw>
References: <20190228220155.88124-1-cai@lca.pw>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Remove unused variable 'cpu'
Git-Commit-ID: 3609e31bc8dc03b701390f79c74fc7fe92b95039
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3609e31bc8dc03b701390f79c74fc7fe92b95039
Gitweb:     https://git.kernel.org/tip/3609e31bc8dc03b701390f79c74fc7fe92b95039
Author:     Qian Cai <cai@lca.pw>
AuthorDate: Thu, 28 Feb 2019 17:01:55 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Mar 2019 23:24:52 +0100

x86/mm: Remove unused variable 'cpu'

The commit a2055abe9c67 ("x86/mm: Pass flush_tlb_info to
flush_tlb_others() etc") removed the unnecessary cpu parameter from
uv_flush_tlb_others() but left an unused variable.

arch/x86/mm/tlb.c: In function 'native_flush_tlb_others':
arch/x86/mm/tlb.c:688:16: warning: variable 'cpu' set but not used
[-Wunused-but-set-variable]
   unsigned int cpu;
                ^~~

Fixes: a2055abe9c67 ("x86/mm: Pass flush_tlb_info to flush_tlb_others() etc")
Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andyt Lutomirski <luto@kernel.org>
Cc: dave.hansen@linux.intel.com
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20190228220155.88124-1-cai@lca.pw

---
 arch/x86/mm/tlb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 999d6d8f0bef..bc4bc7b2f075 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -685,9 +685,6 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 		 * that UV should be updated so that smp_call_function_many(),
 		 * etc, are optimal on UV.
 		 */
-		unsigned int cpu;
-
-		cpu = smp_processor_id();
 		cpumask = uv_flush_tlb_others(cpumask, info);
 		if (cpumask)
 			smp_call_function_many(cpumask, flush_tlb_func_remote,
