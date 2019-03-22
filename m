Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5F1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFDB2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfCVNWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:22:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40787 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbfCVNW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:22:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MDMEa5592848
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 06:22:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MDMEtD592845;
        Fri, 22 Mar 2019 06:22:14 -0700
Date:   Fri, 22 Mar 2019 06:22:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valdis Kletnieks <tipbot@zytor.com>
Message-ID: <tip-4fe64a62e04cfb2dc1daab0d8f05d212aa014161@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, luto@kernel.org, valdis.kletnieks@vt.edu
Reply-To: valdis.kletnieks@vt.edu, luto@kernel.org, mingo@kernel.org,
          hpa@zytor.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <27680.1552376873@turing-police>
References: <27680.1552376873@turing-police>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm/pti: Make local symbols static
Git-Commit-ID: 4fe64a62e04cfb2dc1daab0d8f05d212aa014161
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

Commit-ID:  4fe64a62e04cfb2dc1daab0d8f05d212aa014161
Gitweb:     https://git.kernel.org/tip/4fe64a62e04cfb2dc1daab0d8f05d212aa014161
Author:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
AuthorDate: Tue, 12 Mar 2019 03:47:53 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Mar 2019 13:31:28 +0100

x86/mm/pti: Make local symbols static

With 'make C=2 W=1', sparse and gcc both complain:

  CHECK   arch/x86/mm/pti.c
arch/x86/mm/pti.c:84:3: warning: symbol 'pti_mode' was not declared. Should it be static?
arch/x86/mm/pti.c:605:6: warning: symbol 'pti_set_kernel_image_nonglobal' was not declared. Should it be static?
  CC      arch/x86/mm/pti.o
arch/x86/mm/pti.c:605:6: warning: no previous prototype for 'pti_set_kernel_image_nonglobal' [-Wmissing-prototypes]
  605 | void pti_set_kernel_image_nonglobal(void)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

pti_set_kernel_image_nonglobal() is only used locally. 'pti_mode' exists in
drivers/hwtracing/intel_th/pti.c as well, but it's a completely unrelated
local (static) symbol.

Make both static.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/27680.1552376873@turing-police


---
 arch/x86/mm/pti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 4fee5c3003ed..139b28a01ce4 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -77,7 +77,7 @@ static void __init pti_print_if_secure(const char *reason)
 		pr_info("%s\n", reason);
 }
 
-enum pti_mode {
+static enum pti_mode {
 	PTI_AUTO = 0,
 	PTI_FORCE_OFF,
 	PTI_FORCE_ON
@@ -602,7 +602,7 @@ static void pti_clone_kernel_text(void)
 	set_memory_global(start, (end_global - start) >> PAGE_SHIFT);
 }
 
-void pti_set_kernel_image_nonglobal(void)
+static void pti_set_kernel_image_nonglobal(void)
 {
 	/*
 	 * The identity map is created with PMDs, regardless of the
