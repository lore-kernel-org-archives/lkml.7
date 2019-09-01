Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BBCC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372D523774
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340690;
	bh=JpCrBfj0zr+z8td5586oOqa0nrVVo9maeaQKj48TA9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HkpcPwne75nNFLgVkvY/UApaLaUEXc7FmXs4z38Pqb6adzhLcOmL+vXk/5ayBcSaY
	 WlNmUmAF4rKm90NPAD8624mnDW1QybOBpLd0mcF7mMXCn3NgQvK8zlMH1omT8iALoE
	 woeIy5CPfAdUjX5QCv/Yctrvx2oxZQkJe/jVXreA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfIAMYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbfIAMYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:24:46 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ECD7233A2;
        Sun,  1 Sep 2019 12:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340685;
        bh=JpCrBfj0zr+z8td5586oOqa0nrVVo9maeaQKj48TA9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f9TRNJCPtYNaD2INrbwkkZMOyDHt27xX547WYXT8uoVK2nvrfbJk6x+lYTPG7DPBz
         V8gLU58AY11gkAGRkSmR9Gk6CZGufyxZB25YvpQ1PhwjyFoE6j40/4koU3YtDtBsH+
         7Bek72QA1DTN4GRTdxUJwXhsbNaTfWA6mdrnXDio=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 23/47] perf symbol: Move C++ demangle defines to the only file using it
Date:   Sun,  1 Sep 2019 09:23:02 -0300
Message-Id: <20190901122326.5793-24-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No need to have it generally available in such a critical header as
symbol.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-es1ufxv7bihiumytn5dm3drn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 6 ++++++
 tools/perf/util/symbol.h     | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 7d504dc22108..6d22437e88ae 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -40,6 +40,12 @@
 
 typedef Elf64_Nhdr GElf_Nhdr;
 
+#ifndef DMGL_PARAMS
+#define DMGL_NO_OPTS     0              /* For readability... */
+#define DMGL_PARAMS      (1 << 0)       /* Include function args */
+#define DMGL_ANSI        (1 << 1)       /* Include const, volatile, etc */
+#endif
+
 #ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
 extern char *cplus_demangle(const char *, int);
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 159c59652a5c..bcc0d84a42b8 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -40,12 +40,6 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 			     GElf_Shdr *shp, const char *name, size_t *idx);
 #endif
 
-#ifndef DMGL_PARAMS
-#define DMGL_NO_OPTS     0              /* For readability... */
-#define DMGL_PARAMS      (1 << 0)       /* Include function args */
-#define DMGL_ANSI        (1 << 1)       /* Include const, volatile, etc */
-#endif
-
 /** struct symbol - symtab entry
  *
  * @ignore - resolvable but tools ignore it (e.g. idle routines)
-- 
2.21.0

