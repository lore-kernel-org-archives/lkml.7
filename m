Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3EFC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C19B218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611059;
	bh=8U5PM7f0zvWQQLwZGQonVtrDfBU1SQ1aMA+hGNIrycg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EdxF+qsEqDX7V5daz7XUWl7YJwNYzwhcREAHo35pN52fgw7/p8KiGZe985Wd5wt3C
	 h/sl31nUroCK2E3Ag6S41bNkQ1hffdWhCbomlNxvb9odWXCe41f6nhplGc9wU2zHTL
	 AwcNABZNNhwmQ472UjB/mIcM/gooi7uKgBUsuHCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404207AbfDRSK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403870AbfDRSKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:10:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DFD2218A1;
        Thu, 18 Apr 2019 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611053;
        bh=8U5PM7f0zvWQQLwZGQonVtrDfBU1SQ1aMA+hGNIrycg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MEVP/YNMOrXHJp0U8REapWfdDktVBJz9MwniNQudL0KuW7M2351bVlwh6+S5xpxPx
         O5nUDw5MhHMaWl9smOkDw1inQV8J1YCXqd3iuQmtrLFJ3+dw1uRXrR8E6GKvBRoiFT
         Bc6tRIgUZ/742ZIVoaS+LRA3UpySvODlaTLFnmpc=
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
Subject: [PATCH 5.0 42/93] perf map: Remove map from names tree in __maps__remove()
Date:   Thu, 18 Apr 2019 19:57:20 +0200
Message-Id: <20190418160441.729880336@linuxfoundation.org>
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

[ Upstream commit b49265e04410b97b31a5ee66ef6782c1b2d6cd2c ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 6751301a755c..750ecc3dad50 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -911,6 +911,9 @@ static void __maps__remove(struct maps *maps, struct map *map)
 {
 	rb_erase_init(&map->rb_node, &maps->entries);
 	map__put(map);
+
+	rb_erase_init(&map->rb_node_name, &maps->names);
+	map__put(map);
 }
 
 void maps__remove(struct maps *maps, struct map *map)
-- 
2.19.1



