Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9D3C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9030A206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ky+rtDEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfHUHCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:02:16 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:35706 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfHUHCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:02:16 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x7L727v9010350;
        Wed, 21 Aug 2019 16:02:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x7L727v9010350
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566370927;
        bh=Z7gvvNxo+7LVHLVYFSIPDzEWxjAUzSyIAekpVsmRCAg=;
        h=From:To:Cc:Subject:Date:From;
        b=ky+rtDEX3RZk30Dv08vN0ByKpuhHdlvg+4bh3aO2dtvjc0ezCSDp+CmB1B9FoHOb8
         ZH7ndb4faWzZFYx3c9csb/0oZzZcMpAfyGFKmVLCU07H20Bs+5RBxiO64sXAcmvg6r
         Q4smtMUPGzvSYAwdvjEQquvor7KG3Wc37LFrwyOBxIj/ZG8Tl7zeRtbwfPxpd1SxDo
         r5R7TNAErV7yhXaCUcizgeR3qHvri3TkkBCkNFJiFwH5mEX+QrsKq2Nkzl7afDgTMY
         V6RZ5C4F4txePGIUmc2HElByEa2kiT6jeYYwUdT18EfHcJDIHJ8jhv2T4BSexG1DwA
         ey7QblAaDu4Ig==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] kbuild: pkg: clean up package files/dirs from the top Makefile
Date:   Wed, 21 Aug 2019 16:02:02 +0900
Message-Id: <20190821070205.8297-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am not a big fan of the $(objtree)/ hack for clean-files/clean-dirs.

These are created in the top of $(objtree), so let's clean them up
from the top Makefile.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                 | 6 ++++--
 scripts/Makefile         | 2 +-
 scripts/package/Makefile | 9 ---------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index 5d202ad1481a..e88d4fcd5e87 100644
--- a/Makefile
+++ b/Makefile
@@ -1389,12 +1389,14 @@ CLEAN_FILES += modules.builtin.modinfo
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated          \
-		  arch/$(SRCARCH)/include/generated .tmp_objdiff
+		  arch/$(SRCARCH)/include/generated .tmp_objdiff \
+		  debian/ snap/ tar-install/
 MRPROPER_FILES += .config .config.old .version \
 		  Module.symvers \
 		  signing_key.pem signing_key.priv signing_key.x509	\
 		  x509.genkey extra_certificates signing_key.x509.keyid	\
-		  signing_key.x509.signer vmlinux-gdb.py
+		  signing_key.x509.signer vmlinux-gdb.py \
+		  *.spec
 
 # Directories & files removed with 'make distclean'
 DISTCLEAN_DIRS  +=
diff --git a/scripts/Makefile b/scripts/Makefile
index 16bcb8087899..c42891e10ba3 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -36,4 +36,4 @@ subdir-$(CONFIG_MODVERSIONS) += genksyms
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
 
 # Let clean descend into subdirs
-subdir-	+= basic dtc gdb kconfig mod package
+subdir-	+= basic dtc gdb kconfig mod
diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index ca7f46b562a4..a2d8830f54be 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -65,8 +65,6 @@ binrpm-pkg: FORCE
 	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
 		$(UTS_MACHINE) -bb $(objtree)/binkernel.spec
 
-clean-files += $(objtree)/*.spec
-
 deb-pkg: FORCE
 	$(MAKE) clean
 	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
@@ -82,8 +80,6 @@ bindeb-pkg: FORCE
 intdeb-pkg: FORCE
 	+$(CONFIG_SHELL) $(srctree)/scripts/package/builddeb
 
-clean-dirs += $(objtree)/debian/
-
 # snap-pkg
 # ---------------------------------------------------------------------------
 snap-pkg: FORCE
@@ -98,17 +94,12 @@ snap-pkg: FORCE
 	cd $(objtree)/snap && \
 	snapcraft --target-arch=$(UTS_MACHINE)
 
-clean-dirs += $(objtree)/snap/
-
 # tarball targets
 # ---------------------------------------------------------------------------
 tar%pkg: FORCE
 	$(MAKE) -f $(srctree)/Makefile
 	+$(CONFIG_SHELL) $(srctree)/scripts/package/buildtar $@
 
-clean-dirs += $(objtree)/tar-install/
-
-
 # perf-pkg - generate a source tarball with perf source
 # ---------------------------------------------------------------------------
 
-- 
2.17.1

