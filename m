Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1171DC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81AB20684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eebNRqHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfFFJef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:34:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfFFJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4hDUHDwdfh0H6xMbYh/4yZykXYafNHG4mu0Yi4qQQpg=; b=eebNRqHIKhoC5jWzk2x+U2z6gO
        7vIZkjaiuKl8PY0CS2g56qegQL9fAHC/z1DziUm9c7dFocLFNR+n4pzffbeckDNjVrlzBTHUtan+L
        fat2KQqTpt2h5/nXTaMoKEUwWphLmX85xreod4bhGmTlpY8KO/zyf2WJ7Lf1WbHOEEeSasVxZGcfa
        TMmgcdPQFTlroEvIeCtg5UIDEoN7wWPfkst/FmGWrG3bD8ryxUk1WMNVuyfv3keVhq3mclJAzpegV
        DG9X7A6iLJriZzPxtgBdEAeMduFXZXCKDUimdkHUaldydBpYr58Nvmh2UpuuWUafLtxod8A79TLFJ
        8+Fr5o1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYon0-0000J8-Dr; Thu, 06 Jun 2019 09:34:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E8D02022711B; Thu,  6 Jun 2019 11:34:28 +0200 (CEST)
Date:   Thu, 6 Jun 2019 11:34:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, will.deacon@arm.com, arnd@arndb.de,
        jhansen@vmware.com, vdasa@vmware.com, aditr@vmware.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] VMCI: Fixup atomic64_t abuse
Message-ID: <20190606093428.GF3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The VMCI driver is abusing atomic64_t and atomic_t, there is no actual
atomic RmW operations around.

Rewrite the code to use a regular u64 with READ_ONCE() and
WRITE_ONCE() and a cast to 'unsigned long'. This fully preserves
whatever broken there was (it's not endian-safe for starters, and also
looks to be missing ordering).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/vmw_vmci_defs.h |   30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -438,8 +438,8 @@ enum {
 struct vmci_queue_header {
 	/* All fields are 64bit and aligned. */
 	struct vmci_handle handle;	/* Identifier. */
-	atomic64_t producer_tail;	/* Offset in this queue. */
-	atomic64_t consumer_head;	/* Offset in peer queue. */
+	u64 producer_tail;	/* Offset in this queue. */
+	u64 consumer_head;	/* Offset in peer queue. */
 };
 
 /*
@@ -740,13 +740,9 @@ static inline void *vmci_event_data_payl
  * prefix will be used, so correctness isn't an issue, but using a
  * 64bit operation still adds unnecessary overhead.
  */
-static inline u64 vmci_q_read_pointer(atomic64_t *var)
+static inline u64 vmci_q_read_pointer(u64 *var)
 {
-#if defined(CONFIG_X86_32)
-	return atomic_read((atomic_t *)var);
-#else
-	return atomic64_read(var);
-#endif
+	return READ_ONCE(*(unsigned long *)var);
 }
 
 /*
@@ -755,23 +751,17 @@ static inline u64 vmci_q_read_pointer(at
  * never exceeds a 32bit value in this case. On 32bit SMP, using a
  * locked cmpxchg8b adds unnecessary overhead.
  */
-static inline void vmci_q_set_pointer(atomic64_t *var,
-				      u64 new_val)
+static inline void vmci_q_set_pointer(u64 *var, u64 new_val)
 {
-#if defined(CONFIG_X86_32)
-	return atomic_set((atomic_t *)var, (u32)new_val);
-#else
-	return atomic64_set(var, new_val);
-#endif
+	/* XXX buggered on big-endian */
+	WRITE_ONCE(*(unsigned long *)var, (unsigned long)new_val);
 }
 
 /*
  * Helper to add a given offset to a head or tail pointer. Wraps the
  * value of the pointer around the max size of the queue.
  */
-static inline void vmci_qp_add_pointer(atomic64_t *var,
-				       size_t add,
-				       u64 size)
+static inline void vmci_qp_add_pointer(u64 *var, size_t add, u64 size)
 {
 	u64 new_val = vmci_q_read_pointer(var);
 
@@ -848,8 +838,8 @@ static inline void vmci_q_header_init(st
 				      const struct vmci_handle handle)
 {
 	q_header->handle = handle;
-	atomic64_set(&q_header->producer_tail, 0);
-	atomic64_set(&q_header->consumer_head, 0);
+	q_header->producer_tail = 0;
+	q_header->consumer_head = 0;
 }
 
 /*
