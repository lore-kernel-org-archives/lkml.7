Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA228C28CC4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CDD264D2
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559396291;
	bh=FtvJm9fu6aj7T1gZCNpgvX9YigZ/+6wWTXenqwkTZXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I1c9xismPiM2Ih9w4fZqHXrcEWV3xD3dlkiSYJ1lW+6RWygmj2DlfgbIeWQhx3+SR
	 rPsFmMcYAX4QsqEo5Udqf1LgdiHsRTS54nAR+XDlWr29WjL2w+tTcf5DBGHgqzSiQ7
	 OLJntxdjkWMYXBk/jo5YU3IzZkR1IIC4I+s9nODA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfFANiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbfFANVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:21:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FBE5272E7;
        Sat,  1 Jun 2019 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395292;
        bh=FtvJm9fu6aj7T1gZCNpgvX9YigZ/+6wWTXenqwkTZXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DiOukflbtSTNfBmVe9azHkMRu/5/tDZV+FRmBcjYaxi2PQHXljvGsZBvbZcHWZwzN
         9aGYgwyNZfhScyv1kRc1ACn50JJrO5PcAr5trFFe5oIVRcT26VnHiR1j0vXsOXrl0O
         rOPxfDZnA3mbdHjeGjzo8D6cTETzqVjLNhqXKQYU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 055/173] tracing: probeevent: Fix to make the type of $comm string
Date:   Sat,  1 Jun 2019 09:17:27 -0400
Message-Id: <20190601131934.25053-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601131934.25053-1-sashal@kernel.org>
References: <20190601131934.25053-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 3dd1f7f24f8ceec00bbbc364c2ac3c893f0fdc4c ]

Fix to make the type of $comm "string".  If we set the other type to $comm
argument, it shows meaningless value or wrong data. Currently probe events
allow us to set string array type (e.g. ":string[2]"), or other digit types
like x8 on $comm. But since clearly $comm is just a string data, it should
not be fetched by other types including array.

Link: http://lkml.kernel.org/r/155723736241.9149.14582064184468574539.stgit@devnote2

Cc: Andreas Ziegler <andreas.ziegler@fau.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 533059281ee5 ("tracing: probeevent: Introduce new argument fetching code")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 9962cb5da8acd..44f078cda0ac8 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -405,13 +405,14 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 				return -E2BIG;
 		}
 	}
-	/*
-	 * The default type of $comm should be "string", and it can't be
-	 * dereferenced.
-	 */
-	if (!t && strcmp(arg, "$comm") == 0)
+
+	/* Since $comm can not be dereferred, we can find $comm by strcmp */
+	if (strcmp(arg, "$comm") == 0) {
+		/* The type of $comm must be "string", and not an array. */
+		if (parg->count || (t && strcmp(t, "string")))
+			return -EINVAL;
 		parg->type = find_fetch_type("string");
-	else
+	} else
 		parg->type = find_fetch_type(t);
 	if (!parg->type) {
 		pr_info("Unsupported type: %s\n", t);
-- 
2.20.1

