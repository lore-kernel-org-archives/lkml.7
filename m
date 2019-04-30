Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA910C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF3420675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="g6o3owfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfD3LWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:22:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45331 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfD3LWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:22:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBM7bF1347865
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:22:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBM7bF1347865
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556623328;
        bh=eW2QjPgcBOv7jb4+wi9OFyDTbQHiXsewLb8jvdcZt7Y=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=g6o3owfUu+onMF7rUKsdIIIt443sw2VqCbd70IsLIgZaWT6fvFobjEeoF6YUauR/a
         O1Eyu1HdlCtRnNvg2GhMkaz03x2sj75Kp8G5IcG41YOrpyP583yIjnmRq4BDicjSLQ
         jjGyBTPsoH5kbhM8tSg0djlgp8acvnTYTeFi6r1g1U6L+JBSWBsxWDgvB7NH2vaMVC
         nFwwx2JeKaxcsR3lJxj5FJ0uz8uhIA9Mu468teylfcHpS8WwraXtmDYNpANE5iV14o
         kxAzzzx3YBSes4C+LjbqkaCyxUQeQUlPZ2xP13mrLgzHJDhJzh4mJ8fyYhzDhRhdIQ
         RdBvk5ejT8MYQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBM6ng1347862;
        Tue, 30 Apr 2019 04:22:06 -0700
Date:   Tue, 30 Apr 2019 04:22:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-7298e24f904224fa79eb8fd7e0fbd78950ccf2db@git.kernel.org>
Cc:     peterz@infradead.org, namit@vmware.com, mingo@kernel.org,
        akpm@linux-foundation.org, tglx@linutronix.de,
        rick.p.edgecombe@intel.com, hpa@zytor.com,
        ard.biesheuvel@linaro.org, dave.hansen@linux.intel.com,
        torvalds@linux-foundation.org, kristen@linux.intel.com,
        linux_dti@icloud.com, bp@alien8.de, deneen.t.dock@intel.com,
        riel@surriel.com, luto@kernel.org, will.deacon@arm.com,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Reply-To: bp@alien8.de, deneen.t.dock@intel.com, linux_dti@icloud.com,
          linux-kernel@vger.kernel.org,
          kernel-hardening@lists.openwall.com, riel@surriel.com,
          luto@kernel.org, will.deacon@arm.com, namit@vmware.com,
          mingo@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
          peterz@infradead.org, dave.hansen@linux.intel.com,
          kristen@linux.intel.com, torvalds@linux-foundation.org,
          rick.p.edgecombe@intel.com, hpa@zytor.com,
          ard.biesheuvel@linaro.org
In-Reply-To: <20190426001143.4983-11-namit@vmware.com>
References: <20190426001143.4983-11-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/kprobes: Set instruction page as executable
Git-Commit-ID: 7298e24f904224fa79eb8fd7e0fbd78950ccf2db
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

Commit-ID:  7298e24f904224fa79eb8fd7e0fbd78950ccf2db
Gitweb:     https://git.kernel.org/tip/7298e24f904224fa79eb8fd7e0fbd78950ccf2db
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Thu, 25 Apr 2019 17:11:30 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:37:54 +0200

x86/kprobes: Set instruction page as executable

Set the page as executable after allocation.  This patch is a
preparatory patch for a following patch that makes module allocated
pages non-executable.

While at it, do some small cleanup of what appears to be unnecessary
masking.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <akpm@linux-foundation.org>
Cc: <ard.biesheuvel@linaro.org>
Cc: <deneen.t.dock@intel.com>
Cc: <kernel-hardening@lists.openwall.com>
Cc: <kristen@linux.intel.com>
Cc: <linux_dti@icloud.com>
Cc: <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190426001143.4983-11-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index fed46ddb1eef..06058c44ab57 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -431,8 +431,20 @@ void *alloc_insn_page(void)
 	void *page;
 
 	page = module_alloc(PAGE_SIZE);
-	if (page)
-		set_memory_ro((unsigned long)page & PAGE_MASK, 1);
+	if (!page)
+		return NULL;
+
+	/*
+	 * First make the page read-only, and only then make it executable to
+	 * prevent it from being W+X in between.
+	 */
+	set_memory_ro((unsigned long)page, 1);
+
+	/*
+	 * TODO: Once additional kernel code protection mechanisms are set, ensure
+	 * that the page was not maliciously altered and it is still zeroed.
+	 */
+	set_memory_x((unsigned long)page, 1);
 
 	return page;
 }
@@ -440,8 +452,12 @@ void *alloc_insn_page(void)
 /* Recover page to RW mode before releasing it */
 void free_insn_page(void *page)
 {
-	set_memory_nx((unsigned long)page & PAGE_MASK, 1);
-	set_memory_rw((unsigned long)page & PAGE_MASK, 1);
+	/*
+	 * First make the page non-executable, and only then make it writable to
+	 * prevent it from being W+X in between.
+	 */
+	set_memory_nx((unsigned long)page, 1);
+	set_memory_rw((unsigned long)page, 1);
 	module_memfree(page);
 }
 
