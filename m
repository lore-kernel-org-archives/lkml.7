Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77935C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DBA2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="meG/Gu/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfD3LRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:17:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43595 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfD3LRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:17:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBFEt41346558
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:15:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBFEt41346558
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556622915;
        bh=XYgoeYjtRGBWmjtJBHBeUqBDcK5YVuAc6FWnDPx/HOQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=meG/Gu/lXrE/l4zwnMvymYjspiqwDdqz2joU3PT6uH4A2tbGM0Kp19RZ9sy1zpBPm
         RWPrXo6Au3IbIoO4hl8ZkDqsUp9VDf3DR/3MStW8/THufv3M1DVqZFKLtVaqy5wke3
         CPmqpseDkBX28BMoP7DyYIMAoiQYnyS2L43sOdgJr5er8rfy+PmFG9ApKXUhvBTsTG
         ShgEpo3uKPxRdqP9PX7Rtzu9LtUM0eZbaYvUDe+c8gNUI3q7rALn8/oyGkr1aSVj99
         TUNgfHxLtUymbYQQwr+RG2Ni+Xfsa+y3gdQ/AUFAPCiWAGMJIZV1QELrMOVwxXc9r3
         /74FII+qqoScA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBFDKG1346555;
        Tue, 30 Apr 2019 04:15:13 -0700
Date:   Tue, 30 Apr 2019 04:15:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-c7b6f29b6257532792fc722b68fcc0e00b5a856c@git.kernel.org>
Cc:     luto@kernel.org, namit@vmware.com, linux_dti@icloud.com,
        ard.biesheuvel@linaro.org, will.deacon@arm.com, jannh@google.com,
        riel@surriel.com, rick.p.edgecombe@intel.com,
        kernel-hardening@lists.openwall.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, daniel@iogearbox.net,
        deneen.t.dock@intel.com, tglx@linutronix.de, ast@kernel.org,
        akpm@linux-foundation.org, mingo@kernel.org,
        kristen@linux.intel.com, peterz@infradead.org, bp@alien8.de,
        hpa@zytor.com, dave.hansen@linux.intel.com
Reply-To: deneen.t.dock@intel.com, tglx@linutronix.de, ast@kernel.org,
          mingo@kernel.org, akpm@linux-foundation.org, namit@vmware.com,
          luto@kernel.org, ard.biesheuvel@linaro.org, linux_dti@icloud.com,
          will.deacon@arm.com, jannh@google.com, riel@surriel.com,
          rick.p.edgecombe@intel.com, kernel-hardening@lists.openwall.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          daniel@iogearbox.net, bp@alien8.de, hpa@zytor.com,
          dave.hansen@linux.intel.com, kristen@linux.intel.com,
          peterz@infradead.org
In-Reply-To: <20190426001143.4983-24-namit@vmware.com>
References: <20190426001143.4983-24-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] bpf: Fail bpf_probe_write_user() while mm is switched
Git-Commit-ID: c7b6f29b6257532792fc722b68fcc0e00b5a856c
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

Commit-ID:  c7b6f29b6257532792fc722b68fcc0e00b5a856c
Gitweb:     https://git.kernel.org/tip/c7b6f29b6257532792fc722b68fcc0e00b5a856c
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Thu, 25 Apr 2019 17:11:43 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:37:48 +0200

bpf: Fail bpf_probe_write_user() while mm is switched

When using a temporary mm, bpf_probe_write_user() should not be able to
write to user memory, since user memory addresses may be used to map
kernel memory.  Detect these cases and fail bpf_probe_write_user() in
such cases.

Suggested-by: Jann Horn <jannh@google.com>
Reported-by: Jann Horn <jannh@google.com>
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
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190426001143.4983-24-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/trace/bpf_trace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d64c00afceb5..94b0e37d90ef 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -14,6 +14,8 @@
 #include <linux/syscalls.h>
 #include <linux/error-injection.h>
 
+#include <asm/tlb.h>
+
 #include "trace_probe.h"
 #include "trace.h"
 
@@ -163,6 +165,10 @@ BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
 	 * access_ok() should prevent writing to non-user memory, but in
 	 * some situations (nommu, temporary switch, etc) access_ok() does
 	 * not provide enough validation, hence the check on KERNEL_DS.
+	 *
+	 * nmi_uaccess_okay() ensures the probe is not run in an interim
+	 * state, when the task or mm are switched. This is specifically
+	 * required to prevent the use of temporary mm.
 	 */
 
 	if (unlikely(in_interrupt() ||
@@ -170,6 +176,8 @@ BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
 		return -EPERM;
 	if (unlikely(uaccess_kernel()))
 		return -EPERM;
+	if (unlikely(!nmi_uaccess_okay()))
+		return -EPERM;
 	if (!access_ok(unsafe_ptr, size))
 		return -EPERM;
 
