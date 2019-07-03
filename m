Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10E4C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8154218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HDBwvfkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfGCOK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:10:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33113 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCOK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:10:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EAaZO3321751
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:10:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EAaZO3321751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163036;
        bh=6j0EvFSN8p+SWq2mElmBiDY251g9S+bx9vJvk3NGx7Y=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=HDBwvfkRo5jKOCBwqYbChtVwQFhzox28rgeZyLRowlEyUY87ZLvfDTxmfFj4zM7jF
         FiDygGAs18pa7nGXZFQtw1W1LVFj4pAUv9dufkEydLU7pd9sHV2fYb86Ycpvj1ZHGy
         2cgGfDNDuV5C0bEZLCDVBGLoNB13wdZaG+U9vp0Ny1EKFSluzAkQ/xsBNKJX2OUGA2
         63R83NOXbv3EKNleSwv7np2ei1yDHL8deBQD9iFrW/YQWugfo9H9Ktp8cyDFRRdYuq
         gBSx5x33SxFQkbMjCd6J00d7VJMMAN9bFuzgLMUGkml8jNYDt83hlCL+oRl31nXYCS
         lDDMpceCV2I8Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EAZGG3321748;
        Wed, 3 Jul 2019 07:10:35 -0700
Date:   Wed, 3 Jul 2019 07:10:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-2td8u86mia7143lbr5ttl0kf@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
        jolsa@kernel.org, hpa@zytor.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com
Reply-To: tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
          jolsa@kernel.org, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, namhyung@kernel.org, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ctype: Remove now unused 'spaces' variable
Git-Commit-ID: 93d50edc80abfdf9ad8064af9631a60c56bb0868
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

Commit-ID:  93d50edc80abfdf9ad8064af9631a60c56bb0868
Gitweb:     https://git.kernel.org/tip/93d50edc80abfdf9ad8064af9631a60c56bb0868
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Jun 2019 16:28:40 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 16:28:40 -0300

perf ctype: Remove now unused 'spaces' variable

We can left justify just fine using the 'field width' modifier in %s
printf, ditch this variable.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-2td8u86mia7143lbr5ttl0kf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ctype.c      | 4 ----
 tools/perf/util/sane_ctype.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/tools/perf/util/ctype.c b/tools/perf/util/ctype.c
index 8d90bf8d0d70..75c0da59c230 100644
--- a/tools/perf/util/ctype.c
+++ b/tools/perf/util/ctype.c
@@ -35,10 +35,6 @@ const char *graph_dotted_line =
 	"---------------------------------------------------------------------"
 	"---------------------------------------------------------------------"
 	"---------------------------------------------------------------------";
-const char *spaces =
-	"                                                                     "
-	"                                                                     "
-	"                                                                     ";
 const char *dots =
 	"....................................................................."
 	"....................................................................."
diff --git a/tools/perf/util/sane_ctype.h b/tools/perf/util/sane_ctype.h
index 894594fdedfb..a2bb3890864f 100644
--- a/tools/perf/util/sane_ctype.h
+++ b/tools/perf/util/sane_ctype.h
@@ -3,7 +3,6 @@
 #define _PERF_SANE_CTYPE_H
 
 extern const char *graph_dotted_line;
-extern const char *spaces;
 extern const char *dots;
 
 /* Sane ctype - no locale, and works with signed chars */
