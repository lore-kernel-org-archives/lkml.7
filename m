Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9939C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F7C21881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="N4YjbrCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfGCOUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:20:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58589 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCOUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:20:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EJuM43323482
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:19:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EJuM43323482
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163596;
        bh=3DrXXzYCIMm/+7tMqrIQH3Hc9aNW6YQ+qVbON+f3drw=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=N4YjbrCwr0fy9wMdBSzrePVBvxUzt9GrcCemxRP5maPRGlZeXHidDC2FftuzWE3jI
         BakJr5/JP+FMlwYFASLnddTS8jfAYlJ6VpaYzzhUMhDXUoLlu7luF4EcDmIlbbCIG9
         Gzy6yBh48vMq23xy5rsvqepmCKw1kArstPf7hCQ/WbF40CJNJF6zhkxtylfTa+5zH0
         MwQl2bZpP3Y4dwPZ2tpUW92DkPJkfK4CvfSt/Ko2mMtoeG7nBDz9+5m7CsNduigyHk
         x8q1/KX7Cx8xzPoHTcM2YvIHWMA26ov7phyttuIz9tJdWDEl7ixPbGekloTgI8M0U7
         eL/bgUy82U5QQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EJt653323479;
        Wed, 3 Jul 2019 07:19:55 -0700
Date:   Wed, 3 Jul 2019 07:19:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-0ix211a81z2016dl5nmtdci4@git.kernel.org>
Cc:     namhyung@kernel.org, acme@redhat.com, mingo@kernel.org,
        hpa@zytor.com, mhiramat@kernel.org, tglx@linutronix.de,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org
Reply-To: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, tglx@linutronix.de, mhiramat@kernel.org,
          hpa@zytor.com, namhyung@kernel.org, acme@redhat.com,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf probe: Use skip_spaces() for argv handling
Git-Commit-ID: ee44b5b51f37727f57962b2cdccd548c62045252
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

Commit-ID:  ee44b5b51f37727f57962b2cdccd548c62045252
Gitweb:     https://git.kernel.org/tip/ee44b5b51f37727f57962b2cdccd548c62045252
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Jun 2019 21:46:39 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 26 Jun 2019 11:31:37 -0300

perf probe: Use skip_spaces() for argv handling

The skip_sep() routine has the same implementation as skip_spaces(),
recently adopted from the kernel, sources, switch to it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0ix211a81z2016dl5nmtdci4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/string.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index 084c3e4e9400..d28e723e2790 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -69,18 +69,6 @@ out_err:
 	return -1;
 }
 
-/*
- * Helper function for splitting a string into an argv-like array.
- * originally copied from lib/argv_split.c
- */
-static const char *skip_sep(const char *cp)
-{
-	while (*cp && isspace(*cp))
-		cp++;
-
-	return cp;
-}
-
 static const char *skip_arg(const char *cp)
 {
 	while (*cp && !isspace(*cp))
@@ -94,7 +82,7 @@ static int count_argc(const char *str)
 	int count = 0;
 
 	while (*str) {
-		str = skip_sep(str);
+		str = skip_spaces(str);
 		if (*str) {
 			count++;
 			str = skip_arg(str);
@@ -148,7 +136,7 @@ char **argv_split(const char *str, int *argcp)
 	argvp = argv;
 
 	while (*str) {
-		str = skip_sep(str);
+		str = skip_spaces(str);
 
 		if (*str) {
 			const char *p = str;
