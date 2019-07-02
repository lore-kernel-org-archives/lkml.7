Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984E0C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D55D21850
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034472;
	bh=2Ao3hUKmTlKGsmD8Lyk1U16zAJ7ULSFrqcD1YOz+Vd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TzZ4QcldPRpJz6WDeojLt1a13puuM3St3QlRWZ7NjujMBuowdX+bi8sImPFAhmXoL
	 Gl12MxMVhkPjcb3INvznNsrka0SSsWWerRHAe3l7sNrn/pSi0uh7DMVHGzV2TCMjSC
	 zdaGDy/ofpDugrhQ3P/QuV2qcTQD0L90WrzFLs/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfGBC1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfGBC1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:49 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 409D32173E;
        Tue,  2 Jul 2019 02:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034468;
        bh=2Ao3hUKmTlKGsmD8Lyk1U16zAJ7ULSFrqcD1YOz+Vd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DRmkf/0TyXNb5aYeO02Kw3IjqePOlD1Y2BzeQeA8XViklA8mw2EuFrHAbd1XWJwdI
         XPM7KIBqVII8gcXagKop8v+b0GfZYlicU6jmfIC1Tlwbncp2jh8pplBGXKGTYMs1SY
         i1MPRM9zR8Ut7mr53Zx0mLWkAwmvXVvXH36yJDpo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 27/43] perf probe: Use skip_spaces() for argv handling
Date:   Mon,  1 Jul 2019 23:26:00 -0300
Message-Id: <20190702022616.1259-28-acme@kernel.org>
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
@@ -69,18 +69,6 @@ s64 perf_atoll(const char *str)
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
-- 
2.20.1

