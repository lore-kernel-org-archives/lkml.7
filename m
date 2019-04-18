Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063DAC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC11218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610637;
	bh=WSj1EG0X98D+XEBudL0XKfNLgYv/f+BjW//PInmqCXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T8CK8JMYVQIB94AQjWcrWiA7l0/wmREnY1wxLrXxG0KgsXyNMq38esjlc+O+3N6qa
	 7EXZqIv4i4ZbhDT1WMOx4YUXrKI9MuPh8kIfNL1uubsFgXa6YXzg/JrDvvIzbXmV+Z
	 Ec/092AfQzU3hEH9hUbPO9jN4YosuWFqS58YgDAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389913AbfDRSD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390372AbfDRSDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:03:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7F302186A;
        Thu, 18 Apr 2019 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610634;
        bh=WSj1EG0X98D+XEBudL0XKfNLgYv/f+BjW//PInmqCXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jB4E4hlq/qr/MfnWmKQEBXFiYS7Dzp5NILUzfVg+T06bS+iGHtsdedA4zYKBTSHXl
         xUAWSPcUFjLpSmJDBN0x3MXSBOG6nQfUoi33EHIoBALHCsNFAi3m8fU3qsExxNAgbE
         0966SXZl+GS7I9VjAO1CyH3LJL9gH4cPCgcZDcIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 25/92] perf hist: Add missing map__put() in error case
Date:   Thu, 18 Apr 2019 19:56:43 +0200
Message-Id: <20190418160432.654537988@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



