Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A75C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B4E216E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600599;
	bh=BEWPwa95tbpi2kd9Ez0v9Jr5YtYJyUOPyBcWUfzfO60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RN3Wdv8YZZ9YcX/HJtnR1DYlN3PGskvCatBRW2BxCAfDqq2CquItYeO2pLqvhtrdU
	 jml4fGvVqkzdHLtOnWASBEYGxXcfJoHSDhULHBD04+7ihQErXe+jBDw9NNVvTJddES
	 tPT1lTC3E/Jfp0vUydSg1WpAiIh09GyiSd/fAyyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391152AbfGHPnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388363AbfGHPnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:43:17 -0400
Received: from quaco.ghostprotocols.net (179-240-135-35.3g.claro.net.br [179.240.135.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BB17216FD;
        Mon,  8 Jul 2019 15:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562600596;
        bh=BEWPwa95tbpi2kd9Ez0v9Jr5YtYJyUOPyBcWUfzfO60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ly0cGnBU2xVK41PfCXU7Otsj2WE01B7Jvl5xVnJ3w8fb9/Yj8RU/ABqhEIU9lN739
         tYa6dg0URHoLID99tKwV3Lg69tQKJLLKT7esrHy7LPNOO3zC6Q44/T5WiCEPMVtOgp
         lzwpqn0E2gheyMAv6cyR4jU5OEVkM7mA2ndUwtUM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 7/8] perf python: Remove -fstack-protector-strong if clang doesn't have it
Date:   Mon,  8 Jul 2019 12:42:06 -0300
Message-Id: <20190708154207.11403-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190708154207.11403-1-acme@kernel.org>
References: <20190708154207.11403-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Some distros put -fstack-protector-strong in the compiler flags to be
used to build python extensions, but then, the clang version in that
distro doesn't know about that, only gcc does.

Check if that is the case and remove it from the set of options used to
build the python binding with clang.

Case at hand:

oraclelinux:7

  $ head -2 /etc/os-release
  NAME="Oracle Linux Server"
  VERSION="7.6"
  $ grep stack-protector /usr/lib64/python2.7/_sysconfigdata.py | head -1 | cut -c-120
 'CFLAGS': '-fno-strict-aliasing -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --para
  $
  gcc version 4.8.5 20150623 (Red Hat 4.8.5-36.0.1) (GCC)
  clang version 3.4.2 (tags/RELEASE_34/dot2-final)

  clang: error: unknown argument: '-fstack-protector-strong'
  clang: error: unknown argument: '-fstack-protector-strong'
  error: command 'clang' failed with exit status 1
  cp: cannot stat '/tmp/build/perf/python_ext_build/lib/perf*.so': No such file or directory
  make[2]: *** [/tmp/build/perf/python/perf.so] Error 1

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-brmp2415zxpbhz45etkgjoma@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 5b5a167b43ce..a1a68a2fa917 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -17,6 +17,8 @@ if cc == "clang":
             vars[var] = sub("-fcf-protection", "", vars[var])
         if not clang_has_option("-fstack-clash-protection"):
             vars[var] = sub("-fstack-clash-protection", "", vars[var])
+        if not clang_has_option("-fstack-protector-strong"):
+            vars[var] = sub("-fstack-protector-strong", "", vars[var])
 
 from distutils.core import setup, Extension
 
-- 
2.20.1

