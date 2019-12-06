Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42FFC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6D02468B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfLFIDp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:03:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60492 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfLFIDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:03:45 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1id8aN-00053O-R8; Fri, 06 Dec 2019 09:03:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6414A1C2787;
        Fri,  6 Dec 2019 09:03:35 +0100 (CET)
Date:   Fri, 06 Dec 2019 08:03:35 -0000
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf report/top TUI: Replace pr_err() with ui__error()
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191114132213.5419-2-ravi.bangoria@linux.ibm.com>
References: <20191114132213.5419-2-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <157561941531.21853.3292049704449436636.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     ae87405fb511d6220ce86b9a60807fef92e1a934
Gitweb:        https://git.kernel.org/tip/ae87405fb511d6220ce86b9a60807fef92e1a934
Author:        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate:    Thu, 14 Nov 2019 18:52:11 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 04 Dec 2019 12:27:14 -03:00

perf report/top TUI: Replace pr_err() with ui__error()

pr_err() in TUI mode does not print anyting on the screen and just
quits.

Replace such pr_err() with ui__error().

Before:

  $ perf report -s +
  $

After:

  $ perf report -s +

    ┌─Error:────────────────┐
    │Invalid --sort key: `+'│
    │                       │
    │Press any key...       │
    └───────────────────────┘

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20191114132213.5419-2-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 345b5cc..106d795 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2681,12 +2681,12 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
 			ret = sort_dimension__add(list, tok, evlist, level);
 			if (ret == -EINVAL) {
 				if (!cacheline_size() && !strncasecmp(tok, "dcacheline", strlen(tok)))
-					pr_err("The \"dcacheline\" --sort key needs to know the cacheline size and it couldn't be determined on this system");
+					ui__error("The \"dcacheline\" --sort key needs to know the cacheline size and it couldn't be determined on this system");
 				else
-					pr_err("Invalid --sort key: `%s'", tok);
+					ui__error("Invalid --sort key: `%s'", tok);
 				break;
 			} else if (ret == -ESRCH) {
-				pr_err("Unknown --sort key: `%s'", tok);
+				ui__error("Unknown --sort key: `%s'", tok);
 				break;
 			}
 		}
@@ -2743,7 +2743,7 @@ static int setup_sort_order(struct evlist *evlist)
 		return 0;
 
 	if (sort_order[1] == '\0') {
-		pr_err("Invalid --sort key: `+'");
+		ui__error("Invalid --sort key: `+'");
 		return -EINVAL;
 	}
 
@@ -3034,7 +3034,7 @@ static int __setup_output_field(void)
 		strp++;
 
 	if (!strlen(strp)) {
-		pr_err("Invalid --fields key: `+'");
+		ui__error("Invalid --fields key: `+'");
 		goto out;
 	}
 
