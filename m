Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6842BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC702190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfCVWTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:19:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57671 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVWTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:19:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMJ34l750053
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:19:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMJ3XH750050;
        Fri, 22 Mar 2019 15:19:03 -0700
Date:   Fri, 22 Mar 2019 15:19:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-1y8oi2s8c4jhjtykgs5zvda1@git.kernel.org>
Cc:     ak@linux.intel.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
        jolsa@kernel.org
Reply-To: jolsa@kernel.org, hpa@zytor.com, acme@redhat.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, ak@linux.intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf list: Filter metrics too
Git-Commit-ID: 6f40b2a5dac4b448fe1e8d94dc4238cd95cd5e34
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

Commit-ID:  6f40b2a5dac4b448fe1e8d94dc4238cd95cd5e34
Gitweb:     https://git.kernel.org/tip/6f40b2a5dac4b448fe1e8d94dc4238cd95cd5e34
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 14 Mar 2019 15:49:53 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 11:56:19 -0300

perf list: Filter metrics too

When a filter is specified on the command line, filter the metrics too.

Before:

  % perf list foo
  List of pre-defined events (to be used in -e):

  Metric Groups:

  DSB:
    DSB_Coverage
         [Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)]
  ... more metrics ...

After:

% perf list foo

  List of pre-defined events (to be used in -e):

  Metric Groups:

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
LPU-Reference: 20190314225002.30108-1-andi@firstfloor.org
Link: https://lkml.kernel.org/n/tip-1y8oi2s8c4jhjtykgs5zvda1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index c9f98d00c0e9..a8394b4f1167 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -119,7 +119,7 @@ int cmd_list(int argc, const char **argv)
 						details_flag);
 			print_tracepoint_events(NULL, s, raw_dump);
 			print_sdt_events(NULL, s, raw_dump);
-			metricgroup__print(true, true, NULL, raw_dump, details_flag);
+			metricgroup__print(true, true, s, raw_dump, details_flag);
 			free(s);
 		}
 	}
