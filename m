Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300C3C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057DE23D1D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Z5/reEbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfFDKQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:16:00 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:39732 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfFDKP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:15:58 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x54AEC7J032511;
        Tue, 4 Jun 2019 19:14:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x54AEC7J032511
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559643266;
        bh=BnyOCSyE+CGMxDknrCFwRpFRPhO2lG/Y/shoIrbI5AY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z5/reEbeHi70KbQtAaW59xxuhoN5CJ6vi0zTzUweFozO6GDDLJBeAGOt0HbBxdGYs
         kmnBi+G4qTPRlpvorbsKGV4myGYjxSVZF9yHS55WzeKcH13aYk9/cS2UuOW+A6U6aZ
         /f5GshStK0NXon6uCqj3GinWBcgr25RsSNDCWQXKlTBZ97N9mxffeQvL3rd5WoLYGa
         izMngyoSmA5ZkdN3JvlFeOHitJlzQ4eiTJeUUasTdqPNdfAWGSchXUCFEgU0oUZFlM
         SZ9cV3kw61ijSECWdmpFdOLvbCYuVlhModjQaNe7WJUU+jGrifFNh4HnHvf6H1lo40
         4S3RsAwPlADag==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 13/15] kbuild: add support for ensuring headers are self-contained
Date:   Tue,  4 Jun 2019 19:14:07 +0900
Message-Id: <20190604101409.2078-14-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604101409.2078-1-yamada.masahiro@socionext.com>
References: <20190604101409.2078-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jani Nikula <jani.nikula@intel.com>

Sometimes it's useful to be able to explicitly ensure certain headers
remain self-contained, i.e. that they are compilable as standalone
units, by including and/or forward declaring everything they depend on.

Add special target header-test-y where individual Makefiles can add
headers to be tested if CONFIG_HEADER_TEST is enabled. This will
generate a dummy C file per header that gets built as part of extra-y.

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/kbuild/makefiles.txt |  7 +++++++
 init/Kconfig                       |  9 +++++++++
 scripts/Makefile.build             | 10 ++++++++++
 scripts/Makefile.lib               |  3 +++
 4 files changed, 29 insertions(+)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index bac301a73a86..ca4b24ec0399 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -1018,6 +1018,13 @@ When kbuild executes, the following steps are followed (roughly):
 	In this example, extra-y is used to list object files that
 	shall be built, but shall not be linked as part of built-in.a.
 
+    header-test-y
+
+	header-test-y specifies headers (*.h) in the current directory that
+	should be compile tested to ensure they are self-contained,
+	i.e. compilable as standalone units. If CONFIG_HEADER_TEST is enabled,
+	this autogenerates dummy sources to include the headers, and builds them
+	as part of extra-y.
 
 --- 6.7 Commands useful for building a boot image
 
diff --git a/init/Kconfig b/init/Kconfig
index 36894c9fb420..02d8897b91fb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -96,6 +96,15 @@ config COMPILE_TEST
 	  here. If you are a user/distributor, say N here to exclude useless
 	  drivers to be distributed.
 
+config HEADER_TEST
+	bool "Compile test headers that should be standalone compilable"
+	help
+	  Compile test headers listed in header-test-y target to ensure they are
+	  self-contained, i.e. compilable as standalone units.
+
+	  If you are a developer or tester and want to ensure the requested
+	  headers are self-contained, say Y here. Otherwise, choose N.
+
 config LOCALVERSION
 	string "Local version - append to kernel release"
 	help
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index ae9cf740633e..2b4d56483c2e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -294,6 +294,16 @@ quiet_cmd_cc_lst_c = MKLST   $@
 $(obj)/%.lst: $(src)/%.c FORCE
 	$(call if_changed_dep,cc_lst_c)
 
+# Dummy C sources for header test (header-test-y target)
+# ---------------------------------------------------------------------------
+
+quiet_cmd_header_test = HDRTEST $@
+      cmd_header_test = echo "\#include \"$(<F)\"" > $@
+
+# FIXME: would be nice to be able to limit this implicit rule to header-test-y
+$(obj)/%.header_test.c: $(src)/%.h FORCE
+	$(call if_changed,header_test)
+
 # Compile assembler sources (.S)
 # ---------------------------------------------------------------------------
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index f1f38c8cdc74..60a739a22b9c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -66,6 +66,9 @@ extra-y += $(patsubst %.dtb,%.dt.yaml, $(dtb-y))
 extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtb,%.dt.yaml, $(dtb-))
 endif
 
+# Test self-contained headers
+extra-$(CONFIG_HEADER_TEST) += $(patsubst %.h,%.header_test.o,$(header-test-y))
+
 # Add subdir path
 
 extra-y		:= $(addprefix $(obj)/,$(extra-y))
-- 
2.17.1

