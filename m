Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C86DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D43320661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980702;
	bh=tds8xC+L5u0GBiNW0rykCfMIt3vcpZzIKRVuPx7DtRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z4T3PJFDCxKpWZJFDzgUGn/0PxMN60rWSZD6BWr0NQVQbADeU0vWneoTVB/UkO+Ck
	 u4gBUjb0P0UF95xYpWUpfWcfqrUwQiiPzI6Nz9F/5/TCYviggs7t6JcAws9/HnJlB6
	 kUypaINAYL6ARgjVv8IoV2gY6b7lGsmrJ6smIum4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCGRpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:45:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbfCGRo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:44:59 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 641BE2085A;
        Thu,  7 Mar 2019 17:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980698;
        bh=tds8xC+L5u0GBiNW0rykCfMIt3vcpZzIKRVuPx7DtRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cSSMLEq3k09RRm3b2KOtJiUEPtWsVk9P4IO3IuXT5oUPIIU9/hCLv38LSNGE2Aak9
         3ccpgdqHHR2CTqAC1hsKrUK6AIMoXDEJJm7rMm/sXigq+r0Dy8BABomBOzl2XKgKEQ
         3PyOOHyDyggxJtSSpQjL+PD2SBK2WL+8q9yDv9HY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Michael Sartain <mikesart@fastmail.com>,
        Mathias Krause <minipli@googlemail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/35] tools lib traceevent: Fix buffer overflow in arg_eval
Date:   Thu,  7 Mar 2019 14:44:01 -0300
Message-Id: <20190307174433.28819-4-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Jones <tonyj@suse.de>

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
---
 tools/lib/traceevent/event-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index abd4fa5d3088..87494c7c619d 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -2457,7 +2457,7 @@ static int arg_num_eval(struct tep_print_arg *arg, long long *val)
 static char *arg_eval (struct tep_print_arg *arg)
 {
 	long long val;
-	static char buf[20];
+	static char buf[24];
 
 	switch (arg->type) {
 	case TEP_PRINT_ATOM:
-- 
2.20.1

