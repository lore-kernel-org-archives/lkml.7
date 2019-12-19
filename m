Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B960C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B2824672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780616;
	bh=Ry25ZJNwSjwRt9dR556q7Qn9xzg36UfXvQGRWDhy/jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rY4FSthrumECRr014GJrcC5do+jgddMFAqRe0G/StbJPGy0FqQ/DsWPJ0ScoNSzUZ
	 JO/hxVonOULv6Zvot/pd09eHplAo9ZTf2vHVEOpqiE7VtV+k33IHxZBVoLQtObo4ND
	 d01zTy8lbXlO4qsHnz1OZffhG5y3JnwwR0z7G97I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfLSSgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbfLSSgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:36:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 459CD24679;
        Thu, 19 Dec 2019 18:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780610;
        bh=Ry25ZJNwSjwRt9dR556q7Qn9xzg36UfXvQGRWDhy/jM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z6b0IQ89qfoNWKmnxl4QVaLdV+A3euAPJmbweoIwSWGseI78IBTvDJGeh8AFHOi/V
         PJWs69MIv4xDE6Zs3B6zfgHCZ/qcgS6Jw7M/j5jdy62AVZhM5y+wL57fOQv+TBQjQQ
         GTGH8ZyBFUHDEykhxJvQlywdKB/4/6+7zZVz2BgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 045/162] kbuild: fix single target build for external module
Date:   Thu, 19 Dec 2019 19:32:33 +0100
Message-Id: <20191219183210.650928864@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit e07db28eea38ed4e332b3a89f3995c86b713cb5b ]

Building a single target in an external module fails due to missing
.tmp_versions directory.

For example,

  $ make -C /lib/modules/$(uname -r)/build M=$PWD foo.o

will fail in the following way:

  CC [M]  /home/masahiro/foo/foo.o
/bin/sh: 1: cannot create /home/masahiro/foo/.tmp_versions/foo.mod: Directory nonexistent

This is because $(cmd_crmodverdir) is executed only before building
/, %/, %.ko single targets of external modules. Create .tmp_versions
in the 'prepare' target.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index eb4f5b889a1cc..42102ffb9eff8 100644
--- a/Makefile
+++ b/Makefile
@@ -1424,9 +1424,6 @@ else # KBUILD_EXTMOD
 
 # We are always building modules
 KBUILD_MODULES := 1
-PHONY += crmodverdir
-crmodverdir:
-	$(cmd_crmodverdir)
 
 PHONY += $(objtree)/Module.symvers
 $(objtree)/Module.symvers:
@@ -1438,7 +1435,7 @@ $(objtree)/Module.symvers:
 
 module-dirs := $(addprefix _module_,$(KBUILD_EXTMOD))
 PHONY += $(module-dirs) modules
-$(module-dirs): crmodverdir $(objtree)/Module.symvers
+$(module-dirs): prepare $(objtree)/Module.symvers
 	$(Q)$(MAKE) $(build)=$(patsubst _module_%,%,$@)
 
 modules: $(module-dirs)
@@ -1478,7 +1475,8 @@ help:
 
 # Dummies...
 PHONY += prepare scripts
-prepare: ;
+prepare:
+	$(cmd_crmodverdir)
 scripts: ;
 endif # KBUILD_EXTMOD
 
@@ -1602,17 +1600,14 @@ endif
 
 # Modules
 /: prepare scripts FORCE
-	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
 	$(build)=$(build-dir)
 # Make sure the latest headers are built for Documentation
 Documentation/: headers_install
 %/: prepare scripts FORCE
-	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
 	$(build)=$(build-dir)
 %.ko: prepare scripts FORCE
-	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
 	$(build)=$(build-dir) $(@:.ko=.o)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
-- 
2.20.1



