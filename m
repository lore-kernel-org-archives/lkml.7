Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3802CA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C800A208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BL8dfNYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbfJWAyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 20:54:17 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:35749 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732677AbfJWAyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:54:13 -0400
Received: by mail-pf1-f202.google.com with SMTP id r7so14763893pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 17:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=98x/ZBLRTnMz91JDf+r9eCkgM4R/aoJz7oABA29poQw=;
        b=BL8dfNYwle/qgbtW7ADVHiEsSuwDsPLSjZoTlfXnyBE0oqkv1xRRcAwpwnjTG/UhRy
         ISsJthzTeEQUMS7g0lCGJbG93C5BRxPyP8lId+AdASqwo84DykO2wLDNuaAxqKA1IX/O
         iTR6Luj0jJI3JE5RMfuZvTBQdZTsfSyjj/FPLjdWOQKtb/rP4LSTf3FG61gkWGbAM1QQ
         uys3F9C2nkJ19ZClEX2bMBki9FW87OhkyJlk0k+bgKEzX+VdNwbnee3KVbObhucc/ZHO
         dwiV1/bRVl14YMNAKrWD7i9S/1x8sGDRth318qZKTokTijAHXJaIzF6W5tB20o9btapG
         N9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=98x/ZBLRTnMz91JDf+r9eCkgM4R/aoJz7oABA29poQw=;
        b=Nji4AFdQndgyp2qGz21tyaC2BwFgaVN9SrEbtQiCEyhVedU0B/sN8KW+Eq2n7Ltmws
         51UZFicyZI0TL8+KDEOmIpn+G/K1gA43w8W/rxgFK7iClL9oWMW3381B6byTR6Mztac5
         dbe616kQSihfKjpNf6ByIiIEP9eTFMzUiOiX9NMQJWVDhhzC5s+9/St7QeE/E3VnP/xU
         u1OvCj3la+GbCN/tzzB/MTUymeCXCREXWDXCm+JbOSZnZDc3Ip5Y/lE4zHOXgMQm4VaU
         yeBdlrj58XGkqCpt/dBuKQn84tkMlDyQiMGGC0RTOP8glyVp71KI+m7lYFo8tVB6AfX7
         zmkA==
X-Gm-Message-State: APjAAAVg0fDRvZSM7q6NEmZX+NQUE347pYVM7QhF9jDCyyUJV7x2c12F
        ficWl2swjRqlTitnvxWm6AJyZWe1YJN1
X-Google-Smtp-Source: APXvYqwtREz6g9G/rGR93rQsNY/2ZLedqbEtW+Xi7gR2wUD6zXu9bFlMVAC8iCLgsGQ/ldKSRBkh98pzxPJx
X-Received: by 2002:a63:1666:: with SMTP id 38mr2072471pgw.93.1571792051528;
 Tue, 22 Oct 2019 17:54:11 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:53:33 -0700
In-Reply-To: <20191023005337.196160-1-irogers@google.com>
Message-Id: <20191023005337.196160-6-irogers@google.com>
Mime-Version: 1.0
References: <20191017170531.171244-1-irogers@google.com> <20191023005337.196160-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 5/9] perf tools: avoid a malloc for array events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use realloc rather than malloc+memcpy to possibly avoid a memory
allocation when appending array elements.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 26cb65798522..545ab7cefc20 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -691,14 +691,12 @@ array_terms ',' array_term
 	struct parse_events_array new_array;
 
 	new_array.nr_ranges = $1.nr_ranges + $3.nr_ranges;
-	new_array.ranges = malloc(sizeof(new_array.ranges[0]) *
-				  new_array.nr_ranges);
+	new_array.ranges = realloc($1.ranges,
+				sizeof(new_array.ranges[0]) *
+				new_array.nr_ranges);
 	ABORT_ON(!new_array.ranges);
-	memcpy(&new_array.ranges[0], $1.ranges,
-	       $1.nr_ranges * sizeof(new_array.ranges[0]));
 	memcpy(&new_array.ranges[$1.nr_ranges], $3.ranges,
 	       $3.nr_ranges * sizeof(new_array.ranges[0]));
-	free($1.ranges);
 	free($3.ranges);
 	$$ = new_array;
 }
-- 
2.23.0.866.gb869b98d4c-goog

