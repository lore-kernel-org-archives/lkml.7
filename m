Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D116C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6418F204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711516;
	bh=OfAyRUheI1KuDkhLB6+2ZbSSnra187GFsnbXj6xheuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SKwNSJB6h8vV1JMwKyDKjYrKDjkq2sCcsMgcAsX1B+IvA7YaX48SoHS9WUHcBijYi
	 fjqR8AOD70Wy8pHiPGUygPKZTsoEH4iwN9hsVsTtmgcm91luwdYVdrus+FOLSvkjz6
	 Drff2DYl7eGVM+JS9pElrI7QC0u5ox6ZL6GaQXSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404252AbfC0SZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404236AbfC0SZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:25:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9F2A2063F;
        Wed, 27 Mar 2019 18:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711142;
        bh=OfAyRUheI1KuDkhLB6+2ZbSSnra187GFsnbXj6xheuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pLoZAwRWnk2zu/5y1uMeiSNteZoimUtdXMLHRLCYOY895Cnpe20Gwm6G5WJET3/Gl
         LQ4xrsqso78WTNAthQ9mPFLkK01RNYK1sFnl413UcI7M8ZL/MmR43SZRIXebUZHu4w
         HxEXpE2iLmGf8t2WZXo+rdJoQdIVAXtzrgfEmxMc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Jones <tonyj@suse.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 12/41] tools lib traceevent: Fix buffer overflow in arg_eval
Date:   Wed, 27 Mar 2019 14:24:49 -0400
Message-Id: <20190327182518.19394-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182518.19394-1-sashal@kernel.org>
References: <20190327182518.19394-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Jones <tonyj@suse.de>

[ Upstream commit 7c5b019e3a638a5a290b0ec020f6ca83d2ec2aaa ]

Fix buffer overflow observed when running perf test.

The overflow is when trying to evaluate "1ULL << (64 - 1)" which is
resulting in -9223372036854775808 which overflows the 20 character
buffer.

If is possible this bug has been reported before but I still don't see
any fix checked in:

See: https://www.spinics.net/lists/linux-perf-users/msg07714.html

Reported-by: Michael Sartain <mikesart@fastmail.com>
Reported-by: Mathias Krause <minipli@googlemail.com>
Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Fixes: f7d82350e597 ("tools/events: Add files to create libtraceevent.a")
Link: http://lkml.kernel.org/r/20190228015532.8941-1-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/traceevent/event-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 0c81ca7d18cd..84374e313e3f 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -2283,7 +2283,7 @@ static int arg_num_eval(struct print_arg *arg, long long *val)
 static char *arg_eval (struct print_arg *arg)
 {
 	long long val;
-	static char buf[20];
+	static char buf[24];
 
 	switch (arg->type) {
 	case PRINT_ATOM:
-- 
2.19.1

