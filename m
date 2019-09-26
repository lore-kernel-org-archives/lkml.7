Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AF9C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A616217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458062;
	bh=qZo5QgjckF5L2sMkVA0aSyj7ObG3yJzAAWbQoUnA0jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kcXoNUJM3Gj6NkG5rtAM9Y3Lc4MnoxCJTUFZTY9prJxilviWQ2aWRxqvD4jJP/3R0
	 /VmkqyL8+cjv1mB6+ItWya0rbrk1DqN7dIKOWSVMzp64K3KTioIwnCSZ8dbrqnrNAJ
	 UYV1HIN2/17RRz58md/ZbaX8ZELNnvaN1sT7AejI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbfIZAeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388464AbfIZAeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:19 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 532C8222C1;
        Thu, 26 Sep 2019 00:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458058;
        bh=qZo5QgjckF5L2sMkVA0aSyj7ObG3yJzAAWbQoUnA0jA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PTiG8bkv6TwqHBFkC4IZhplQQjM4bXeqE4quv7nJIu4pGEsVoBSahfFknXATy9IWC
         sHfqElbI+5LYlsKmOXnW147p6DgP9f4xRyodrpBNF1E4EwGroRdg73bj71vE6q+p0y
         ciJSa61px2xf781RbEQkKNwes/a96K+pvYDPhE+g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/66] libperf: Link libapi.a in libperf.so
Date:   Wed, 25 Sep 2019 21:31:59 -0300
Message-Id: <20190926003244.13962-22-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Linking libapi.a in libperf.so, because we are about to use some of the
API functions in it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index e325c0503dc6..54466cc84544 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -59,7 +59,13 @@ else
   CFLAGS := -g -Wall
 endif
 
-INCLUDES = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/ -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
+INCLUDES = \
+-I$(srctree)/tools/perf/lib/include \
+-I$(srctree)/tools/lib/ \
+-I$(srctree)/tools/include \
+-I$(srctree)/tools/arch/$(SRCARCH)/include/ \
+-I$(srctree)/tools/arch/$(SRCARCH)/include/uapi \
+-I$(srctree)/tools/include/uapi
 
 # Append required CFLAGS
 override CFLAGS += $(EXTRA_WARNINGS)
@@ -88,13 +94,34 @@ LIBPERF_PC := $(OUTPUT)libperf.pc
 
 LIBPERF_ALL := $(LIBPERF_A) $(OUTPUT)libperf.so*
 
+LIB_DIR := $(srctree)/tools/lib/api/
+
+ifneq ($(OUTPUT),)
+ifneq ($(subdir),)
+  API_PATH=$(OUTPUT)/../lib/api/
+else
+  API_PATH=$(OUTPUT)
+endif
+else
+  API_PATH=$(LIB_DIR)
+endif
+
+LIBAPI = $(API_PATH)libapi.a
+
+$(LIBAPI): FORCE
+	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) $(OUTPUT)libapi.a
+
+$(LIBAPI)-clean:
+	$(call QUIET_CLEAN, libapi)
+	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
+
 $(LIBPERF_IN): FORCE
 	$(Q)$(MAKE) $(build)=libperf
 
 $(LIBPERF_A): $(LIBPERF_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN)
 
-$(LIBPERF_SO): $(LIBPERF_IN)
+$(LIBPERF_SO): $(LIBPERF_IN) $(LIBAPI)
 	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so \
                                     -Wl,--version-script=$(VERSION_SCRIPT) $^ -o $@
 	@ln -sf $(@F) $(OUTPUT)libperf.so
@@ -106,7 +133,7 @@ libs: $(LIBPERF_A) $(LIBPERF_SO) $(LIBPERF_PC)
 all: fixdep
 	$(Q)$(MAKE) libs
 
-clean:
+clean: $(LIBAPI)-clean
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
                 *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS $(LIBPERF_PC)
 	$(Q)$(MAKE) -C tests clean
-- 
2.21.0

