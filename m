Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190C4C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BE7208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934706;
	bh=b30BjwC86bSBzRsL0WzOkPFpGQCDV3H1PobzYZ/QOtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GlHoT1I9xnWTj3h6T/rvsME2sbaFSAM2RwVf1TMTx25BmnkFiE4cZ26k9TohAL0eQ
	 nKiYjN7X7x12dM0pZLnLCvkMqlGRBvXox0ekPc9sHGQHINEpw6/h0XML+CF57OnE9H
	 wHOi73GvibxsImHEiNEcuoSrG4sDspM+tzc0itMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfGLMbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729356AbfGLMbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:31:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25347208E4;
        Fri, 12 Jul 2019 12:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934701;
        bh=b30BjwC86bSBzRsL0WzOkPFpGQCDV3H1PobzYZ/QOtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VAyvRIPHrEBLAke4ovRUlshhpe/kH4kuG3gf0zJN1clDKQyKK+ZWgwRSjHAeppryR
         X4HwkWkvydoGCsXBqIKIEsWpLrWpfyWHTUvOqlObEuWde8sVfTZYRPxwVAlRXqNwva
         Xtp5f9NxhOVEwGW3eQZ+m9/Ib+B/w4YmWHTtRKaw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alan Modra <amodra@gmail.com>,
        Jordan Rupprect <rupprecht@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 5.1 124/138] lkdtm: support llvm-objcopy
Date:   Fri, 12 Jul 2019 14:19:48 +0200
Message-Id: <20190712121633.497228796@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>

commit e9e08a07385e08f1a7f85c5d1e345c21c9564963 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/lkdtm/Makefile |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

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


