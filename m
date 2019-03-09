Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D644EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 13:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ED92081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 13:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="Yp+z3vAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfCINND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 08:13:03 -0500
Received: from imap.cs.msu.ru ([188.44.42.39]:57027 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfCINNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 08:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:
        To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vcEDE23bKhWAiKV28m244/+iGAXIF72vhhMUUDwx3gU=; b=Yp+z3vAsRy1PGWN3Ntp0sjjseB
        xOcQYOlWSGrrp/y6Gij+cs9B5zbN85/fDT/DKsHJFVLVUm4x/pRCtpefrrNhjnH6Ofa/Ljky5h7yv
        v/2ikTr74qUPGUu8Dgep9rMUJsvfI3p4M9MQMxsUiHbZFVNWmvWK/7BEFd+2Pgg4K8NUg4BNpYp8a
        g35Az8nN/8y2qmh+yNilfwbSyUGP9P69erj9aM3hehJg4HcO+JzIl+/C7i25vfQwdTI7SMGUj4nAv
        J9UuG58FcHcxHRh9JjJlrILUWKjkb9d9lP1OZw1fzw9BVBe4KTgWdScAANlf9nBtqeZzBjJwfxfNf
        j97Cthnw==;
Received: from [37.204.119.143] (port=43958 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1h2bmc-000BSC-FH; Sat, 09 Mar 2019 16:12:58 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arseny Maslennikov <ar@cs.msu.ru>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Sat,  9 Mar 2019 16:12:35 +0300
Message-Id: <20190309131235.31823-1-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH] scripts/kconfig/Makefile: kvmconfig: use KCONFIG_CONFIG if set
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a kernel source tree:

% make mrproper
% make KCONFIG_CONFIG=.myconfig kvmconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/preprocess.o
  LEX     scripts/kconfig/zconf.lex.c
  YACC    scripts/kconfig/zconf.tab.h
  HOSTCC  scripts/kconfig/zconf.lex.o
  YACC    scripts/kconfig/zconf.tab.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
The base file '.config' does not exist.  Exit.
make[1]: *** [scripts/kconfig/Makefile:96: kvm_guest.config] Error 1
make: *** [Makefile:538: kvmconfig] Error 2

Essentially `make kvmconfig' (and probably other similar targets)
did ignore KCONFIG_CONFIG set to a different filename.

If KCONFIG_CONFIG is set, use it; otherwise behave as if it was set
to `.config'.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
---
 scripts/kconfig/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 181973509a05..1c7ac07def4d 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -93,7 +93,7 @@ configfiles=$(wildcard $(srctree)/kernel/configs/$@ $(srctree)/arch/$(SRCARCH)/c
 
 %.config: $(obj)/conf
 	$(if $(call configfiles),, $(error No configuration exists for this target on this architecture))
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m .config $(configfiles)
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m $(KCONFIG_CONFIG) $(configfiles)
 	+$(Q)yes "" | $(MAKE) -f $(srctree)/Makefile oldconfig
 
 PHONY += kvmconfig
-- 
2.20.1

