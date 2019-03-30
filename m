Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31A7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBF421904
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907247;
	bh=TWpSuKBAUvtbsGEMAmdQpa3GBJrTmu1Oc51o1Cv74Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n9DZgBLI+1QIjJCyrhe+SIbXoqk5WkeeS9qkp4+rb1efWcLxFcvI07T9sztmocAtl
	 3V9q7cLCrq9NKe/pLcNnNac4WU05VqCkhYKnaUkfrxSyDo932Kzfg9/xpxZC0DqCmd
	 wwSIjtZ9pGL0kptr37injQSvYPahkjArTHHwJ0S8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfC3AyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:32796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731417AbfC3AyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:54:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D15218CD;
        Sat, 30 Mar 2019 00:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907242;
        bh=TWpSuKBAUvtbsGEMAmdQpa3GBJrTmu1Oc51o1Cv74Q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbsYREK8NGZFB8wVNWeEYtbyUlxM73HbFwJC0JqOwdQT32h8OTqztz0bd5CS6cs9i
         O+YY9AMZcZzUaZfAOHEK2xKH5gUmIQxiSY8gNhwfYg54L4Z1Nbt21M2NaD7hMbgQU2
         z08eQDVwsFw+sB7VO9f4nhcJBps9uW1RxTbY+t3I=
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
Subject: [PATCH AUTOSEL 4.19 33/52] perf hist: Add missing map__put() in error case
Date:   Fri, 29 Mar 2019 20:52:40 -0400
Message-Id: <20190330005301.26868-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005301.26868-1-sashal@kernel.org>
References: <20190330005301.26868-1-sashal@kernel.org>
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
index 828cb9794c76..e1e94b44d588 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1048,8 +1048,10 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 
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

