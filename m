Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD8CC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2DD218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lZMB5Prf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfGCOBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:01:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52129 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCOBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:01:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63E1Dks3318295
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:01:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63E1Dks3318295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562162474;
        bh=WtlbA0FBI8j+SaWDDgbyIaaQRw1FmnyK9KV94OVUoPI=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=lZMB5PrfKYNAMXP+wOkP1tzy1Z29wr9IMRTCfeOu4T78Y6py0q6i4lyYEMUGtiq9J
         TXYzTBKcw62kG/rW8CtQLZmJxDJi5FoF4cc2IUgRj7ikqD//bmbC5TYqHZ5xhGuBRw
         OlYqxxGExCMZpyJgbjyo+uKtQ5CVe/BxMhT/e811fA3i6CRRLOJWQ18SWZpTuliMUA
         IBt/QjnbSMM/GkBgW3g+T5YVuEdg+H1Ll8iSOKIaLcZWqdYCXYBHaHoiBUNCT6qSl6
         ZVK2phWHOD5bQ08H9Qa622qetlyHbCtMCuOkUpZQXKkTPbvKiiW4h/VhZVQ9gyP0go
         6jiNInbV3d09Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63E1Cwv3318292;
        Wed, 3 Jul 2019 07:01:12 -0700
Date:   Wed, 3 Jul 2019 07:01:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Numfor Mbiziwo-Tiapo <tipbot@zytor.com>
Message-ID: <tip-pud8usyutvd2npg2vpsygncz@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        tglx@linutronix.de, eranian@google.com, nums@google.com,
        hpa@zytor.com
Reply-To: acme@redhat.com, tglx@linutronix.de, mingo@kernel.org,
          nums@google.com, eranian@google.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Fix cache.h include directive
Git-Commit-ID: 2d7102a0453769fd37e9f4ce68652e104fbf5c84
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

Commit-ID:  2d7102a0453769fd37e9f4ce68652e104fbf5c84
Gitweb:     https://git.kernel.org/tip/2d7102a0453769fd37e9f4ce68652e104fbf5c84
Author:     Numfor Mbiziwo-Tiapo <nums@google.com>
AuthorDate: Thu, 20 Jun 2019 14:54:46 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 08:47:09 -0300

perf tools: Fix cache.h include directive

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
