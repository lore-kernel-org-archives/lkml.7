Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88AAC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C922173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfH2X3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:29:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfH2X3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 19:29:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1872E3C93;
        Thu, 29 Aug 2019 23:29:06 +0000 (UTC)
Received: from treble.redhat.com (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5476C60635;
        Thu, 29 Aug 2019 23:29:05 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
Subject: [PATCH] objtool: Clobber user CFLAGS variable
Date:   Thu, 29 Aug 2019 18:28:49 -0500
Message-Id: <83a276df209962e6058fcb6c615eef9d401c21bc.1567121311.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 29 Aug 2019 23:29:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the build user has the CFLAGS variable set in their environment,
objtool blindly appends to it, which can cause unexpected behavior.

Clobber CFLAGS to ensure consistent objtool compilation behavior.

Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Tested-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 88158239622b..20f67fcf378d 100644
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
-- 
2.20.1

