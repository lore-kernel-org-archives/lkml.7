Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0BCC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BE1217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555612070;
	bh=YB009ikRBuir0WOecmcHcGI4uSWeMVe8omgTY6HNExM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gq4jtnqofgRIyqG7GVC3UTHooE7NgzpH/KZRARctJMvbU72baC1FTnwv7FsWbv/t2
	 CGmRRIjLVRYjuZ+4aJHfnx+wyObNklp34h9rglYxvke8DoDb/lAKXusPGfj0xtNPA7
	 ICbMlbqchARLBFL6cbuwN2kiGUV91wQeTvYo9Nes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403831AbfDRS1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390382AbfDRSDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:03:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9AA021871;
        Thu, 18 Apr 2019 18:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610629;
        bh=YB009ikRBuir0WOecmcHcGI4uSWeMVe8omgTY6HNExM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FoUKnUGfwm9zefFAzs2Cj5/0hLMhs9TQZ0x0iuxAr3gpGdwZgyWBG53DqPUz1cA0n
         o7JfTTvVel7c/ciio7z7qCrBTj2xPTWNo+uz+8JUrQoN+RQT4qKztTqRYzv2VmZwe/
         MsDeRpl0yG4ph9g3YDbwmNbZF+zfQ5MVkY8GE7/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 23/92] perf build-id: Fix memory leak in print_sdt_events()
Date:   Thu, 18 Apr 2019 19:56:41 +0200
Message-Id: <20190418160432.496393932@linuxfoundation.org>
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

[ Upstream commit 8bde8516893da5a5fdf06121f74d11b52ab92df5 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/build-id.c     | 1 +
 tools/perf/util/parse-events.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 7f8553630c4d..69910deab6e0 100644
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
index ec3517326a68..29e2bb304168 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2180,6 +2180,7 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 				printf("  %-50s [%s]\n", buf, "SDT event");
 				free(buf);
 			}
+			free(path);
 		} else
 			printf("  %-50s [%s]\n", nd->s, "SDT event");
 		if (nd2) {
-- 
2.19.1



