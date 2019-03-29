Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EE7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D593C2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZdqR4+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfC2QbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:31:06 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:48824 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfC2QbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:31:04 -0400
Received: by mail-qk1-f202.google.com with SMTP id b188so2243887qkg.15
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VDhFgWJ/56vXJisR9dcHKiBzroB9HEmnMiZSpGUlpdE=;
        b=KZdqR4+TFEn7QsE/4nZtLwoH2wc4UDFBAuDcjfLltrQEOnnf2CFcXNN44qcY3xlbAP
         0zQnZw9mfSXOEqRDL0PddyXoqlnuQu2frreQ7dQVwFBLe4+pEV0cismBmNqxYnH/GC1S
         EohjyqrxdXdUVrlYl8ihoiOnVsx7QU0WhDX200wzukYX4PlQFtXeAVtrPmZ0G6tezjxf
         rvM47Ra5SER77P0bHWeR+1u/LkGFCPv8UWZPbCBocfzKiQSQqMSXAguQHZ4iudvXk2fR
         rbrD6+uV+WY63NyWAVNRPnZ8MwTHYfUofY5VhYJrNOescEzqCU+NdOBppolbutKlsk5+
         +8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VDhFgWJ/56vXJisR9dcHKiBzroB9HEmnMiZSpGUlpdE=;
        b=ifBN/3Co8lXH5qDYrZETGxA8kbqK7kUWf7pfvtr3aole8p1FF5HbEtRox5NyzcUhFX
         OxXb1816Lagoy65KZjwaGBjn6kxIguSMLCph9PlCutIvaSBJIpqED1ZgxqXs2JRneCa7
         WraupRiwMYuGH+1X7mFjPBobJ2IPVOAtvzC5XZ4lGX7CgI2+0BLWn9jWy1bCyUtAeK3X
         YOGT23C3SwZbJZjwBZ0uL+Ferok4BbfxY/aSjfjS/GsYLjrF0qE6xdCP+SPAsMndeBAz
         1oIkLD1ZX96R8DCDJhXgMaNevET3dgrsMGa8ho/KFThMrbvr83iSpPFnBewtDPcruzNz
         L1mw==
X-Gm-Message-State: APjAAAXsm0lMHTF9Z140+1MU18bvuPGUEzkgESHJ8ElDbFR6WTt49iiM
        cubxlSJPrGm6z1XQ5DSr0F04M/dhfw==
X-Google-Smtp-Source: APXvYqy6jfn1vab76SzbHlheK2KbCeYBEDQvT/kiSSQLA5B3P4hBy0I48eKFMz/7Kk7+IrLuQCl3nV820w==
X-Received: by 2002:a0c:94b9:: with SMTP id j54mr3790002qvj.44.1553877063522;
 Fri, 29 Mar 2019 09:31:03 -0700 (PDT)
Date:   Fri, 29 Mar 2019 17:30:47 +0100
In-Reply-To: <20190329163047.223508-1-jannh@google.com>
Message-Id: <20190329163047.223508-4-jannh@google.com>
Mime-Version: 1.0
References: <20190329163047.223508-1-jannh@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2 4/4] x86/uaccess: Fix implicit cast of __user pointer
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jannh@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Qiaowei Ren <qiaowei.ren@intel.com>
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

