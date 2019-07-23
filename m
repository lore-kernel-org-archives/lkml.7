Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78955C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC03218F0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qA6aOQNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392261AbfGWVxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:53:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39119 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731504AbfGWVxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:53:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6NLr1dn253955
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 23 Jul 2019 14:53:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6NLr1dn253955
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563918782;
        bh=PUJ8/fvQOVHwcBDOP7rqUb2issf2d0QvweNYh0vKVgY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qA6aOQNHjyNYF/MM4cX5RjkWEPqNnDSyJWgYTopm8yd7hTveAb5CWUGk8JJE4VYAs
         M8O0kkWVgkBPA73MEWCuMaZKjF8vWdMBpUcFNYCtx6X7hgJ9fxeYpajqgwkn1GdDcj
         8DZwcoOl1uTtvV7KYE07vSmy/D4hQRKOAcODCeo2RskSKn+vsf0QRD4ZKmfQLurAL8
         fBjaHSfbOLcyjhg0gJyponxWJoUmWxhfTFNpV/25j9hNblY83+Z31iY/T1uRol5jD6
         4YqA/CBcfkSKh2WWqX88Z9m61dy5b+Dn9Z7iq9FrPRzZKzZywHJ+22NnG2+92KAdqx
         uGsCAYyuPCRjQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6NLr0Ei253952;
        Tue, 23 Jul 2019 14:53:00 -0700
Date:   Tue, 23 Jul 2019 14:53:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-39e7317e37f7f0be366d1201c283f968c17268da@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, adrian.hunter@intel.com,
        hpa@zytor.com, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, andrii.nakryiko@gmail.com,
        linux-kernel@vger.kernel.org
Reply-To: namhyung@kernel.org, andrii.nakryiko@gmail.com, jolsa@kernel.org,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, adrian.hunter@intel.com,
          mingo@kernel.org
In-Reply-To: <20190719183417.GQ3624@kernel.org>
References: <20190719183417.GQ3624@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf build: Do not use -Wshadow on gcc < 4.8
Git-Commit-ID: 39e7317e37f7f0be366d1201c283f968c17268da
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

Commit-ID:  39e7317e37f7f0be366d1201c283f968c17268da
Gitweb:     https://git.kernel.org/tip/39e7317e37f7f0be366d1201c283f968c17268da
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 19 Jul 2019 15:34:30 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Jul 2019 09:04:54 -0300

perf build: Do not use -Wshadow on gcc < 4.8

As it is too strict, see https://lkml.org/lkml/2006/11/28/253 and
https://gcc.gnu.org/gcc-4.8/changes.html, that takes into account
Linus's comments (search for Wshadow) for the reasoning about -Wshadow
not being interesting before gcc 4.8.

Acked-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20190719183417.GQ3624@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/scripts/Makefile.include | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 495066bafbe3..ded7a950dc40 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -32,7 +32,6 @@ EXTRA_WARNINGS += -Wno-system-headers
 EXTRA_WARNINGS += -Wold-style-definition
 EXTRA_WARNINGS += -Wpacked
 EXTRA_WARNINGS += -Wredundant-decls
-EXTRA_WARNINGS += -Wshadow
 EXTRA_WARNINGS += -Wstrict-prototypes
 EXTRA_WARNINGS += -Wswitch-default
 EXTRA_WARNINGS += -Wswitch-enum
@@ -69,8 +68,16 @@ endif
 # will do for now and keep the above -Wstrict-aliasing=3 in place
 # in newer systems.
 # Needed for the __raw_cmpxchg in tools/arch/x86/include/asm/cmpxchg.h
+#
+# See https://lkml.org/lkml/2006/11/28/253 and https://gcc.gnu.org/gcc-4.8/changes.html,
+# that takes into account Linus's comments (search for Wshadow) for the reasoning about
+# -Wshadow not being interesting before gcc 4.8.
+
 ifneq ($(filter 3.%,$(MAKE_VERSION)),)  # make-3
 EXTRA_WARNINGS += -fno-strict-aliasing
+EXTRA_WARNINGS += -Wno-shadow
+else
+EXTRA_WARNINGS += -Wshadow
 endif
 
 ifneq ($(findstring $(MAKEFLAGS), w),w)
