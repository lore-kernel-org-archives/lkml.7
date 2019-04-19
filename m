Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D8EC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5C720854
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="d0xv+rli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfDSTGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:06:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729082AbfDSTDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JHGEFY358854
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 10:16:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JHGEFY358854
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555694175;
        bh=UAwxDUGsys1u7qf8N9TiU+TfvY2VSsUr3yoWqV1la9M=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=d0xv+rli0H24vZuZndLy5wBqsyu79EvDpUtUSJZiaif0s73OY88Zccy9XRpX3Dd3e
         CfJNzS7XzeVk5gqLCuISBhgOceMyQIDOFmbgEoQjYydH92mmnCTMdhlUSh4C7oILi6
         uccwzZqyuK8tme/+z+gXHgKUjI4zsoijGqOv4YsKNopjvM3lVqBREI/1ID3+yVAuHi
         PT4rkgOletg/jRA0qPd7YcITxx67K1sdBUVP3+xJ2ydUgvuJ5WnM4NgNduFuH8yyPl
         rpW+1YbHEKrzmfnqmsSfPXsVHemIbkS8pC2lVzd5qwAPoEOMSzQgIIlsrNGbEdo65u
         xxFcTJ8dZh3Cg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JHGC55358851;
        Fri, 19 Apr 2019 10:16:12 -0700
Date:   Fri, 19 Apr 2019 10:16:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-1e6db2ee86e6a4399fc0ae5689e55e0fd1c43caf@git.kernel.org>
Cc:     hpa@zytor.com, bastian.beischer@rwth-aachen.de, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: namhyung@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          acme@redhat.com, alexander.shishkin@linux.intel.com,
          jolsa@kernel.org, bastian.beischer@rwth-aachen.de,
          tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org
In-Reply-To: <20190415125333.27160-1-jolsa@kernel.org>
References: <20190415125333.27160-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Always sample time to satisfy needs of
 use of ordered queuing
Git-Commit-ID: 1e6db2ee86e6a4399fc0ae5689e55e0fd1c43caf
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

Commit-ID:  1e6db2ee86e6a4399fc0ae5689e55e0fd1c43caf
Gitweb:     https://git.kernel.org/tip/1e6db2ee86e6a4399fc0ae5689e55e0fd1c43caf
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 15 Apr 2019 14:53:33 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 16 Apr 2019 12:36:20 -0300

perf top: Always sample time to satisfy needs of use of ordered queuing

Bastian reported broken 'perf top -p PID' command, it won't display any
data.

The problem is that for -p option we monitor single thread, so we don't
enable time in samples, because it's not needed.

However since commit 16c66bc167cc we use ordered queues to stash data
plus later commits added logic for dropping samples in case there's big
load and we don't keep up. All this needs timestamp for sample. Enabling
it unconditionally for perf top.

Reported-by: Bastian Beischer <bastian.beischer@rwth-aachen.de>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: bastian beischer <bastian.beischer@rwth-aachen.de>
Fixes: 16c66bc167cc ("perf top: Add processing thread")
Link: http://lkml.kernel.org/r/20190415125333.27160-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1999d6533d12..fbbb0da43abb 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1377,6 +1377,7 @@ int cmd_top(int argc, const char **argv)
 			 * */
 			.overwrite	= 0,
 			.sample_time	= true,
+			.sample_time_set = true,
 		},
 		.max_stack	     = sysctl__max_stack(),
 		.annotation_opts     = annotation__default_options,
