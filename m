Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0822C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8222133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bKrxAH1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfHPU7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:59:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49817 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPU7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:59:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7GKxaCS2960506
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 16 Aug 2019 13:59:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7GKxaCS2960506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565989177;
        bh=nzabgyf9hCpfYaccqHLaTyHGWhAPRe7zkXA9FOIeOkA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=bKrxAH1P8rzRj/VQCpLIFJ/pGVNUk64jY2T5B14KKOCtUsY9MblhlEHw14sqXFEqz
         Fv+B9n8xm9V6e36z6Cl2rlugyw7VV55DcNKvxzTn7LtEITyxNUjHboeRh+K7dQe8Cr
         w5Lx0Fu1p3uECZM1btoEcUzE4YmlOYjAO5pPrwg2LtLcSGVOwEYjOqY1xmg7pnMgwO
         IuGjsJzHQgeGano8KY2yxMKkZ8p8yZ559VCnrVKiOMbZKtSkaVGmtircqVUHqRZGNf
         OdQfAL/E02aTsTodXIYVZ/gd0lDpKs3xEbQuYsPXdn/HA3HjCY/eiWUi7Br6cyFaD1
         yTpOreDqOXnfQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7GKxaNB2960503;
        Fri, 16 Aug 2019 13:59:36 -0700
Date:   Fri, 16 Aug 2019 13:59:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for John Keeping <tipbot@zytor.com>
Message-ID: <tip-ab6cd0e5276e24403751e0b3b8ed807738a8571f@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
        jolsa@kernel.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mingo@kernel.org, khlebnikov@yandex-team.ru, john@metanate.com,
        acme@redhat.com
Reply-To: tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
          jolsa@kernel.org, alexander.shishkin@linux.intel.com,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          mingo@kernel.org, khlebnikov@yandex-team.ru, john@metanate.com,
          acme@redhat.com
In-Reply-To: <20190815100146.28842-1-john@metanate.com>
References: <20190815100146.28842-1-john@metanate.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf map: Use zalloc for map_groups
Git-Commit-ID: ab6cd0e5276e24403751e0b3b8ed807738a8571f
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

Commit-ID:  ab6cd0e5276e24403751e0b3b8ed807738a8571f
Gitweb:     https://git.kernel.org/tip/ab6cd0e5276e24403751e0b3b8ed807738a8571f
Author:     John Keeping <john@metanate.com>
AuthorDate: Thu, 15 Aug 2019 11:01:44 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Aug 2019 12:25:23 -0300

perf map: Use zalloc for map_groups

In the next commit we will add new fields to map_groups and we need
these to be null if no value is assigned.  The simplest way to achieve
this is to request zeroed memory from the allocator.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: john keeping <john@metanate.com>
Link: http://lkml.kernel.org/r/20190815100146.28842-1-john@metanate.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 668410b1d426..44b556812e4b 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -636,7 +636,7 @@ bool map_groups__empty(struct map_groups *mg)
 
 struct map_groups *map_groups__new(struct machine *machine)
 {
-	struct map_groups *mg = malloc(sizeof(*mg));
+	struct map_groups *mg = zalloc(sizeof(*mg));
 
 	if (mg != NULL)
 		map_groups__init(mg, machine);
