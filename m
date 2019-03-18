Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEC1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB082087E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3jKOMhzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfCRPx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:53:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58768 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfCRPxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mk5dMYYtCIyk+/MFF/tv9mK5siRqVBysuKMZ8ggJwpA=; b=3jKOMhzOlIfwFMo/s3U5Pv6jl9
        mzAR6gXhRc6LOVXaVn07YyTS8HrLHZOV65XraJbvXcDTxG4ExN7bSzScUSC/HEZKEZxWXPSb2AlJh
        s0Jbkzu5TlbozJjb6dOTSO8uT0M7DwjXLV2E2lItATnysDo7C//Jj3GEPbh9BFI8hEwpfyHWA8pea
        /iiI2g8JOWO/GBQxExw/RL24anMcRazSFrQvCn0lZbWoI0LOTXuaw/Ds9HBrd1hnDrLi72sCSnnbd
        XzUocsMWWL+/h11hdX0a+rxXLbTyNDy0uxG3Iz2R3xbY/c8kihga425CD55UPTzv8IBMyhbkHlR72
        iRaz9XEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZ5-0005Ui-Rh; Mon, 18 Mar 2019 15:52:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9145D25E45D6D; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318155140.255700184@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:38:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 04/25] i915,uaccess: Fix redundant CLAC
References: <20190318153840.906404905@infradead.org>
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


