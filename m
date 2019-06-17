Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECB2C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818C02084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LQN4/bxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfFQTjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:39:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60693 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfFQTjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:39:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJctOp3566290
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:38:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJctOp3566290
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800336;
        bh=lNkg6DZ8FgQwgxahgiDoQJ0tnV0E0qNHLp/ST+rL6MQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LQN4/bxPbBc1eO9H6urSp9aXzcJgxjNpokeehbGPBiQWOBWXBHHKIyhke+YHqpm2/
         7Em1kYN7CnY1gDdnmuDcH/u8HTEyBpqM+yWL1TBTikdjQ5hIIiPYkxdUKjuSF1usLR
         am3AXK26c4XEBsXXBWbUuQzXurHKCY8DIT5cuMPyvdwS6O9P0qW8Z0ykXvq0WkkJfH
         KNH2bQvRkRXALUkR1Ifu671hsz2j0I8mr6pnBFKXBkZbwbHGAY3qao9dbdbhaaxcSU
         Y7m1saUcMMmFf7hs41Not3xd/bS6mj70tKIM4u5RAwQtWFTcYWlv2tFnffx7XY7Ati
         trhjV2HQjAHqw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJctTu3566287;
        Mon, 17 Jun 2019 12:38:55 -0700
Date:   Mon, 17 Jun 2019 12:38:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-400ae9818fe64899cea921a89c7078e0df9e41ea@git.kernel.org>
Cc:     adrian.hunter@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        yao.jin@linux.intel.com, tglx@linutronix.de, acme@redhat.com,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, jolsa@redhat.com,
          adrian.hunter@intel.com, mingo@kernel.org, acme@redhat.com,
          tglx@linutronix.de, yao.jin@linux.intel.com, hpa@zytor.com
In-Reply-To: <20190604130017.31207-3-adrian.hunter@intel.com>
References: <20190604130017.31207-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script: Set perf time interval in
 itrace_synth_ops
Git-Commit-ID: 400ae9818fe64899cea921a89c7078e0df9e41ea
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

Commit-ID:  400ae9818fe64899cea921a89c7078e0df9e41ea
Gitweb:     https://git.kernel.org/tip/400ae9818fe64899cea921a89c7078e0df9e41ea
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 16:00:00 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:11 -0300

perf script: Set perf time interval in itrace_synth_ops

Instruction trace decoders can optimize output based on what time
intervals will be filtered, so pass that information in
itrace_synth_ops.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 80c722ade852..61f00055476a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3829,6 +3829,10 @@ int cmd_script(int argc, const char **argv)
 						  &script.range_num);
 		if (err < 0)
 			goto out_delete;
+
+		itrace_synth_opts__set_time_range(&itrace_synth_opts,
+						  script.ptime_range,
+						  script.range_num);
 	}
 
 	err = __cmd_script(&script);
@@ -3836,8 +3840,10 @@ int cmd_script(int argc, const char **argv)
 	flush_scripting();
 
 out_delete:
-	if (script.ptime_range)
+	if (script.ptime_range) {
+		itrace_synth_opts__clear_time_range(&itrace_synth_opts);
 		zfree(&script.ptime_range);
+	}
 
 	perf_evlist__free_stats(session->evlist);
 	perf_session__delete(session);
