Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956A8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6202F207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576017154;
	bh=jMU3kFotkVBX39/Yd5DQJ41yYpGXPPIv4Qel/rKToJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IgIX0ESmFbrFknj9lWAo+sA/FP+4PZlMigsfQ4Wy6jFYxbn7ajsp615GjFnM2L3iY
	 PxNqMvIigTX2yRcjTBBkHULSji0GQLBX+8cJGoSrGgYi/mgkz0Z5rhCu+63hhNKXRz
	 GrJgDXb5BjbI4hNhvu0+pq9nNmE5e0BLTgLypCfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfLJWcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:32:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729406AbfLJWcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:32:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB73206EC;
        Tue, 10 Dec 2019 22:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017141;
        bh=jMU3kFotkVBX39/Yd5DQJ41yYpGXPPIv4Qel/rKToJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRu50ERfPHiHAvbPGLqt0ls3D4JO9I1QY/73DywNhM5fLtOiclzoZIzm3JHsj5bun
         1wg2G0je4qfKJQ6v9OEUmzGz66KFNQaTGmG46crt8RGCxAo+GrQ5rO09nmivxPx7UU
         f/s1tBq+o28iTAEz3Rgschsi2/DX64geA0xEPlA4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hewenliang <hewenliang4@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 88/91] libtraceevent: Fix memory leakage in copy_filter_type
Date:   Tue, 10 Dec 2019 17:30:32 -0500
Message-Id: <20191210223035.14270-88-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223035.14270-1-sashal@kernel.org>
References: <20191210223035.14270-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hewenliang <hewenliang4@huawei.com>

[ Upstream commit 10992af6bf46a2048ad964985a5b77464e5563b1 ]

It is necessary to free the memory that we have allocated when error occurs.

Fixes: ef3072cd1d5c ("tools lib traceevent: Get rid of die in add_filter_type()")
Signed-off-by: Hewenliang <hewenliang4@huawei.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lore.kernel.org/lkml/20191119014415.57210-1-hewenliang4@huawei.com
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/traceevent/parse-filter.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 5e10ba796a6f4..569bceff5f51b 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1492,8 +1492,10 @@ static int copy_filter_type(struct event_filter *filter,
 	if (strcmp(str, "TRUE") == 0 || strcmp(str, "FALSE") == 0) {
 		/* Add trivial event */
 		arg = allocate_arg();
-		if (arg == NULL)
+		if (arg == NULL) {
+			free(str);
 			return -1;
+		}
 
 		arg->type = FILTER_ARG_BOOLEAN;
 		if (strcmp(str, "TRUE") == 0)
@@ -1502,8 +1504,11 @@ static int copy_filter_type(struct event_filter *filter,
 			arg->boolean.value = 0;
 
 		filter_type = add_filter_type(filter, event->id);
-		if (filter_type == NULL)
+		if (filter_type == NULL) {
+			free(str);
+			free_arg(arg);
 			return -1;
+		}
 
 		filter_type->filter = arg;
 
-- 
2.20.1

