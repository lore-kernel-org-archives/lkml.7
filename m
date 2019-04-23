Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9638C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854B820674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JXVqyc+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfDWIZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:25:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46028 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDWIZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=486psj+sENvabR+BWnaVeA+iic8CMCHnGgf5S4MT6mU=; b=JXVqyc+rvPckzr3h4llI1qg+T
        axl1zJwMs8J7iWwe3fPjVKfxETdgGT6x3PD5h5IQO2DaNYsDRrSRB3JPYpRMqeRjxhrwlDbP6NLLa
        d9Gv+ipg04uE7doZGtfZCeO9ePt6iuHP9gf5FY1AJ9UNrO5RmSaDE1j4yPzTLG+zusm0cUv4Ecm+V
        X3l748BCsX2VW1nSetCSxcUIFkJvaP0TiOhaVkwJRclhVxGYiyITTXpC0jguuvedt2TeIzuWJC+/5
        pnNDaXXkM9fTcK6ha11moWgE7p1En0ThQu8e/4nAokdj469bkOVaGQvRwLWE6bYmH5prcy8ZMfrIm
        +7UJb5GMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIqjU-0000vO-0J; Tue, 23 Apr 2019 08:24:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDBC129B47DC4; Tue, 23 Apr 2019 10:24:48 +0200 (CEST)
Date:   Tue, 23 Apr 2019 10:24:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: mmotm 2019-04-19-14-53 uploaded (objtool)
Message-ID: <20190423082448.GY11158@hirez.programming.kicks-ass.net>
References: <20190419215358.WMVFXV3bT%akpm@linux-foundation.org>
 <af3819b4-008f-171e-e721-a9a20f85d8d1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af3819b4-008f-171e-e721-a9a20f85d8d1@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 09:36:46PM -0700, Randy Dunlap wrote:
> On 4/19/19 2:53 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2019-04-19-14-53 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> 
> on x86_64:
> 
>   CC      lib/strncpy_from_user.o
> lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x315: call to __ubsan_handle_add_overflow() with UACCESS enabled
>   CC      lib/strnlen_user.o
> lib/strnlen_user.o: warning: objtool: strnlen_user()+0x337: call to __ubsan_handle_sub_overflow() with UACCESS enabled

Lemme guess, you're using GCC < 8 ? That had a bug where UBSAN
considered signed overflow UB when using -fno-strict-overflow or
-fwrapv.

Now, we could of course allow this symbol, but I found only the below
was required to make allyesconfig build without issue.

Andy, Linus?

(note: the __put_user thing is from this one:

  drivers/gpu/drm/i915/i915_gem_execbuffer.c:	if (unlikely(__put_user(offset, &urelocs[r-stack].presumed_offset))) {

 where (ptr) ends up non-trivial due to UBSAN)

---

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 22ba683afdc2..c82abd6e4ca3 100644
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
diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 58eacd41526c..07045bc4872e 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -26,7 +26,7 @@
 static inline long do_strncpy_from_user(char *dst, const char __user *src, long count, unsigned long max)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
-	long res = 0;
+	unsigned long res = 0;
 
 	/*
 	 * Truncate 'max' to the user-specified limit, so that
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 1c1a1b0e38a5..0729378ad3e9 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -28,7 +28,7 @@
 static inline long do_strnlen_user(const char __user *src, unsigned long count, unsigned long max)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
-	long align, res = 0;
+	unsigned long align, res = 0;
 	unsigned long c;
 
 	/*

