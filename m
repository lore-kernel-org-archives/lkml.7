Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2804BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E874220449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369979;
	bh=pr7wRFi4rYvVi4I5EGh+MuGTOyqXG5mlnUalXXuwVlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z+VfFdrDOcrgcc3emXCwgEUgkkIQELcYgHmYu7NVapLfcf59Rtw9D6Sh48KAfEuDS
	 CYq7XgftGhfC4kqjQLtWufBGQD44BeDPlT7lycpeBIbw+xDlkZcIt7HannqvYLflPI
	 bahdTw3TdDoB19lmlgyW2lF1P+s1lcP6//Gaglhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbfDDJ0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733014AbfDDJNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:13:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C373520693;
        Thu,  4 Apr 2019 09:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369197;
        bh=pr7wRFi4rYvVi4I5EGh+MuGTOyqXG5mlnUalXXuwVlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LOmPfNKRlqVEPdBTy/gOreGqpijBfkfhxgpdWOgInUJF6kO3Kfhcv1cv+FV/5jX37
         OnX/mMCVJIonyUkec+cB37r499AKdhYYO5k0G9F13vqP3Kf+vHD3CpDbcjJokuR2rQ
         2S+p7pGtM3gXFcAp08CAU84S5+sxn5GW+MAOR1ms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, He Kuang <hekuang@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 110/246] perf report: Dont shadow inlined symbol with different addr range
Date:   Thu,  4 Apr 2019 10:46:50 +0200
Message-Id: <20190404084623.000473746@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



