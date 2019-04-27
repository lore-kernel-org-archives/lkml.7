Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00749C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6040215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329172;
	bh=5qL0G0kCZ9Qk9WCEvjcICicxNkk6HfiP7V8tSAewFmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bf0sE0zoJwrroEPzCrrlnQQRKF7lKRlAl96aJ6DMPANYIYCMTU+B+xLfJi1PYbKQK
	 muJoDKQfxgStR/7PigCKwNTM1QWctlp8jqgXAqU+ItGzDeXg9TSs3XhnDFOtpZGTwl
	 dVqHfyZ6zv6QhnC7/NFhbv/pGPlNilIJXlzWCXA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfD0Bjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfD0Bj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D60214AE;
        Sat, 27 Apr 2019 01:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329168;
        bh=5qL0G0kCZ9Qk9WCEvjcICicxNkk6HfiP7V8tSAewFmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PngDV9DHRcKrpGX01tmKLoMu35sEwDY0HXefITcnoQAiSjYhCch1Mo0XH2QH+7G5E
         qwTAz3iaaRXWjok5Bm8Od36c6eX+yk0Rpgs3tWNhXopY6tojRqWPofG6UTdIjt5tqe
         FL/149nWaAx0rpmxTRhA5wD/8iRvTG/Jl7fOUoIs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Borislav Petkov <bp@suse.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        NeilBrown <neilb@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 33/79] linux/kernel.h: Use parentheses around argument in u64_to_user_ptr()
Date:   Fri, 26 Apr 2019 21:37:52 -0400
Message-Id: <20190427013838.6596-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

[ Upstream commit a0fe2c6479aab5723239b315ef1b552673f434a3 ]

Use parentheses around uses of the argument in u64_to_user_ptr() to
ensure that the cast doesn't apply to part of the argument.

There are existing uses of the macro of the form

  u64_to_user_ptr(A + B)

which expands to

  (void __user *)(uintptr_t)A + B

(the cast applies to the first operand of the addition, the addition
is a pointer addition). This happens to still work as intended, the
semantic difference doesn't cause a difference in behavior.

But I want to use u64_to_user_ptr() with a ternary operator in the
argument, like so:

  u64_to_user_ptr(A ? B : C)

This currently doesn't work as intended.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: NeilBrown <neilb@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qiaowei Ren <qiaowei.ren@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190329214652.258477-1-jannh@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/kernel.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8f0e68e250a7..fd827b240059 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -73,8 +73,8 @@
 
 #define u64_to_user_ptr(x) (		\
 {					\
-	typecheck(u64, x);		\
-	(void __user *)(uintptr_t)x;	\
+	typecheck(u64, (x));		\
+	(void __user *)(uintptr_t)(x);	\
 }					\
 )
 
-- 
2.19.1

