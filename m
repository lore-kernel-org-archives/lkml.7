Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DFCC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACEE2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555332819;
	bh=tUOUBKN6OyTeIm+VF8rIXekX6tJ+PkjDIfokljGfrpE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=A4ddktAgSLuaK5lt3+SVKNVo8qbb36XTARktLTA65CPTw9BtKeDlxRBycg6phQGVH
	 lcWcPDbVCkYrU3XQ9tK707ws8ZmQ3yWcMmwgMQO7HGvEGiuNYdBlLprAKNhuquItfM
	 pWxO6B+iKwu+GrxXb68TnPXPpIEdjGg5JZpySEwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfDOMxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:53:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfDOMxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:53:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 084308764F;
        Mon, 15 Apr 2019 12:53:37 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E04C19C56;
        Mon, 15 Apr 2019 12:53:33 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Bastian Beischer <bastian.beischer@rwth-aachen.de>
Subject: [PATCH perf/urgent] perf top: Always sample time
Date:   Mon, 15 Apr 2019 14:53:33 +0200
Message-Id: <20190415125333.27160-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 15 Apr 2019 12:53:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bastian reported broken perf top -p PID command, it won't
display any data.

The problem is that for -p option we monitor single thread,
so we don't enable time in samples, because it's not needed.

However since commit 16c66bc167cc we use ordered queues to
stash data plus later commits added logic for dropping samples
in case there's big load and we don't keep up. All this needs
timestamp for sample. Enabling it unconditionally for perf top.

Fixes: 16c66bc167cc ("perf top: Add processing thread")
Reported-by: Bastian Beischer <bastian.beischer@rwth-aachen.de>
Link: http://lkml.kernel.org/n/tip-zhn7jg8hqpl9547g7vqjini7@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-top.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1999d6533d12..fbbb0da43abb 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1377,6 +1377,7 @@ int cmd_top(int argc, const char **argv)
 			 * */
 			.overwrite	= 0,
 			.sample_time	= true,
+			.sample_time_set = true,
 		},
 		.max_stack	     = sysctl__max_stack(),
 		.annotation_opts     = annotation__default_options,
-- 
2.17.2

