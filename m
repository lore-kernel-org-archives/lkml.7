Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2D32183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfC1QOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:14:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35577 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfC1QOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:14:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2SGDFH23393768
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Mar 2019 09:13:15 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2SGDD3b3393762;
        Thu, 28 Mar 2019 09:13:13 -0700
Date:   Thu, 28 Mar 2019 09:13:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-f6027c81099e87516d27d123867f10abd04b2d38@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
        bp@suse.de, jannh@google.com, mingo@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, yamada.masahiro@socionext.com, namit@vmware.com
Reply-To: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
          namit@vmware.com, yamada.masahiro@socionext.com, x86@kernel.org,
          linux-kernel@vger.kernel.org, bp@suse.de, mingo@kernel.org,
          jannh@google.com
In-Reply-To: <20190328154948.152273-1-jannh@google.com>
References: <20190328154948.152273-1-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cpufeature: Fix __percpu annotation in
 this_cpu_has()
Git-Commit-ID: f6027c81099e87516d27d123867f10abd04b2d38
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f6027c81099e87516d27d123867f10abd04b2d38
Gitweb:     https://git.kernel.org/tip/f6027c81099e87516d27d123867f10abd04b2d38
Author:     Jann Horn <jannh@google.com>
AuthorDate: Thu, 28 Mar 2019 16:49:48 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 28 Mar 2019 17:03:11 +0100

x86/cpufeature: Fix __percpu annotation in this_cpu_has()

&cpu_info.x86_capability is __percpu, and the second argument of
x86_this_cpu_test_bit() is expected to be __percpu. Don't cast the
__percpu away and then implicitly add it again. This gets rid of 106
lines of sparse warnings with the kernel config I'm using.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190328154948.152273-1-jannh@google.com
---
 arch/x86/include/asm/cpufeature.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index ce95b8cbd229..0e56ff7e4848 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -112,8 +112,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	 test_cpu_cap(c, bit))
 
 #define this_cpu_has(bit)						\
-	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : 	\
-	 x86_this_cpu_test_bit(bit, (unsigned long *)&cpu_info.x86_capability))
+	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
+	 x86_this_cpu_test_bit(bit,					\
+		(unsigned long __percpu *)&cpu_info.x86_capability))
 
 /*
  * This macro is for detection of features which need kernel
