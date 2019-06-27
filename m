Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84851C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6F32064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eSGaSNOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfF0WSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:18:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40511 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0WSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:18:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RMHR9x473034
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 15:17:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RMHR9x473034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561673848;
        bh=JBzb6pQKsbydbEJm8hq0OG91D9DJ0InbaEh+vbPMXJg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=eSGaSNOm0UNdafn2VkL1dMEP4pU++yyH/vqk0XjuxU3GNf+6PygP2I3ImzQON3ikN
         VhPuyK1e4bIl7WZO/R4ilrmDwYx7OTTu/Bc9zyZuVxGkIai8zLdU8c3bW2sPJS9HqI
         AeEnCWewhQc8cfStO8W3TT11rQqbdIZu81NnVAYqx6z9b8AdkmciucOi8t9n8E6eH0
         A+R5iBtwY2NLEFzBxjXzD2A0DHvNK4FQLQPhjGVvWL8+/7UG6K4oOKPUXDv/n2IjDo
         FbgusiJLg/DbNSpgyRl4Ns6JfvjjQUubpYS/TLzteC8YdHPrjSHspu2bQ5K6fwtToK
         AH7HFukdTkkZQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RMHR0C473026;
        Thu, 27 Jun 2019 15:17:27 -0700
Date:   Thu, 27 Jun 2019 15:17:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-441cedab2dfca18fe4983cbc795de04536ed421e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        tglx@linutronix.de, fweimer@redhat.com, luto@kernel.org,
        peterz@infradead.org, bp@alien8.de, hpa@zytor.com,
        mingo@kernel.org, kernel-hardening@lists.openwall.com,
        jannh@google.com
Reply-To: bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          keescook@chromium.org, luto@kernel.org, fweimer@redhat.com,
          tglx@linutronix.de, peterz@infradead.org, jannh@google.com,
          mingo@kernel.org, kernel-hardening@lists.openwall.com
In-Reply-To: <a386925835e49d319e70c4d7404b1f6c3c2e3702.1561610354.git.luto@kernel.org>
References: <a386925835e49d319e70c4d7404b1f6c3c2e3702.1561610354.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/entry] x86/vsyscall: Add __ro_after_init to global
 variables
Git-Commit-ID: 441cedab2dfca18fe4983cbc795de04536ed421e
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

Commit-ID:  441cedab2dfca18fe4983cbc795de04536ed421e
Gitweb:     https://git.kernel.org/tip/441cedab2dfca18fe4983cbc795de04536ed421e
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 26 Jun 2019 21:45:08 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:04:40 +0200

x86/vsyscall: Add __ro_after_init to global variables

The vDSO is only configurable by command-line options, so make its
global variables __ro_after_init.  This seems highly unlikely to
ever stop an exploit, but it's nicer anyway.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/a386925835e49d319e70c4d7404b1f6c3c2e3702.1561610354.git.luto@kernel.org

---
 arch/x86/entry/vsyscall/vsyscall_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 9c58ab807aeb..07003f3f1bfc 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -42,7 +42,7 @@
 #define CREATE_TRACE_POINTS
 #include "vsyscall_trace.h"
 
-static enum { EMULATE, XONLY, NONE } vsyscall_mode =
+static enum { EMULATE, XONLY, NONE } vsyscall_mode __ro_after_init =
 #ifdef CONFIG_LEGACY_VSYSCALL_NONE
 	NONE;
 #elif defined(CONFIG_LEGACY_VSYSCALL_XONLY)
@@ -305,7 +305,7 @@ static const char *gate_vma_name(struct vm_area_struct *vma)
 static const struct vm_operations_struct gate_vma_ops = {
 	.name = gate_vma_name,
 };
-static struct vm_area_struct gate_vma = {
+static struct vm_area_struct gate_vma __ro_after_init = {
 	.vm_start	= VSYSCALL_ADDR,
 	.vm_end		= VSYSCALL_ADDR + PAGE_SIZE,
 	.vm_page_prot	= PAGE_READONLY_EXEC,
