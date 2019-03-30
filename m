Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E348C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF371218D8
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907140;
	bh=I5D0HKB/zmE5GQ3L4AKNHpjhodylwcfPSVTPZMaYrME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fvCZWv9AmfiVWyJt2M8nOOZYsdF8LnFsf3DQ+AUv00ZyKTw3dRLlL4/5iaXVD8auZ
	 qCE8AVmLIa8lu6Ch2GeCaqZ5TF3o48ezgUOYO4/KtPEkgEKmza0HeYjteHInSi06pz
	 xtocMdtObtYdvufwnPMBuUjwOdMgzlUSIWRJWIw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfC3AwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730948AbfC3AwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:52:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A92C206DD;
        Sat, 30 Mar 2019 00:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907136;
        bh=I5D0HKB/zmE5GQ3L4AKNHpjhodylwcfPSVTPZMaYrME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcvWFkoFTuCYjZAu5Yf4Z1TrdWm9LoYGK885CdHdC+A4qkXwFk+FCLy0XBZIbMubB
         +cr7DhEDPyb6mniel6GbzkBW92rbr41YtTzQDV2qjhZEX/OQlY9c9Md77W0ZNXwhP7
         joKNLAsGk/bMoW4x4aG/QAL755qJGyenb4r2UxuM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 43/67] perf maps: Purge all maps from the 'names' tree
Date:   Fri, 29 Mar 2019 20:50:23 -0400
Message-Id: <20190330005047.25998-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

[ Upstream commit da3a53a7390a89391bd63bead0c2e9af4c5ef3d6 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/map.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 750ecc3dad50..2b37f56f0549 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -571,10 +571,25 @@ static void __maps__purge(struct maps *maps)
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
2.19.1

