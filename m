Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7194C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFB120449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698692;
	bh=Okr0FcJ2+exwj0VKB7RIylDI9kmdtXu/3QkheOWHXoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OOIsAhv/J0tytnREFGzt0h+BucOjGCLQHFcfv5ApRloIPP9GtmPFjW8U7yIB09Fwx
	 Vv7Fmq6fIUpGkU4nSHNHQsh8sB84cAAvQTtqQejK7ZFUkW8rxoqJWO5sEz/r5FXRNX
	 xoiIOtFuMuQsQlJWxjtkYDmKfHmR4n/wp66foIgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfDSSba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbfDSS3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:18 -0400
Received: from quaco.ghostprotocols.net (unknown [177.102.80.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6D242192C;
        Fri, 19 Apr 2019 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555677052;
        bh=Okr0FcJ2+exwj0VKB7RIylDI9kmdtXu/3QkheOWHXoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lm2zIc+G6zlaB6oorAwqEca7l+XRTRADNUm61VreSrmYqGoFfKSAAsHKRoFNszPGD
         KYvgktcfD7GTgFhlIUDNDkNTnGTh8AyWTG02jQUpxunTUXL/agrV8n3C64nIr3VQ6+
         tbhHWEfFBiTG/cruVhHu3PRqEHdwWU8F+IBxlYGA=
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
Subject: [PATCH 3/7] perf bpf: Return NULL when RB tree lookup fails in perf_env__find_bpf_prog_info()
Date:   Fri, 19 Apr 2019 09:30:25 -0300
Message-Id: <20190419123029.11328-4-acme@kernel.org>
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
-- 
2.20.1

