Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F17C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AD32087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207865;
	bh=YRI2vS5gPurKLrLP0aEOIiT6Wwu2Vf5taONQIIzy4SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kHAUvzjB2yuiJEkalMnPhVCdtA2tF/kZigBQjdhL95R/PPuA7TYmFRPW9QwLgXKZO
	 bxHr+Mf813BjYkcwokXqOXiKZW2+AzWqg2nzzZv0Thg4W6jxdvSgLqb6eQWm4fg3fl
	 UZrtv/D7vVLuWOawaUBvRkbXWnE/s3hHkWjXI6po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfEGFoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729317AbfEGFmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:42:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 838C320675;
        Tue,  7 May 2019 05:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207758;
        bh=YRI2vS5gPurKLrLP0aEOIiT6Wwu2Vf5taONQIIzy4SE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ynvT1r8sxA4NYYpfuKoSWUQ0mhZVbFyg7TK/JmExHgZcMyGnGbW1ZaA5G/4JOJwZu
         9knL249OdcWzNbpJqkTGDUiDhDxHb5+WzcFrf5frErAz1l6CUE3cHEKYfhwpG5I021
         7CbfFauNeEoy46TVwZwWBHgOvLLwrKY3rN3/mdg8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 09/14] tools lib traceevent: Fix missing equality check for strcmp
Date:   Tue,  7 May 2019 01:42:11 -0400
Message-Id: <20190507054218.340-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507054218.340-1-sashal@kernel.org>
References: <20190507054218.340-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rikard Falkeborn <rikard.falkeborn@gmail.com>

[ Upstream commit f32c2877bcb068a718bb70094cd59ccc29d4d082 ]

There was a missing comparison with 0 when checking if type is "s64" or
"u64". Therefore, the body of the if-statement was entered if "type" was
"u64" or not "s64", which made the first strcmp() redundant since if
type is "u64", it's not "s64".

If type is "s64", the body of the if-statement is not entered but since
the remainder of the function consists of if-statements which will not
be entered if type is "s64", we will just return "val", which is
correct, albeit at the cost of a few more calls to strcmp(), i.e., it
will behave just as if the if-statement was entered.

If type is neither "s64" or "u64", the body of the if-statement will be
entered incorrectly and "val" returned. This means that any type that is
checked after "s64" and "u64" is handled the same way as "s64" and
"u64", i.e., the limiting of "val" to fit in for example "s8" is never
reached.

This was introduced in the kernel tree when the sources were copied from
trace-cmd in commit f7d82350e597 ("tools/events: Add files to create
libtraceevent.a"), and in the trace-cmd repo in 1cdbae6035cei
("Implement typecasting in parser") when the function was introduced,
i.e., it has always behaved the wrong way.

Detected by cppcheck.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Fixes: f7d82350e597 ("tools/events: Add files to create libtraceevent.a")
Link: http://lkml.kernel.org/r/20190409091529.2686-1-rikard.falkeborn@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/traceevent/event-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 743746a3c50d..df3c73e9dea4 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -2201,7 +2201,7 @@ eval_type_str(unsigned long long val, const char *type, int pointer)
 		return val & 0xffffffff;
 
 	if (strcmp(type, "u64") == 0 ||
-	    strcmp(type, "s64"))
+	    strcmp(type, "s64") == 0)
 		return val;
 
 	if (strcmp(type, "s8") == 0)
-- 
2.20.1

