Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F63C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6691A21934
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194357;
	bh=Sq4o21iOcECuvhwNlozyMSRFoNTl3koHZuNnPgkBge4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zqzp7EHsJyFD6VnvFfXch/rXRtubBdQgr/1ncdqMrQRd8CfYIGALEfWtYwiuWmoWg
	 lL6EENhbw8eeI06m1M1NJiAjfcVexDti6nTDpH2rkkmZvBsct0yaC/lSrmxalTcjX8
	 oIpsL2a1qUvmfRtfQ9w8CzfFq63RANvZudFXCiK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfCUSwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbfCUSwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:52:33 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53E2B21917;
        Thu, 21 Mar 2019 18:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194352;
        bh=Sq4o21iOcECuvhwNlozyMSRFoNTl3koHZuNnPgkBge4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PFytF8w0D++EiBFnLNGxmjljiXFSizKQX8qbRzL+iadV0P5ArHeYuPxlM62L4XTG3
         mpPOK7e5Kv/FksU86MX9wbI72W8Ql2r23kYW7jATohFlScwDcOz7b7tMrPPuGrSCfD
         j7Zk6iTUU5XwUEoJ+EHKqPr+TMBplpsR1pX6c1cs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/44] perf tools: Add doc about how to build perf with Asan and UBSan
Date:   Thu, 21 Mar 2019 15:51:08 -0300
Message-Id: <20190321185142.11441-11-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

AddressSanitizer (or ASan) and UndefinedBehaviorSanitizer (or UBSan) are
very useful tools to detect program bugs:

 - AddressSanitizer (or ASan) is a GCC feature that detects memory
   corruption bugs such as buffer overflows and memory leaks.

 - UndefinedBehaviorSanitizer (or UBSan) is a fast undefined behavior
   detector supported by GCC. UBSan detects undefined behaviors of programs
   at runtime.

This patch adds a document about how to use them on perf. Later patches will fix
some of the issues disclosed by them.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190316080556.3075-2-changbin.du@gmail.com
[ Make some changes based on comments made by Jiri Olsa ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/Build.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/Documentation/Build.txt b/tools/perf/Documentation/Build.txt
index f6fc6507ba55..3766886c4bca 100644
--- a/tools/perf/Documentation/Build.txt
+++ b/tools/perf/Documentation/Build.txt
@@ -47,3 +47,27 @@ Those objects are then used in final linking:
 
 NOTE this description is omitting other libraries involved, only
      focusing on build framework outcomes
+
+3) Build with ASan or UBSan
+==========================
+  $ cd tools/perf
+  $ make DESTDIR=/usr
+  $ make DESTDIR=/usr install
+
+AddressSanitizer (or ASan) is a GCC feature that detects memory corruption bugs
+such as buffer overflows and memory leaks.
+
+  $ cd tools/perf
+  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
+  $ ASAN_OPTIONS=log_path=asan.log ./perf record -a
+
+ASan outputs all detected issues into a log file named 'asan.log.<pid>'.
+
+UndefinedBehaviorSanitizer (or UBSan) is a fast undefined behavior detector
+supported by GCC. UBSan detects undefined behaviors of programs at runtime.
+
+  $ cd tools/perf
+  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=undefined'
+  $ UBSAN_OPTIONS=print_stacktrace=1 ./perf record -a
+
+If UBSan detects any problem at runtime, it outputs a “runtime error:” message.
-- 
2.20.1

