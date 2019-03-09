Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3320C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6BD20836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="OEyIdflY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfCIPnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 10:43:49 -0500
Received: from imap.cs.msu.ru ([188.44.42.39]:50712 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfCIPns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 10:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a2A+taKjoNPZbH6GRbsyFcp2CMYguJDwXGJstd7lijw=; b=OEyIdflYbiyZxB73Lh8/4b+3F3
        w++BzTM8I2WmfH5r41P0dZ9smV9ViXp8OzBGtuBU62AYnM48qLOx1hcAlfub/G9cD2CmBRDeZeb8t
        NoVbRgdS+JUQmGhRpusjfqfRcVeQ+EXn6NedmNRHn7UCyreDyQcQmEuinONWJS47EydU7mvKa43r2
        9ryVfjBeyONQaxWXdw04SLFY2QCe0y1DIGbOBUF5CvsU3tj4ZmorYYR/EbP8dUZmtjTUzc19PMXXY
        i2OEH+0kwbkm73RTxmhKufRrL46g28jJ6cjTt7Hrudo+k1+jYPbLZi5CFqF2mNvo4l/YViUrR1rKE
        PhMW2zEw==;
Received: from [37.204.119.143] (port=44904 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1h2e8T-000IDA-NA; Sat, 09 Mar 2019 18:43:41 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arseny Maslennikov <ar@cs.msu.ru>,
        Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>
Date:   Sat,  9 Mar 2019 18:43:07 +0300
Message-Id: <20190309154307.23039-3-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190309154307.23039-1-ar@cs.msu.ru>
References: <20190309154307.23039-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH v2 3/3] package: {mkdebian,Makefile}: ignore .config in dpkg-source diffs
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* We'd like to make dpkg-source ignore certain filepath patterns while
  producing the .diff.gz as part of a Debian source package.
  The relationship between dpkg-source's -i and --extend-diff-ignore
  options is quite complicated[1]. It's thus not very convenient to
  specify file path patterns to ignore on dpkg-buildpackage's command
  line (they do not end up in the source package as well), so we turn
  `-i.git' into a record in debian/source/options.
  Besides, the dot in `-i.git' is a metacharacter and matches a tad
  too much.

* In cases where a .config exists in the source tree, but the .config
  in the source tarball is provided by wherever KCONFIG_CONFIG pointed
  to, dpkg-source would attempt to replace the second, proper one with
  the first one, which is undesirable and nullifies the effort made
  to put the proper config in the source tarball.
  To prevent this, force dpkg-source to ignore /^[.]config$/ as well.

This makes it possible to build working Debian source packages with a
redefined KCONFIG_CONFIG:
 - that file is put in the source tarball at its traditional place,
   and the diff.gz does not dare touch it;
 - when the source package is rebuilt, debian/rules initiates the build
   process with the desired config already in the standard location.

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=625789#22

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 scripts/package/Makefile | 2 +-
 scripts/package/mkdebian | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index 134cefee068d..f2fca7e7d9fa 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -73,7 +73,7 @@ deb-pkg: FORCE
 	$(call cmd,src_tar,$(KDEB_SOURCENAME))
 	origversion=$$(dpkg-parsechangelog -SVersion |sed 's/-[^-]*$$//');\
 		mv $(KDEB_SOURCENAME).tar.gz ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
-	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) -i.git -us -uc
+	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) -us -uc
 
 bindeb-pkg: FORCE
 	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index d276eb671a27..74158c7f28ea 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -135,6 +135,12 @@ fi
 mkdir -p debian/source/
 echo "1.0" > debian/source/format
 
+cat <<EOF > debian/source/options
+# The regexes are matched against paths from the source tree.
+diff-ignore = "[.]git"
+extend-diff-ignore = "^[.]config$"
+EOF
+
 echo $debarch > debian/arch
 
 # Generate a simple changelog template
-- 
2.20.1

