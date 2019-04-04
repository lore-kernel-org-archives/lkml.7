Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A172CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD2220693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368992;
	bh=4IL2HCaPmyapqk+1indfqhywJwA9ug07I37kg2icq78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k/1gYPTd0+t1azbVbqiko4qBpbszYiX93Mrb6l0hr86sTKs2S6IL6/sE9h3l3FBA2
	 xtdwXH9wSJ8IXKsYCey19SisySGExB5+II2FsBLYNJWnu1MriBlFzneEmVC1/JVnd0
	 8+P8MhNl8RQ7hFgGEmSSaE9JcK/u+M5RZmuMQxWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbfDDJJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732892AbfDDJJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:09:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C44572054F;
        Thu,  4 Apr 2019 09:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368988;
        bh=4IL2HCaPmyapqk+1indfqhywJwA9ug07I37kg2icq78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KpKyxVCRzi9J70xI2KulJGFUZjmHM5fG3KF0BQ8B05qLlT648XJfOsspMoVgpr82w
         UiqCbyCOUrytqZkFY3AVTUCvB9uAXl883xSbzKCrrw4tvWWjUbKvN51oGQ81oo2kgl
         KbtOc8p0VToopmH8a1cxgrgXKUek3x9Tuvb66N48=
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
Subject: [PATCH 5.0 056/246] tools lib traceevent: Fix buffer overflow in arg_eval
Date:   Thu,  4 Apr 2019 10:45:56 +0200
Message-Id: <20190404084620.985241647@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
2.19.1



