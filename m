Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DFBCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A22208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="to6RZPB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfJ3WfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:35:04 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35539 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfJ3WfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 18:35:02 -0400
Received: by mail-pl1-f202.google.com with SMTP id p14so2535605plq.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NBXoMPDHJVu6DlppqIY2kjj0WH1XM9PlNXSL9vxvGXc=;
        b=to6RZPB9HFoQbqmKAJUjZ3WJ1y220f1xnCCYFZnT8AHAyKvmI8iWBbzxYGOL4HqHKy
         1PmW2Bk89kqcN/6509Ht4gbojZ5Fh0aN5BFvIX8S68OJJTJ6Mff6wholdeCtt3kTjz3U
         w3vdMLOcc7/CbI89RYUlJHak4evKhlgVd+Rl/3BbdoruqPitAijXNWl5sHkS4nBHdEab
         ZSgXoFbdZZJmfYz/5M/8PUltrW61Xa7L/5ZyDlkdvZ+7Ga6yzrmZFGykRxZ7ShYVNaNP
         NJf+XleoCHdf0X22IRjQJPcYBshJ+diy+lRANqX0xK7jRsmAUBhOKu7lRtlqL9tBWAGB
         84HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NBXoMPDHJVu6DlppqIY2kjj0WH1XM9PlNXSL9vxvGXc=;
        b=aWjos+npcazWyvolj/LZqzOo6ZF5oLWUpZc7yi6Pog1AYa1x3jvLA13FAs57MvlXdK
         IWPUEuR2z8BqrrbDBfAqxOJfDhS+oj7+FFSwh8sSUC5FrwE4GyrcfoujVdl35VsNn8rJ
         u+z2QJ4NtcpdnjRDIvE/DjA70/n2PWml5UtfUsnSQGwFImI7H1LRlpOt3pcWauS+FHWS
         PXFkAwnepH8AbXz0txhLL8hvyipOkVb1pD88x065KWlEks1fvjZ/PAI1LRmMIxInO+dh
         sd/G7nzKFAVc6V1MElLfVbT+YoN3ke4i1OdHKMjYjtu6DAr6MVdWp9F9av9jx4b/cSz9
         9flg==
X-Gm-Message-State: APjAAAV+ewQsstFsRkpEXMXkKLf+F0x3n8yh/bWl9tQJa2Q+9dwF+uQL
        xaZ2bdjsK1ftKng1OKW03LmgWFypeQgn
X-Google-Smtp-Source: APXvYqwFABu3kNyEZzoXKOLqzFswnHr6Oczw+2eZi3gXz92ar/LQWg0327BtdqSuK5s1slzmYFKaoRLbH4A8
X-Received: by 2002:a63:e145:: with SMTP id h5mr1976435pgk.447.1572474900839;
 Wed, 30 Oct 2019 15:35:00 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:34:41 -0700
In-Reply-To: <20191030223448.12930-1-irogers@google.com>
Message-Id: <20191030223448.12930-4-irogers@google.com>
Mime-Version: 1.0
References: <20191025180827.191916-1-irogers@google.com> <20191030223448.12930-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v5 03/10] perf tools: avoid a malloc for array events
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
index 5863acb34780..ffa1a1b63796 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -689,14 +689,12 @@ array_terms ',' array_term
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
2.24.0.rc1.363.gb1bccd3e3d-goog

