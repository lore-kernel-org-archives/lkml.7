Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF377C5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 08:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9983920449
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 08:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="YPcCkcKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfF3Iz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 04:55:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42263 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF3Iz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 04:55:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so5650324plb.9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hoCin+E18q+LgZx8f6Rfy4v3UybYvt2FKj3BHGiFlAQ=;
        b=YPcCkcKx89gqsEDYDWr+bIPWs4LEMKS0395qCxpRwgQheqqf/nMDotkw3qniiqVa1n
         7FL7/+5UDDrcebRTWnlSG4W41kJk+mbWiX9+9sbNR6sAed3WPL05tjy8Ge4a+YYJ7EYT
         I96ijTm7QByiRyZ3xz4LPz2pJWOboN8dJdPqw8198cpduIW7fc1swTPNFWBr910QPSQn
         bUKx1z8f6Va13qGHBzdSYdF2355eL+zoIAHS8hXCHN+OIKQtt4OKj/EzKqPlgmA1PEe2
         B347VSTRkIdg+8f5iB0QVrT1yrEIzq+w7/OVJ9KLZwkoyTGvM25bqScZZQ5irdLbmjMi
         FF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hoCin+E18q+LgZx8f6Rfy4v3UybYvt2FKj3BHGiFlAQ=;
        b=J8MsDL668oNux5UIJgfRj27IxruYwd3HoixHsBXy520UJwm4h9SsIIeYzTVQhPxV7P
         JTKGVra73ER7l+o+eoCM50TCVlNQutsanAp7XVNofDg4T+DHetF9XEVo9eSM2OCcrreD
         WgEORf5ImxPzdX1POIV3MaoSi9UzklET6pVK7p5pJ6HMepPHSCZIVd4yyoyhd2/wLcOG
         SDUOVyb1oQtIPsCeKXR8uit2XLz7rEmXPlF8fB09fJ9mwn6c6jrmoWjRMxFEfjOyz+tW
         ddqtzSoprRq8fTflySoJEaewpZLbWm/ZqDbl309tfAOGRBIndlKP7ul7uMa6b1fcoFMZ
         Bvqw==
X-Gm-Message-State: APjAAAXtKCybFux4IF+edq6S+FVMXnbNe/NitlJEWQG8ne/8Ott2vKAA
        kF1BZ6w+0j5wfeXf/FQ6AjmP5w==
X-Google-Smtp-Source: APXvYqwVf62sF+DqHKBfVWzpE9wvrQ8g2dZxSNaV6FOs8GiIfJidANHQhYicRImimOT4NgBxvT0hyQ==
X-Received: by 2002:a17:902:9a84:: with SMTP id w4mr21569146plp.160.1561884927315;
        Sun, 30 Jun 2019 01:55:27 -0700 (PDT)
Received: from localhost.localdomain (p2517222-ipngn21701marunouchi.tokyo.ocn.ne.jp. [118.7.246.222])
        by smtp.gmail.com with ESMTPSA id c18sm7615381pfc.180.2019.06.30.01.55.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 01:55:26 -0700 (PDT)
From:   Eiichi Tsukata <devel@etsukata.com>
To:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Eiichi Tsukata <devel@etsukata.com>
Subject: [PATCH] tracing: Fix user stack trace "??" output
Date:   Sun, 30 Jun 2019 17:54:38 +0900
Message-Id: <20190630085438.25545-1-devel@etsukata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c5c27a0a5838 ("x86/stacktrace: Remove the pointless ULONG_MAX
marker") removes ULONG_MAX marker from user stack trace entries but
trace_user_stack_print() still uses the marker and it outputs unnecessary
"??".

For example:

            less-1911  [001] d..2    34.758944: <user stack trace>
   =>  <00007f16f2295910>
   => ??
   => ??
   => ??
   => ??
   => ??
   => ??
   => ??

The user stack trace code zeroes the storage before saving the stack, so if
the trace is shorter than the maximum number of entries it can terminate
the print loop if a zero entry is detected.

Fixes: 4285f2fcef80 ("tracing: Remove the ULONG_MAX stack trace hackery")
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
---
 kernel/trace/trace_output.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index ba751f993c3b..cab4a5398f1d 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1109,17 +1109,10 @@ static enum print_line_t trace_user_stack_print(struct trace_iterator *iter,
 	for (i = 0; i < FTRACE_STACK_ENTRIES; i++) {
 		unsigned long ip = field->caller[i];
 
-		if (ip == ULONG_MAX || trace_seq_has_overflowed(s))
+		if (!ip || trace_seq_has_overflowed(s))
 			break;
 
 		trace_seq_puts(s, " => ");
-
-		if (!ip) {
-			trace_seq_puts(s, "??");
-			trace_seq_putc(s, '\n');
-			continue;
-		}
-
 		seq_print_user_ip(s, mm, ip, flags);
 		trace_seq_putc(s, '\n');
 	}
-- 
2.21.0

