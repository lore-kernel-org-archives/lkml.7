Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C56C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9020B20851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="G8UPo275"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfCIPny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 10:43:54 -0500
Received: from imap.cs.msu.ru ([188.44.42.39]:52414 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfCIPnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 10:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:
        To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lggRxzWvoqfJxyRfc5m6AD0bqLNWTNk6axPQzHT2cDg=; b=G8UPo275ParO04h5qr79vRWJ6j
        y9ofFM/t/SMasTHKeeDzvEJYc8nLv9NyppCy+S6Cx6WN1FoGPPAWf7PHLTnmSi3EGuYwY9C4mNfwz
        Zvc5IygPF7ROTzfRQ2O+FD0C31foguXCVjHqglEV3TEZqYNoSzphusdgBBhR2gaIY86GIgfxALHI8
        ZKC13kGhAOS4wDJ+WrR3/TvC/PHNZ1bNTcvc1rbRW+kXa31UjLawgU07WBFJ5gtsNfoPCHX+lTqkS
        8j1+M3XEuK4+chL0uGHWyVxD7BAI4wlyYyN8jBteVpbb8RvFDt+sHQoU38FCrinZkvOpeThJmShq7
        ThxxtUwg==;
Received: from [37.204.119.143] (port=44904 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1h2e8Q-000IDA-Ni; Sat, 09 Mar 2019 18:43:38 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arseny Maslennikov <ar@cs.msu.ru>,
        Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>
Date:   Sat,  9 Mar 2019 18:43:05 +0300
Message-Id: <20190309154307.23039-1-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH v2 1/3] scripts/package/Makefile: put proper config in source tarball
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is widely known that one can build a kernel without a .config in the
source tree by setting KCONFIG_CONFIG equal to the actual configuration
file path.

When making a *-pkg target, make(1) prepares a source tarball and tries
to pack `.config' in there regardless of the value of KCONFIG_CONFIG,
failing spectacularly if .config is absent and packing the wrong config
if it exists.
Let's fix that by including whatever KCONFIG_CONFIG points to in the
archive under the traditional name `.config'.

We have to pass --absolute-names to tar, since it seems to trim the
paths of archive members first and only then consider --transform, which
breaks KCONFIG_CONFIG=../../some.config, as well as absolute paths.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 scripts/package/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index 2c6de21e5152..134cefee068d 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -27,7 +27,7 @@ KDEB_SOURCENAME ?= linux-$(KERNELRELEASE)
 KBUILD_PKG_ROOTCMD ?="fakeroot -u"
 export KDEB_SOURCENAME
 # Include only those top-level files that are needed by make, plus the GPL copy
-TAR_CONTENT := $(KBUILD_ALLDIRS) .config .scmversion Makefile \
+TAR_CONTENT := $(KBUILD_ALLDIRS) $(KCONFIG_CONFIG) .scmversion Makefile \
                Kbuild Kconfig COPYING $(wildcard localversion*)
 MKSPEC     := $(srctree)/scripts/package/mkspec
 
@@ -44,6 +44,7 @@ if test "$(objtree)" != "$(srctree)"; then \
 fi ; \
 $(srctree)/scripts/setlocalversion --save-scmversion; \
 tar -cz $(RCS_TAR_IGNORE) -f $(2).tar.gz \
+	--absolute-names --transform 's:^$(KCONFIG_CONFIG)$$:.config:S' \
 	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3); \
 rm -f $(objtree)/.scmversion
 
-- 
2.20.1

