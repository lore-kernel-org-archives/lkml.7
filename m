Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879C5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A171206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012980;
	bh=qitiSLApEjDsgcCYvw4GRr3kRgxB/6ILRbxPCzBegpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tsIwEYvyG8H9q/tykFbli++oaGgeawwnw1LyA8eD32pbc79CUScSLqkENWQnyDjlx
	 KKtSHUyFRVTJP4VH+551IpI0/ABz4fzIx1Ld7O7t38mDNmcmIA9HT34UB8YtDcz/4j
	 l8P3WS8ve40qm/Oa1OH7T3popBfPKZwxF3HRfAPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfLJVW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:22:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbfLJVLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:11:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 011A8246B2;
        Tue, 10 Dec 2019 21:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012280;
        bh=qitiSLApEjDsgcCYvw4GRr3kRgxB/6ILRbxPCzBegpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qy27rFj9VDOuY8ZRqhr0Y58gLWN+1aLMmRGsbz7uSKk3LEbfi7wEXsQYQ9rRtH+Zl
         b82nvITZY9dpOjEAlWL/KJhvypEN/X9Bu6ioIk5xQIBqTPTDZd7CY8qh0Sy3X+rbf0
         YMHGv0RmXc8rawqr9bJnsjKbKVmOfSb4yEEXhnSU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 223/350] perf probe: Fix to probe an inline function which has no entry pc
Date:   Tue, 10 Dec 2019 16:05:28 -0500
Message-Id: <20191210210735.9077-184-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit eb6933b29d20bf2c3053883d409a53f462c1a3ac ]

Fix perf probe to probe an inlne function which has no entry pc
or low pc but only has ranges attribute.

This seems very rare case, but I could find a few examples, as
same as probe_point_search_cb(), use die_entrypc() to get the
entry address in probe_point_inline_cb() too.

Without this patch:

  # perf probe -D __amd_put_nb_event_constraints
  Failed to get entry address of __amd_put_nb_event_constraints.
  Probe point '__amd_put_nb_event_constraints' not found.
    Error: Failed to add events.

With this patch:

  # perf probe -D __amd_put_nb_event_constraints
  p:probe/__amd_put_nb_event_constraints amd_put_event_constraints+43

Committer testing:

Before:

  [root@quaco ~]# perf probe -D __amd_put_nb_event_constraints
  Failed to get entry address of __amd_put_nb_event_constraints.
  Probe point '__amd_put_nb_event_constraints' not found.
    Error: Failed to add events.
  [root@quaco ~]#

After:

  [root@quaco ~]# perf probe -D __amd_put_nb_event_constraints
  p:probe/__amd_put_nb_event_constraints _text+33789
  [root@quaco ~]#

Fixes: 4ea42b181434 ("perf: Add perf probe subcommand, a kprobe-event setup helper")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157199320336.8075.16189530425277588587.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/probe-finder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 7c8d30fb2b99f..7857ae7a10b73 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -942,7 +942,7 @@ static int probe_point_inline_cb(Dwarf_Die *in_die, void *data)
 		ret = find_probe_point_lazy(in_die, pf);
 	else {
 		/* Get probe address */
-		if (dwarf_entrypc(in_die, &addr) != 0) {
+		if (die_entrypc(in_die, &addr) != 0) {
 			pr_warning("Failed to get entry address of %s.\n",
 				   dwarf_diename(in_die));
 			return -ENOENT;
-- 
2.20.1

