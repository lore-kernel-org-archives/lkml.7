Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB33C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1450026B68
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ozkPZplA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfEaPLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:11:44 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:46465 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfEaPLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:11:42 -0400
Received: by mail-ua1-f74.google.com with SMTP id f25so415660ual.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 08:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LNEghw4B+GvmCMDyCJlZQOSF0gWgpI6UWg+d86gG2mc=;
        b=ozkPZplAJd4r//3+vEEoJahNvXQO1X4ZigVyEubSdIpqctPhuNZLdlWXMYpzn67h0X
         JreDTRTgDzX6i2a85Ia9Q+9zBKklei2FPPQbxVrT8uDoUQNOpsN/p8+BkJ1SU3yDiMNw
         1KJBsS9Szx7t+Z3QsoD17P8MBZba3PqICFgjsntr0+BzPLbSbFLUzxrI2rNF4WXbIr6B
         NjlRCy5ykAL5B1aiDgvaccG0XHNZwMHu3r2aBEaZOLLrreJ9CrY7Ieugpp59+Z5NF2U0
         xuVrgPGdqr3vuv5BoBXZKO31zh2+kuZ3KqXUUmM1Uym7mHKx3LiZMdKIk+7MQPDnNV1p
         ikKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LNEghw4B+GvmCMDyCJlZQOSF0gWgpI6UWg+d86gG2mc=;
        b=i3eImyczFw6SH77YDM9bE6RfKdsBmvytOs/zrxYl7qTEEeKqAJSiyQ5wirusWU+z/5
         qhjMksmGsjrbXjQ0R9cHhkeL76c5gTdAE6CdTi1AoH/e5QAiaRjlZlKe3aoObnvJRKRY
         R79pd2b9TI9uuefhMDGJTlgnmcl3BnKbbGALbpcVCysdW4U1FJnjJ6XCK1SSsaLoWXC2
         rAjYC2kYPyHO9xb5J1lq5+6Y61tL13RcJ28j0kMal7THyTzJBFET60zZhMz9MoMzAYTI
         Jj5C34rwwtJ3xswc/SE3PHzAvWTbwZxSZiUUooFvCxQovAMzHFHq2gMxTVh4j1rlBVQ7
         kOcA==
X-Gm-Message-State: APjAAAUXOa10i7SRmpq99dUm3l8OM/nHsHCu1nIVUJvnnAijkDr9gVeA
        GDKu9tCwG2AwX8q4XoD0iHX8yDI49A==
X-Google-Smtp-Source: APXvYqxMRxD/zc6HiE9yfl3teIOaD5ernl+4NfEmJo1Hwn7xZzxHUm1PC8Ix91D9Z/1irN8QwfsHq9covg==
X-Received: by 2002:ac5:c215:: with SMTP id m21mr4221628vkk.84.1559315501278;
 Fri, 31 May 2019 08:11:41 -0700 (PDT)
Date:   Fri, 31 May 2019 17:08:30 +0200
In-Reply-To: <20190531150828.157832-1-elver@google.com>
Message-Id: <20190531150828.157832-3-elver@google.com>
Mime-Version: 1.0
References: <20190531150828.157832-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v3 2/3] x86: Use static_cpu_has in uaccess region to avoid instrumentation
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        hpa@zytor.com
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a pre-requisite for enabling KASAN bitops instrumentation;
using static_cpu_has instead of boot_cpu_has avoids instrumentation of
test_bit inside the uaccess region. With instrumentation, the KASAN
check would otherwise be flagged by objtool.

For consistency, kernel/signal.c was changed to mirror this change,
however, is never instrumented with KASAN (currently unsupported under
x86 32bit).

Signed-off-by: Marco Elver <elver@google.com>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
---
Changes in v3:
* Use static_cpu_has instead of moving boot_cpu_has outside uaccess
  region.

Changes in v2:
* Replaces patch: 'tools/objtool: add kasan_check_* to uaccess
  whitelist'
---
 arch/x86/ia32/ia32_signal.c | 2 +-
 arch/x86/kernel/signal.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 629d1ee05599..1cee10091b9f 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -358,7 +358,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 		put_user_ex(ptr_to_compat(&frame->uc), &frame->puc);
 
 		/* Create the ucontext.  */
-		if (boot_cpu_has(X86_FEATURE_XSAVE))
+		if (static_cpu_has(X86_FEATURE_XSAVE))
 			put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
 		else
 			put_user_ex(0, &frame->uc.uc_flags);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 364813cea647..52eb1d551aed 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -391,7 +391,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 		put_user_ex(&frame->uc, &frame->puc);
 
 		/* Create the ucontext.  */
-		if (boot_cpu_has(X86_FEATURE_XSAVE))
+		if (static_cpu_has(X86_FEATURE_XSAVE))
 			put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
 		else
 			put_user_ex(0, &frame->uc.uc_flags);
-- 
2.22.0.rc1.257.g3120a18244-goog

