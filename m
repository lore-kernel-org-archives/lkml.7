Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5847CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF8A20883
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfCVWU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:20:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37079 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCVWU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:20:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMKKtg750227
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:20:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMKKtG750222;
        Fri, 22 Mar 2019 15:20:20 -0700
Date:   Fri, 22 Mar 2019 15:20:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-9yecyuha04nyg8toyd1b2pgi@git.kernel.org>
Cc:     jolsa@kernel.org, acme@redhat.com, tglx@linutronix.de,
        ak@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
          jolsa@kernel.org, ak@linux.intel.com, hpa@zytor.com,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf record: Clarify help for --switch-output
Git-Commit-ID: c38dab7df7ee4fdecd51e390d4d33d5ef5cff49d
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

Commit-ID:  c38dab7df7ee4fdecd51e390d4d33d5ef5cff49d
Gitweb:     https://git.kernel.org/tip/c38dab7df7ee4fdecd51e390d4d33d5ef5cff49d
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 14 Mar 2019 15:49:56 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:15:42 -0300

perf record: Clarify help for --switch-output

The help description for --switch-output looks like there are multiple
comma separated fields. But it's actually a choice of different options.
Make it clear and less confusing.

Before:

  % perf record -h
  ...
          --switch-output[=<signal,size,time>]
                            Switch output when receive SIGUSR2 or cross size,time threshold

After:

  % perf record -h
  ...

          --switch-output[=<signal or size[BKMG] or time[smhd]>]
                            Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
LPU-Reference: 20190314225002.30108-4-andi@firstfloor.org
Link: https://lkml.kernel.org/n/tip-9yecyuha04nyg8toyd1b2pgi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 02d7c40b2d10..e7144a1c1c82 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1989,8 +1989,8 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
 		    "Record timestamp boundary (time of first/last samples)"),
 	OPT_STRING_OPTARG_SET(0, "switch-output", &record.switch_output.str,
-			  &record.switch_output.set, "signal,size,time",
-			  "Switch output when receive SIGUSR2 or cross size,time threshold",
+			  &record.switch_output.set, "signal or size[BKMG] or time[smhd]",
+			  "Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold",
 			  "signal"),
 	OPT_INTEGER(0, "switch-max-files", &record.switch_output.num_files,
 		   "Limit number of switch output generated files"),
