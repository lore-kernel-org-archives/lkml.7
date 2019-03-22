Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B94C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A78A218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfCVWbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:31:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33745 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVWbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:31:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMUfAg753674
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:30:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMUe24753671;
        Fri, 22 Mar 2019 15:30:40 -0700
Date:   Fri, 22 Mar 2019 15:30:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Changbin Du <tipbot@zytor.com>
Message-ID: <tip-b49265e04410b97b31a5ee66ef6782c1b2d6cd2c@git.kernel.org>
Cc:     jolsa@kernel.org, changbin.du@gmail.com, namhyung@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        rostedt@goodmis.org, daniel@iogearbox.net, ast@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com,
        eric.saint.etienne@oracle.com, hpa@zytor.com
Reply-To: ast@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
          eric.saint.etienne@oracle.com, hpa@zytor.com,
          rostedt@goodmis.org, daniel@iogearbox.net, peterz@infradead.org,
          tglx@linutronix.de, mingo@kernel.org, jolsa@kernel.org,
          changbin.du@gmail.com, namhyung@kernel.org
In-Reply-To: <20190316080556.3075-11-changbin.du@gmail.com>
References: <20190316080556.3075-11-changbin.du@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf map: Remove map from 'names' tree in
 __maps__remove()
Git-Commit-ID: b49265e04410b97b31a5ee66ef6782c1b2d6cd2c
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

Commit-ID:  b49265e04410b97b31a5ee66ef6782c1b2d6cd2c
Gitweb:     https://git.kernel.org/tip/b49265e04410b97b31a5ee66ef6782c1b2d6cd2c
Author:     Changbin Du <changbin.du@gmail.com>
AuthorDate: Sat, 16 Mar 2019 16:05:50 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:05 -0300

perf map: Remove map from 'names' tree in __maps__remove()

There are two trees for each map inserted by maps__insert(), so remove
it from the 'names' tree in __maps__remove().

Detected with gcc's ASan.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: 1e6285699b30 ("perf symbols: Fix slowness due to -ffunction-section")
Link: http://lkml.kernel.org/r/20190316080556.3075-11-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index fbeb0c6efaa6..64bea5eb8bf6 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -917,6 +917,9 @@ static void __maps__remove(struct maps *maps, struct map *map)
 {
 	rb_erase_init(&map->rb_node, &maps->entries);
 	map__put(map);
+
+	rb_erase_init(&map->rb_node_name, &maps->names);
+	map__put(map);
 }
 
 void maps__remove(struct maps *maps, struct map *map)
