Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EA4C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85913206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Hwr8lpcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfECF56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:57:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53511 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECF56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:57:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x435vigI2618837
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 2 May 2019 22:57:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x435vigI2618837
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556863065;
        bh=++hh1yg5aqjHiY1Nuplh1Eur4zvagm4/E58wzwhEN1E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Hwr8lpcEFM+WKLJpmkQa6SSdcZHdkfvv7AW4YdgxPNMs03K0e8Ck5xhlg9OHub0Je
         w1JhRhZjG7xll1icq68xKBCgvfiYNPfcsMQ8p1SLKPIsH9b+gBT9YTnjN2OZl+l5IE
         ynDlq9S2iPnxGlsey48MNeuvBWKAJ6D5397JVWiS9AhYxb5ePoS1xyrLM4aP4zxV28
         1VK3OLjSy1lZ5TCLdJ5vIbmG7wEeWejDj6usWgCinKtmozVwvgo+6macjtYhFBPGpS
         xyZlMqNuslWgbu2DzhyAasginjbo/Y2c9rGu/qKtAKYgVDUS5BaYj0LGq6a//GLiy3
         o9TNf9udPYnxQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x435vi302618834;
        Thu, 2 May 2019 22:57:44 -0700
Date:   Thu, 2 May 2019 22:57:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-c638417e1a64b1f43ebab589e697d1cd1a127a74@git.kernel.org>
Cc:     adrian.hunter@intel.com, acme@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, songliubraving@fb.com,
        tglx@linutronix.de, namhyung@kernel.org, tmb@mageia.org,
        mingo@kernel.org, jolsa@kernel.org
Reply-To: jolsa@kernel.org, mingo@kernel.org, namhyung@kernel.org,
          tmb@mageia.org, tglx@linutronix.de, songliubraving@fb.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
          adrian.hunter@intel.com
In-Reply-To: <20190501173158.GC21436@kernel.org>
References: <20190501173158.GC21436@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools build: Add -ldl to the
 disassembler-four-args feature test
Git-Commit-ID: c638417e1a64b1f43ebab589e697d1cd1a127a74
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

Commit-ID:  c638417e1a64b1f43ebab589e697d1cd1a127a74
Gitweb:     https://git.kernel.org/tip/c638417e1a64b1f43ebab589e697d1cd1a127a74
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 1 May 2019 16:27:00 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 May 2019 16:00:20 -0400

tools build: Add -ldl to the disassembler-four-args feature test

Thomas Backlund reported that the perf build was failing on the Mageia 7
distro, that is because it uses:

  cat /tmp/build/perf/feature/test-disassembler-four-args.make.output
  /usr/bin/ld: /usr/lib64/libbfd.a(plugin.o): in function `try_load_plugin':
  /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:243:
  undefined reference to `dlopen'
  /usr/bin/ld:
  /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:271:
  undefined reference to `dlsym'
  /usr/bin/ld:
  /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:256:
  undefined reference to `dlclose'
  /usr/bin/ld:
  /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:246:
  undefined reference to `dlerror'
  as we allow dynamic linking and loading

Mageia 7 uses these linker flags:
  $ rpm --eval %ldflags
    -Wl,--as-needed -Wl,--no-undefined -Wl,-z,relro -Wl,-O1 -Wl,--build-id -Wl,--enable-new-dtags

So add -ldl to this feature LDFLAGS.

Reported-by: Thomas Backlund <tmb@mageia.org>
Tested-by: Thomas Backlund <tmb@mageia.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: https://lkml.kernel.org/r/20190501173158.GC21436@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index fe3f97e342fa..6d65874e16c3 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -227,7 +227,7 @@ FEATURE_CHECK_LDFLAGS-libpython-version := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
-FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes
+FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
 
 CFLAGS += -fno-omit-frame-pointer
 CFLAGS += -ggdb3
