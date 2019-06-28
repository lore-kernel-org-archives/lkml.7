Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AA8C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 21:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B4920828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 21:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfF1VMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 17:12:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:51823 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfF1VMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 17:12:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 14:12:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,429,1557212400"; 
   d="scan'208";a="361638711"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2019 14:12:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B3C59130; Sat, 29 Jun 2019 00:12:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: perf: Build with make -C <Linux O=...>
Date:   Sat, 29 Jun 2019 00:12:38 +0300
Message-Id: <20190628211238.84990-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My setup includes Linux kernel repository and Buildroot.
I build Linux kernel with make O=<Linux O=...> and then
when I try to build perf by running

	make -j1 V=1 JOBS=1 \
		-C <Linux O=...> \
		CROSS_COMPILE=".../i586-buildroot-linux-uclibc-" \
		DESTDIR="..." tools/perf_install

where <Linux O=...> is a patch to output folder of built Linux kernel,
I got wrong path in perf during build, so, instead of tools/perf it becomes
tools/perf/tools/perf.

Note, it fulfills my purposes with minimal features supported,
that's why not every library got "fixed".

Below is the patch which helped me to achieve above.

I'm pretty sure it's not the best solution. Anyway, would like to hear any
ideas how to do this better.

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 4d46ca6d7e20..c56d4c0fd29b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -698,23 +698,24 @@ $(LIBPERF_A): $(LIBPERF_IN)
 LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ) 'EXTRA_CFLAGS=$(EXTRA_CFLAGS)' 'LDFLAGS=$(LDFLAGS)'
 
 $(LIBTRACEEVENT): FORCE
-	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) $(OUTPUT)libtraceevent.a
+	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) subdir= $(OUTPUT)libtraceevent.a
 
 libtraceevent_plugins: FORCE
-	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) plugins
+	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) subdir= plugins
 
 $(LIBTRACEEVENT_DYNAMIC_LIST): libtraceevent_plugins
-	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) $(OUTPUT)libtraceevent-dynamic-list
+	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) subdir= $(OUTPUT)libtraceevent-dynamic-list
 
 $(LIBTRACEEVENT)-clean:
 	$(call QUIET_CLEAN, libtraceevent)
 	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) O=$(OUTPUT) clean >/dev/null
 
 install-traceevent-plugins: libtraceevent_plugins
-	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) install_plugins
+	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) subdir= install_plugins
 
 $(LIBAPI): FORCE
-	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) $(OUTPUT)libapi.a
+	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) subdir= $(OUTPUT)libapi.a
+	mkdir -p $(API_PATH) && cp $(OUTPUT)libapi.a $(LIBAPI)
 
 $(LIBAPI)-clean:
 	$(call QUIET_CLEAN, libapi)
@@ -728,7 +729,7 @@ $(LIBBPF)-clean:
 	$(Q)$(MAKE) -C $(BPF_DIR) O=$(OUTPUT) clean >/dev/null
 
 $(LIBSUBCMD): FORCE
-	$(Q)$(MAKE) -C $(SUBCMD_DIR) O=$(OUTPUT) $(OUTPUT)libsubcmd.a
+	$(Q)$(MAKE) -C $(SUBCMD_DIR) O=$(OUTPUT) subdir= $(OUTPUT)libsubcmd.a
 
 $(LIBSUBCMD)-clean:
 	$(call QUIET_CLEAN, libsubcmd)
-- 
2.20.1

