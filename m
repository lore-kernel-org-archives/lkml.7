Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35106C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F54218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sv/53jT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfDWVQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:16:19 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:41226 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWVQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:16:19 -0400
Received: by mail-ua1-f73.google.com with SMTP id o26so2024257uar.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 14:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zwticmzDXTuD2usR0HamRrNVNkzWKEvaBnNaKDIUP9U=;
        b=sv/53jT29JGAqQNkjnN3SiBAXINSYk8Fsz0rxPwXWhw8Vsh4Ijmq9+TL+wGTAx06DD
         EijqWaotTDj8zyteNA7+TufWqSxzM93zB18k+j5mvwV31lNPcA/rhIF1jFNuDbpj6sLc
         x3aXynk1uFp4d8i4e6j5F2n+/wklhfUM4ylhAQpT6gETUvjp3ncs9ncig+pgbAjzpuMF
         nEBx6XFaXxMiUfU4HnKUkfbvdeWQsQPS5uVt+3ANzZ76dK3ZURYovm+KRyRBR5Q478+1
         3y4Vhj1Ozl5ISacvTm6zSMt4SXqglRU31cL3xlHuAkS6mAvwDUYM7qVgrmtK35DDy4Wx
         96KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zwticmzDXTuD2usR0HamRrNVNkzWKEvaBnNaKDIUP9U=;
        b=G8J89tacgG0pU8TVjDCpylG6m1RbE5OLmAgMpw7/Z0j7fU32Q0g98C0Ot2oj0imSur
         /Y4lIhm2lRADOFBjILqaRk+e3UuAriyBgvVzAsl1xw3PoA684liT+pUYEBMdAaRPDH/8
         i+w8/ylHggPxAJNLF8xvPaSnrw+td/2WL16rvcGkf7aaDh9vCsosLHxFHFq9A5dClmr1
         /ZfhSQo9cehaECdbKqK8hfqn0ibd5oRUj/zrTkR+eCEiOKitZblROjDTeRnlD3VwWiSa
         g/qQu+Ab7iWiFFhqghgT996Zt2Rtqjv+Xw1XKpOnQ/LJMQRiLf8mPVZhfOSITjnUrzwe
         1KJQ==
X-Gm-Message-State: APjAAAUmRfwCGVC4OqlqXNCb7TAWW8iv4juD/fLWjE8gNGrQztdRBZtv
        JDvy8xlW5EYfOkslrfiXF3zUphP3eh/M6z+90rE=
X-Google-Smtp-Source: APXvYqzT2YRBb7rYNF2E/fZx0RcocTOXnVGVnZoxT7s/sWHFTP8XkvflEGwma+se9BMNPt9Rsmrdl+EhbXaJgzlr+tk=
X-Received: by 2002:ab0:278b:: with SMTP id t11mr13541612uap.88.1556054178288;
 Tue, 23 Apr 2019 14:16:18 -0700 (PDT)
Date:   Tue, 23 Apr 2019 14:15:53 -0700
Message-Id: <20190423211554.1594-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] x86: um: vdso: drop unnecessary cc-ldoption
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Towards the goal of removing cc-ldoption, it seems that --hash-style=
was added to binutils 2.17.50.0.2 in 2006. The minimal required version
of binutils for the kernel according to
Documentation/process/changes.rst is 2.20.

Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
Cc: clang-built-linux@googlegroups.com
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/um/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index bf94060fc06f..0caddd6acb22 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -62,7 +62,7 @@ quiet_cmd_vdso = VDSO    $@
 		       -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^) && \
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
 
-VDSO_LDFLAGS = -fPIC -shared $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv
 GCOV_PROFILE := n
 
 #
-- 
2.21.0.593.g511ec345e18-goog

