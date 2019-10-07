Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9905CC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B42020684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfJGRlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:41:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:17771 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbfJGRlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:41:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 10:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="196361497"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga003.jf.intel.com with ESMTP; 07 Oct 2019 10:41:22 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B77983019B5; Mon,  7 Oct 2019 10:41:22 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf data: Fix babeltrace detection
Date:   Mon,  7 Oct 2019 10:41:20 -0700
Message-Id: <20191007174120.12330-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The symbol the feature file checks for is now actually in -lbabeltrace,
not -lbabeltrace-ctf, at least as of libbabeltrace-1.5.6-2.fc30.x86_64

Always add both libraries to fix the feature detection.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Makefile.config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index bf8caa7d17f6..71638917e18a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -155,7 +155,7 @@ ifdef LIBBABELTRACE_DIR
   LIBBABELTRACE_LDFLAGS := -L$(LIBBABELTRACE_DIR)/lib
 endif
 FEATURE_CHECK_CFLAGS-libbabeltrace := $(LIBBABELTRACE_CFLAGS)
-FEATURE_CHECK_LDFLAGS-libbabeltrace := $(LIBBABELTRACE_LDFLAGS) -lbabeltrace-ctf
+FEATURE_CHECK_LDFLAGS-libbabeltrace := $(LIBBABELTRACE_LDFLAGS) -lbabeltrace-ctf -lbabeltrace
 
 ifdef LIBZSTD_DIR
   LIBZSTD_CFLAGS  := -I$(LIBZSTD_DIR)/lib
@@ -895,7 +895,7 @@ ifndef NO_LIBBABELTRACE
   ifeq ($(feature-libbabeltrace), 1)
     CFLAGS += -DHAVE_LIBBABELTRACE_SUPPORT $(LIBBABELTRACE_CFLAGS)
     LDFLAGS += $(LIBBABELTRACE_LDFLAGS)
-    EXTLIBS += -lbabeltrace-ctf
+    EXTLIBS += -lbabeltrace-ctf -lbabeltrace
     $(call detected,CONFIG_LIBBABELTRACE)
   else
     msg := $(warning No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev);
-- 
2.21.0

