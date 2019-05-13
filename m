Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93578C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C6720862
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfaNmFL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEMWVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:21:34 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50650 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfEMWVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:21:34 -0400
Received: by mail-pl1-f202.google.com with SMTP id o12so2628660pll.17
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AuVjfNBr2+kooUNC4DV3ysuf+Fv6Qzi5cBLNqdsxq6Q=;
        b=bfaNmFL2Ng8OQj0f4CqDD0zd8RaArpJFv4J+IvkwUv+1gNtB0NXngyn4Fh1R14Qic+
         0VGL3bypDi8JEBGYm2jdydCa8HXXrwi5DO1YfGS8+YV5vwpAhVEKagIWTo0K0eD+oy0z
         QwUvD6PVGn1lwnpkHosMPqP20//eLc4I8e3vAR9kkppKk93sIfd7czXmQ1edFmZJh3Om
         b856unadmKUCwxCPG0s0XrEP2gSHIyRoQnkjDvzY85tmJ9uRs3MNjpJg4q+SSo92GYwB
         s+pX3khqV78K8zAOpkcCJPhXFiJuzAN8y3hEoYbVJZyX9R/bLGjTHA5vwjg9bTi5cZUF
         5rPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AuVjfNBr2+kooUNC4DV3ysuf+Fv6Qzi5cBLNqdsxq6Q=;
        b=Mnr6ebsjFfxJFkyYJRzWLZVxXp3wEQoIYbCvBPQo5H6sYjtSSTsk2hny6N6qc8+KFV
         0GVqYg4Yvc7+4FaxUl15FEPMj3tIAt1gFDOLD7YsobGhbJVvpoNF78wPOPvhy0C3l/70
         mtpdXWH+YcPktTs/aHKIkMg3dWXijMxcDcOvRSiT4CxEjJBmG/j9n4Wwt5fSwZlVVdGH
         0sruQoZfeQ7PfOJlXGIVdYiRS5zND20LQwwflO1rwHAiCp+t4QtRIH3s6nlFZiQQCR4d
         3h7/VyVpdf6U+gerym3wC03iwxtdlWOjDdvUMerlsQcOAUbIF95JoPpN9aDf219ot/KJ
         YzOQ==
X-Gm-Message-State: APjAAAVF0YYljcY7ARx6jR9hC4y8Fd6yNFqkABsrSqBQLQoo9iCA8wlQ
        c5zEQYJV4cqtawwUcdR93B+aIlh9Y/dticVNKQc=
X-Google-Smtp-Source: APXvYqw163IvdCTLo0CWBq7o4d4mp6620q+0DJWXVn76HOBNG6bnV+HRhrnfUEb8GU5yYXepvLVUcPIewlCrU8FpCx8=
X-Received: by 2002:a63:a55:: with SMTP id z21mr34502680pgk.440.1557786093072;
 Mon, 13 May 2019 15:21:33 -0700 (PDT)
Date:   Mon, 13 May 2019 15:21:09 -0700
Message-Id: <20190513222109.110020-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH] lkdtm: support llvm-objcopy
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     keescook@chromium.org
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathanchance@gmail.com>,
        Jordan Rupprect <rupprecht@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
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
via --rename-section.

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

Which shows in the Flags field that .text is now renamed .rodata, the
append flag A is set, and the section is not flagged as writeable W.

Link: https://github.com/ClangBuiltLinux/linux/issues/448
Reported-by: Nathan Chancellor <nathanchance@gmail.com>
Suggested-by: Jordan Rupprect <rupprecht@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/misc/lkdtm/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 951c984de61a..89dee2a9d88c 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -15,8 +15,7 @@ KCOV_INSTRUMENT_rodata.o	:= n
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
-			--set-section-flags .text=alloc,readonly \
-			--rename-section .text=.rodata
+			--rename-section .text=.rodata,alloc,readonly
 targets += rodata.o rodata_objcopy.o
 $(obj)/rodata_objcopy.o: $(obj)/rodata.o FORCE
 	$(call if_changed,objcopy)
-- 
2.21.0.1020.gf2820cf01a-goog

