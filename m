Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D628C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AA82089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561055238;
	bh=dQf7mbFCXQNIjfwLP5w5E5NTD174bikfFnt5UJbnQZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wrtUqqDu3fc8w+lzSaoKJJUfqBiyBVp17Jnz7SGYE4qRQHfsT3cmb+JC3evf4B1dV
	 oYfi3NHmjhOffQVIfQpht28J7LmIhkSyLmqKEGkiNc5xwcN/IknQ43g+hB0pFnesrP
	 XPW7dOZA/BaVdKJqiJ0vXpeHhvCnyLJodCE2IGdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfFTS1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbfFTSFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:05:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827FF2082C;
        Thu, 20 Jun 2019 18:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053909;
        bh=dQf7mbFCXQNIjfwLP5w5E5NTD174bikfFnt5UJbnQZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T1iGjORrOqI8ObUQ8sp4E8C13x7CtqYdHJ/pILNmE6EbW6d46lb2FGjyEHZNGg98o
         LK1PNyTl+tyEzvW7GLUnjaaf8VrnbKCD8qCuaedq5GMcYPtcNrpaQK++4//HyGQ8hg
         kb01VkC8AM36LpYdJoHUaQSmdRPcC3BuJY8ZeBKM=
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
Subject: [PATCH 4.9 069/117] x86/uaccess, kcov: Disable stack protector
Date:   Thu, 20 Jun 2019 19:56:43 +0200
Message-Id: <20190620174356.843817104@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 40ea97290b08be2e038b31cbb33097d1145e8169 ]

New tooling noticed this mishap:

  kernel/kcov.o: warning: objtool: write_comp_data()+0x138: call to __stack_chk_fail() with UACCESS enabled
  kernel/kcov.o: warning: objtool: __sanitizer_cov_trace_pc()+0xd9: call to __stack_chk_fail() with UACCESS enabled

All the other instrumentation (KASAN,UBSAN) also have stack protector
disabled.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/Makefile b/kernel/Makefile
index 314e7d62f5f0..184fa9aa5802 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -28,6 +28,7 @@ KCOV_INSTRUMENT_extable.o := n
 # Don't self-instrument.
 KCOV_INSTRUMENT_kcov.o := n
 KASAN_SANITIZE_kcov.o := n
+CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 
 # cond_syscall is currently not LTO compatible
 CFLAGS_sys_ni.o = $(DISABLE_LTO)
-- 
2.20.1



