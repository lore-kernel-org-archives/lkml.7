Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C870C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7952089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6M2O8JB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405985AbfFKRVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:21:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42911 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405263AbfFKRVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:21:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id z25so21229285edq.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 10:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oLZoCH+w0vEsUh5B0jjb151kNbWDekY9Hx2peXKMbk4=;
        b=p6M2O8JBT2y4hXNXJ+k4giMVUWIS/Vosq/FvvB5BUcx5CPLUCVhxMVpiKnBWJjmM+j
         bpuaGCRGv3v0FS4vVfk6v3U5vqxLynpHPLlsCXUykwcn1Ztl5JH+vHVIe7GMg0z+CPBr
         LzbhW4T+KhsMjCaPYzE5s6M5K9kOVr3z2uwec/+WMTXMQ3ppTHziHNvlDaySYajKXhpd
         FQvVjnanOlnC/2R6c/9V1sx0kbvm5T7fxtOXsSmsRjSSLd2u4doQFURIdkmck2CsNZu5
         BLGgTvnkcl0ZS2Pst76joa7hhkGeR5KfgWZin00PDYtmQZsnEHwmJNw7N1jq6PrmoVG4
         vh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLZoCH+w0vEsUh5B0jjb151kNbWDekY9Hx2peXKMbk4=;
        b=B46W7NGJplufibTibnHtGHT8YkKVUTzNHLtQFCScdPHJqOudbNyalTT7S/AZC43Kcd
         8zIT82XbT1fJNdYYfAg6XxDXLT8KG8bdCaH4cDMdDszAm8ZBJMMTD7sWAgLUAzkkQfQQ
         PqvPvbkkEzZ7vcRRl3GqczXotmshrOVGNWozkOadW8pGs46APMyq9ZWR+80hA10ik+P4
         Ow1TXV1SjMpaCdK7XKS7V5onmTr59u6msCJdRX5IdnqwROVJPQIU7unGnrDjGAhsMZS8
         COTFIcVTGezIJ6ZkJOQXsZ1Ut87yocu2bvoOjfasLMe77eEwVEBYdzNGLTA/n0R7o0sX
         3nJQ==
X-Gm-Message-State: APjAAAXmhkx7CJYH1ZS7D8fnvy/jroSKgjNhl0ngceBYEpnD1lJVFf3w
        mOqJ4LX0qlWVxYPMj+n8RV8=
X-Google-Smtp-Source: APXvYqyFh8CR41gRS/XNKx0eEHFjObJh4Rmr0MyxvtAXn6PhWqRAH/Y2ng7P1x+vtBW7ACiKuHvkyw==
X-Received: by 2002:a17:906:d6a:: with SMTP id s10mr29877187ejh.180.1560273674134;
        Tue, 11 Jun 2019 10:21:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id k9sm2403111eja.72.2019.06.11.10.21.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 10:21:13 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Qian Cai <cai@lca.pw>, Dave Martin <Dave.Martin@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] arm64: Don't unconditionally add -Wno-psabi to KBUILD_CFLAGS
Date:   Tue, 11 Jun 2019 10:19:32 -0700
Message-Id: <20190611171931.99705-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190607161201.73430-1-natechancellor@gmail.com>
References: <20190607161201.73430-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a GCC only option, which warns about ABI changes within GCC, so
unconditionally adding it breaks Clang with tons of:

warning: unknown warning option '-Wno-psabi' [-Wunknown-warning-option]

and link time failures:

ld.lld: error: undefined symbol: __efistub___stack_chk_guard
>>> referenced by arm-stub.c:73
(/home/nathan/cbl/linux/drivers/firmware/efi/libstub/arm-stub.c:73)
>>>               arm-stub.stub.o:(__efistub_install_memreserve_table)
in archive ./drivers/firmware/efi/libstub/lib.a

These failures come from the lack of -fno-stack-protector, which is
added via cc-option in drivers/firmware/efi/libstub/Makefile. When an
unknown flag is added to KBUILD_CFLAGS, clang will noisily warn that it
is ignoring the option like above, unlike gcc, who will just error.

$ echo "int main() { return 0; }" > tmp.c

$ clang -Wno-psabi tmp.c; echo $?
warning: unknown warning option '-Wno-psabi' [-Wunknown-warning-option]
1 warning generated.
0

$ gcc -Wsometimes-uninitialized tmp.c; echo $?
gcc: error: unrecognized command line option
‘-Wsometimes-uninitialized’; did you mean ‘-Wmaybe-uninitialized’?
1

For cc-option to work properly with clang and behave like gcc, -Werror
is needed, which was done in commit c3f0d0bc5b01 ("kbuild, LLVMLinux:
Add -Werror to cc-option to support clang").

$ clang -Werror -Wno-psabi tmp.c; echo $?
error: unknown warning option '-Wno-psabi'
[-Werror,-Wunknown-warning-option]
1

As a consequence of this, when an unknown flag is unconditionally added
to KBUILD_CFLAGS, it will cause cc-option to always fail and those flags
will never get added:

$ clang -Werror -Wno-psabi -fno-stack-protector tmp.c; echo $?
error: unknown warning option '-Wno-psabi'
[-Werror,-Wunknown-warning-option]
1

This can be seen when compiling the whole kernel as some warnings that
are normally disabled (see below) show up. The full list of flags
missing from drivers/firmware/efi/libstub are the following (gathered
from diffing .arm64-stub.o.cmd):

-fno-delete-null-pointer-checks
-Wno-address-of-packed-member
-Wframe-larger-than=2048
-Wno-unused-const-variable
-fno-strict-overflow
-fno-merge-all-constants
-fno-stack-check
-Werror=date-time
-Werror=incompatible-pointer-types
-ffreestanding
-fno-stack-protector

Use cc-disable-warning so that it gets disabled for GCC and does nothing
for Clang.

Fixes: ebcc5928c5d9 ("arm64: Silence gcc warnings about arch ABI drift")
Link: https://github.com/ClangBuiltLinux/linux/issues/511
Reported-by: Qian Cai <cai@lca.pw>
Acked-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Improve commit message explanation, I wasn't entirely happy with the
  first one; let me know if there are any issues/questions.

* Carry forward Dave's ack and Nick's review (let me know if you
  disagree with the commit messasge rewording).

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
2.22.0

