Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143C7C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB68C204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698760;
	bh=gQuu4bhG+lWk++HaSCHR8f4lu8xVQEdn2ZVHLT/iYnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ElJdIoK0uSom7eg5WFkgBnAIE4dl9M8EiOajD2jSXsHYi28ulWvFqoSpre4yxDIYo
	 SGxhp10IkmmAb3qK8dqZQ96DR3eWnsrKpqI7LNLGNLAWPs38m9AR8lfh5sM1kp6X9h
	 Pc6RZkt3saHiVVYYlx9t/8zST3R+9H3cMTnN1U7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfDSScj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbfDSS3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:17 -0400
Received: from quaco.ghostprotocols.net (unknown [177.102.80.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 475E321B18;
        Fri, 19 Apr 2019 12:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555677076;
        bh=gQuu4bhG+lWk++HaSCHR8f4lu8xVQEdn2ZVHLT/iYnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FtoxCpiogNTN0iVeiFvaHlQZZq43HUJnPriZMrqLFCSq1dLJkPjxu8QJR9WlMmdNW
         dB2IRapK77vvPetbR6MUMCZWed/9733HZ8eq5VonhTVkZ3Eze9vKaarFTl1r07M2yt
         lNobLEczLeWkWWliAXq2/8ZSggP3PGkh5/9vsMz8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 7/7] perf bpf: Return NULL when RB tree lookup fails in perf_env__find_btf()
Date:   Fri, 19 Apr 2019 09:30:29 -0300
Message-Id: <20190419123029.11328-8-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419123029.11328-1-acme@kernel.org>
References: <20190419123029.11328-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We don't return NULL when we don't find the bpf_prog_info_node, fix
that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reported-by: Song Liu <songliubraving@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 3792cb2ff43b ("perf bpf: Save BTF in a rbtree in perf_env")
Link: http://lkml.kernel.org/r/20190417145539.11669-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/env.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 34a363f2e71b..9494f9dc61ec 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -111,10 +111,12 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
 		else if (btf_id > node->id)
 			n = n->rb_right;
 		else
-			break;
+			goto out;
 	}
+	node = NULL;
 
 	up_read(&env->bpf_progs.lock);
+out:
 	return node;
 }
 
-- 
2.20.1

