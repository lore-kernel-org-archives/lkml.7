Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00324C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7022192C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194504;
	bh=0/qGtWEUX8wS344nPYQDYbtwBsjU1SBKfDnRjHl15fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f0M6KlAsatDPenlUGq4FSpH+oh9FpAlOSqAP1lOufOVaqa0Kg6NIy+VN5+xviUaEk
	 Mp0uOfh4lgIFgD2zXIfS/IMFCEt/vmWNS9OTdefZfWvcnr/Oob77ZI1Ot2DraNrZO2
	 R75hcYIiNiZDGKjrCgHObszdnxQh6esVnlBgNSc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfCUSzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbfCUSzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:55:00 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B546B20643;
        Thu, 21 Mar 2019 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194499;
        bh=0/qGtWEUX8wS344nPYQDYbtwBsjU1SBKfDnRjHl15fY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6L1tc+OsJH4KkIkwmgYCxl6vgKxthQDpRwZqDZXGRNzw25LRS5c/iXobxeY0E4PB
         upXgAK64QJLhS+C0GjIs2lOfNomy04aNu3kh/rEB2E+xw3Jh16X10omeHZ63Kf+XS6
         9/GND/nqql8IkYyu4Bs6cJGOFWA0lIdeamW2G7gQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislav Fomichev <sdf@google.com>, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 36/44] perf feature detection: Add -lopcodes to feature-libbfd
Date:   Thu, 21 Mar 2019 15:51:34 -0300
Message-Id: <20190321185142.11441-37-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

Both libbfd and libopcodes are distributed with binutil-dev/devel. When
libbfd is present, it is OK to assume that libopcodes also present. This
has been a safe assumption for bpftool.

This patch adds -lopcodes to perf/Makefile.config. libopcodes will be
used in the next commit for BPF annotation.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: kernel-team@fb.com
Link: http://lkml.kernel.org/r/20190312053051.2690567-12-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0f11d5891301..df4ad45599ca 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -713,7 +713,7 @@ else
 endif
 
 ifeq ($(feature-libbfd), 1)
-  EXTLIBS += -lbfd
+  EXTLIBS += -lbfd -lopcodes
 else
   # we are on a system that requires -liberty and (maybe) -lz
   # to link against -lbfd; test each case individually here
@@ -724,10 +724,10 @@ else
   $(call feature_check,libbfd-liberty-z)
 
   ifeq ($(feature-libbfd-liberty), 1)
-    EXTLIBS += -lbfd -liberty
+    EXTLIBS += -lbfd -lopcodes -liberty
   else
     ifeq ($(feature-libbfd-liberty-z), 1)
-      EXTLIBS += -lbfd -liberty -lz
+      EXTLIBS += -lbfd -lopcodes -liberty -lz
     endif
   endif
 endif
-- 
2.20.1

