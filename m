Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58536C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2112920643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SQxamtvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfDSTDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:03:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbfDSTDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JHKviX359497
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 10:20:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JHKviX359497
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555694457;
        bh=hl/RCREFKNQghBucLoq012aN2yeHVPxeMXnnllTtWZw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=SQxamtvGIGH5zjYri6Y6b9DbuicmViXnkoRxZueji39nqHai4/cBS2uyXMF+Q9dL5
         FuisnoGb9TC/ohUKXeig2x6lRZcKJI4HS4/GTJMBZrBWf2sflS9VVBp7Grguz2988a
         GO844wwZQI3gywjLtW6RWNtmCEK4ZgmLacv+ym8F2sAICgmHPBkJv4by7/WXcN5AqM
         XDxEPecQcRitMKDvR2DD4vjPlInLbK2W/BGVZ1lRKmG0pR91wBaUWFMsGpj4TqH0hb
         12fyoXo14vRnUtgBfxymnBTJofkNajbZinO76me7Ea2xyTKu7oVzhKMB68v62dsvW8
         SjtQUjMcBw4cQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JHKu5x359494;
        Fri, 19 Apr 2019 10:20:56 -0700
Date:   Fri, 19 Apr 2019 10:20:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-2db7b1e0bd49d2b0e7d16949e167b1cfaf5c07cf@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, namhyung@kernel.org,
        acme@redhat.com, songliubraving@fb.com, jolsa@kernel.org,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: namhyung@kernel.org, acme@redhat.com, songliubraving@fb.com,
          tglx@linutronix.de, jolsa@kernel.org, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190417145539.11669-1-jolsa@kernel.org>
References: <20190417145539.11669-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Return NULL when RB tree lookup fails
 in perf_env__find_btf()
Git-Commit-ID: 2db7b1e0bd49d2b0e7d16949e167b1cfaf5c07cf
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

Commit-ID:  2db7b1e0bd49d2b0e7d16949e167b1cfaf5c07cf
Gitweb:     https://git.kernel.org/tip/2db7b1e0bd49d2b0e7d16949e167b1cfaf5c07cf
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 17 Apr 2019 16:55:39 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 17 Apr 2019 14:30:23 -0300

perf bpf: Return NULL when RB tree lookup fails in perf_env__find_btf()

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
 
