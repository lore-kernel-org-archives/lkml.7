Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6EEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11B22177E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709933;
	bh=PnXmQiK8XqkAJPnF2yyNcsknUPosTDhHfOWVke53zfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FwadJUP0InpRUYH7F9wU1JxxWyAIsQc0XLpl39Ma2C6lk/MNkKOEVmQMcDyzhhkLw
	 AeUAYIctO0TEq/1CYp95dwb06paYBIG9Q7n1Rg5rQgwnZlcOqbZqhSbIE7LYONNyn6
	 BYvGJrfwzoAI5GNeJYt+XmUxGeJhQ66SEPLb80oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbfC0SFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732477AbfC0SFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:05:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 168642063F;
        Wed, 27 Mar 2019 18:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709929;
        bh=PnXmQiK8XqkAJPnF2yyNcsknUPosTDhHfOWVke53zfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i1xlToVqNg+Ag6voA+8jzVK15f8lZ6wHSgieXMva2jwJlO87sVRONuLJtFC9qXjZR
         7BfJ+3Wx+NscttlihCA1AF25pdHKXQca6gtN5CLWyr5dMjo34MevQJWfLAIYkwqd5I
         Oking9hP5Ot/8ovpuaarEGO4JhVQU8uwDSJLNH2g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     He Kuang <hekuang@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 117/262] perf report: Don't shadow inlined symbol with different addr range
Date:   Wed, 27 Mar 2019 13:59:32 -0400
Message-Id: <20190327180158.10245-117-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Kuang <hekuang@huawei.com>

[ Upstream commit 7346195e8643482968f547483e0d823ec1982fab ]

We can't assume inlined symbols with the same name are equal, because
their address range may be different. This will cause the symbols with
different addresses be shadowed when adding to the hist entry, and lead
to ERANGE error when checking the symbol address during sample parse,
the addr should be within the range of [sym.start, sym.end].

The error message is like: "0x36aea60 [0x8]: failed to process type: 68".

The second parameter of symbol__new() is the length of the fake symbol
for the inline frame, which is the subtraction of the end and start
address of base_sym.

Signed-off-by: He Kuang <hekuang@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: aa441895f7b4 ("perf report: Compare symbol name for inlined frames when sorting")
Link: http://lkml.kernel.org/r/20190219130531.15692-1-hekuang@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/sort.c    | 10 ++++++++--
 tools/perf/util/srcline.c |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 6c1a83768eb0..d0334c33da54 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -230,8 +230,14 @@ static int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
 	if (sym_l == sym_r)
 		return 0;
 
-	if (sym_l->inlined || sym_r->inlined)
-		return strcmp(sym_l->name, sym_r->name);
+	if (sym_l->inlined || sym_r->inlined) {
+		int ret = strcmp(sym_l->name, sym_r->name);
+
+		if (ret)
+			return ret;
+		if ((sym_l->start <= sym_r->end) && (sym_l->end >= sym_r->start))
+			return 0;
+	}
 
 	if (sym_l->start != sym_r->start)
 		return (int64_t)(sym_r->start - sym_l->start);
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index dc86597d0cc4..ccf42c4e83f0 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -104,7 +104,7 @@ static struct symbol *new_inline_sym(struct dso *dso,
 	} else {
 		/* create a fake symbol for the inline frame */
 		inline_sym = symbol__new(base_sym ? base_sym->start : 0,
-					 base_sym ? base_sym->end : 0,
+					 base_sym ? (base_sym->end - base_sym->start) : 0,
 					 base_sym ? base_sym->binding : 0,
 					 base_sym ? base_sym->type : 0,
 					 funcname);
-- 
2.19.1

