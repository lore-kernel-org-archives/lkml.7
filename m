Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3825CC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01193218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907340;
	bh=rrgOgsThx5m+VQG+Sc/vrPZfYxcrrtViM3Iopzd8tco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ivX1CdFbr9QPo3iyE9XudTB97firkTfyxMIqx5m5zUKDeZsDXt1OxoNgHTFuvEXZC
	 Ls0nXt0iXGcXcyR76vmGPPvflu7ITgC1EWsKdEtPaqvgC83My8VySNTDjQVTTiL+0x
	 DafzHoRj2/js3jwjz/vmN79jtApqYk1NgzOrHogs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbfC3Azi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731018AbfC3Aza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:55:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC7D0218CD;
        Sat, 30 Mar 2019 00:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907329;
        bh=rrgOgsThx5m+VQG+Sc/vrPZfYxcrrtViM3Iopzd8tco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5hkRN89omy099r5SZoH9rowpTAWta2Eo6DR2ybPMmmRvfmn+VznBZ/v3LKGUjinO
         NhBAaybJp4UyAfEgTfY0Wt7gAVkL9aV7YMQnHvDIMFx9Td/MR5Ut8MywNP6OssA/S6
         gD4zzAvG1iJva6iIiQacwLCN8KoV4oU1YAAUXRyA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 25/37] perf hist: Add missing map__put() in error case
Date:   Fri, 29 Mar 2019 20:54:26 -0400
Message-Id: <20190330005441.27540-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005441.27540-1-sashal@kernel.org>
References: <20190330005441.27540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

[ Upstream commit cb6186aeffda4d27e56066c79e9579e7831541d3 ]

We need to map__put() before returning from failure of
sample__resolve_callchain().

Detected with gcc's ASan.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: 9c68ae98c6f7 ("perf callchain: Reference count maps")
Link: http://lkml.kernel.org/r/20190316080556.3075-10-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/hist.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 5d420209505e..5b8bc1fd943d 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1040,8 +1040,10 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 
 	err = sample__resolve_callchain(iter->sample, &callchain_cursor, &iter->parent,
 					iter->evsel, al, max_stack_depth);
-	if (err)
+	if (err) {
+		map__put(alm);
 		return err;
+	}
 
 	err = iter->ops->prepare_entry(iter, al);
 	if (err)
-- 
2.19.1

