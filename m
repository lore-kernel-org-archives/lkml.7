Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93453C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661A62190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194404;
	bh=pyaanXNIpAA82wpDrEVogUMOtO+Jdg/gPiODWulMPPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BY62XhqzefmfDoNZJpGH0+DmEwwSwWbyFiyGVn1H8ObuCr3FBE5E6O14Y7CzWUJf7
	 +9n//urgVNpuJ4dxQKb0/krG8vuXlusbUbe++tZlabWEcJ1zExUtPfYJIiyhD6Tfen
	 FvV4USB3H19088fSJ5xwWsb/8xtDMueu9dfSQ14k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfCUSxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbfCUSxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:53:22 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B00218D8;
        Thu, 21 Mar 2019 18:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194401;
        bh=pyaanXNIpAA82wpDrEVogUMOtO+Jdg/gPiODWulMPPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MUDHotzHkJlpc9J1jS7u1yspPvubWd69JKIjwG+RiXyDugLzgvCzyU2wt023n3tO2
         OfecQe+M3tCR66ikjRih7AD/kVjLychaMeYOF11DEGWS+/YlJDbolo/HHmEbeOP66D
         FGr2k9ER6rfAZz9bpNt8JXgoV9yCkoC8E/cpAB2g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/44] perf build-id: Fix memory leak in print_sdt_events()
Date:   Thu, 21 Mar 2019 15:51:13 -0300
Message-Id: <20190321185142.11441-16-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

Detected with gcc's ASan:

  Direct leak of 4356 byte(s) in 120 object(s) allocated from:
      #0 0x7ff1a2b5a070 in __interceptor_strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3b070)
      #1 0x55719aef4814 in build_id_cache__origname util/build-id.c:215
      #2 0x55719af649b6 in print_sdt_events util/parse-events.c:2339
      #3 0x55719af66272 in print_events util/parse-events.c:2542
      #4 0x55719ad1ecaa in cmd_list /home/changbin/work/linux/tools/perf/builtin-list.c:58
      #5 0x55719aec745d in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
      #6 0x55719aec7d1a in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
      #7 0x55719aec8184 in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
      #8 0x55719aeca41a in main /home/changbin/work/linux/tools/perf/perf.c:520
      #9 0x7ff1a07ae09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: 40218daea1db ("perf list: Show SDT and pre-cached events")
Link: http://lkml.kernel.org/r/20190316080556.3075-7-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/build-id.c     | 1 +
 tools/perf/util/parse-events.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index bff0d17920ed..0c5517a8d0b7 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -185,6 +185,7 @@ char *build_id_cache__linkname(const char *sbuild_id, char *bf, size_t size)
 	return bf;
 }
 
+/* The caller is responsible to free the returned buffer. */
 char *build_id_cache__origname(const char *sbuild_id)
 {
 	char *linkname;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2e9035c4c252..5ef4939408f2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2342,6 +2342,7 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 				printf("  %-50s [%s]\n", buf, "SDT event");
 				free(buf);
 			}
+			free(path);
 		} else
 			printf("  %-50s [%s]\n", nd->s, "SDT event");
 		if (nd2) {
-- 
2.20.1

