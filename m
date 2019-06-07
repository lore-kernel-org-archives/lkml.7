Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09623C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01D62089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqR33tXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfFGQMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:12:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42011 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfFGQMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:12:06 -0400
Received: by mail-ed1-f66.google.com with SMTP id z25so3739363edq.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0JpUdTsOa7EIqirFoRpEdJ3i1kEV+MZYFQgC803VPU4=;
        b=JqR33tXvj7r3SHSdAHfYwNexD3XwyD1ZvtvYnpUh+WuFIqsP+hRuv63fN0FauVOcjj
         RtW7VNOkguzUN+evgxN0vU5f6Utscp5VDT9uCSvFv9ErP39f1DoZVwUcEudOh1cCg4xf
         tXEHhviwSiYhRa8OVpLjGGzNq1UZOdWKHbbxVqkr7wucaWqoqdi9VfXzJ2u3vOnrJ6T5
         FFQajWDRxOgOQOxXqEJyUwGhAWYf8n9qUP7QiVrxOXxdsH/MO7OnaTDxomnk5pjOseKK
         yTYkGnLAsm7mvkh4RoLf/xq8TfoJt46ZDhv8N6jrBWO+qUc1gTrp1g6Lf4hKfaVUQ+pg
         pg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0JpUdTsOa7EIqirFoRpEdJ3i1kEV+MZYFQgC803VPU4=;
        b=W8RmEOfCOgnwTzVzIxSNC367E2WeowWBDcDjR/y8kFVkKYtJAbWMqyx3AjUSWaeuHv
         kIr8uFyW5EVnQYHW4GVzGb4zUIrysj6+vUHDpkwPTr2PnTTdcr5CXjRFiWoHMuEzqwwE
         ueNwDk7yraR8VJYTEhrK1GMpMA4uTQx9+F38KVjv7kjhK7Ny8M4OobPWvRxESRR+T5jB
         EqcGMr9wpAfHkLhd75KQ5RLUvowlfmfRWW4IF3dQATAj+wroeSRVXSXDjCrnZswTRrwE
         GwpJg73DnbnOQGo+5hetNuNiSHA+naN6LLeeJ+sPC+u+gub/fvFgYpfqFG2hYpanej2e
         VBPg==
X-Gm-Message-State: APjAAAUoka6k2Jpho0wz12P0HLcyd6LpT0Q3w7Ebk7Qo++fLKexG9TLp
        ObVtlGgq1cmk4k78UK0avUQ=
X-Google-Smtp-Source: APXvYqxaqFHNuIkJrpIMXSYPMvOKZbnkIur25HxoxqrDANRMZ9mZX+ezXOZ6faSEaGlGt95Y6uIsEQ==
X-Received: by 2002:a17:906:53c8:: with SMTP id p8mr48103973ejo.18.1559923925065;
        Fri, 07 Jun 2019 09:12:05 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id q24sm440117ejr.35.2019.06.07.09.12.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 09:12:04 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] arm64: Don't unconditionally add -Wno-psabi to KBUILD_CFLAGS
Date:   Fri,  7 Jun 2019 09:12:01 -0700
Message-Id: <20190607161201.73430-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc3
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a GCC only option, which warns about ABI changes within GCC, so
unconditionally adding breaks Clang with tons of:

warning: unknown warning option '-Wno-psabi' [-Wunknown-warning-option]

and link time failures:

ld.lld: error: undefined symbol: __efistub___stack_chk_guard
>>> referenced by arm-stub.c:73
(/home/nathan/cbl/linux/drivers/firmware/efi/libstub/arm-stub.c:73)
>>>               arm-stub.stub.o:(__efistub_install_memreserve_table)
in archive ./drivers/firmware/efi/libstub/lib.a

I suspect the link time failure comes from some flags not being added
via cc-option, which will always fail when an unknown flag is
unconditionally added to KBUILD_CFLAGS because -Werror is added after
commit c3f0d0bc5b01 ("kbuild, LLVMLinux: Add -Werror to cc-option to
support clang").

$ echo "int main() { return 0; }" | clang -Wno-psabi -o /dev/null -x c -
warning: unknown warning option '-Wno-psabi' [-Wunknown-warning-option]
1 warning generated.

$ echo $?
0

$ echo "int main() { return 0; }" | clang -Werror -Wno-psabi -o /dev/null -x c -
error: unknown warning option '-Wno-psabi' [-Werror,-Wunknown-warning-option]

$ echo $?
1

This side effect is user visible (aside from the inordinate amount of
-Wunknown-warning-option and build failure), as some warnings that are
normally disabled like -Waddress-of-packed-member or
-Wunused-const-variable show up.

Use cc-disable-warning so that it gets disabled for GCC and does nothing
for Clang.

Fixes: ebcc5928c5d9 ("arm64: Silence gcc warnings about arch ABI drift")
Link: https://github.com/ClangBuiltLinux/linux/issues/511
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 8fbd583b18e1..e9d2e578cbe6 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -51,7 +51,7 @@ endif
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
-KBUILD_CFLAGS	+= -Wno-psabi
+KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
 KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
 
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
-- 
2.22.0.rc3

