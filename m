Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31766C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37AA217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121810;
	bh=otI2IVTmlUEHx5SzujlUeWeDDywAcK/C6FNbFhN8nV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SJ19R9KQLQlUyBLPQa4nCGzz1aZO/RMap+UtOHDvvK0JScIyxzfKdF1jmbuqHTkiK
	 UJF2FyokrNeG7iEN8UXwI1Bjnhaulnqkv+dL/eoNOOGB6YXT+dmPaEdBXwzGS/Mbf+
	 skz8h7rEt1CkisY15BWqoFBpM/rFYDCZbd2mVOHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfEQTgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfEQTgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:36:46 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A24821726;
        Fri, 17 May 2019 19:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121805;
        bh=otI2IVTmlUEHx5SzujlUeWeDDywAcK/C6FNbFhN8nV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iHx8MsjB53WORtY5DPAnTbCRSpK9Lc/HjY4cjqMQRsv/hUKoeM0apZn2smEG/kpjK
         4Tc9myoC6xlRqgNKhtTpMP8zmDZZpLAtahw9nk4ZzUlQ5nerQaTRvPsd0fEywEchtP
         kgUtB9G9jobXwpKVq1B294F3pUIoSbRrfE9Gcufo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/73] tools lib traceevent: Remove hard coded install paths from pkg-config file
Date:   Fri, 17 May 2019 16:35:02 -0300
Message-Id: <20190517193611.4974-5-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

Install directories of header and library files are hard coded in
pkg-config template file.

They must be configurable, the Makefile should set them on the
compilation / install stage.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190418211556.5a12adc3@oasis.local.home
Link: http://lkml.kernel.org/r/20190329144546.5819-1-tstoyanov@vmware.com
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/Makefile                  | 13 +++++++++----
 tools/lib/traceevent/libtraceevent.pc.template |  4 ++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index 941761d9923d..34cf33a4f001 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -50,6 +50,9 @@ man_dir = $(prefix)/share/man
 man_dir_SQ = '$(subst ','\'',$(man_dir))'
 pkgconfig_dir ?= $(word 1,$(shell $(PKG_CONFIG) 		\
 			--variable pc_path pkg-config | tr ":" " "))
+includedir_relative = traceevent
+includedir = $(prefix)/include/$(includedir_relative)
+includedir_SQ = '$(subst ','\'',$(includedir))'
 
 export man_dir man_dir_SQ INSTALL
 export DESTDIR DESTDIR_SQ
@@ -279,6 +282,8 @@ define do_install_pkgconfig_file
 		cp -f ${PKG_CONFIG_FILE}.template ${PKG_CONFIG_FILE}; 		\
 		sed -i "s|INSTALL_PREFIX|${1}|g" ${PKG_CONFIG_FILE}; 		\
 		sed -i "s|LIB_VERSION|${EVENT_PARSE_VERSION}|g" ${PKG_CONFIG_FILE}; \
+		sed -i "s|LIB_DIR|${libdir}|g" ${PKG_CONFIG_FILE}; \
+		sed -i "s|HEADER_DIR|$(includedir)|g" ${PKG_CONFIG_FILE}; \
 		$(call do_install,$(PKG_CONFIG_FILE),$(pkgconfig_dir),644); 	\
 	else 									\
 		(echo Failed to locate pkg-config directory) 1>&2;		\
@@ -300,10 +305,10 @@ install_pkgconfig:
 
 install_headers:
 	$(call QUIET_INSTALL, headers) \
-		$(call do_install,event-parse.h,$(prefix)/include/traceevent,644); \
-		$(call do_install,event-utils.h,$(prefix)/include/traceevent,644); \
-		$(call do_install,trace-seq.h,$(prefix)/include/traceevent,644); \
-		$(call do_install,kbuffer.h,$(prefix)/include/traceevent,644)
+		$(call do_install,event-parse.h,$(DESTDIR)$(includedir_SQ),644); \
+		$(call do_install,event-utils.h,$(DESTDIR)$(includedir_SQ),644); \
+		$(call do_install,trace-seq.h,$(DESTDIR)$(includedir_SQ),644); \
+		$(call do_install,kbuffer.h,$(DESTDIR)$(includedir_SQ),644)
 
 install: install_lib
 
diff --git a/tools/lib/traceevent/libtraceevent.pc.template b/tools/lib/traceevent/libtraceevent.pc.template
index 42e4d6cb6b9e..86384fcd57f1 100644
--- a/tools/lib/traceevent/libtraceevent.pc.template
+++ b/tools/lib/traceevent/libtraceevent.pc.template
@@ -1,6 +1,6 @@
 prefix=INSTALL_PREFIX
-libdir=${prefix}/lib64
-includedir=${prefix}/include/traceevent
+libdir=LIB_DIR
+includedir=HEADER_DIR
 
 Name: libtraceevent
 URL: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
-- 
2.20.1

