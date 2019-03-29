Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C49C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EBF218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyG2sJOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfC2VrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:47:18 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:38877 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbfC2VrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:47:15 -0400
Received: by mail-qk1-f202.google.com with SMTP id c67so3085348qkg.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 14:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OdjzvoFspfXUN9mwmR0C21P1QUGjvwo+0+77lt90xtU=;
        b=WyG2sJOLuEITLdvR7p4EHfBQFnxRQUj+8uyIpPJW74u0hlbQxkEVoZIa0YZ0anvF/Q
         YIcT7zH4rUdT+tXq8PGLf2bI7mLkyl8IEhrO+BQ2qcFgJ/SVic8yjqEl8Uz3oBBhlDJM
         8TrMUnTt6SdeEVTRTbjmVp5bIkOpLcO3PnImVe66BtZLMIQ/padU8cH1PTSsyD+nnIdL
         aSBEHlRbKke6zGjbyLHxobpJ9BNXvmynsNQmMDWgpUVobL0dBps+g6mDYZoTvWPlhx10
         X66M4J46b19VJvTqgWOtGbqyGq5ARVELDFdb/U2ldywXat15xIJG3ni49eFsEHCMMFXG
         9DKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OdjzvoFspfXUN9mwmR0C21P1QUGjvwo+0+77lt90xtU=;
        b=EEu1LJ1fbvMBvzoWSemhnukrbtNq9k9Ea3LRE9nlpyEf9g8wbq3syKnLGV4faQJo1l
         4BvNy4K/+Ys4tc+LVyHc6DFgmq0lEwzCsjnCIpNv1kXsSj6QIF6FUUJ4EGafaUEzqNEb
         jyZIrhry5tj9x2vSWfQdZ+Q+tTZpgiCP5gsyiV7FIBAswcDzUxMMQKBUwnFfANIoq7od
         321NtuINiMihJycuGX1b1ccJUCLuy/Mkqy/W7eREJWCqBpJ/l4e5BIMSMYpQiIND8E6/
         XpJRE1bF+e7a7nIhW3A02n7LEQTzkMhv4JxzjhSlBo5vs9Gr8Snx8H3diZurE6rI59oo
         cmcA==
X-Gm-Message-State: APjAAAXAS6sUm/ihpHmgbU6JpSt/eQtXUOdoYagKa8nLRHlQc4K7fhmF
        OBhKV6PgpcdOon0+nWl9SUSsr0JbQg==
X-Google-Smtp-Source: APXvYqzT6a8Dv5e/IqFLEIm0d+bw2q3Y7mlPTlVXO7svglBhcDJG4jg/sWEVvU8FsED5iDAm44B9sqH2VA==
X-Received: by 2002:a37:945:: with SMTP id 66mr3198178qkj.60.1553896035139;
 Fri, 29 Mar 2019 14:47:15 -0700 (PDT)
Date:   Fri, 29 Mar 2019 22:46:52 +0100
In-Reply-To: <20190329214652.258477-1-jannh@google.com>
Message-Id: <20190329214652.258477-4-jannh@google.com>
Mime-Version: 1.0
References: <20190329214652.258477-1-jannh@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3 4/4] x86/uaccess: Fix implicit cast of __user pointer
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jannh@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Mukesh Ojha <mojha@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two arguments of __user_atomic_cmpxchg_inatomic() are:

 - `uval` is a kernel pointer into which the old value should be stored
 - `ptr` is the user pointer on which the cmpxchg should operate

This means that casting `uval` to `__typeof__(ptr)` is wrong. Since `uval`
is only used once inside the macro, just get rid of __uval and use `(uval)`
directly.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/include/asm/uaccess.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 1954dd5552a2..a21f2a2f17bf 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -585,7 +585,6 @@ extern void __cmpxchg_wrong_size(void)
 #define __user_atomic_cmpxchg_inatomic(uval, ptr, old, new, size)	\
 ({									\
 	int __ret = 0;							\
-	__typeof__(ptr) __uval = (uval);				\
 	__typeof__(*(ptr)) __old = (old);				\
 	__typeof__(*(ptr)) __new = (new);				\
 	__uaccess_begin_nospec();					\
@@ -661,7 +660,7 @@ extern void __cmpxchg_wrong_size(void)
 		__cmpxchg_wrong_size();					\
 	}								\
 	__uaccess_end();						\
-	*__uval = __old;						\
+	*(uval) = __old;						\
 	__ret;								\
 })
 
-- 
2.21.0.392.gf8f6787159e-goog

