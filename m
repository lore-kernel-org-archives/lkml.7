Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2E6C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E412070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbfDBNkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:40:19 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43152 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731427AbfDBNkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:05 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0002oX-09; Tue, 02 Apr 2019 14:40:01 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdw-0004tp-Ae; Tue, 02 Apr 2019 14:40:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Jiri Olsa" <jolsa@kernel.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.171312230@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 42/99] perf parse-events: Fix unchecked usage of
 strncpy()
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit bd8d57fb7e25e9fcf67a9eef5fa13aabe2016e07 upstream.

The strncpy() function may leave the destination string buffer
unterminated, better use strlcpy() that we have a __weak fallback
implementation for systems without it.

This fixes this warning on an Alpine Linux Edge system with gcc 8.2:

  util/parse-events.c: In function 'print_symbol_events':
  util/parse-events.c:2465:4: error: 'strncpy' specified bound 100 equals destination size [-Werror=stringop-truncation]
      strncpy(name, syms->symbol, MAX_NAME_LEN);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  In function 'print_symbol_events.constprop',
      inlined from 'print_events' at util/parse-events.c:2508:2:
  util/parse-events.c:2465:4: error: 'strncpy' specified bound 100 equals destination size [-Werror=stringop-truncation]
      strncpy(name, syms->symbol, MAX_NAME_LEN);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  In function 'print_symbol_events.constprop',
      inlined from 'print_events' at util/parse-events.c:2511:2:
  util/parse-events.c:2465:4: error: 'strncpy' specified bound 100 equals destination size [-Werror=stringop-truncation]
      strncpy(name, syms->symbol, MAX_NAME_LEN);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 947b4ad1d198 ("perf list: Fix max event string size")
Link: https://lkml.kernel.org/n/tip-b663e33bm6x8hrkie4uxh7u2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1217,7 +1217,7 @@ static void print_symbol_events(const ch
 		if (strlen(syms->alias))
 			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms->symbol, syms->alias);
 		else
-			strncpy(name, syms->symbol, MAX_NAME_LEN);
+			strlcpy(name, syms->symbol, MAX_NAME_LEN);
 
 		printf("  %-50s [%s]\n", name, event_type_descriptors[type]);
 

