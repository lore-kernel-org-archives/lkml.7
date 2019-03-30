Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDA0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24B92064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907792;
	bh=sL94BgoWL7UGHj659l0V9xGnUIuemmh1zMALROTlvjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A+DZEe9R0Ru0WwvhJ2uMKYuDRCSCI42M0IuCl3Gb2vFdb6gnLiJaUVwIeX+dLacBg
	 fUs94NP2B371pWnBYXTNQP+4lUuNg0PEJLiREASK2GAQfww2jIv8Xmc4xaqXHGPXXx
	 XPpUBcHhrOB2s/adWZzVp4YXPS3h5CNIkasMeuHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbfC3AzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731720AbfC3AzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:55:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21CCE218FC;
        Sat, 30 Mar 2019 00:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907316;
        bh=sL94BgoWL7UGHj659l0V9xGnUIuemmh1zMALROTlvjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDIPnmrBIxPka08zi+9+CL5kectryoeLCSQkAcibOk8rJUO38T5iE5/UIExJcUEJB
         8mFPA7icp6tN328fBq1nxYS1eUqWlRQYUmW+AFzefSfSBL2S+Ty7owc2bkvO1B97CS
         +rgVRsp5M6EmYPY5p1kZm/zZnGWoONhUT0pYykzc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 20/37] perf list: Don't forget to drop the reference to the allocated thread_map
Date:   Fri, 29 Mar 2019 20:54:21 -0400
Message-Id: <20190330005441.27540-20-sashal@kernel.org>
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

[ Upstream commit 39df730b09774bd860e39ea208a48d15078236cb ]

Detected via gcc's ASan:

  Direct leak of 2048 byte(s) in 64 object(s) allocated from:
    6     #0 0x7f606512e370 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xee370)
    7     #1 0x556b0f1d7ddd in thread_map__realloc util/thread_map.c:43
    8     #2 0x556b0f1d84c7 in thread_map__new_by_tid util/thread_map.c:85
    9     #3 0x556b0f0e045e in is_event_supported util/parse-events.c:2250
   10     #4 0x556b0f0e1aa1 in print_hwcache_events util/parse-events.c:2382
   11     #5 0x556b0f0e3231 in print_events util/parse-events.c:2514
   12     #6 0x556b0ee0a66e in cmd_list /home/changbin/work/linux/tools/perf/builtin-list.c:58
   13     #7 0x556b0f01e0ae in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
   14     #8 0x556b0f01e859 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
   15     #9 0x556b0f01edc8 in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
   16     #10 0x556b0f01f71f in main /home/changbin/work/linux/tools/perf/perf.c:520
   17     #11 0x7f6062ccf09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: 89896051f8da ("perf tools: Do not put a variable sized type not at the end of a struct")
Link: http://lkml.kernel.org/r/20190316080556.3075-3-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/parse-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d0b92d374ba9..ec3517326a68 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2109,6 +2109,7 @@ static bool is_event_supported(u8 type, unsigned config)
 		perf_evsel__delete(evsel);
 	}
 
+	thread_map__put(tmap);
 	return ret;
 }
 
-- 
2.19.1

