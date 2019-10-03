Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15629C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F3B21783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118811;
	bh=xkN8nyZz0hiPeOQuHgssCKwD5TFVPmPIchXLi/WOgfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZEbv/59jUVtHsaKUhYSIaWcWGB9xZvQLNv/fZ5NvbFDi/6kLhUYjaubo5SdLs16oz
	 ZRk/7H3/4TTVcIzAIg0xkOa9wK6Ikbwc0cDKxXUgEP0mzYcq46Bouh7VQB4esh8JHB
	 0chtgOGzl6NFhnUBeFoRtRRk0dZtHwlPV081I5zU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732843AbfJCQGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732827AbfJCQGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:06:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89F2F20865;
        Thu,  3 Oct 2019 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118807;
        bh=xkN8nyZz0hiPeOQuHgssCKwD5TFVPmPIchXLi/WOgfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VnC5zzDcFhJYeHUcUU0GZP/fxoJFyJuZmln8m3d2axs7CCd/k+jPKE+LDRg3VXP1m
         QOCaz/6PQWehI17A5bFesPvQPBdK1Yk9pLlOLC9T4kxcnFhib9XnbEYrvw5YI5w3JE
         wBQSQWa75gTZ5pYimjwTxPMhh/YsbAIqSnq/S78M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.14 017/185] objtool: Clobber user CFLAGS variable
Date:   Thu,  3 Oct 2019 17:51:35 +0200
Message-Id: <20191003154441.396821940@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit f73b3cc39c84220e6dccd463b5c8279b03514646 upstream.

If the build user has the CFLAGS variable set in their environment,
objtool blindly appends to it, which can cause unexpected behavior.

Clobber CFLAGS to ensure consistent objtool compilation behavior.

Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Tested-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/83a276df209962e6058fcb6c615eef9d401c21bc.1567121311.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
CC: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -35,7 +35,7 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
-CFLAGS   += -Wall -Werror $(WARNINGS) -fomit-frame-pointer -O2 -g $(INCLUDES) $(LIBELF_FLAGS)
+CFLAGS   := -Wall -Werror $(WARNINGS) -fomit-frame-pointer -O2 -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD)
 
 # Allow old libelf to be used:


