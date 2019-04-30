Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F03AC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41F0217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="l38RuALb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfD3L30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:29:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39753 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfD3L30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:29:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBSsZn1350483
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:28:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBSsZn1350483
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556623735;
        bh=WfJFjlrVKDAHNC3QUvZ4JO/hVajU8ThCQdYlFFnVL34=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=l38RuALbSthRDZUGX/NEfk5lUBhu8z+io8EUDl8dBK7w/IJZjUv0Y5MPwsc4B2SPr
         g/R+5USGLfE8BeN0uV9Q0oJvLl9KTMD36Vs+/AFcr+gyLBOXiRyRgizWgk8PUKWREo
         CokJq3ya7vqfChyvNtxNRxyTbdGKGJRNDhrqwAqBnoG8pdSfwZ9pU62tnrGUQg+JD4
         j5wG1eZcgCxhHJDsqoPSWWYDlb4uWabH429+KJkLB/TKbtSjtCSyMeKekVPV0vlqB4
         PwV5pxf88XGVdDaGsG1H3zce9zCXPN7TjvGY0pL9pXTcqSrj0uHcGZ+weCl7lw1nbQ
         qTZzUe7C16NFg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBSsEQ1350480;
        Tue, 30 Apr 2019 04:28:54 -0700
Date:   Tue, 30 Apr 2019 04:28:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rick Edgecombe <tipbot@zytor.com>
Message-ID: <tip-241a1f22380646bc4d1dd18e5bc246877513da68@git.kernel.org>
Cc:     deneen.t.dock@intel.com, luto@kernel.org,
        akpm@linux-foundation.org, rick.p.edgecombe@intel.com,
        nadav.amit@gmail.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        peterz@infradead.org, linux_dti@icloud.com,
        dave.hansen@linux.intel.com, kernel-hardening@lists.openwall.com,
        hpa@zytor.com, torvalds@linux-foundation.org, will.deacon@arm.com,
        tglx@linutronix.de, riel@surriel.com, ard.biesheuvel@linaro.org,
        mhiramat@kernel.org, kristen@linux.intel.com, mingo@kernel.org
Reply-To: torvalds@linux-foundation.org,
          kernel-hardening@lists.openwall.com, hpa@zytor.com,
          mhiramat@kernel.org, kristen@linux.intel.com, mingo@kernel.org,
          will.deacon@arm.com, tglx@linutronix.de, riel@surriel.com,
          ard.biesheuvel@linaro.org, dave.hansen@linux.intel.com,
          nadav.amit@gmail.com, linux-kernel@vger.kernel.org,
          linux_dti@icloud.com, peterz@infradead.org, bp@alien8.de,
          deneen.t.dock@intel.com, luto@kernel.org,
          rick.p.edgecombe@intel.com, akpm@linux-foundation.org
In-Reply-To: <20190426001143.4983-21-namit@vmware.com>
References: <20190426001143.4983-21-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/kprobes: Use vmalloc special flag
Git-Commit-ID: 241a1f22380646bc4d1dd18e5bc246877513da68
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

Commit-ID:  241a1f22380646bc4d1dd18e5bc246877513da68
Gitweb:     https://git.kernel.org/tip/241a1f22380646bc4d1dd18e5bc246877513da68
Author:     Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate: Thu, 25 Apr 2019 17:11:40 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:38:01 +0200

x86/kprobes: Use vmalloc special flag

Use new flag VM_FLUSH_RESET_PERMS for handling freeing of special
permissioned memory in vmalloc and remove places where memory was set NX
and RW before freeing which is no longer needed.

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
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190426001143.4983-21-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 06058c44ab57..800593f4ddf7 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -434,6 +434,7 @@ void *alloc_insn_page(void)
 	if (!page)
 		return NULL;
 
+	set_vm_flush_reset_perms(page);
 	/*
 	 * First make the page read-only, and only then make it executable to
 	 * prevent it from being W+X in between.
@@ -452,12 +453,6 @@ void *alloc_insn_page(void)
 /* Recover page to RW mode before releasing it */
 void free_insn_page(void *page)
 {
-	/*
-	 * First make the page non-executable, and only then make it writable to
-	 * prevent it from being W+X in between.
-	 */
-	set_memory_nx((unsigned long)page, 1);
-	set_memory_rw((unsigned long)page, 1);
 	module_memfree(page);
 }
 
