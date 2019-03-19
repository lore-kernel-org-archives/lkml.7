Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9BDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E916D20685
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfCSH3s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 03:29:48 -0400
Received: from mx1.emlix.com ([188.40.240.192]:55692 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfCSH3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 03:29:48 -0400
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Mar 2019 03:29:47 EDT
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 42CDA5F97B;
        Tue, 19 Mar 2019 08:20:12 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: query pkg-config for libelf location
Date:   Tue, 19 Mar 2019 08:20:12 +0100
Message-ID: <3381642.TeJ1gWjbju@devpool35>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If it is not in the default location compilation would fail at several points.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 Makefile               | 4 +++-
 tools/objtool/Makefile | 7 +++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 9ef547fc7ffe..666b52c1c5f4 100644
--- a/Makefile
+++ b/Makefile
@@ -940,9 +940,11 @@ mod_sign_cmd = true
 endif
 export mod_sign_cmd
 
+HOST_LIBELF_LIBS = $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
+
 ifdef CONFIG_STACK_VALIDATION
   has_libelf := $(call try-run,\
-		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -,1,0)
+		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null $(HOST_LIBELF_LIBS) -,1,0)
   ifeq ($(has_libelf),1)
     objtool_target := tools/objtool FORCE
   else
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index c9d038f91af6..0c8dd1609348 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -25,14 +25,17 @@ LIBSUBCMD		= $(LIBSUBCMD_OUTPUT)libsubcmd.a
 OBJTOOL    := $(OUTPUT)objtool
 OBJTOOL_IN := $(OBJTOOL)-in.o
 
+LIBELF_FLAGS = $(shell pkg-config libelf --cflags)
+LIBELF_LIBS = $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
+
 all: $(OBJTOOL)
 
 INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
-CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES)
-LDFLAGS  += -lelf $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
+CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
+LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:
 elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
-- 
2.21.0


-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



