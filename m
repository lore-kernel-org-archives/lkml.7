Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15488C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA51216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455554;
	bh=VpES/eOOB14gMojXhbnYEZJUZDwKdptKCm/L2wU9PBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GAqa1BbYycijXnL64Fsb7f1M68YnpHURDJW+yJkpow8XN9uPJtt9of0EOQea+wULu
	 01zhcUt04lASa1ASPpNgFeOfKHUYW+gOB9fDyQsA9ZaqoqifLO0iP0TfBC9ldQAqxd
	 fQFvz1OoSHGKMZrZY43L97bCwx6t2mha2YtbEMCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbfG3C7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732158AbfG3C7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:59:11 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E13982070B;
        Tue, 30 Jul 2019 02:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455550;
        bh=VpES/eOOB14gMojXhbnYEZJUZDwKdptKCm/L2wU9PBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOwcHu3b78sLXIZJjpghOn+dn/DRv8TnYzLKDLx+bVMmRGaWon8qJWKnYD3rdk0ul
         f4a2NPseXN/c9huas4JqfkzxMyn+VYUKSg5Z9nu8bL0myh8/L0f/TtoIUkkA8iTPde
         kyunT/RWHqIDg6c83zL2mDrvaehDFoBUHYVX2O1c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 052/107] libperf: Add libperf to the python.so build
Date:   Mon, 29 Jul 2019 23:55:15 -0300
Message-Id: <20190730025610.22603-53-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Link libperf.a with python.so.

Committer testing:

Continues to work:

  # perf test python
  18: 'import perf' in python                               : Ok
  #

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-26-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 1 +
 tools/perf/util/setup.py | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 6e7e7d44ffac..67512a12276b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -307,6 +307,7 @@ LIBBPF = $(BPF_PATH)libbpf.a
 LIBSUBCMD = $(SUBCMD_PATH)libsubcmd.a
 
 LIBPERF = $(LIBPERF_PATH)libperf.a
+export LIBPERF
 
 # python extension build directories
 PYTHON_EXTBUILD     := $(OUTPUT)python_ext_build/
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index a1a68a2fa917..d48f9cd58964 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -48,6 +48,7 @@ build_lib = getenv('PYTHON_EXTBUILD_LIB')
 build_tmp = getenv('PYTHON_EXTBUILD_TMP')
 libtraceevent = getenv('LIBTRACEEVENT')
 libapikfs = getenv('LIBAPI')
+libperf = getenv('LIBPERF')
 
 ext_sources = [f.strip() for f in open('util/python-ext-sources')
 				if len(f.strip()) > 0 and f[0] != '#']
@@ -64,7 +65,7 @@ perf = Extension('perf',
 		  include_dirs = ['util/include'],
 		  libraries = extra_libraries,
 		  extra_compile_args = cflags,
-		  extra_objects = [libtraceevent, libapikfs],
+		  extra_objects = [libtraceevent, libapikfs, libperf],
                  )
 
 setup(name='perf',
-- 
2.21.0

