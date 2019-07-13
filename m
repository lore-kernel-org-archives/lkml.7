Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09D1C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D6620848
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KreTI4Hk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfGMLHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 07:07:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34561 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfGMLHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:07:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DB7L5G3841182
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 04:07:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DB7L5G3841182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563016042;
        bh=ARVJQCZM7pqse0tIbDehEEThS9dGutaOlMuqSxN1DfQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KreTI4Hk4me5Sij/Be/KMkwaEz/pael9risl22kdZ9kRFXcu1As0PcX2vb3vFcM3A
         a4ipx+HjsDIsLvXEwfnIwtUZgdWHF9HG9Ir0r4wxkjOePCPhgwJm4XoeVgW0MqNb5u
         0PvQyHQzgzNPFB1daiEA98DaRQLRPs9umS2FK+MxpawOgnTzOe1Bi0eUAX8i8dhAlW
         RH2ia2bBujaPer2cdvrrApczuUMXZnAmaaV2WBO2a6vHuPZpZdzw9DzuF5AMiBEA8z
         Xa2kgYQk64+yvKtKFGi82T59yks46HJ0ORJLzgPyjORHVjTmhTJBvsGly43qTKNp2Z
         d2LlMrlX/bFrg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DB7Ls73841179;
        Sat, 13 Jul 2019 04:07:21 -0700
Date:   Sat, 13 Jul 2019 04:07:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-1334bb94cd8a21217cb0c186925f9bc9d47adafc@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        tglx@linutronix.de, jolsa@redhat.com
Reply-To: acme@redhat.com, adrian.hunter@intel.com, jolsa@redhat.com,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190708055232.5032-3-adrian.hunter@intel.com>
References: <20190708055232.5032-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: export-to-sqlite.py: Fix
 DROP VIEW power_events_view
Git-Commit-ID: 1334bb94cd8a21217cb0c186925f9bc9d47adafc
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

Commit-ID:  1334bb94cd8a21217cb0c186925f9bc9d47adafc
Gitweb:     https://git.kernel.org/tip/1334bb94cd8a21217cb0c186925f9bc9d47adafc
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 8 Jul 2019 08:52:32 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 10:13:28 -0300

perf scripts python: export-to-sqlite.py: Fix DROP VIEW power_events_view

Drop power_events_view before its dependent tables.

SQLite does not seem to mind but the fix was needed for PostgreSQL
(export-to-postgresql.py script), so do the same fix for the SQLite. It is
more logical and keeps the 2 scripts following the same approach.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Fixes: 5130c6e55531 ("perf scripts python: export-to-sqlite.py: Export Intel PT power and ptwrite events")
Link: http://lkml.kernel.org/r/20190708055232.5032-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index 3222a83f4184..021326c46285 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -608,11 +608,11 @@ def trace_end():
 	if is_table_empty("ptwrite"):
 		drop("ptwrite")
 	if is_table_empty("mwait") and is_table_empty("pwre") and is_table_empty("exstop") and is_table_empty("pwrx"):
+		do_query(query, 'DROP VIEW power_events_view');
 		drop("mwait")
 		drop("pwre")
 		drop("exstop")
 		drop("pwrx")
-		do_query(query, 'DROP VIEW power_events_view');
 		if is_table_empty("cbr"):
 			drop("cbr")
 
