Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2116FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E405021850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709978;
	bh=XVjp35Tex1zTpPcHxN1Y3LCrM06SxgzVYHwwVeTfrD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MnnGSt13OXsxfeLEhSOzwz7rlWniXy0iMwzNeQ0RLSCWWEuxmdynCVkIWSusoZtqQ
	 BaiA9m4YNpZgR2SXqGHZ/t5KmOE7wtBpo6iSWRPzipaZN9VTWvhQWOVuKoieStLhum
	 NgYu0ks9YJgOvbr2MAXjQAsa5h2qYcxyqLH0lzew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387894AbfC0SGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387879AbfC0SGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:06:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5CD62177E;
        Wed, 27 Mar 2019 18:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709970;
        bh=XVjp35Tex1zTpPcHxN1Y3LCrM06SxgzVYHwwVeTfrD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kb6e2CCd2j86tc451gnD5ZZzoiBZ5WRaliYY9ihlKFqhbwlnRrXXYtf4nPT9VYUBI
         E/e5bKP+clNxd68fdDVlWtqSznlTWSEGSH48WP6OEysxTJT2N455Dx+3SqFIyFyZiT
         yNPybi2/3qeeUBkTvDwHvD8B10wowz2vJmjxFlTU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 139/262] tools build: Add -lrt to FEATURE_CHECK_LDFLAGS-libaio
Date:   Wed, 27 Mar 2019 13:59:54 -0400
Message-Id: <20190327180158.10245-139-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit aa8f9c517ebce7a0959da064ef2660ea03f133f8 ]

Since we need it to resolve the AIO symbols, otherwise we fail with:

  $ cat /tmp/build/perf/feature/test-all.make.output
  /usr/bin/ld: /tmp/ccEqrj36.o: undefined reference to symbol 'aio_return64@@GLIBC_2.2.5'
  /usr/bin/ld: //usr/lib64/librt.so.1: error adding symbols: DSO missing from command line
  collect2: error: ld returned 1 exit status
  $

When we added the aio support in 'perf record' only the test-libaio.bin
target got the -lrt, i.e. the feature detection slow path. Fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 2a07d814747b ("tools build feature: Check if libaio is available")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Makefile.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b441c88cafa1..e6360d47e73a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -218,6 +218,8 @@ FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
 FEATURE_CHECK_CFLAGS-libpython-version := $(PYTHON_EMBED_CCOPTS)
 FEATURE_CHECK_LDFLAGS-libpython-version := $(PYTHON_EMBED_LDOPTS)
 
+FEATURE_CHECK_LDFLAGS-libaio = -lrt
+
 CFLAGS += -fno-omit-frame-pointer
 CFLAGS += -ggdb3
 CFLAGS += -funwind-tables
-- 
2.19.1

