Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895ADC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E03C206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZlF5mMCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfHUHCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:02:23 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:35875 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbfHUHCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:02:20 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x7L727vA010350;
        Wed, 21 Aug 2019 16:02:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x7L727vA010350
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566370928;
        bh=+clSVecoKH2g25vlDLqxPHel4AoAmLlsWAj659naMc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZlF5mMCucHptFuOC2iNrbVpnU9EjmYxjDnCd1Kezt2jBAxVUpp6+bZmA1a+0mE0CZ
         Zf2/JKR36Ec8Ss6S7yCraGKNASZju5zFZNjXRUwDw0sbfW6njnfeYpL19SnE/Rfgs4
         LHJ3Uk9uGbZX1woevT6xZoE7Mku7jM2BNWeefpY+uAz7QfDmG2xQBYR6dynYxMGbhe
         LpANOf9+wsXZk/Kn8pCzdwvR2eFwIu9Pd3CBaSb6xxhS+6IXfvTmOl/mpfpaZwRB3Q
         FuDJC6kNh9o8e+2GzT1qFs/Vw5gE3SqmNiI982PAZI0r9u6+ZUUucDKO0FDX9j7TuR
         8Eaq0AHZdoRJg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] kbuild: pkg: add package targets to PHONY instead of FORCE
Date:   Wed, 21 Aug 2019 16:02:03 +0900
Message-Id: <20190821070205.8297-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821070205.8297-1-yamada.masahiro@socionext.com>
References: <20190821070205.8297-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are not real targets. Adding them to PHONY is preferred.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/package/Makefile | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index a2d8830f54be..407189d9942a 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -50,7 +50,8 @@ rm -f $(objtree)/.scmversion
 
 # rpm-pkg
 # ---------------------------------------------------------------------------
-rpm-pkg: FORCE
+PHONY += rpm-pkg
+rpm-pkg:
 	$(MAKE) clean
 	$(CONFIG_SHELL) $(MKSPEC) >$(objtree)/kernel.spec
 	$(call cmd,src_tar,$(KERNELPATH),kernel.spec)
@@ -59,13 +60,15 @@ rpm-pkg: FORCE
 
 # binrpm-pkg
 # ---------------------------------------------------------------------------
-binrpm-pkg: FORCE
+PHONY += binrpm-pkg
+binrpm-pkg:
 	$(MAKE) -f $(srctree)/Makefile
 	$(CONFIG_SHELL) $(MKSPEC) prebuilt > $(objtree)/binkernel.spec
 	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
 		$(UTS_MACHINE) -bb $(objtree)/binkernel.spec
 
-deb-pkg: FORCE
+PHONY += deb-pkg
+deb-pkg:
 	$(MAKE) clean
 	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
 	$(call cmd,src_tar,$(KDEB_SOURCENAME))
@@ -73,16 +76,19 @@ deb-pkg: FORCE
 		mv $(KDEB_SOURCENAME).tar.gz ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
 	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) -i.git -us -uc
 
-bindeb-pkg: FORCE
+PHONY += bindeb-pkg
+bindeb-pkg:
 	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
 	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) -b -nc -uc
 
-intdeb-pkg: FORCE
+PHONY += intdeb-pkg
+intdeb-pkg:
 	+$(CONFIG_SHELL) $(srctree)/scripts/package/builddeb
 
 # snap-pkg
 # ---------------------------------------------------------------------------
-snap-pkg: FORCE
+PHONY += snap-pkg
+snap-pkg:
 	rm -rf $(objtree)/snap
 	mkdir $(objtree)/snap
 	$(MAKE) clean
@@ -96,7 +102,9 @@ snap-pkg: FORCE
 
 # tarball targets
 # ---------------------------------------------------------------------------
-tar%pkg: FORCE
+tar-pkgs := tar-pkg targz-pkg tarbz2-pkg tarxz-pkg
+PHONY += $(tar-pkgs)
+$(tar-pkgs):
 	$(MAKE) -f $(srctree)/Makefile
 	+$(CONFIG_SHELL) $(srctree)/scripts/package/buildtar $@
 
@@ -124,12 +132,15 @@ $(if $(findstring xz,$@),xz,                                        \
 $(error unknown target $@))))                                       \
 	-f -9 $(perf-tar).tar)
 
-perf-%pkg: FORCE
+perf-tar-pkgs := perf-tar-src-pkg perf-targz-src-pkg perf-tarbz2-src-pkg perf-tarxz-src-pkg
+PHONY += $(perf-tar-pkgs)
+$(perf-tar-pkgs):
 	$(call cmd,perf_tar)
 
 # Help text displayed when executing 'make help'
 # ---------------------------------------------------------------------------
-help: FORCE
+PHONY += help
+help:
 	@echo '  rpm-pkg             - Build both source and binary RPM kernel packages'
 	@echo '  binrpm-pkg          - Build only the binary kernel RPM package'
 	@echo '  deb-pkg             - Build both source and binary deb kernel packages'
-- 
2.17.1

