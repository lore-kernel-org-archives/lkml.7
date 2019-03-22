Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBB9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5BC21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254372;
	bh=CuCmzyEWVeHrwCY4SlFvxNhSxr9tLhav4r8JJZx+YhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uLw6NEdIxK2/zNkHTb+dTl7JI7pLDqWxqYsJl7l4d5aRd/sgDyvkLHDbI0NkewTeS
	 5xnsxoQjupvhlkv17Fhxxpj+Nhb+4MPzHfl0Q/ddqJI7VAgG6M+P9HXObiv7D2F3oX
	 vc33j6ClK7ZV6/6ugfV+Zft0pAWKlgE8FqrCemto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfCVLcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729752AbfCVLcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:32:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3718D21929;
        Fri, 22 Mar 2019 11:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254367;
        bh=CuCmzyEWVeHrwCY4SlFvxNhSxr9tLhav4r8JJZx+YhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xjWliXdX46lOcEv8e/tedjmt4CHVy3Ik2vwuYODIXTwwnBdpUHLjdZkC99YrFPbyD
         H3ONQJA5H0ru/VXrC7MNFRslARcnr2Ian83U98K+lwv0qSC3VotVzfKiL+itx7Qbi5
         ncblXKw+ofswJSPRPveWAb2+Yt1B7yU42wWD7Bw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 099/230] x86_64: increase stack size for KASAN_EXTRA
Date:   Fri, 22 Mar 2019 12:13:57 +0100
Message-Id: <20190322111243.553241642@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a8e911d13540487942d53137c156bd7707f66e5d ]

If the kernel is configured with KASAN_EXTRA, the stack size is
increasted significantly because this option sets "-fstack-reuse" to
"none" in GCC [1].  As a result, it triggers stack overrun quite often
with 32k stack size compiled using GCC 8.  For example, this reproducer

  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise06.c

triggers a "corrupted stack end detected inside scheduler" very reliably
with CONFIG_SCHED_STACK_END_CHECK enabled.

There are just too many functions that could have a large stack with
KASAN_EXTRA due to large local variables that have been called over and
over again without being able to reuse the stacks.  Some noticiable ones
are

  size
  7648 shrink_page_list
  3584 xfs_rmap_convert
  3312 migrate_page_move_mapping
  3312 dev_ethtool
  3200 migrate_misplaced_transhuge_page
  3168 copy_process

There are other 49 functions are over 2k in size while compiling kernel
with "-Wframe-larger-than=" even with a related minimal config on this
machine.  Hence, it is too much work to change Makefiles for each object
to compile without "-fsanitize-address-use-after-scope" individually.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23

Although there is a patch in GCC 9 to help the situation, GCC 9 probably
won't be released in a few months and then it probably take another
6-month to 1-year for all major distros to include it as a default.
Hence, the stack usage with KASAN_EXTRA can be revisited again in 2020
when GCC 9 is everywhere.  Until then, this patch will help users avoid
stack overrun.

This has already been fixed for arm64 for the same reason via
6e8830674ea ("arm64: kasan: Increase stack size for KASAN_EXTRA").

Link: http://lkml.kernel.org/r/20190109215209.2903-1-cai@lca.pw
Signed-off-by: Qian Cai <cai@lca.pw>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/page_64_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 4928cf0d5af0..fb1251946b45 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -2,7 +2,11 @@
 #define _ASM_X86_PAGE_64_DEFS_H
 
 #ifdef CONFIG_KASAN
+#ifdef CONFIG_KASAN_EXTRA
+#define KASAN_STACK_ORDER 2
+#else
 #define KASAN_STACK_ORDER 1
+#endif
 #else
 #define KASAN_STACK_ORDER 0
 #endif
-- 
2.19.1



