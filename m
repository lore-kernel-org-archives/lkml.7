Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122D4C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AC821906
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765861;
	bh=fJRIE1yXHyuEXQ+irInj0w2AxnLqI9dVf+67QWo0nfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Do2zbmQQjh0OSGYUY9qdDaJWS5C55mX6KOY7Jomyr7YS3f33ondDjJObEXs/Dwd/0
	 oZqhEYWZLNgH7ch0tiWvcTZWmOhI6uHr35UZ8R0xJ5vCz45hrp3WevZQWBN8umTo18
	 KPGkvjBulfT0h02wcRgviNbIvydnO+w0O0SaCBRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfI2OEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729533AbfI2OES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:04:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B04921835;
        Sun, 29 Sep 2019 14:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765855;
        bh=fJRIE1yXHyuEXQ+irInj0w2AxnLqI9dVf+67QWo0nfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EOnNCJM5Pa7x6aKpt4mQd4KV7uIXrw9hlWAZVN6pKyiuCce4dinEDlmcceDGeM3Bw
         qd2u9fKPttSW4sA1ZXF5HDUbD667Aq36ma5mVWpe1dRJAVx0T3f+6njvNf97ej55ec
         3Am2DC4o2opxq+lN/Rb1BV7MNhqZfR3qN2/7k2wk=
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
Subject: [PATCH 5.3 25/25] objtool: Clobber user CFLAGS variable
Date:   Sun, 29 Sep 2019 15:56:28 +0200
Message-Id: <20190929135018.391005370@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135006.127269625@linuxfoundation.org>
References: <20190929135006.127269625@linuxfoundation.org>
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
-CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
+CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:


