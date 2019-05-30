Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EE4C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF87257D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JcqHwJVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfE3IQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:16:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35827 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3IQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:16:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8GCHb2905139
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:16:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8GCHb2905139
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559204173;
        bh=E9vElWTLNhS7QK+btXZx2c4ZOYPCWXmdZxHZrCXGCrg=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=JcqHwJVZ1y0Rltccl4SbD0982Dg7l0k+06HkNQ2T16wECFDmVH+Ylf9sie2WuTpGs
         iCJif3tR/HNsjU/oe3KYzuyOdWp5B8Or3oXjBuBXFExXgXytDWHT6DVMreraG1JOAK
         kRSB/WHiPTxjG+Q0PdrXEXRmQIXifwoCWRbePZewUN3dAF5Bo9NMa2aIgkHXuto66G
         mI8Mpj9dTxHPg9Nnf7SnmHCSpxiPaTZ8kGeqFyP5oXpWjP65MdgAF8E+rQxbOpULE6
         rh7eQZMiAH2dYMfkkMXlE9QLsKLRAcKggVLBvw5veWXtulXaMDBwR3VXYNBkp+UENP
         S1XWIgodnDEfw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8GCmZ2905136;
        Thu, 30 May 2019 01:16:12 -0700
Date:   Thu, 30 May 2019 01:16:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-brmp2415zxpbhz45etkgjoma@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        acme@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        jolsa@kernel.org, namhyung@kernel.org, mingo@kernel.org
Reply-To: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf python: Remove -fstack-protector-strong if
 clang doesn't have it
Git-Commit-ID: 7952fa3b54bf6834dca22a21363c7caf78525720
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7952fa3b54bf6834dca22a21363c7caf78525720
Gitweb:     https://git.kernel.org/tip/7952fa3b54bf6834dca22a21363c7caf78525720
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 28 May 2019 17:36:46 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:44 -0300

perf python: Remove -fstack-protector-strong if clang doesn't have it

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
 
