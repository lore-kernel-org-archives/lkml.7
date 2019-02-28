Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BA4C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4590F2184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2nCLIS5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbfB1PFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:05:34 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46206 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732086AbfB1PFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NCOwExRglA7GDbRpIFe8QPx8JZnZrtPW5WDyqNgV2G8=; b=2nCLIS5zVt77/xtW3WJjdO1qt8
        d2zhrQ2ag1CJqKElpnKPp+vF3s7LymiWtUvq3MywgJ4S0gyL7NjuugJgA89/bsIqvFXmHofLbpBP1
        pKBpGQa60uwHxiCahGGCJcRe+YPb/2mxTkf9lm56WM/0ND29l4+lu2JloCsqS71mKsBiJoc9BCIAo
        PvQDbukWdjVbxoCMbLLqCufY5Om1vtK82KKkAJ95p6b4RDH8QRZNXk02jNetsVheLnRDtiQ9+MiRu
        U9OA8XFfrWRdpA9GyJ0O0O8jptGOiiRQiLdgdjgtqG69fV76MEFPnxmDuhNhBleVEWg5gji2gHOAJ
        YJ6q/ZjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzNFI-0005bc-QO; Thu, 28 Feb 2019 15:05:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DA313202C2DDA; Thu, 28 Feb 2019 16:05:08 +0100 (CET)
Message-Id: <20190228150152.540038736@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 28 Feb 2019 15:54:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 6/8] i915,uaccess: Fix redundant CLAC
References: <20190228145450.289603901@infradead.org>
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
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
@@ -1605,7 +1605,6 @@ static int eb_copy_relocations(const str
 					     (char __user *)urelocs + copied,
 					     len)) {
 end_user:
-				user_access_end();
 				kvfree(relocs);
 				err = -EFAULT;
 				goto err;
@@ -2628,8 +2627,8 @@ i915_gem_execbuffer2_ioctl(struct drm_de
 					&user_exec_list[i].offset,
 					end_user);
 		}
-end_user:
 		user_access_end();
+end_user:;
 	}
 
 	args->flags &= ~__I915_EXEC_UNKNOWN_FLAGS;


