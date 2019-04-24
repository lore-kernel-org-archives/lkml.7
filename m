Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AD1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466A82054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126210;
	bh=qsNA7ktH6p1nFxddQTbp3DGU3lw1MwLb2ZbZJ0nd4vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yIuXxpZ34+KPZjabEAkzQAHVPoyel6tZ4ymi3IQNlkbDbAydIVGWZPKAkyuzzE6tV
	 nVV3v+wuaNs3+DMeW0s2wxj7+gZl3fxf5OhPaHU2xAdOgsKiefwJOofZbEiW4qTUf2
	 yd862PHZ+io7lDOHXOj7vF7TuPxncQ2IYSuXZ3Kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbfDXRQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388481AbfDXRQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:16:43 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 896D321909;
        Wed, 24 Apr 2019 17:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126203;
        bh=qsNA7ktH6p1nFxddQTbp3DGU3lw1MwLb2ZbZJ0nd4vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTEa8pz64oQCCobAcMGj5mMxWVIUy8lCWGGLC3rapgY9s7WTdV2ZmY2hobYATj3X7
         EEP4bwuzdespGJYr7MOkxzf66AJCgAUR+a5PInYq0JunC6tkYhMQG56csd3oiTkdlm
         tXh+HgyR24hmFxc7b5l3kU7yOPzh5wzbZqYj6bw8=
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
Subject: [PATCH 4.4 027/168] tools lib traceevent: Fix buffer overflow in arg_eval
Date:   Wed, 24 Apr 2019 19:07:51 +0200
Message-Id: <20190424170925.283693164@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 6e4a10fe9dd0..743746a3c50d 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -2419,7 +2419,7 @@ static int arg_num_eval(struct print_arg *arg, long long *val)
 static char *arg_eval (struct print_arg *arg)
 {
 	long long val;
-	static char buf[20];
+	static char buf[24];
 
 	switch (arg->type) {
 	case PRINT_ATOM:
-- 
2.19.1



