Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5748BC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C18A2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561649763;
	bh=oMQqoZTTHUmTQiqJcOaUDewMwpqi+f3Um0R+ZcVoUCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=jVKZPJf/gIYZQED9hCZnKj6SEHkBE5BZK+k8EtvyKyxjLrRjkueNJC+KNzGfK2fFK
	 RT2O7xZs2zW9jhouDLyEU3YL7XP/ZYyGZcZSgX9Lfgu5O1yE6jrt09wxyvQO9guSTi
	 e4yqPxXNAdVLhhMAAE7eHu9+ilIlFpQ7pGcR8OYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfF0Pft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfF0Pfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:35:48 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B016E2146E;
        Thu, 27 Jun 2019 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561649748;
        bh=oMQqoZTTHUmTQiqJcOaUDewMwpqi+f3Um0R+ZcVoUCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=bIDA4qTpddrOGlWSblljO6o+i6/XRJ6O0FEwnDTLJRVHxCcpf2+lH55m8I5d84nKR
         uIE1er1xlVDbCAVeNwR1Y+5dm3sl3HsF8XO4PEF9pvAgJ3jU4xHl63I2pvUYNDPrET
         quFf7bILM+ekQGMZjOzg1RMb1OahVJ9Mby21PAyU=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] tracing: Add 'hist:' to hist trigger error log error string
Date:   Thu, 27 Jun 2019 10:35:18 -0500
Message-Id: <333b59c7f7e42d852f3da908f8f3369fdc8c9fda.1561647046.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1561647046.git.zanussi@kernel.org>
References: <cover.1561647046.git.zanussi@kernel.org>
In-Reply-To: <cover.1561647046.git.zanussi@kernel.org>
References: <cover.1561647046.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'hist:' prefix gets stripped from the command text during command
processing, but should be added back when displaying the command
during error processing.

Not only because it's what should be displayed but also because not
having it means the test cases fail because the caret is miscalculated
by the length of the prefix string.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index d33c94a1cfa9..79768f22d5c5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -607,7 +607,8 @@ static void last_cmd_set(struct trace_event_file *file, char *str)
 	if (!str)
 		return;
 
-	strncpy(last_cmd, str, MAX_FILTER_STR_VAL - 1);
+	strcpy(last_cmd, "hist:");
+	strncat(last_cmd, str, MAX_FILTER_STR_VAL - 1 - sizeof("hist:"));
 
 	if (file) {
 		call = file->event_call;
-- 
2.14.1

