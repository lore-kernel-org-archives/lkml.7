Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B94AC28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4790C21903
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559136994;
	bh=uZwNlhBK32PUMxr2O23ngaSNno2a+GCU1RyguvKiISY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JxNP8IURuFq9vPBcNng6Cn5Af6qsJTqu5IT5zdUu8vlrf7Q6uvw6meyPxOu7pRzYr
	 JU1T8dyFplGmNc1uh7QHd4jYqSJXKKvVVLMghmTKkqsnSBsgoWQU6a+yhR6tU7JpfE
	 iF2crgwMXQRUSaPPp/xLuMsf/ukOfAIEydCWEqnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfE2Ngd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfE2Nga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:36:30 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A58DE218B0;
        Wed, 29 May 2019 13:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559136989;
        bh=uZwNlhBK32PUMxr2O23ngaSNno2a+GCU1RyguvKiISY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGG4i3nqMwACfD5Kom+H27ac8sAisIyXeMCgXERxby6FRdVBC1KBt0JBg8BwogDK8
         F5MuoEmafal4h8LqaX4NgSLuWmedyiuGmZ4GjjcydGoC6hJS60rv7HeZXUofwzydjM
         hKCiUJa85JRDQ1hP7AFKzjLD9mVR2IUGqwR+3urU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org
Subject: [PATCH 03/41] perf auxtrace: Fix itrace defaults for perf script
Date:   Wed, 29 May 2019 10:35:27 -0300
Message-Id: <20190529133605.21118-4-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Commit 4eb068157121 ("perf script: Make itrace script default to all
calls") does not work for the case when '--itrace' only is used, because
default_no_sample is not being passed.

Example:

 Before:

  $ perf record -e intel_pt/cyc/u ls
  $ perf script --itrace > cmp1.txt
  $ perf script --itrace=cepwx > cmp2.txt
  $ diff -sq cmp1.txt cmp2.txt
  Files cmp1.txt and cmp2.txt differ

 After:

  $ perf script --itrace > cmp1.txt
  $ perf script --itrace=cepwx > cmp2.txt
  $ diff -sq cmp1.txt cmp2.txt
  Files cmp1.txt and cmp2.txt are identical

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 4eb068157121 ("perf script: Make itrace script default to all calls")
Link: http://lkml.kernel.org/r/20190520113728.14389-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index fb76b6b232d4..5dd9d1893b89 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1010,7 +1010,8 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 	}
 
 	if (!str) {
-		itrace_synth_opts__set_default(synth_opts, false);
+		itrace_synth_opts__set_default(synth_opts,
+					       synth_opts->default_no_sample);
 		return 0;
 	}
 
-- 
2.20.1

