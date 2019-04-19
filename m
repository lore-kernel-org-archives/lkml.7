Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FE4C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4C520821
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TvsfGABc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfDSTFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:05:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbfDSTDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JHKCb5359452
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 10:20:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JHKCb5359452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555694413;
        bh=0EAxZyIYLvbBqIqpv21imHEWbPqbM4Nop87IZkV6s20=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TvsfGABcdif5CXljLVTRR4lHSRTWQRAVcViYP5vEA4BuEeed/iUPWwVEnSAJIhi/j
         +g209HabJnyWPESRmppUpzBza7FYBRpQj7KsxFCUL7wtkU3aFK/Fr4A1P7M2o/g2NL
         3vN6hrjFulW0Hxk3qVym8AyxPJFnOE3miN8Dr//cGT+EegIhbI67r6n1kmBtYKcori
         sOj8Ikmep8LLmSdDtw/2GEhoZoALWNBGURLC9yjf7AGF1i5Dgz7o9jBOSdPY3GNLJt
         B9P+7wQbvZ8wJnw/R8ilq5n6eYRf9lu4ZlkmsN/ITwawpXMOquj+E/2ea8NBnqA1RH
         IW9gPvXhY3CnA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JHKAcW359448;
        Fri, 19 Apr 2019 10:20:10 -0700
Date:   Fri, 19 Apr 2019 10:20:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b9abbdfa88024d52c8084d8f46ea4f161606c692@git.kernel.org>
Cc:     songliubraving@fb.com, tglx@linutronix.de, adrian.hunter@intel.com,
        eric.saint.etienne@oracle.com, jolsa@kernel.org, hpa@zytor.com,
        peterz@infradead.org, daniel@iogearbox.net, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, ast@kernel.org,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, eric.saint.etienne@oracle.com,
          adrian.hunter@intel.com, jolsa@kernel.org, songliubraving@fb.com,
          acme@redhat.com, ak@linux.intel.com,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          ast@kernel.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, hpa@zytor.com, daniel@iogearbox.net,
          namhyung@kernel.org
In-Reply-To: <20190416160127.30203-10-jolsa@kernel.org>
References: <20190416160127.30203-10-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix map reference counting
Git-Commit-ID: b9abbdfa88024d52c8084d8f46ea4f161606c692
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b9abbdfa88024d52c8084d8f46ea4f161606c692
Gitweb:     https://git.kernel.org/tip/b9abbdfa88024d52c8084d8f46ea4f161606c692
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 16 Apr 2019 18:01:24 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 17 Apr 2019 14:30:11 -0300

perf tools: Fix map reference counting

By calling maps__insert() we assume to get 2 references on the map,
which we relese within maps__remove call.

However if there's already same map name, we currently don't bump the
reference and can crash, like:

  Program received signal SIGABRT, Aborted.
  0x00007ffff75e60f5 in raise () from /lib64/libc.so.6

  (gdb) bt
  #0  0x00007ffff75e60f5 in raise () from /lib64/libc.so.6
  #1  0x00007ffff75d0895 in abort () from /lib64/libc.so.6
  #2  0x00007ffff75d0769 in __assert_fail_base.cold () from /lib64/libc.so.6
  #3  0x00007ffff75de596 in __assert_fail () from /lib64/libc.so.6
  #4  0x00000000004fc006 in refcount_sub_and_test (i=1, r=0x1224e88) at tools/include/linux/refcount.h:131
  #5  refcount_dec_and_test (r=0x1224e88) at tools/include/linux/refcount.h:148
  #6  map__put (map=0x1224df0) at util/map.c:299
  #7  0x00000000004fdb95 in __maps__remove (map=0x1224df0, maps=0xb17d80) at util/map.c:953
  #8  maps__remove (maps=0xb17d80, map=0x1224df0) at util/map.c:959
  #9  0x00000000004f7d8a in map_groups__remove (map=<optimized out>, mg=<optimized out>) at util/map_groups.h:65
  #10 machine__process_ksymbol_unregister (sample=<optimized out>, event=0x7ffff7279670, machine=<optimized out>) at util/machine.c:728
  #11 machine__process_ksymbol (machine=<optimized out>, event=0x7ffff7279670, sample=<optimized out>) at util/machine.c:741
  #12 0x00000000004fffbb in perf_session__deliver_event (session=0xb11390, event=0x7ffff7279670, tool=0x7fffffffc7b0, file_offset=13936) at util/session.c:1362
  #13 0x00000000005039bb in do_flush (show_progress=false, oe=0xb17e80) at util/ordered-events.c:243
  #14 __ordered_events__flush (oe=0xb17e80, how=OE_FLUSH__ROUND, timestamp=<optimized out>) at util/ordered-events.c:322
  #15 0x00000000005005e4 in perf_session__process_user_event (session=session@entry=0xb11390, event=event@entry=0x7ffff72a4af8,
  ...

Add the map to the list and getting the reference event if we find the
map with same name.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Fixes: 1e6285699b30 ("perf symbols: Fix slowness due to -ffunction-section")
Link: http://lkml.kernel.org/r/20190416160127.30203-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 28d484ef74ae..ee71efb9db62 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -926,10 +926,8 @@ static void __maps__insert_name(struct maps *maps, struct map *map)
 		rc = strcmp(m->dso->short_name, map->dso->short_name);
 		if (rc < 0)
 			p = &(*p)->rb_left;
-		else if (rc  > 0)
-			p = &(*p)->rb_right;
 		else
-			return;
+			p = &(*p)->rb_right;
 	}
 	rb_link_node(&map->rb_node_name, parent, p);
 	rb_insert_color(&map->rb_node_name, &maps->names);
