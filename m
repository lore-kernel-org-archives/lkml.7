Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02975C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE342083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mgCTnxXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfCAM2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:28:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfCAM2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5nST5mD8fD941OtCbMGRJbm3+ycdOPkj4s+kpXfPFPo=; b=mgCTnxXYhucOsqOGadNl6VYWl
        f9hiCB/2wvbQreuDGnU3qoA2B2PgrCVuKxV0DHlcBt41uVeEXa+qDz/la9DK9LVCUZAx7vkB+Np5X
        KJINIHGYtOmcDAThC1XdsxIFIEiXxVjH+zbQ+iHtLCPY6OgzGBohIviJmRZHtJbYXjcLaY7249tWE
        sFLWPxB1giQr8cE4PG7UuoGYWvysPEDtBEIGweMp/1OIkxUm3XD1ivtHFzWm577KmyAdB2Xhand0O
        E4DVyRdK/5qmVZWwCifCpLCQFmgYdJltFPt8+NQKkj0RRkuQFHzhdXZ3gJzDDL3sR+rKsbDfBYFiQ
        pA1wGyzlg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzhGX-00079d-Cn; Fri, 01 Mar 2019 12:27:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD6992030867F; Fri,  1 Mar 2019 13:27:45 +0100 (CET)
Date:   Fri, 1 Mar 2019 13:27:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 6/8] i915,uaccess: Fix redundant CLAC
Message-ID: <20190301122745.GR32534@hirez.programming.kicks-ass.net>
References: <20190228145450.289603901@infradead.org>
 <20190228150152.540038736@infradead.org>
 <CAHk-=wgsSXxL5c2Lbmbai=bcCgN0G=jPO+gWhQ3a+wx-LTaFkQ@mail.gmail.com>
 <20190228175114.GG32494@hirez.programming.kicks-ass.net>
 <20190228180154.GO32534@hirez.programming.kicks-ass.net>
 <CAHk-=whJww5smbSU2VzvcR7tajNqp=i9ZBYHK3RvwVXbs+V_JQ@mail.gmail.com>
 <20190228190111.GI32494@hirez.programming.kicks-ass.net>
 <20190301103452.GQ32534@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301103452.GQ32534@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 11:34:52AM +0100, Peter Zijlstra wrote:

> Let me do an allmodconfig build to see how much pain is caused by that
> redundant CLAC warning.

arch/x86/lib/usercopy_64.o: warning: objtool: .altinstr_replacement+0x30: redundant UACCESS disable
drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x22: redundant UACCESS disable
drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x64: redundant UACCESS disable
drivers/xen/privcmd.o: warning: objtool: privcmd_ioctl()+0x1c0: call to {dynamic}() with UACCESS enabled

The usercopy one is difficult, that's copy_user_handle_tail(), it is
buggered though, because that lacks notrace and thus has a __fentry__
call in.

Also, afaict all exception jumps into copy_user_handle_tail() will have
AC=1, but the __{get,put}_user_nocheck() things do STAC/CLAC all over
again.

So what do we do? Annotate that we start with AC=1 and then immediately
do the clac, and then let __{get,put}_user_nocheck() do their own thing?
or make it use the unsafe stuff?

---
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index ee42bb0cbeb3..e1ab9a50937c 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -59,7 +59,7 @@ EXPORT_SYMBOL(clear_user);
  * Since protection fault in copy_from/to_user is not a normal situation,
  * it is not necessary to optimize tail handling.
  */
-__visible unsigned long
+__visible notrace unsigned long
 copy_user_handle_tail(char *to, char *from, unsigned len)
 {
 	for (; len; --len, to++) {
diff --git a/drivers/gpu/drm/i915/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
index 485b259127c3..695212c5bd07 100644
--- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
@@ -1606,6 +1606,7 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
 					     len)) {
 end_user:
 				user_access_end();
+end:
 				kvfree(relocs);
 				err = -EFAULT;
 				goto err;
@@ -1625,7 +1626,7 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
 		 * relocations were valid.
 		 */
 		if (!user_access_begin(urelocs, size))
-			goto end_user;
+			goto end;
 
 		for (copied = 0; copied < nreloc; copied++)
 			unsafe_put_user(-1,
@@ -2616,7 +2617,7 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
 		 * when we did the "copy_from_user()" above.
 		 */
 		if (!user_access_begin(user_exec_list, count * sizeof(*user_exec_list)))
-			goto end_user;
+			goto end;
 
 		for (i = 0; i < args->buffer_count; i++) {
 			if (!(exec2_list[i].offset & UPDATE))
@@ -2630,6 +2631,7 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
 		}
 end_user:
 		user_access_end();
+end:;
 	}
 
 	args->flags &= ~__I915_EXEC_UNKNOWN_FLAGS;
