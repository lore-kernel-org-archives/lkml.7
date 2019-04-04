Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEF9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C942171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367839;
	bh=091zDTOViqJ10FX10fzbKlQDrXiwwima9ZT097FjJB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=orw0vLzVBsp03PdJJZ92YHhXaMoSiPkzfqxMWy/aPAHH9bEnN1RWVQfsotEr69uqw
	 qktSbNcKJ3NYNsscKsbi/OHCRt5nVMsfs6cSPvmYtq25bAgxc8UDNZ/tfpcz0q30Gb
	 kLQ2o3yCGeRvqrmCuzzKJwhtWLZ88HyWc/YWPaLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfDDIui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729104AbfDDIuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:50:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88F3820882;
        Thu,  4 Apr 2019 08:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367835;
        bh=091zDTOViqJ10FX10fzbKlQDrXiwwima9ZT097FjJB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEqhAfTdWDqCIQurzXxUCqmg5GPjjEvedM7SKchGOAgeazuy4JeB95I1VSrV9ZRmy
         PhHIJATug1tQrDtrl7K7geifIhgPFfRTfwmElzUk0SPotJFKkAuAXcJzYZsnOnU1Pl
         qmJ6nOPddvw8OtWSkEzBij2ZNyhykM0bBh67JtNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Sartain <mikesart@fastmail.com>,
        Mathias Krause <minipli@googlemail.com>,
        Tony Jones <tonyj@suse.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 30/91] tools lib traceevent: Fix buffer overflow in arg_eval
Date:   Thu,  4 Apr 2019 10:47:14 +0200
Message-Id: <20190404084537.205989697@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 669475300ba8..700c74b0aed0 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -2428,7 +2428,7 @@ static int arg_num_eval(struct print_arg *arg, long long *val)
 static char *arg_eval (struct print_arg *arg)
 {
 	long long val;
-	static char buf[20];
+	static char buf[24];
 
 	switch (arg->type) {
 	case PRINT_ATOM:
-- 
2.19.1



