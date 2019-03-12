Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA55EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC436205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413965;
	bh=7tfMRPys/JBVyMfISNySf0skRqcdL2gLgG8iSMqxuAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JDsJMbuNrtZTUBX4G5h97FFEemUwgzrhxf76LX27irZGqOTe2HuATsrk8XZ2ljtuz
	 vbZz9ph1U3hxq6UxoFVQdcUKTtfnLKMNEJ2vxymcMT2DhhzX5x6mTW8F1xA417iIyb
	 CEbJyw+tiC7cD0Yw+5zYfsioP4N8LDrsWvNJvekE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfCLSGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbfCLRMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:34 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EA6121852;
        Tue, 12 Mar 2019 17:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410753;
        bh=7tfMRPys/JBVyMfISNySf0skRqcdL2gLgG8iSMqxuAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZChBKlKfbIGNaq7vs9Q1mtBGtLd2neMlTxgJT9yfRLQlnmCYGy5a6O8sdDxXnYBOz
         uslc5e7pgzTnozaABVJKuhK2bYJM5ShOC673+goVVkPdqqlrIQaNObKP6iQNY+pAkd
         OX0+FoxyiiFtS//q0y0wK177FK86aImFU+Qxv6E4=
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
Subject: [PATCH 4.20 062/171] x86_64: increase stack size for KASAN_EXTRA
Date:   Tue, 12 Mar 2019 10:07:22 -0700
Message-Id: <20190312170353.545553186@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 8f657286d599..0ce558a8150d 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -7,7 +7,11 @@
 #endif
 
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



