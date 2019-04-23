Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3476C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE31218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOF5nYs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfDWVW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:22:59 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:40616 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWVW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:22:59 -0400
Received: by mail-oi1-f202.google.com with SMTP id q82so6665216oif.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 14:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8vlVGUDGuhaBum7VBXWJ2Ypo4IITj7wohx6wdq9xz00=;
        b=UOF5nYs3c+dDVnGSN4CYAmHRGzjeARM2Ftbv92tRi+1cryxR95ULqvVMem3a8MWDhM
         lAbL5MTzXH5J722iGevcK84S+PIteceFaLQcvK5Z64QO43JL5RMBKOwy3yl8qsY/HhfA
         8VtD/jiu/MuPBLh2PPRdV1c88Zabuc2/T+pGriu4/3ip6gYaoJB9VWExbMN2plQ24v/+
         l0kiHQppke8xxTwaJq9xDowiaIbUkzifAZyAHp68pEFg73oZchhgvbRvzsNPtJ054iyH
         8zqb35m55epPXw1MVYnuLQ9tJKSEkESss7HhN/1rYuVW7J0jg2lleZUd2CfkRR7ZUBXJ
         g8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8vlVGUDGuhaBum7VBXWJ2Ypo4IITj7wohx6wdq9xz00=;
        b=UqQ5taRi4YF5shmqB+yes4Fvp0vDB0CH9cDkFr+ETgFWPlsaLTul2AaF4dIgYDdSEf
         bU+t0qhjyl0wATqC4lsZvrXhuUgUFUZoNFecmV8dklLktQliuh3nNPyJgbFGNuHrrwvn
         GACWkVzVt7LcIb1H0okxukdodihOUEDDZt5puh8tD8RuAEbLNUHnBiIT6NR7oN7crotS
         0IqPQkS3g81olnyuX+qcyCSJucKGwaMSVYZjZzcLF2uvpYOVSSYmXab7SIVFIxM3lHiu
         R7H122EMZwcK/d3nrmwArU1PINSG9AvuJtVLYSjq4VJLUIbtn8XIo3/33bxuZ23CiS2e
         Yx/Q==
X-Gm-Message-State: APjAAAWmmqy/h5nzZGbkfD3+4jOAEvAVIQnPw3FRp7PIgahNjRhDZBO0
        OV9vphUlcdsge9eR3fFSa6OaR2I57y0dcKzDu80=
X-Google-Smtp-Source: APXvYqwm/kDtfFMUlLMZVLj6lAR+30/LM7ThVuJsH7R3kWki0aPvkQZv88UCVOUQR+wzDdGGEwUhJm9TJJMpSydP/jQ=
X-Received: by 2002:aca:5946:: with SMTP id n67mr3127938oib.48.1556054578217;
 Tue, 23 Apr 2019 14:22:58 -0700 (PDT)
Date:   Tue, 23 Apr 2019 14:22:53 -0700
Message-Id: <20190423212254.9504-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] riscv: vdso: drop unnecessary cc-ldoption
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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
 arch/riscv/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index fec62b24df89..b07b765f312a 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -36,7 +36,7 @@ $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
 # these symbols in the kernel code rather than hand-coded addresses.
 
 SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
-                            $(call cc-ldoption, -Wl$(comma)--hash-style=both)
+	-Wl,--hash-style=both
 $(obj)/vdso-dummy.o: $(src)/vdso.lds $(obj)/rt_sigreturn.o FORCE
 	$(call if_changed,vdsold)
 
-- 
2.21.0.593.g511ec345e18-goog

