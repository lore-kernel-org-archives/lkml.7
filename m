Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33BEC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A1620856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221178;
	bh=fMZUM13D83vQpqHU8QDi6QnpWqa6JFiGavbuaaWfaUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rtijJxquqgxu55AS5ecYRPUZFtL8eIyeIxno1zfRH/zrAiAkiq1T9WhLphIv2fZJS
	 b0jxzf7vKXOeeh5HNTMNxwclZ/2ERxB9tA/vN1ZcWlFLKQFQwyAR2Gk/sLeimL21py
	 nMaKryGBTR2AZxnAPSMTCDOR2qC4m4ElhUrb+ZHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbfDBQGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729813AbfDBQGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:06:16 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154D520840;
        Tue,  2 Apr 2019 16:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221176;
        bh=fMZUM13D83vQpqHU8QDi6QnpWqa6JFiGavbuaaWfaUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYJhHGHIDQx+sFPBnd9ubspOWpyrTo3LF7yZCY4tcNLSzs2W40KaRwYkn6q7Ddd8i
         +6q10BpSgttW67D7KqqRtUxCpNhpyubHE921C8zia+biUdCXw/aYJnr1ZBMCDhZyb+
         Ebu/eqArJnuyO5eXw11U63ZXxivlIaiA9TowXg6E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 04/44] perf trace beauty renameat: No need to include linux/fs.h
Date:   Tue,  2 Apr 2019 13:05:09 -0300
Message-Id: <20190402160549.13544-5-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There is no use for what is in that file, as everything is
built by the tools/perf/trace/beauty/rename_flags.sh script from
the copied kernel headers, the end result being:

  $ cat /tmp/build/perf/trace/beauty/generated/rename_flags_array.c
  static const char *rename_flags[] = {
	[0 + 1] = "NOREPLACE",
	[1 + 1] = "EXCHANGE",
	[2 + 1] = "WHITEOUT",
  };
  $

I.e. no use of any defines from uapi/linux/fs.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lgugmfa8z4bpw5zsbuoitllb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/renameat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/trace/beauty/renameat.c b/tools/perf/trace/beauty/renameat.c
index 6dab340cc506..852d2e271833 100644
--- a/tools/perf/trace/beauty/renameat.c
+++ b/tools/perf/trace/beauty/renameat.c
@@ -2,7 +2,6 @@
 // Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
 
 #include "trace/beauty/beauty.h"
-#include <uapi/linux/fs.h>
 
 static size_t renameat2__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
 {
-- 
2.20.1

