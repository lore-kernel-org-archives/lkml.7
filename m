Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3097C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5A225B8F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191608;
	bh=dCVDXips007izB5sZEkFSjcUty+mk+m6uZJDYn5+XbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t7v/WiPHsGyRkLpgsqER1usK/I/66V/OLH6d2l7HCEvZy2VafDkOycqWOXEQjr5dB
	 exRyHsORGMMWDbBZJQZye6D1TlETfZ3gYHGaNq/dRGgqc+oT/7it/8MWhBz9gZx6RY
	 uZ00R0n/62lbZOum06tHq2omSjsI7Dck8++ZCHV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfE3Eqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:46:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbfE3DLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:41 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00D8424508;
        Thu, 30 May 2019 03:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185901;
        bh=dCVDXips007izB5sZEkFSjcUty+mk+m6uZJDYn5+XbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yj9v8sioykoumAB+eSIOXR/Mlu8jgSMGcv5NiHMLBL+LgQkMzJxA6j2FasGCFm96m
         EnQQ8Ul8pYqBp/7NfOjyN5++C9K46iJ56+y2xJKIYiF4aqezNXrP3lqHdUrkX6qDkH
         /O5um5iHm1JxzD4Psp9k2/hlor8IvSq93203AXmY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 269/405] x86/uaccess: Fix up the fixup
Date:   Wed, 29 May 2019 20:04:27 -0700
Message-Id: <20190530030554.526258149@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b69656fa7ea2f75e47d7bd5b9430359fa46488af ]

New tooling got confused about this:

  arch/x86/lib/memcpy_64.o: warning: objtool: .fixup+0x7: return with UACCESS enabled

While the code isn't wrong, it is tedious (if at all possible) to
figure out what function a particular chunk of .fixup belongs to.

This then confuses the objtool uaccess validation. Instead of
returning directly from the .fixup, jump back into the right function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/lib/memcpy_64.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 3b24dc05251c7..9d05572370edc 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -257,6 +257,7 @@ ENTRY(__memcpy_mcsafe)
 	/* Copy successful. Return zero */
 .L_done_memcpy_trap:
 	xorl %eax, %eax
+.L_done:
 	ret
 ENDPROC(__memcpy_mcsafe)
 EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
@@ -273,7 +274,7 @@ EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
 	addl	%edx, %ecx
 .E_trailing_bytes:
 	mov	%ecx, %eax
-	ret
+	jmp	.L_done
 
 	/*
 	 * For write fault handling, given the destination is unaligned,
-- 
2.20.1



