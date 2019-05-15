Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1325C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7D82053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557920556;
	bh=Zzwu0lQza0Dk0N4IkQenYME2SbLJibUQ7DVqa5x/odY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vyy8IZcvFSfThRXgkjcwj3EpZ+YyhcxKrgHW9nyj9fi2WoDd8DZEuARQiv9bMxMhV
	 fCk1apDlwtci0b1FI+AznP75EcwIgeJVYSy+a7KmgPwP/0BSnjf/287c0w7uU6OJms
	 Zi4Y9vq8ux3YV35mkMH9oiGffRl8Rx32p1M2DlBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfEOLmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:42:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732322AbfEOL2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:28:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B250206BF;
        Wed, 15 May 2019 11:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919680;
        bh=Zzwu0lQza0Dk0N4IkQenYME2SbLJibUQ7DVqa5x/odY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wtL/r0H8hk/fd6/m/O4ut3gOEim4f+h6ZdJHRKc/sN8MMDGKUWPwa0nbDjPXtg3LS
         Nxvr4XlRGr9yMdFz7xd3Y5hKw1qfoR5hCGLlKzuARQdDeMuSpeappJaDW/6z4GC6a1
         +Ckw1hDjYXhe0+bowMbjYn9D/O5jwfRq9/XGuCiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 053/137] tools lib traceevent: Fix missing equality check for strcmp
Date:   Wed, 15 May 2019 12:55:34 +0200
Message-Id: <20190515090657.347481345@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 87494c7c619d8..981c6ce2da2c7 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -2233,7 +2233,7 @@ eval_type_str(unsigned long long val, const char *type, int pointer)
 		return val & 0xffffffff;
 
 	if (strcmp(type, "u64") == 0 ||
-	    strcmp(type, "s64"))
+	    strcmp(type, "s64") == 0)
 		return val;
 
 	if (strcmp(type, "s8") == 0)
-- 
2.20.1



