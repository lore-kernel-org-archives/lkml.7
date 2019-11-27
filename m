Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CF5C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81245217BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889053;
	bh=nZdoRaeE0FxWGCecbzOvB2AAJ+KHGsxC/QthJB7BhRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T8FR6pwLF0sJp+XlvX1zB3Fff2sxlEHN45tw1fUsQJ1Yt1K3frfR+1grZvfuMS0fN
	 G3FYrV2woLBvW2AbBrqy6jAXLX7InJvl4YvoDLpwSHHr+t3QHEp+yDysxB8YFmFXQp
	 LFf+HDjD/2t/c1jv4PVfx+BGnNJ6OkpSGJ88Aoy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733091AbfK0VKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:10:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733081AbfK0VKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:10:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2990B2176D;
        Wed, 27 Nov 2019 21:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574889047;
        bh=nZdoRaeE0FxWGCecbzOvB2AAJ+KHGsxC/QthJB7BhRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJQfEhHJLOl18PWw60AYoWvh2Fk6JWlXYVYP1i8ZLBzQLTNM4RPrJiPEkXawNQYuk
         q63LfPyHBVsa6DHj1nE5aoblx0sqZMCUHPXR6Qtgh3UvDPfSpRPU6pVk5v2MzZccTd
         agL+tAgvL+F7CkyfBHqJf3bi3Bk0ESidph0kWq74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@kernel.org
Subject: [PATCH 5.3 63/95] selftests/x86/sigreturn/32: Invalidate DS and ES when abusing the kernel
Date:   Wed, 27 Nov 2019 21:32:20 +0100
Message-Id: <20191127202928.486043857@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

commit 4d2fa82d98d2d296043a04eb517d7dbade5b13b8 upstream.

If the kernel accidentally uses DS or ES while the user values are
loaded, it will work fine for sane userspace.  In the interest of
simulating maximally insane userspace, make sigreturn_32 zero out DS
and ES for the nasty parts so that inadvertent use of these segments
will crash.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/sigreturn.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -451,6 +451,19 @@ static void sigusr1(int sig, siginfo_t *
 	ctx->uc_mcontext.gregs[REG_SP] = (unsigned long)0x8badf00d5aadc0deULL;
 	ctx->uc_mcontext.gregs[REG_CX] = 0;
 
+#ifdef __i386__
+	/*
+	 * Make sure the kernel doesn't inadvertently use DS or ES-relative
+	 * accesses in a region where user DS or ES is loaded.
+	 *
+	 * Skip this for 64-bit builds because long mode doesn't care about
+	 * DS and ES and skipping it increases test coverage a little bit,
+	 * since 64-bit kernels can still run the 32-bit build.
+	 */
+	ctx->uc_mcontext.gregs[REG_DS] = 0;
+	ctx->uc_mcontext.gregs[REG_ES] = 0;
+#endif
+
 	memcpy(&requested_regs, &ctx->uc_mcontext.gregs, sizeof(gregset_t));
 	requested_regs[REG_CX] = *ssptr(ctx);	/* The asm code does this. */
 


