Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AB1C04AA9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9785D216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556843175;
	bh=fMME0WDV3FAqd937U+9NedAkvSv2gMD90WbC8yI9E7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZaV5xEzbDGDReooSiGfYaZB1/mKksxcKZQ3kJXqlwmJEdhgRxDg9mxXGUTc7Lp3SR
	 FD9kyKVLYwDAfJeCPOLBoRYGVhVytiEARRWvhbM7wMM6pUDxPPZvth58qjZY+iPfCN
	 AvOjqbvi6ZsmlsRijolfsrKSWZ/VMbz4KRoUxTVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfECA0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 20:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfECA0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:26:11 -0400
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23264217D7;
        Fri,  3 May 2019 00:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556843170;
        bh=fMME0WDV3FAqd937U+9NedAkvSv2gMD90WbC8yI9E7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=epewocQgIYaS2RN27ZBLsnj6f+Kj8wlSX1gCYrdpKj8BoOmgvv+WZZVh1BpqsgKRl
         4rUFmzTwY0efStvGwhsUmdogHBBzOiHlhVtMv0agMX6ed5RlZQXCKSwtx4fKVfC17p
         IW9SR3MIoIT1/YdrK1lUJyfALq0j1p91r59chrko=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Thomas Backlund <tmb@mageia.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 09/11] tools build: Add -ldl to the disassembler-four-args feature test
Date:   Thu,  2 May 2019 20:25:31 -0400
Message-Id: <20190503002533.29359-10-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503002533.29359-1-acme@kernel.org>
References: <20190503002533.29359-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.20.1

