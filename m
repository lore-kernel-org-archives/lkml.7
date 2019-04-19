Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799B0C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401D020645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AWocWkjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfDSTGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:06:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729068AbfDSTDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JHHo97358929
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 10:17:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JHHo97358929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555694271;
        bh=XhddGcJXvvqevlaZQ82ng9Tcs3FT/5ztcfYv7vzTi1U=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=AWocWkjAgDketLGjEl9H5GiEx4yYZ1ATd2xnNS4fevzDlcT8NGeYpjWA0mGPbV6q+
         LOEydTPLaojcoAM+st8io3/W+l61Lhfv4qOVF9MO3veoMA719TK6yDq+fqqnzsnMMb
         L24ukAjFhCUKrcxk74iL7I7haxZd/mKAFmNWB6Qm47Ypc6AaA8t2N3qWkZJaIFGV/F
         dfGrEL1nbphAzlEATCueolzd5UmdmXl1zrBR35kHHWmJmvq2Noc8kzQ9XOe1fsX5WZ
         dbDWTwZLG2XODWjBTbeuiyYsxJEx22c+QEIzwJ7PL+BNoDfZVbVP6DOMJJR+C8+gAG
         BLQFDb8Wbn/xg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JHHoj5358925;
        Fri, 19 Apr 2019 10:17:50 -0700
Date:   Fri, 19 Apr 2019 10:17:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-aa52660231410b13d237299e691c43e346e3a73f@git.kernel.org>
Cc:     peterz@infradead.org, jolsa@kernel.org, namhyung@kernel.org,
        songliubraving@fb.com, mingo@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: acme@redhat.com, alexander.shishkin@linux.intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          peterz@infradead.org, jolsa@kernel.org, namhyung@kernel.org,
          songliubraving@fb.com, mingo@kernel.org
In-Reply-To: <20190416134151.15282-1-jolsa@kernel.org>
References: <20190416134151.15282-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Return NULL when RB tree lookup fails
 in perf_env__find_bpf_prog_info()
Git-Commit-ID: aa52660231410b13d237299e691c43e346e3a73f
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

Commit-ID:  aa52660231410b13d237299e691c43e346e3a73f
Gitweb:     https://git.kernel.org/tip/aa52660231410b13d237299e691c43e346e3a73f
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 16 Apr 2019 15:41:51 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 17 Apr 2019 14:30:06 -0300

perf bpf: Return NULL when RB tree lookup fails in perf_env__find_bpf_prog_info()

We currently don't return NULL in case we don't find the
bpf_prog_info_node, fixing that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: e4378f0cb90b ("perf bpf: Save bpf_prog_info in a rbtree in perf_env")
Link: http://lkml.kernel.org/r/20190416134151.15282-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/env.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index c6351b557bb0..34a363f2e71b 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -57,9 +57,11 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 		else if (prog_id > node->info_linear->info.id)
 			n = n->rb_right;
 		else
-			break;
+			goto out;
 	}
+	node = NULL;
 
+out:
 	up_read(&env->bpf_progs.lock);
 	return node;
 }
