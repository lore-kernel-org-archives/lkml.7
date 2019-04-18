Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE73C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFE4218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611063;
	bh=C/j5V8sMFIhlMwoa32Qk7l0DmGVA3hjnWlwYO6l0m7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E7B1vAlO88MVObQQ6RNUQLOzUb2Dpp6S9Lsxant5kCbwnSIgXmLnJUb/Tbxy5zh3L
	 sCbsETZiaiNcTd+MyHbelLTF3oGqBbjOzSly4tcocUz/Abw6QwnBu5vT3bAWmmBzoY
	 /j988KSLBFXOySUv/KkjNf98eIQOsSQq3951YUHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391599AbfDRSLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404198AbfDRSK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:10:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFEB0206B6;
        Thu, 18 Apr 2019 18:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611056;
        bh=C/j5V8sMFIhlMwoa32Qk7l0DmGVA3hjnWlwYO6l0m7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JS8fNbe1jmHXjVpGDNf00zM4i9WtIvW/FpkJjCrWXCbmDnP0ViOFeu7k4bdG6vWl2
         0I6oCknr2+jvy3FIWHqriLGZGWgd+fTwMgr7HAYhiHWWI50HAAit1oLTQwhqKBQIdn
         WGuYTInqOI5ryYVlWj6BOh8Jp28AAyFTdxhC0q+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 43/93] perf maps: Purge all maps from the names tree
Date:   Thu, 18 Apr 2019 19:57:21 +0200
Message-Id: <20190418160441.894910402@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



