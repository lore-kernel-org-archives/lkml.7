Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99392C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6117C204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713734;
	bh=0GvJ4QiK5qJxLpjYNk2eBqDxTD0OZyskBRj1Qn12pTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WEFgIGp969PtyhSMC/GuryDyl4PBHL+f6g/QqXVciB0P5jI0RIZiW89Cf7IvxLJF0
	 1rLnokjvg2CWX10m9E0xM0FEutD1uFP0jdIKbXt7fn9GQakuZAjk2+huax6N9Dw1Ah
	 1AKiodLBsGvHjkvjswQYJNWBvmfAUfptA9G3PeAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389277AbfC0TIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389076AbfC0SLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:11:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F189921741;
        Wed, 27 Mar 2019 18:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710302;
        bh=0GvJ4QiK5qJxLpjYNk2eBqDxTD0OZyskBRj1Qn12pTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxXoAV/5dwXTX7dVrJPTdzD97pzHdCmegSjGN+BFvlr1qtcF7Tf4X46XXtcb73ZX3
         wIzBd4x7XXLJw/uYSvkEjqLHB3cVJEVRO/nHCm7pY1YWcbgdDU1flttaH3qErCZoVN
         WuBo/a4O7zhHtk1A6aDWrRkxXZVzmwC0S6g/i5cg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Jones <tonyj@suse.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 045/192] tools lib traceevent: Fix buffer overflow in arg_eval
Date:   Wed, 27 Mar 2019 14:07:57 -0400
Message-Id: <20190327181025.13507-45-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
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
index 75de355a63d6..10985d991ed2 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -2416,7 +2416,7 @@ static int arg_num_eval(struct print_arg *arg, long long *val)
 static char *arg_eval (struct print_arg *arg)
 {
 	long long val;
-	static char buf[20];
+	static char buf[24];
 
 	switch (arg->type) {
 	case PRINT_ATOM:
-- 
2.19.1

