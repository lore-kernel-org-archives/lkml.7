Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD61DC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928B6214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561724491;
	bh=BGryAr8Pia225g1aqO5H2+IzIU1mVLbTpsFcqhyTlNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YcdpvCzBdDKtFfauxNOybEVqFSSz/lkW+l5ZLEeWedMTgUCqTSOIV5IRKXDJipRU1
	 w8LwnOYsU1oyVXGwMWVIhWt0EZ5isaltqi1T1DDQqkdPxNoGWyatJLheV3U5dIYRNb
	 DCA8NybHG8sFSSDsJJjC/AwhZZOxqhKN6xaY5uYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfF1MU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:20:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfF1MUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iH19Eomt9tt7WC2PMNB05lbgQlaUjJpUyUxesC2gN4k=; b=qw6kQuOjP6oW2cYh6RZFkAHTRN
        7fNdQNSf2fVJPdWuY7C6RT/OVM6foUNFva9pvD+H5tECDHCjHnqY+Wm0ilYLEVul0XSs+Ecxaxsue
        YOlSO+sg+Lt5CP0Gdrv2I8Vo1XjEau+rTyz0YygNOJvUmf/9WuNNA8iBBcqAE8W/uh8CTmYk6ETWH
        dW5UFPlmJ2UhuOsVXz+LAV17vtRkuvtnqyQ87VcHl9qDsPpRp3ulm6lA5gf6dPfEKHGoBB2TJ9JAm
        p1YMB/BpVFEgx8mcS6tXOvlJDdlpqiIpBpdKJQr/D++YjIanodKkEwzh+zFRzpbEVgjeJY+udQ769
        RFMukT8A==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgprw-00009u-Vc; Fri, 28 Jun 2019 12:20:45 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgpru-0005AB-7o; Fri, 28 Jun 2019 09:20:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>
Subject: [PATCH 42/43] docs: move gcc_plugins.txt to core-api and rename to .rst
Date:   Fri, 28 Jun 2019 09:20:38 -0300
Message-Id: <bfcbd5a6cbbbdb10122b30176c3bb907bf1731fc.1561723980.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723979.git.mchehab+samsung@kernel.org>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gcc_plugins.txt file is already a ReST file. Move it
to the core-api book while renaming it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/{gcc-plugins.txt => core-api/gcc-plugins.rst} | 0
 Documentation/core-api/index.rst                            | 2 +-
 MAINTAINERS                                                 | 2 +-
 scripts/gcc-plugins/Kconfig                                 | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/{gcc-plugins.txt => core-api/gcc-plugins.rst} (100%)

diff --git a/Documentation/gcc-plugins.txt b/Documentation/core-api/gcc-plugins.rst
similarity index 100%
rename from Documentation/gcc-plugins.txt
rename to Documentation/core-api/gcc-plugins.rst
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 2466a4c51031..d1e5b95bf86d 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -35,7 +35,7 @@ Core utilities
    boot-time-mm
    memory-hotplug
    protection-keys
-
+   gcc-plugins
 
 Interfaces for kernel debugging
 ===============================
diff --git a/MAINTAINERS b/MAINTAINERS
index 2cf8abf6d48e..7ba6d174f49f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6609,7 +6609,7 @@ S:	Maintained
 F:	scripts/gcc-plugins/
 F:	scripts/gcc-plugin.sh
 F:	scripts/Makefile.gcc-plugins
-F:	Documentation/gcc-plugins.txt
+F:	Documentation/core-api/gcc-plugins.rst
 
 GASKET DRIVER FRAMEWORK
 M:	Rob Springer <rspringer@google.com>
diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index e9c677a53c74..d33de0b9f4f5 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -23,7 +23,7 @@ config GCC_PLUGINS
 	  GCC plugins are loadable modules that provide extra features to the
 	  compiler. They are useful for runtime instrumentation and static analysis.
 
-	  See Documentation/gcc-plugins.txt for details.
+	  See Documentation/core-api/gcc-plugins.rst for details.
 
 menu "GCC plugins"
 	depends on GCC_PLUGINS
-- 
2.21.0

