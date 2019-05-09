Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE85C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B3220656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428873;
	bh=cKiMoy8UKOUBMhm7ME4fulz2LgyrjgJBd10ShikA/ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZoVrg1gdG1vAYzs8jLnsqIuwH6j7FymE2gUM4M2AHw9fCaXYjjzKLXYY6cu1WhcF7
	 v38KvqQP41wFK/1bFngHa2VmjxSboTfLN5rm25H2xsh0ERpXQAqy/GUTuls+RpipTg
	 iqakA9rRrqxlFLzIiNVA+/WFWSgUW30qtI8SzonA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfEITHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbfEISpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:45:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDC162184B;
        Thu,  9 May 2019 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427533;
        bh=cKiMoy8UKOUBMhm7ME4fulz2LgyrjgJBd10ShikA/ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2jm0zs2qOw4sdUYoktO+ApRAWTUbd7AllcI3y/Gbmb5DOK6l4RuB3l44qj3PAPi+Z
         G+dO4jBbmsXE7iGc4Gw0OfLACgNHYHGM3lrg1+bsXPDgiq5eFMPYgUYibin+eRuOjg
         bR+vJvhoaETqgKnVRYz1/vz4SBG1FHehRAhGBmi4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Borislav Petkov <bp@suse.de>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Andrei Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        NeilBrown <neilb@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 18/42] linux/kernel.h: Use parentheses around argument in u64_to_user_ptr()
Date:   Thu,  9 May 2019 20:42:07 +0200
Message-Id: <20190509181256.381372059@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181252.616018683@linuxfoundation.org>
References: <20190509181252.616018683@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 4b484ab9e1635..1c5469adaa85e 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -72,8 +72,8 @@
 
 #define u64_to_user_ptr(x) (		\
 {					\
-	typecheck(u64, x);		\
-	(void __user *)(uintptr_t)x;	\
+	typecheck(u64, (x));		\
+	(void __user *)(uintptr_t)(x);	\
 }					\
 )
 
-- 
2.20.1



