Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFE1C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6B0218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tjKpilAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfDXHYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:24:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59324 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729787AbfDXHYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ydgV9tNXDJWZMp7Yl1W3UgC2hJrKqSTwrC04jpwwBkY=; b=tjKpilAxTtzKlKUfCJh1xMR2E9
        rWzjIZUhABq2cXuWNY6jc2QYaBdZG6BDTFzANeM6V6iwov1LB8hAmk+hsmW+Y8njRsyJeUXUNvhsW
        MgM1Pn2G+ZNjYqpUY90adK8uFv0N7YMo04O9CkLHJ3sElUyWHZR4wPegWOYjNd729qVaO4i45Nizf
        as0z9OxvQlTlpAbA4JEMz5lMCv6y5imKPCZ3f9iGRP+2Y3+oWeJ1e/5dhdrMRa2bkuAw1dChLWK78
        QOZR3gV9a6CU8kvpxdNQKo8GTujG6c9ScvXn6bGjEOqVU0h/GW9hjFTHl2oOdvTztlxMGTmDe6bh1
        7RfqV1BA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJCGC-0000dt-3G; Wed, 24 Apr 2019 07:24:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 905FA20321BBC; Wed, 24 Apr 2019 09:24:02 +0200 (CEST)
Message-Id: <20190424072208.695962771@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 24 Apr 2019 09:19:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] x86/uaccess: Dont leak the AC flag into __put_user() argument evaluation
References: <20190424071923.275371441@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __put_user() macro evaluates it's @ptr argument inside the
__uaccess_begin() / __uaccess_end() region. While this would normally
not be expected to be an issue, an UBSAN bug (it ignored -fwrapv,
fixed in GCC 8+) would transform the @ptr evaluation for:

  drivers/gpu/drm/i915/i915_gem_execbuffer.c: if (unlikely(__put_user(offset, &urelocs[r-stack].presumed_offset))) {

into a signed-overflow-UB check and trigger the objtool AC validation.
Finish commit 2a418cf3f5f1 ("x86/uaccess: Don't leak the AC flag into
__put_user() value evaluation") and explicitly evaluate all 3 argument
early.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 2a418cf3f5f1 ("x86/uaccess: Don't leak the AC flag into __put_user() value evaluation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/uaccess.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -427,10 +427,11 @@ do {									\
 ({								\
 	__label__ __pu_label;					\
 	int __pu_err = -EFAULT;					\
-	__typeof__(*(ptr)) __pu_val;				\
-	__pu_val = x;						\
+	__typeof__(*(ptr)) __pu_val = (x);			\
+	__typeof__(ptr) __pu_ptr = (ptr);			\
+	__typeof__(size) __pu_size = (size);			\
 	__uaccess_begin();					\
-	__put_user_size(__pu_val, (ptr), (size), __pu_label);	\
+	__put_user_size(__pu_val, __pu_ptr, __pu_size, __pu_label);	\
 	__pu_err = 0;						\
 __pu_label:							\
 	__uaccess_end();					\


