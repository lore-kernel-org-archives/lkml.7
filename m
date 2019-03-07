Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF48AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7654520835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hxGPd7ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfCGLxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:53:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfCGLxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:53:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mk5dMYYtCIyk+/MFF/tv9mK5siRqVBysuKMZ8ggJwpA=; b=hxGPd7ixi2FMkhogEZNgGh8gs0
        e77JKxZ3pTpBuZSQOpOdtofg2ltBA7FYyKjiM1f+0MccugMxblW0/5Ol+CIsZF5q1iFWvoDSzungl
        UxdelrwLjCPZBGcjAg6sxb8jttzm1OBSTdPeHZ5PS4bV4GQKiKCpZBzc+5a4VLmvD7GFjsGnFI8Yf
        hWmFjUxLBi2oNcxlq94A1JhwZJ1VehsjqR74/XliXsf21anp1Sau1kRZWRSlI73oBkMdbIT2qsZpy
        FGHm+/XZxWJEKiDmw8WZUIyS8CF1jHbXPQ9dIAmlcSSfk7uci6zfYz20CJmgMVvhXtUKIS+fdvsmg
        72qOXurg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1rZl-0001WU-43; Thu, 07 Mar 2019 11:52:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8649320297BC3; Thu,  7 Mar 2019 12:52:35 +0100 (CET)
Message-Id: <20190307115159.262970101@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 Mar 2019 12:45:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 02/20] i915,uaccess: Fix redundant CLAC
References: <20190307114511.870090179@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x3c: redundant UACCESS disable
drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x66: redundant UACCESS disable

AKA. you don't need user_access_end() if user_access_begin() fails.

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
@@ -1606,6 +1606,7 @@ static int eb_copy_relocations(const str
 					     len)) {
 end_user:
 				user_access_end();
+end:
 				kvfree(relocs);
 				err = -EFAULT;
 				goto err;
@@ -1625,7 +1626,7 @@ static int eb_copy_relocations(const str
 		 * relocations were valid.
 		 */
 		if (!user_access_begin(urelocs, size))
-			goto end_user;
+			goto end;
 
 		for (copied = 0; copied < nreloc; copied++)
 			unsafe_put_user(-1,
@@ -2616,7 +2617,7 @@ i915_gem_execbuffer2_ioctl(struct drm_de
 		 * when we did the "copy_from_user()" above.
 		 */
 		if (!user_access_begin(user_exec_list, count * sizeof(*user_exec_list)))
-			goto end_user;
+			goto end;
 
 		for (i = 0; i < args->buffer_count; i++) {
 			if (!(exec2_list[i].offset & UPDATE))
@@ -2630,6 +2631,7 @@ i915_gem_execbuffer2_ioctl(struct drm_de
 		}
 end_user:
 		user_access_end();
+end:;
 	}
 
 	args->flags &= ~__I915_EXEC_UNKNOWN_FLAGS;


