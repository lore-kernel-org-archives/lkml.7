Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F75C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF7F217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555430541;
	bh=ZqOg3Yr7Zx8JhIKDYP9iSBU0vcd7gjtZUTEVVIE9maY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HzXxxZplJmdGX5nCjx2X8D5rvOi0SaS3BLXvezrW1PBS7X5+ONVrm6FMauI3XneQ7
	 1EUMs6ZU3sGHaj60Rfp6xG7CQPvDvdMyjYjKLgZchix8gdbR22425CkLCGNJjpHXLE
	 6ecuA5ITg9BC+xrI1zOA6QEkJh6XA4YpPjraaqIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbfDPQCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:02:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbfDPQCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:02:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24AF95D60E;
        Tue, 16 Apr 2019 16:02:03 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1B9B5D71B;
        Tue, 16 Apr 2019 16:02:00 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 09/12] perf tools: Fix map reference counting
Date:   Tue, 16 Apr 2019 18:01:24 +0200
Message-Id: <20190416160127.30203-10-jolsa@kernel.org>
In-Reply-To: <20190416160127.30203-1-jolsa@kernel.org>
References: <20190416160127.30203-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 16 Apr 2019 16:02:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By calling maps__insert we assume to get 2 references
on the map, which we relese within maps__remove call.

However if there's already same map name, we currently
don't bump the reference and can crash, like:

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

Adding the map on the list and getting the reference event
if we find the map with same name.

Cc: Song Liu <songliubraving@fb.com>
Link: http://lkml.kernel.org/n/tip-38t1ihcy32lvu4xfpm0p7yex@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
-- 
2.17.2

