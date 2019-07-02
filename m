Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD403C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13DF2184B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034446;
	bh=pt7M9IAWzut9bbShKb0iHaCS031KBTWvctm+4G6dj5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B6bcf8ieq4w0y7Q/9Tni1na0fvdJ1jsTYWEY9lPDRmlw1CE791QYZUN9GRFC/DWZQ
	 YFbwda52PXnk5mOKmUyXqF+esKzma7/xdjE99en2CA9PzkrNjAtP1Pqdfzp5/15fyD
	 vQUur2ugqHW+01tS+LMNA1aJP8ZsAOl0V056vXtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfGBC1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbfGBC1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D151421848;
        Tue,  2 Jul 2019 02:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034442;
        bh=pt7M9IAWzut9bbShKb0iHaCS031KBTWvctm+4G6dj5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRn5aPqT8V9GBWMPdzLEQSDeh7VnOnnnS4/BrMSBbrq37n8hOePfvPtQ9fotBHAzu
         Sniktz8jYcCRM91kl38wBvQC3kJjnzK0KhmBr10UkL4AkZrDXzM3PdB0eBB8K+pd+P
         D/+hj/o8GE6eKVrSz79RbaUsuPgKv7rCM1z/W4yo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 19/43] perf tools: Remove old baggage that is util/include/linux/ctype.h
Date:   Mon,  1 Jul 2019 23:25:52 -0300
Message-Id: <20190702022616.1259-20-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It was just including a ../util.h that wasn't even there:

  $ cat tools/perf/util/include/linux/../util.h
  cat: tools/perf/util/include/linux/../util.h: No such file or directory
  $

This would make kallsyms.h get util.h somehow and then files including
it would get util.h defined stuff, a mess, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wlzwken4psiat4zvfbvaoqiw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/symbol/kallsyms.h           | 1 -
 tools/perf/util/include/linux/ctype.h | 1 -
 2 files changed, 2 deletions(-)
 delete mode 100644 tools/perf/util/include/linux/ctype.h

diff --git a/tools/lib/symbol/kallsyms.h b/tools/lib/symbol/kallsyms.h
index bd988f7b18d4..2b238f181d97 100644
--- a/tools/lib/symbol/kallsyms.h
+++ b/tools/lib/symbol/kallsyms.h
@@ -3,7 +3,6 @@
 #define __TOOLS_KALLSYMS_H_ 1
 
 #include <elf.h>
-#include <linux/ctype.h>
 #include <linux/types.h>
 
 #ifndef KSYM_NAME_LEN
diff --git a/tools/perf/util/include/linux/ctype.h b/tools/perf/util/include/linux/ctype.h
deleted file mode 100644
index a53d4ee1e0b7..000000000000
--- a/tools/perf/util/include/linux/ctype.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../util.h"
-- 
2.20.1

