Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B73C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAA4218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QjMWQQTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfDWVTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:19:41 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:50247 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfDWVTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:19:40 -0400
Received: by mail-yw1-f74.google.com with SMTP id j66so13268575ywa.17
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 14:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HLwbm2ixUCUU8yHUub9JWOZJ0WYHpVgzhxGwrAg6Yo8=;
        b=QjMWQQTgONkYT6av0EQrfI49Pj26aGTpliQWAnVkig7D11d32ywX7gZvKeTzln4OZT
         43jVMFUYBNRJIU76YxQxBVovq0lBkONQqy3RqadgNgdJvqEmiA/WpIicOmtfYRF9ujRE
         stWPpFbI6RzS0JbfCVp/r9eDIqYIpoTflt7fE7+9pHZGDceZlGAl+AFa/XSD9fIZ5clL
         VL+duKaaL9KoWgisTmmIOmqWjA5FFfAorgnMUQvTk57WaM8BMVDAJ+0/QYkHpGIF++GY
         8pr51r3aqYwvXwR+dBhalOZmNzslwwB8zY/+O02JsOvZOfCKliDeWFgzzhb+1oLHTLqT
         1uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HLwbm2ixUCUU8yHUub9JWOZJ0WYHpVgzhxGwrAg6Yo8=;
        b=On6NqqHM56DClF+91xopImIXOVVLJYRplcj/kqNSimWrx4FXL/49uksobm8aWBuf/h
         8IIk+BgVgudUhjC1uybQwXTKFBiVdK06csLLzgbBVklqJ4jU25sJ4TCulRBr9hKzuIrk
         h6XUGhR1Zwvn+Hiw3mrR/yPUAggX2YJp2zAFx+NTJ4CxtSBk6WMSyfOxVq7mgCOZH+x8
         HAT2gHh/mw17IWZ/QvieN0z2CiZeQiBLGgnG3UeXRYAa4HOUGlglwoz1OXDkc0qMRUwH
         h4XuZRjFSFz6zywL98uPDhGyMw0nybPDEUX42IEX+UcjGgpOtdsYIWge31jGAimG5/HB
         BLNw==
X-Gm-Message-State: APjAAAV0LMYsLxscJNhpyt2JUF66GO789hcPleH9kUW2F3i8+d7fyXZB
        fthHgAx4E2CZBpGcxZt0RF+HdehVACsqWxosGFo=
X-Google-Smtp-Source: APXvYqwc3BASsDYQzCPRGoJ2mIlZ+MMRfU3OfGRBKDQv/vQwj4MPhHKUGOcVXdT4inJ5+yaZ6JKK88/cPD/ecD9kVRc=
X-Received: by 2002:a25:2d49:: with SMTP id s9mr1727497ybe.278.1556054380091;
 Tue, 23 Apr 2019 14:19:40 -0700 (PDT)
Date:   Tue, 23 Apr 2019 14:19:31 -0700
Message-Id: <20190423211932.4906-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] nds32: vdso: drop unnecessary cc-ldoption
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     green.hu@gmail.com, deanbo422@gmail.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
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
 arch/nds32/kernel/vdso/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/nds32/kernel/vdso/Makefile b/arch/nds32/kernel/vdso/Makefile
index e6c50a701313..d379645cad74 100644
--- a/arch/nds32/kernel/vdso/Makefile
+++ b/arch/nds32/kernel/vdso/Makefile
@@ -11,10 +11,8 @@ obj-vdso := note.o datapage.o sigreturn.o gettimeofday.o
 targets := $(obj-vdso) vdso.so vdso.so.dbg
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 
-ccflags-y := -shared -fno-common -fno-builtin
-ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
-		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
-ccflags-y += -fPIC -Wl,-shared -g
+ccflags-y := -shared -fno-common -fno-builtin -nostdlib -fPIC -Wl,-shared -g \
+	-Wl,-soname=linux-vdso.so.1 -Wl,--hash-style=sysv
 
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
-- 
2.21.0.593.g511ec345e18-goog

