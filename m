Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC373C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C34D20833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0Y4vy/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfDIJPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:15:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36444 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIJPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:15:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so2043761ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 02:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W2XnhV7DF9HKIMzg9IQYFPKY6JKOcgHlLNAyCCGdQnI=;
        b=l0Y4vy/I/CQn5UA2YZ8P1/SFa5+njpG0PYmedo1FiI3bwiaQ17vwhJaklhwmY8BA1A
         4SlRaB9jgIeGHFDt6dIewadGSRPzHMOIWlnaYk+AAOfnwF4I571p0XZNlqhElTVGSnRH
         qKeKQ9KvSMKnyO+CNR1M7IlvwXhZ/l1hyxz2zd6YazdvMVnRiPZxXPGcxCr8UEfeJlCw
         XHx9LJHMwVjSEkU41bhnPC0bIhVOo3GJyaE8AxRSLqjX1FdVsmK9JYr9j5OYXO/vbDIF
         81RebRnemuJriCa8IKt0s3ZkIRcTjZdpFlR/K/G55oe+t09fZd0k538P4WDD0APblxif
         YV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W2XnhV7DF9HKIMzg9IQYFPKY6JKOcgHlLNAyCCGdQnI=;
        b=deF8H6kGZuGjD1yup8H5hzhM9CgUOEVY2SHwsVRQssBfwsjMFr73NDnWRbmhc/faDd
         4RxeplvvMuHeQlDGNSin70/QIPcvk1o5tCXZswgLJc5o7yI2+y3x4JPak+xvUc6i4Zd5
         6O8TlTIgcYo4paYx2A10LagcfMrE8c4ko2mdOdh9OVKJdKneBuTGljtkYe/b94cD+NMY
         IFtRzVNZdTlIEFZhYQbmNB7+q/06dVFk1/OVfGM5LyjaBte1dMWSEkmGO8dOl7rauSW9
         77O/724lmGUVVWAyhkpMBlwJtmMS+v4h5aEmZUDCdFNMjqt7JjqNRexQOasUNvP8xGpp
         e9gQ==
X-Gm-Message-State: APjAAAWMjrnBgnRJ15Xqpw/Jq/eMuY7VOd454XTyeHTxaePdSluF9cqs
        SrB/ukYFiuJ8WlSS+uN3BbngZ699Q5U=
X-Google-Smtp-Source: APXvYqxA93JY7aBfq6KX/Pa5fxA2bnGH3B9P2KwVHFzHTXLDwmD8EkBC0iF9g2jV6BopSvdguW1HdQ==
X-Received: by 2002:a2e:884a:: with SMTP id z10mr18572257ljj.21.1554801336488;
        Tue, 09 Apr 2019 02:15:36 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-222-95.NA.cust.bahnhof.se. [155.4.222.95])
        by smtp.gmail.com with ESMTPSA id s24sm6723030ljs.30.2019.04.09.02.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 02:15:35 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, tstoyanov@vmware.com, rostedt@goodmis.org,
        rikard.falkeborn@gmail.com
Subject: [PATCH] tools lib traceevent: Fix missing equality check for strcmp
Date:   Tue,  9 Apr 2019 11:15:29 +0200
Message-Id: <20190409091529.2686-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a missing comparison with 0 when checking if type is "s64" or
"u64". Therefore, the body of the if-statement was entered if "type" was
"u64" or not "s64", which made the first strcmp() redundant since if
type is "u64", it's not "s64".

If type is "s64", the body of the if-statement is not entered but since the
remainder of the function consists of if-statements which will not be
entered if type is "s64", we will just return "val", which is correct,
albeit at the cost of a few more calls to strcmp(), i.e., it will behave
just as if the if-statement was entered.

If type is neither "s64" or "u64", the body of the if-statement will be
entered incorrectly and "val" returned. This means that any type that is
checked after "s64" and "u64" is handled the same way as "s64" and
"u64", i.e., the limiting of "val" to fit in for example "s8" is never
reached.

This was introduced in the kernel tree when the sources were copied from
trace-cmd in commit f7d82350e597 ("tools/events: Add files to create
libtraceevent.a"), and in the trace-cmd repo in 1cdbae6035cei ("Implement
typecasting in parser") when the function was introduced, i.e., it has
always behaved the wrong way.

Detected by cppcheck.

Fixes: f7d82350e597 ("tools/events: Add files to create libtraceevent.a")
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
I have only compile tested the patch but it should be correct. I don't
know if any other problems will surface due to this though.
---
 tools/lib/traceevent/event-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 87494c7c619d..981c6ce2da2c 100644
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
2.21.0

