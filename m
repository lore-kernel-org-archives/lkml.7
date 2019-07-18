Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7EAC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 00:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F5020873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 00:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzADRtkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfGRACn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 20:02:43 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54373 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbfGRACn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 20:02:43 -0400
Received: by mail-pl1-f202.google.com with SMTP id u10so12882776plq.21
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 17:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=d2opEawD5+UpjHd3NqyX+5wHPW1XJIxl9MSYmfk275Q=;
        b=JzADRtkOw2096YFXxVSMAzsSWjQX8A9aoK4y1dNuoORdeMgF6K2He4c4O4zv+SvN1C
         UNqNMY/GIiooHoE15NvVgxlMs/qpJxGGW8RFAoHq/wQ6szsqmG6LnRHB4dULrMiW4Vzg
         IUj4LTC/4PLSbvqJwgooz1Mlzhu1UhCeAzoMilvUyGj/7izvs3+tWqOjcFQR2KUg25Si
         omfLoHXCTMhlrVNQEY9J5rCa7XG2EOcD+J5GGbnvSsBg6GUf8Gelz5fbj6EqKMRp7c0Y
         L5YSYp3s7fpOT6STKRp3YIixv/u1jSSDhY/5h3ag4LEIAN3yGLS7G6GAXS9ckGFD8wu0
         1tmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d2opEawD5+UpjHd3NqyX+5wHPW1XJIxl9MSYmfk275Q=;
        b=T1fOldl6iJ6NekwKGsyqDKex6rmZ6WjkBX8djz3yXVrVa14FB4wxcJ2HSltb38+/M0
         naz2FeN9Qofi7uPfQ9VCZsAAx94fLGimIcOGuxSUG+dx1/7ad1yIxy2a/FIYtZbon2If
         TsoLwQgKPivr3qL3nMlkpd+yLJnVy2ryTE9xeQLNZIKABSvn2mTfTRVRKhfMmM6rrC+1
         PBvcZ7nc/m1M9X/UBvZO/2IHa/3Z2N+saKOAkvS7EmeoAlv1xIko4LUOOg6TMNyqD+3U
         RMiZfCG3+0LWXKANsPpLw1RfRuOZtiRGc+iVcJB5/TNFVZXaAD+st3BYfMTy2ZeFO9VT
         ZYWg==
X-Gm-Message-State: APjAAAXq6GqhWXB53TeeVhadKTRZO5DOnxy34GbcYDuNRc3v9liYuIev
        xt7YuCibDtwW15fTNerOrjP7LW0tgZuK/Am42DEJvQ==
X-Google-Smtp-Source: APXvYqx8C+Hy6Xs2urAbdNvACQ68TCh4KNRmJw+r8zbsjI0Iz08oehTCqQsB2iYjkYZRoMBdYUgYRrzMAIY59zdjl7ZMAQ==
X-Received: by 2002:a63:a35c:: with SMTP id v28mr728662pgn.144.1563408162493;
 Wed, 17 Jul 2019 17:02:42 -0700 (PDT)
Date:   Wed, 17 Jul 2019 17:02:05 -0700
In-Reply-To: <20190718000206.121392-1-vaibhavrustagi@google.com>
Message-Id: <20190718000206.121392-2-vaibhavrustagi@google.com>
Mime-Version: 1.0
References: <20190718000206.121392-1-vaibhavrustagi@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH 1/2] x86/purgatory: add -mno-sse, -mno-mmx, -mno-sse2 to Makefile
From:   Vaibhav Rustagi <vaibhavrustagi@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>,
        Vaibhav Rustagi <vaibhavrustagi@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling the purgatory code with clang results in using of mmx
registers.

$ objdump -d arch/x86/purgatory/purgatory.ro | grep xmm

     112:	0f 28 00             	movaps (%rax),%xmm0
     115:	0f 11 07             	movups %xmm0,(%rdi)
     122:	0f 28 00             	movaps (%rax),%xmm0
     125:	0f 11 47 10          	movups %xmm0,0x10(%rdi)

Add -mno-sse, -mno-mmx, -mno-sse2 to avoid generating SSE instructions.

Signed-off-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
---
 arch/x86/purgatory/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 3cf302b26332..3589ec4a28c7 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -20,6 +20,7 @@ KCOV_INSTRUMENT := n
 # sure how to relocate those. Like kexec-tools, use custom flags.
 
 KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -fno-builtin -ffreestanding -c -Os -mcmodel=large
+KBUILD_CFLAGS += -mno-mmx -mno-sse -mno-sse2
 KBUILD_CFLAGS += -m$(BITS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 
-- 
2.22.0.510.g264f2c817a-goog

