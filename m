Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74674C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489EF2192C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194435;
	bh=BJT2Sbax2KWBRF5nM9mi822l0WpcDLBYYDH5IpAQPy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TrSPSwTXHGZjfd9PkyWdWl3hRRWCV/8ON5he7GnNxkms3YqUcWFKP52KiYIRa7A/o
	 OWdDcg+i3PEGbl7zCEq1aKD/rrhkB0BY6pElXj5JYoU4YgmR1XwK/Ti4pJFnJkV2oo
	 7C+ga+IdZOi7xw3mXeAUCqW7s1oozlGyPhr4LGpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfCUSxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbfCUSxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:53:53 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5389B21934;
        Thu, 21 Mar 2019 18:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194432;
        bh=BJT2Sbax2KWBRF5nM9mi822l0WpcDLBYYDH5IpAQPy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNS4yyrDuyw4wEsySW7fdi3dBTwlL010rI4JrjRVqLsBkPWS4NzjrvWBzU1yXVXWJ
         FCSMemKY9OD6FLyKPBwmMJwHp7MFhluStlCZW4v8CCvHnWA+CPzbCyRN8Hes9vLIP7
         Dw0+HjRL9YfRe9eP51+AEr67OhWNr4iBf/5HLvFc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/44] perf maps: Purge all maps from the 'names' tree
Date:   Thu, 21 Mar 2019 15:51:18 -0300
Message-Id: <20190321185142.11441-21-acme@kernel.org>
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

Add function __maps__purge_names() to purge all maps from the names
tree.  We need to cleanup the names tree in maps__exit().

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
Link: http://lkml.kernel.org/r/20190316080556.3075-12-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 64bea5eb8bf6..e32628cd20a7 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -577,10 +577,25 @@ static void __maps__purge(struct maps *maps)
 	}
 }
 
+static void __maps__purge_names(struct maps *maps)
+{
+	struct rb_root *root = &maps->names;
+	struct rb_node *next = rb_first(root);
+
+	while (next) {
+		struct map *pos = rb_entry(next, struct map, rb_node_name);
+
+		next = rb_next(&pos->rb_node_name);
+		rb_erase_init(&pos->rb_node_name, root);
+		map__put(pos);
+	}
+}
+
 static void maps__exit(struct maps *maps)
 {
 	down_write(&maps->lock);
 	__maps__purge(maps);
+	__maps__purge_names(maps);
 	up_write(&maps->lock);
 }
 
-- 
2.20.1

