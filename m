Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A20C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B0A20880
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MimfWGqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfCRPxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:53:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58810 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfCRPxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7T84Lnlv66T1X6jWOL4vr/4eoU1srD1fxx4tDzOyoqs=; b=MimfWGqGnZJsJt0Pt+rYledetz
        UVkHK51Vvw5PY6yH1uE371ggYbEsjF7fjEKEzG9HHoIMyLFsZG2UaDAr8YwLgPVGQW07COVgWjhLY
        RwoU4kyA67z/QaP7lYMVdfQVUYt/qXwiRRkKxYmkP+EY0aX34Uqsy13lQXjL/03bZk+48b+mfz6hQ
        e3qHF80Xh5vFjAZaslkctaRBUdwDftmlG+b+eETWrFfXYHUH1wW5YuU+HTYLUtKd6y9Ha5sY4CKQC
        T8jHbuer57bsVgd3evENJQwj9SGlkazMN4110qSkTykmWG/MM2V9nEk/384nvCPIL/gyL9laFMIOf
        ynYSiqzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZ7-0005Uw-GB; Mon, 18 Mar 2019 15:52:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A789B25E45D72; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318155140.628311202@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:38:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org, andrew.cooper3@citrix.com,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 08/25] x86/uaccess,xen: Suppress SMAP warnings
References: <20190318153840.906404905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/xen/privcmd.o: warning: objtool: privcmd_ioctl()+0x1414: call to hypercall_page() with UACCESS enabled

Some Xen hypercalls allow parameter buffers in user land, so they need
to set AC=1. Avoid the warning for those cases.

Cc: andrew.cooper3@citrix.com
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/xen/hypercall.h |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -214,6 +214,22 @@ xen_single_call(unsigned int call,
 	return (long)__res;
 }
 
+static __always_inline void __xen_stac(void)
+{
+	/*
+	 * Suppress objtool seeing the STAC/CLAC and getting confused about it
+	 * calling random code with AC=1.
+	 */
+	asm volatile(ANNOTATE_IGNORE_ALTERNATIVE
+		     ASM_STAC ::: "memory", "flags");
+}
+
+static __always_inline void __xen_clac(void)
+{
+	asm volatile(ANNOTATE_IGNORE_ALTERNATIVE
+		     ASM_CLAC ::: "memory", "flags");
+}
+
 static inline long
 privcmd_call(unsigned int call,
 	     unsigned long a1, unsigned long a2,
@@ -222,9 +238,9 @@ privcmd_call(unsigned int call,
 {
 	long res;
 
-	stac();
+	__xen_stac();
 	res = xen_single_call(call, a1, a2, a3, a4, a5);
-	clac();
+	__xen_clac();
 
 	return res;
 }
@@ -421,9 +437,9 @@ HYPERVISOR_dm_op(
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
 


