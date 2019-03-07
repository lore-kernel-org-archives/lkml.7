Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA17C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF0C2146F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zBmAImF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfCGLx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:53:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51056 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfCGLxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L+FW4OfjKyeFW/usRxFKwEukBQi/kai3MjXQ8nm59+M=; b=zBmAImF2CU6HqKgpRu0XaYwH5R
        SRZYrCbs8Pk1qcnWQK+8uULB/o0g3h7bHpfGv3YiWPRQi+u9llHoR2r/4fCJ9xQLhdaLFLd8DL+UF
        2YgdUq9Q7giO9WGQgOO1bE5XQclWL3+TatMS4puMU9ux58pjNG4RnLzjUUBwLntNgPDJQBBPnMNzY
        /ONq/wCx25CAUn/cyBSkfSlGelvs/hKDVbSbipdAwcMFtnjDusmk9wyBxzKTFsbYQYq2aJNA9OnuH
        UYYDgZbyT5oi2zMbyWYWLq/6ITlSUIVG3tiPvKV5bdiah58CQ92YLiox5BAXYONbP9hQuIsb3U4Eo
        7wXQSHGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1rZm-0005PT-LX; Thu, 07 Mar 2019 11:52:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 986D120297BCC; Thu,  7 Mar 2019 12:52:35 +0100 (CET)
Message-Id: <20190307115159.530608243@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 Mar 2019 12:45:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org, andrew.cooper3@citrix.com
Subject: [PATCH 05/20] x86/uaccess/xen: Suppress SMAP warnings
References: <20190307114511.870090179@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/xen/privcmd.o: warning: objtool: privcmd_ioctl()+0x1414: call to hypercall_page() with UACCESS enabled

Xen needs to do HV calls with AC=1 for hysterical raisins. Make the
warning go away.

XXX: arguably we should rename ANNOTATE_NOSPEC_ALTERNATIVE to
     ANNOTATE_IGNORE_ALTERNATIVE.

Cc: andrew.cooper3@citrix.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/xen/hypercall.h |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -214,6 +214,24 @@ xen_single_call(unsigned int call,
 	return (long)__res;
 }
 
+static __always_inline void __xen_stac(void)
+{
+	/*
+	 * This is just about as horrible as this interface; we abuse the
+	 * nospec alternative annotation to supress objtool seeing the
+	 * STAC/CLAC and getting confused about it calling random code with
+	 * AC=1.
+	 */
+	asm volatile(ANNOTATE_NOSPEC_ALTERNATIVE
+		     ASM_STAC ::: "memory", "flags");
+}
+
+static __always_inline void __xen_clac(void)
+{
+	asm volatile(ANNOTATE_NOSPEC_ALTERNATIVE
+		     ASM_CLAC ::: "memory", "flags");
+}
+
 static inline long
 privcmd_call(unsigned int call,
 	     unsigned long a1, unsigned long a2,
@@ -222,9 +240,9 @@ privcmd_call(unsigned int call,
 {
 	long res;
 
-	stac();
+	__xen_stac();
 	res = xen_single_call(call, a1, a2, a3, a4, a5);
-	clac();
+	__xen_clac();
 
 	return res;
 }
@@ -430,9 +448,9 @@ HYPERVISOR_dm_op(
 	domid_t dom, unsigned int nr_bufs, struct xen_dm_op_buf *bufs)
 {
 	int ret;
-	stac();
+	__xen_stac();
 	ret = _hypercall3(int, dm_op, dom, nr_bufs, bufs);
-	clac();
+	__xen_clac();
 	return ret;
 }
 


