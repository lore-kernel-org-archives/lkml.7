Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F061EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E3E21916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194323;
	bh=ueP9Sc8pv7SBsTzGcaypipkGiRVpyOJLkopwE4gQlKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1UDVoZVp3wDuJ4Qu6e8MKqo+VbYXL0rSXpA7fckAcwvFH5jm0goBEIEBrZe7T0bUS
	 XqVXnr1G+DrT206nz3Ye6oCjxnIhAW0T9kl5Bo0MMkn8+P2fcnooRSOFhD9UbZ5/Xw
	 hSFT9rvdKvrFCDLHn/CYHkshuuOoWhJrHKfYiOSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfCUSv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbfCUSv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:51:58 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE7C421929;
        Thu, 21 Mar 2019 18:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194318;
        bh=ueP9Sc8pv7SBsTzGcaypipkGiRVpyOJLkopwE4gQlKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g1NUjmViouFMpgX5LFngFCnFGHp3tAycXBIN1WyHG8pppJ3XoxE+RwKKnaTRx8fdA
         WjxxFcrP4N+4JplpgMfScaIJ4tbs7TVls/V5xtCZB0i44yZJYPgYxrLLFmo5eblS3B
         Luq7+miROEBvJg8ws1geOdAp9PsXyQJriN8Skf1w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/44] perf list: Filter metrics too
Date:   Thu, 21 Mar 2019 15:50:59 -0300
Message-Id: <20190321185142.11441-2-acme@kernel.org>
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
-- 
2.20.1

