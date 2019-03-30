Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1B2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCE0205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908189;
	bh=o0FzjwNuqPm1Z10x6EB0cmafSwvt1zpWYrGhlGJDzPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zBy//WQQAvLgrrHihJ+6ZIuU29PUr3D5wRBTOfkvu0/RR+zfNmYHTjirqLr1IYE1k
	 AhpR9lWMvmcKJGgwYUX1Dpcoel9/01WxhnzHiT3nZr0g3IigzsjGfiZE7aK1JHzKE9
	 UWtO9DawRCTPm5y0vH3IRpgFz+nmTs0owS1gGPDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbfC3AwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:52:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730931AbfC3AwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:52:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 751A9218AC;
        Sat, 30 Mar 2019 00:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907133;
        bh=o0FzjwNuqPm1Z10x6EB0cmafSwvt1zpWYrGhlGJDzPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbNqOvrNjrrFir8aiNFSG+G9FIEZObVySrGnwR1aajp9TS01IEXI6NZi871j912+2
         UAVYD2hVVpW6Ku3juZSoisY1FCyIfsE4UvBwKWVngZTLoB4301ozY4p9DNY+pt+cRe
         lNTYuy+V+R8mobpnzcnbbvT+NDImaNXmefzfrzO0=
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
Subject: [PATCH AUTOSEL 5.0 42/67] perf map: Remove map from 'names' tree in __maps__remove()
Date:   Fri, 29 Mar 2019 20:50:22 -0400
Message-Id: <20190330005047.25998-42-sashal@kernel.org>
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

