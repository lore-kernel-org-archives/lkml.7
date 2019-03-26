Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33EFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10522070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbfCZRsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:48:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfCZRsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:48:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3A4288318;
        Tue, 26 Mar 2019 17:48:52 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-253.rdu2.redhat.com [10.10.120.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BB86176B1;
        Tue, 26 Mar 2019 17:48:52 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Rolf Eike Beer <eb@emlix.com>
Subject: [PATCH] objtool: Query pkg-config for libelf location
Date:   Tue, 26 Mar 2019 12:48:39 -0500
Message-Id: <91a25e992566a7968fedc89ec80e7f4c83ad0548.1553622500.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 26 Mar 2019 17:48:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rolf Eike Beer <eb@emlix.com>

If it is not in the default location, compilation would fail at several
points.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 Makefile               | 4 +++-
 tools/objtool/Makefile | 7 +++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 99c0530489ef..32caf30e0d79 100644
--- a/Makefile
+++ b/Makefile
@@ -950,9 +950,11 @@ mod_sign_cmd = true
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
index c9d038f91af6..53f8be0f4a1f 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -25,14 +25,17 @@ LIBSUBCMD		= $(LIBSUBCMD_OUTPUT)libsubcmd.a
 OBJTOOL    := $(OUTPUT)objtool
 OBJTOOL_IN := $(OBJTOOL)-in.o
 
+LIBELF_FLAGS := $(shell pkg-config libelf --cflags 2>/dev/null)
+LIBELF_LIBS  := $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
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
2.17.2

