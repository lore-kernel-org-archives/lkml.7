Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6FDC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DFA207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989723;
	bh=aGgdFvpMglC45vwjBAcHm0WOQNCFhiuqOIYXysefnNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BrIPkG5zLdRQ2cuR3fIL2TtrIXmTnPu5Kp+zTqaLEbJgnSelgwekX+uX2046PJpFW
	 V08LhMpXyWwCUt6CTG571LRcNNmbx9kQdyv7HeR5jFzJ9PN9pIA+dx+BVa5+CgfuHl
	 9/92NV+5EPTxvCPEaRDrbJxwC3LCuOi4yTBVPQNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390210AbfITO2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:28:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389321AbfITO0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:49 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F685207E0;
        Fri, 20 Sep 2019 14:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989609;
        bh=aGgdFvpMglC45vwjBAcHm0WOQNCFhiuqOIYXysefnNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=orosjw/gIU3tpnvXh6EHp7SNyZ187AdlCFHev+8rVgRZdMjn3rtfIk5L5ZFuZgImQ
         LplZ1QiTP0CS1X8UDJ4L4b/vzqShMiq/dwLMXV5VvOUgIlSBUmkoQrbH0QoK9viMlA
         4Mdz68qIivREC3Zg+ViQHDwSKjXQ3foU0Z+DVSJs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 21/31] perf auxtrace: Add missing 'struct perf_sample' forward declaration
Date:   Fri, 20 Sep 2019 11:25:32 -0300
Message-Id: <20190920142542.12047-22-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Its needed, was being obtained indirectly, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c3k1il7sm28old4e22nwlm7l@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 37e70dc01436..1ed902a24a39 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -24,6 +24,7 @@ struct perf_session;
 struct evlist;
 struct perf_tool;
 struct perf_mmap;
+struct perf_sample;
 struct option;
 struct record_opts;
 struct perf_record_auxtrace_info;
-- 
2.21.0

