Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A534C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F8921917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194329;
	bh=tivakt/YLgfjn9clfj4mcvtQ37VYhzR0azMnNsQgQAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F1VhTC5RAGAtW0BlpSo9WqRqOgobIXdVTWKY9h6WCmJ8XOxYFBZth1tumL+mNTu4s
	 0CDY4PrFT/OebS5tU3+q8qDp6Mrpsk9k1ZaSAwTIe/sryJZPmWHk4aW+puGKO5Faw2
	 +3DIQhpYZUIEU0yUJQxuR0+66qYtRZ/nWUDQQ44I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfCUSwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbfCUSwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:52:05 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C808A2190A;
        Thu, 21 Mar 2019 18:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194324;
        bh=tivakt/YLgfjn9clfj4mcvtQ37VYhzR0azMnNsQgQAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LoisYfpCrzIs77qoHQxklAGunuTsR4fvsbcRdFSWN/u7o5afkkZtNpdF12N4JP/3S
         n72MxZrO1kopO/6aEU2P/l6nqV4lhe/vtN0yiXK9l9ocilVhBCTCYnEvSmi4z8mw1s
         dJigz1umMz4F5ZhRiJHU3VT9bAgcJeAnxenx1iog=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/44] perf record: Clarify help for --switch-output
Date:   Thu, 21 Mar 2019 15:51:01 -0300
Message-Id: <20190321185142.11441-4-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

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
-- 
2.20.1

