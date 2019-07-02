Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CB3C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A0521871
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034392;
	bh=R7QZj6daDZIn87ZnYi84fHWJ7jqqTAkfQu8mBjrTYYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=enRb2lzOG/AL4yVyQfBKIRtj6aT/Xdu31JBpAOKOv9+niP9FoXtSb1Ed//HtvZk94
	 3XkIdymijfZ1zsLsvLfDOukoMdhbuK7fqV+9XQuW83hPUJZRmg+ZoDknKhP0+2lD3W
	 2qiB6dNbAQzecSfTVZAHe3URdQMSjKC0kq+6Ipa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfGBC0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfGBC02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:26:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E6A92173E;
        Tue,  2 Jul 2019 02:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034387;
        bh=R7QZj6daDZIn87ZnYi84fHWJ7jqqTAkfQu8mBjrTYYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCQxpQJjZWY5MiBuOX06+PWzlq+t4e37iFzY7Epzb3k/3y9kDYUdKqw6M4SpLiwE/
         nOQ0q4kki68GU/mtBGmyAdeRjE+MdGv6K4hXjC/tCVJ5WR+RwfOSL69PB+cSJQniKH
         PbogzNGPdwygXuSuM9dKoRK1KMgR1mVUiAnIiYzQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Numfor Mbiziwo-Tiapo <nums@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Luke Mujica <lukemujica@google.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/43] perf tools: Fix cache.h include directive
Date:   Mon,  1 Jul 2019 23:25:34 -0300
Message-Id: <20190702022616.1259-2-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Numfor Mbiziwo-Tiapo <nums@google.com>

Change the include path so that progress.c can find cache.h since it was
previously searching in the wrong directory.

Committer notes:

  $ ls -la tools/perf/ui/../cache.h
  ls: cannot access 'tools/perf/ui/../cache.h': No such file or directory

So it really should include ../../util/cache.h, or plain cache.h, since
we have -Iutil in INC_FLAGS in tools/perf/Makefile.config

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>,
Cc: Luke Mujica <lukemujica@google.com>,
Cc: Stephane Eranian <eranian@google.com>
To: Ian Rogers <irogers@google.com>
Link: https://lkml.kernel.org/n/tip-pud8usyutvd2npg2vpsygncz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/progress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/progress.c b/tools/perf/ui/progress.c
index bbfbc91a0fa4..8cd3b64c6893 100644
--- a/tools/perf/ui/progress.c
+++ b/tools/perf/ui/progress.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
-#include "../cache.h"
+#include "../util/cache.h"
 #include "progress.h"
 
 static void null_progress__update(struct ui_progress *p __maybe_unused)
-- 
2.20.1

