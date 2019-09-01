Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3463EC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BBA2339D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340624;
	bh=zYJ0Vu0FXnXxkI1XK3mgO5OHSWkn3J9kcE+/K0lFPvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tumv45Q6C2zzveWgPFwxBB3087hSiQ5cpa/0a/YyMeArGXusY9fuESOPYlnCqvQ28
	 e1rKuErFA4a6sXXLlwEj8c1Kld8RjMKEu/ryyDjgqBwERIk6rePijbNu6+tfFuFdv4
	 IyJZzKECXZmo9EYKLvAHFfNaDkwdYcWKEmnUnLSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfIAMXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:23:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfIAMXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:23:39 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 655B12342E;
        Sun,  1 Sep 2019 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340618;
        bh=zYJ0Vu0FXnXxkI1XK3mgO5OHSWkn3J9kcE+/K0lFPvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3F5oUHlrMTShXk9w1T0O0oQ62sGt4HfHffEsGb4EuOecPMVd+SGw0vHqwpvdH5lp
         esAP57VINEfJjgNSZ0kAmU0Czt7QbM4ELYmE4oDHAlyd7RMbRCLFJp3/FGPZdh0f55
         KrHO+gzbw5a7JRgefD5iNjS4jhcPErNFy4Yyp2BU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Joe Mario <jmario@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/47] perf c2c: Display proper cpu count in nodes column
Date:   Sun,  1 Sep 2019 09:22:40 -0300
Message-Id: <20190901122326.5793-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's wrong bitmap considered when checking for cpu count of specific
node.

We do the needed computation for 'set' variable, but at the end we use
the 'c2c_he->cpuset' weight, which shows misleading numbers.

Fixes: 1e181b92a2da ("perf c2c report: Add 'node' sort key")
Reported-by: Joe Mario <jmario@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190820140219.28338-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 73782d99ee5a..8335a4076a5a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1107,7 +1107,7 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 			break;
 		case 1:
 		{
-			int num = bitmap_weight(c2c_he->cpuset, c2c.cpus_cnt);
+			int num = bitmap_weight(set, c2c.cpus_cnt);
 			struct c2c_stats *stats = &c2c_he->node_stats[node];
 
 			ret = scnprintf(hpp->buf, hpp->size, "%2d{%2d ", node, num);
-- 
2.21.0

