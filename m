Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B1FC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683CE2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="A/aR6m6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfECFxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:53:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfECFxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:53:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x435qDj32617936
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 2 May 2019 22:52:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x435qDj32617936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556862734;
        bh=TNXXM/ioTOLJPNbitD6CbEOnSI/AUw78a5A10EIXNU0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=A/aR6m6YDcX3NKPIdim9AqzP2XEZgjqQAPjLn6UE86R3JGiPHYRGEOMGEdpbQeDlR
         lJAIcnoqhBJe9S3AluiNuAKlftuURxiGZCF8etqQ+fAVvcjCdI7hlvzzPTwDJr1QQ/
         YPZnVHR6+YzcH1t7PW2iH9eYTL83OGr6IzZ5nl2bRtM4w6nFG2CJDLlmNG2YIWengs
         GDR0/SHkqQnuuwVMEaJtZysd620hVhCDz6eArjSomAW5zBehzhQPZj7meu12DyVX7A
         iXWGojLsm+Vhhv13n0+Cu9ViIcnOzxwyMjs9+5Z0CY7HN2TcPg3dR8G1Uu0ShWSVgJ
         Yp+xzAE1yj68g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x435qB2m2617933;
        Thu, 2 May 2019 22:52:11 -0700
Date:   Thu, 2 May 2019 22:52:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bo YU <tipbot@zytor.com>
Message-ID: <tip-2e712675ffd1331bb527dfc851b0e98cd684c2f1@git.kernel.org>
Cc:     kafai@fb.com, tglx@linutronix.de, acme@redhat.com,
        tsu.yubo@gmail.com, daniel@iogearbox.net, yhs@fb.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        songliubraving@fb.com, adrian.hunter@intel.com,
        namhyung@kernel.org, jolsa@kernel.org, mingo@kernel.org,
        ast@kernel.org, hpa@zytor.com, alexander.shishkin@linux.intel.com
Reply-To: hpa@zytor.com, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, ast@kernel.org, adrian.hunter@intel.com,
          namhyung@kernel.org, songliubraving@fb.com, jolsa@kernel.org,
          daniel@iogearbox.net, tsu.yubo@gmail.com, yhs@fb.com,
          acme@redhat.com, kafai@fb.com, tglx@linutronix.de,
          peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190422080138.10088-1-tsu.yubo@gmail.com>
References: <20190422080138.10088-1-tsu.yubo@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Return value with unlocking in
 perf_env__find_btf()
Git-Commit-ID: 2e712675ffd1331bb527dfc851b0e98cd684c2f1
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

Commit-ID:  2e712675ffd1331bb527dfc851b0e98cd684c2f1
Gitweb:     https://git.kernel.org/tip/2e712675ffd1331bb527dfc851b0e98cd684c2f1
Author:     Bo YU <tsu.yubo@gmail.com>
AuthorDate: Mon, 22 Apr 2019 04:01:38 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 May 2019 16:00:19 -0400

perf bpf: Return value with unlocking in perf_env__find_btf()

In perf_env__find_btf(), we're returning without unlocking
"env->bpf_progs.lock". There may be cause lockdep issue.

Detected by CoversityScan, CID# 1444762:(program hangs(LOCK))

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org
Fixes: 2db7b1e0bd49d: (perf bpf: Return NULL when RB tree lookup fails in perf_env__find_btf())
Link: http://lkml.kernel.org/r/20190422080138.10088-1-tsu.yubo@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 9494f9dc61ec..6a3eaf7d9353 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -115,8 +115,8 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
 	}
 	node = NULL;
 
-	up_read(&env->bpf_progs.lock);
 out:
+	up_read(&env->bpf_progs.lock);
 	return node;
 }
 
