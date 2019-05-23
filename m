Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E407BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8002187F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558638596;
	bh=GoC1OIA003h0+CxziUkA4dOZlYYlol8sXKPimKJOX4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uz7rsElov7Jkj/38YPTx3xv0kSHNs1/GB82QyL6LgIIdh2k9/p1nR5nqWuQ0YdI8P
	 vbQPy4Uyw3v4ROiXuq5lh8cRgwAmfkXzJxF2gwEb2HeIiS7hUs9NRIisX/bfH9lti9
	 OPF1xb9rp4xMckKpH7k29TqGHDtmD2UzzeeFGYB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbfEWTJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:09:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387557AbfEWTJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:09:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA21E2184B;
        Thu, 23 May 2019 19:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638592;
        bh=GoC1OIA003h0+CxziUkA4dOZlYYlol8sXKPimKJOX4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZV3K26vB22rWPJJhbRp9yY1Spqa2dn9RRECM/eLqKsI7BWJNIShSFVyzlLK5xJsUh
         kfJyNmf5EIGZwOPOTGz8NNaH/BnATnrzOhN0mEM38NC9v3ge+Q+6NiGsSnO8dgflgo
         hGstUC0MigGp54lQVPDxXCi/7srkQSh0gM6NyVWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 29/53] objtool: Allow AR to be overridden with HOSTAR
Date:   Thu, 23 May 2019 21:05:53 +0200
Message-Id: <20190523181715.421061869@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181710.981455400@linuxfoundation.org>
References: <20190523181710.981455400@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit 8ea58f1e8b11cca3087b294779bf5959bf89cc10 upstream.

Currently, this Makefile hardcodes GNU ar, meaning that if it is not
available, there is no way to supply a different one and the build will
fail.

  $ make AR=llvm-ar CC=clang LD=ld.lld HOSTAR=llvm-ar HOSTCC=clang \
         HOSTLD=ld.lld HOSTLDFLAGS=-fuse-ld=lld defconfig modules_prepare
  ...
    AR       /out/tools/objtool/libsubcmd.a
  /bin/sh: 1: ar: not found
  ...

Follow the logic of HOST{CC,LD} and allow the user to specify a
different ar tool via HOSTAR (which is used elsewhere in other
tools/ Makefiles).

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: <stable@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/80822a9353926c38fd7a152991c6292491a9d0e8.1558028966.git.jpoimboe@redhat.com
Link: https://github.com/ClangBuiltLinux/linux/issues/481
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -7,11 +7,12 @@ ARCH := x86
 endif
 
 # always use the host compiler
+HOSTAR	?= ar
 HOSTCC	?= gcc
 HOSTLD	?= ld
+AR	 = $(HOSTAR)
 CC	 = $(HOSTCC)
 LD	 = $(HOSTLD)
-AR	 = ar
 
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))


