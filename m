Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B32C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4792084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="beu4yzHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfEOSYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:24:50 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:53642 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfEOSYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:24:49 -0400
Received: by mail-oi1-f202.google.com with SMTP id k66so309617oib.20
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N9RlwjMz1QRxFz5UTAAidlBnW72fnnEfpH4I5MZT8Og=;
        b=beu4yzHgM7U8hFeDMQJamSrdbx1zUTG5hJrkF907gvHOYtlddPWagaHORRo5BQcIbF
         N1O7KMsT1r2E8OQOMOcJcYx8L8AcMSdwZwQ9+KloSX7k5jCKb/pku9WsFNsvmk2MEeYc
         r/PuIKe5owg9FdySwwVbe+bn2d9UuAk/V3NezPDcy1I+hz7g9AwaKm6LLEFhWnuvJ2/a
         WeD5zr+wtyCr/Ly+5pgTzcCvKa4gV1ckcb84hNhvOrsPEdXxMbBg/cjtJoef07uhtfuc
         3iRI/t33KuRunBcvRaOt+SWxtRPxUdcF0H3jEEPuW0wAn4ru0Th+2ALBnBE3wEdnF3+B
         MXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N9RlwjMz1QRxFz5UTAAidlBnW72fnnEfpH4I5MZT8Og=;
        b=b8koqZ/ZsE1/aXe45zUEMyZQCVy96ybZYp1r15uNUvO60ER9aW8KfTnWNR6KB7Lkc7
         Jql8b5yW7zc5gM0+qNmuPA77M2Ht0S6PW1sioU869U+pUZPUo/R4LYEiSDtXkMc3lZIh
         cd0WnKDPXqL6RoXj4cDQZKNS95i4yit3D9tabOLY1zU5BXaRj9NR+6eiQxpMMPz/JF9U
         LQB7Z9p1+eqOCyycUUjrcOdv6YCFR2UMa3MI3rhVphRah51XgdpT2j2mMorWQG6jw/dn
         cpyyFrt6kHdGiXRHZrGdQQOXw7vcTXSaWK1adxF1UPScCE8LMJcEiRt1ZM+S9BwKUSlG
         5Qxw==
X-Gm-Message-State: APjAAAXRsaSwq0IkY6CVxPCGvt0E+4C9un+JzIv0mDLVhDl1cDn1QQim
        wrfvRt57S5OEuqIE7nyKBZ/u184Fb0KsRjDZh3E=
X-Google-Smtp-Source: APXvYqzVQclzyTRtP1W9tjHn71J0Mfp3eIqkMMAnpSq2WT679SFy1dEQsgRSRmQFcVOmkd46xnCenxCtHMxj+6jRvaI=
X-Received: by 2002:aca:c5d7:: with SMTP id v206mr7708350oif.20.1557944689033;
 Wed, 15 May 2019 11:24:49 -0700 (PDT)
Date:   Wed, 15 May 2019 11:24:41 -0700
In-Reply-To: <20190515181909.GA11401@archlinux-i9>
Message-Id: <20190515182441.30990-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190515181909.GA11401@archlinux-i9>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v3] lkdtm: support llvm-objcopy
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     gregkh@linuxfoundation.org
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alan Modra <amodra@gmail.com>,
        Jordan Rupprect <rupprecht@google.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_LKDTM=y and make OBJCOPY=llvm-objcopy, llvm-objcopy errors:
llvm-objcopy: error: --set-section-flags=.text conflicts with
--rename-section=.text=.rodata

Rather than support setting flags then renaming sections vs renaming
then setting flags, it's simpler to just change both at the same time
via --rename-section. Adding the load flag is required for GNU objcopy
to mark .rodata Type as PROGBITS after the rename.

This can be verified with:
$ readelf -S drivers/misc/lkdtm/rodata_objcopy.o
...
Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
...
  [ 1] .rodata           PROGBITS         0000000000000000  00000040
       0000000000000004  0000000000000000   A       0     0     4
...

Which shows that .text is now renamed .rodata, the alloc flag A is set,
the type is PROGBITS, and the section is not flagged as writeable W.

Cc: stable@vger.kernel.org
Link: https://sourceware.org/bugzilla/show_bug.cgi?id=24554
Link: https://github.com/ClangBuiltLinux/linux/issues/448
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Suggested-by: Alan Modra <amodra@gmail.com>
Suggested-by: Jordan Rupprect <rupprecht@google.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes from v2 -> v3:
* correct Nathan's email address and collect his reviewed by.
Changes from v1 -> v2:
* add load flag, as per Kees and Alan.
* update commit message to mention reason for load flag.
* add Kees' and Alan's suggested by.
* carry Kees' Ack.
* cc stable.

 drivers/misc/lkdtm/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 951c984de61a..fb10eafe9bde 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -15,8 +15,7 @@ KCOV_INSTRUMENT_rodata.o	:= n
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
-			--set-section-flags .text=alloc,readonly \
-			--rename-section .text=.rodata
+			--rename-section .text=.rodata,alloc,readonly,load
 targets += rodata.o rodata_objcopy.o
 $(obj)/rodata_objcopy.o: $(obj)/rodata.o FORCE
 	$(call if_changed,objcopy)
-- 
2.21.0.1020.gf2820cf01a-goog

