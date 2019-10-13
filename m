Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B999C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 15:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E632082F
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570979675;
	bh=59Bgv8ErsS8oBdOo2wVu0GauRXUBeQce0EuIHuFbsUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KH3U7T+wCkQqDntyc15JnWmZTFi2x15OWogekwGwsF3FqiQPp1FC04ISZagGJzbVA
	 zjPlaiD3m5urP9rFcr5/vxcqN4rPePjIQIxtkvbigAOT3dWxiJ0S4GH38qDezfwxMn
	 uf8aSX5c+A1Kmfs1TGF+rkofYvSXaYtGBe0yoR14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfJMPOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 11:14:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfJMPOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 11:14:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBDAD10C0929;
        Sun, 13 Oct 2019 15:14:33 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-28.brq.redhat.com [10.40.204.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C355600C6;
        Sun, 13 Oct 2019 15:14:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/3] perf tools: Allow to build with -ltcmalloc
Date:   Sun, 13 Oct 2019 17:14:25 +0200
Message-Id: <20191013151427.11941-2-jolsa@kernel.org>
In-Reply-To: <20191013151427.11941-1-jolsa@kernel.org>
References: <20191013151427.11941-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Sun, 13 Oct 2019 15:14:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using "make TCMALLOC=1" you can enable perf to be build
for usage with libtcmalloc.so (gperftools).

Get heap profile (tools/perf directory):

  $ <install gperftools>
  $ make TCMALLOC=1 DEBUG=1
  $ HEAPPROFILE=/tmp/heapprof ./perf ...
  $ pprof ./perf /tmp/heapprof.000*
  (pprof) top
  Total: 2335.5 MB
    1735.1  74.3%  74.3%   1735.1  74.3% memdup
     402.0  17.2%  91.5%    402.0  17.2% zalloc
     140.2   6.0%  97.5%    145.8   6.2% map__new
      33.6   1.4%  98.9%     33.6   1.4% symbol__new
      12.4   0.5%  99.5%     12.4   0.5% alloc_event
       6.2   0.3%  99.7%      6.2   0.3% nsinfo__new
       5.5   0.2% 100.0%      5.5   0.2% nsinfo__copy
       0.3   0.0% 100.0%      0.3   0.0% dso__new
       0.1   0.0% 100.0%      0.1   0.0% do_read_string
       0.0   0.0% 100.0%      0.0   0.0% __GI__IO_file_doallocate

See callstack:
  $ pprof --pdf ./perf /tmp/heapprof.00* > callstack.pdf
  $ pprof --web ./perf /tmp/heapprof.00*

Link: http://lkml.kernel.org/n/tip-qyo3c7z69dysk10sr3pf5k05@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Makefile.config | 5 +++++
 tools/perf/Makefile.perf   | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 063202c53b64..1783427da9b0 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -265,6 +265,11 @@ LDFLAGS += -Wl,-z,noexecstack
 
 EXTLIBS = -lpthread -lrt -lm -ldl
 
+ifneq ($(TCMALLOC),)
+  CFLAGS += -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc -fno-builtin-free
+  EXTLIBS += -ltcmalloc
+endif
+
 ifeq ($(FEATURES_DUMP),)
 include $(srctree)/tools/build/Makefile.feature
 else
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a099a8a89447..8f1ba986d3bf 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -114,6 +114,8 @@ include ../scripts/utilities.mak
 # Define NO_LIBZSTD if you do not want support of Zstandard based runtime
 # trace compression in record mode.
 #
+# Define TCMALLOC to enable tcmalloc heap profiling.
+#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
-- 
2.21.0

