Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B000EC10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890302186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbfDELdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:33:23 -0400
Received: from wp260.webpack.hosteurope.de ([80.237.133.29]:48974 "EHLO
        wp260.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730761AbfDELdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:33:23 -0400
X-Greylist: delayed 1866 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Apr 2019 07:33:22 EDT
Received: from hsi-kbw-46-223-87-231.hsi.kabel-badenwuerttemberg.de ([46.223.87.231] helo=vega.skynet.aixah.de); authenticated
        by wp260.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1hCMbr-00057I-Ch; Fri, 05 Apr 2019 13:02:11 +0200
Received: by vega.skynet.aixah.de (Postfix, from userid 1000)
        id 9BA86E5352; Fri,  5 Apr 2019 13:02:10 +0200 (CEST)
From:   Luis Ressel <aranea@aixah.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Luis Ressel <aranea@aixah.de>, stable@vger.kernel.org
Subject: [PATCH] objtool: Don't use -Werror
Date:   Fri,  5 Apr 2019 13:01:50 +0200
Message-Id: <20190405110151.2461-1-aranea@aixah.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;aranea@aixah.de;1554464002;889bf956;
X-HE-SMSGID: 1hCMbr-00057I-Ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-Werror can be handy for development, but enabling it for production
builds is a bad idea -- other compilers might produce unexpected
warnings, or #included library headers might trigger warnings.

In my case, libelf's (not elfutil's!) headers trigger several -Wundef
warnings. This wasn't a problem before 056d28d135bc, since gcc doesn't
emit warnings for system headers, but now that there's a
-I/usr/include/libelf/ in the gcc command line, those warnings appear
and break the build.

CC'ing stable@ since 056d28d135bc has also been included in stable
versions.

Fixes: 056d28d135bc ("objtool: Query pkg-config for libelf location")
Signed-off-by: Luis Ressel <aranea@aixah.de>
Cc: stable@vger.kernel.org
---
 tools/objtool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 53f8be0f4a1f..ad2c11a881db 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -34,7 +34,7 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
-CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
+CFLAGS   += $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:
-- 
2.21.0

