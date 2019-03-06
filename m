Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A17C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A159420663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfCFWci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:32:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35645 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfCFWci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:32:38 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x26MWVFB1911410
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Mar 2019 14:32:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x26MWUFP1911407;
        Wed, 6 Mar 2019 14:32:30 -0800
Date:   Wed, 6 Mar 2019 14:32:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qian Cai <tipbot@zytor.com>
Message-ID: <tip-a2863b53418d7d8f6332adf0cfb32611def0c4b9@git.kernel.org>
Cc:     cai@lca.pw, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, cai@lca.pw, hpa@zytor.com
In-Reply-To: <20190306213806.46139-1-cai@lca.pw>
References: <20190306213806.46139-1-cai@lca.pw>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] Revert "x86_64: Increase stack size for
 KASAN_EXTRA"
Git-Commit-ID: a2863b53418d7d8f6332adf0cfb32611def0c4b9
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

Commit-ID:  a2863b53418d7d8f6332adf0cfb32611def0c4b9
Gitweb:     https://git.kernel.org/tip/a2863b53418d7d8f6332adf0cfb32611def0c4b9
Author:     Qian Cai <cai@lca.pw>
AuthorDate: Wed, 6 Mar 2019 16:38:06 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Mar 2019 23:03:27 +0100

Revert "x86_64: Increase stack size for KASAN_EXTRA"

This reverts commit a8e911d13540487942d53137c156bd7707f66e5d.
KASAN_EXTRA was removed via the commit 7771bdbbfd3d ("kasan: remove use
after scope bugs detection."), so this is no longer needed.

Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: bp@alien8.de
Cc: akpm@linux-foundation.org
Cc: aryabinin@virtuozzo.com
Cc: glider@google.com
Cc: dvyukov@google.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20190306213806.46139-1-cai@lca.pw

---
 arch/x86/include/asm/page_64_types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 0ce558a8150d..8f657286d599 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -7,11 +7,7 @@
 #endif
 
 #ifdef CONFIG_KASAN
-#ifdef CONFIG_KASAN_EXTRA
-#define KASAN_STACK_ORDER 2
-#else
 #define KASAN_STACK_ORDER 1
-#endif
 #else
 #define KASAN_STACK_ORDER 0
 #endif
