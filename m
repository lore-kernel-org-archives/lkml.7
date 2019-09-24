Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22997C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34BF214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCee7g6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436597AbfIXTdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:33:15 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:43576 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfIXTdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:33:14 -0400
Received: by mail-pg1-f202.google.com with SMTP id 6so1944727pgi.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 12:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OrZSsFgz8YSYCzyY3m6MisHwmEHZxndakULq4rIEpuc=;
        b=JCee7g6OG9+4bweqR5aGATiwCA3e/cWEATDyxZar3AWX+mfuet8p4InLbwToRYS1fY
         D73O6sap0Cc1+YXgtQW63ytieUYaFWsd+uDb2lQZUI5OTKRk8HqTLa+J+raA5NYB4u9e
         5fVPdS0GVbuykzouDvQYecqhhyj3UErHMVYoh7f8uymGRiYEq+VW2k19OXwyLU4Aqo+0
         9YF3F7H8XtGQjtTyxTu+5n6Rw70qE2Lda5ib6J6Jfsi6nqV+ZjjPy8N2Zprtml9brWz5
         Ihs2h8NYnZQPaCRMP6fgfhnXeNkF7Zr3zIgQXSPCs/GYvuLbTskd4+U+ryYJH5cMyikq
         F4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OrZSsFgz8YSYCzyY3m6MisHwmEHZxndakULq4rIEpuc=;
        b=qA9bMcRiJEkdlZ1523UaR30z3qFLKyasZA0gWG2aKvQ1GYpm4bT2ecVREq3Baz+aNi
         lhgiUYD4jwBzO3exoh06PNhTzc++Qi3ybvj4AB8/DoRQIX+jYgGn/9XNX5pZzO41O85g
         dDw8m/nl8i4sFIRjg6IzjrnBYSG5dXkAxZIMEV85TkMgFkmZwpRiJ5zMRYTx1t13cZAX
         3DR2Zj83A9jaOVxcroF3XoOyIKJIzUfp0U5Mw0ugH+qWHkfudN47dV/8PAyrsZDckRQf
         G1ZVCmEShRX+68xCqbZQrb4XUfJGK6Y2dkI/nCVakOcXHVyT+dPzbTawN8VlkNiRNB4o
         U7Xg==
X-Gm-Message-State: APjAAAVU0yiz28iWt5P+BlBAO9+PAWNca4oAJo+GmynCFOaz2Lj7hMYH
        3B3BnENVirY0Mnso5Cfp7KRBIcZXp26fXAk1YzA=
X-Google-Smtp-Source: APXvYqwNScNpb9+1laHqvEtbkhw1hVHkR7r8t1bRUL1yfCnQpIZIhzfB4ycyD15NvFn/sqjGOeLEEeXv9dfbFrgV/iw=
X-Received: by 2002:a63:6c81:: with SMTP id h123mr4758455pgc.132.1569353593673;
 Tue, 24 Sep 2019 12:33:13 -0700 (PDT)
Date:   Tue, 24 Sep 2019 12:33:08 -0700
In-Reply-To: <CAKwvOdmFqPSyeKn-0th_ca9B3QU63G__kEJ=X0tfjhE+1_p=FQ@mail.gmail.com>
Message-Id: <20190924193310.132104-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAKwvOdmFqPSyeKn-0th_ca9B3QU63G__kEJ=X0tfjhE+1_p=FQ@mail.gmail.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v2] x86, realmode: explicitly set entry via command line
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Tri Vo <trong@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>,
        George Rimar <grimar@accesssoftek.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linking with ld.lld via $ make LD=ld.lld produces the warning:
ld.lld: warning: cannot find entry symbol _start; defaulting to 0x1000

Linking with ld.bfd shows the default entry is 0x1000:
$ readelf -h arch/x86/realmode/rm/realmode.elf | grep Entry
  Entry point address:               0x1000

While ld.lld is being pedantic, just set the entry point explicitly,
instead of depending on the implicit default.

Link: https://github.com/ClangBuiltLinux/linux/issues/216
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1 -> V2:
* Use command line flag, rather than linker script, as ld.bfd produces a
  syntax error for `ENTRY(0x1000)` but is happy with `-e 0x1000`

 arch/x86/realmode/rm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index f60501a384f9..338a00c5257f 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -46,7 +46,7 @@ $(obj)/pasyms.h: $(REALMODE_OBJS) FORCE
 targets += realmode.lds
 $(obj)/realmode.lds: $(obj)/pasyms.h
 
-LDFLAGS_realmode.elf := -m elf_i386 --emit-relocs -T
+LDFLAGS_realmode.elf := -m elf_i386 --emit-relocs -e 0x1000 -T
 CPPFLAGS_realmode.lds += -P -C -I$(objtree)/$(obj)
 
 targets += realmode.elf
-- 
2.23.0.351.gc4317032e6-goog

