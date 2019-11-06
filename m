Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96D2C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A77D217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FEKUt/CI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbfKFDJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:09:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44878 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbfKFDJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:09:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id q26so17709671pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MbFjCcAubd11uC4jn25Hggo8LJLFYUWUem/fHxABFTk=;
        b=FEKUt/CI+v+uoMiHa4DN5cE1nnITW5AZOfT6jXOsFTkw/ZGuaRhlwL33bXq2KOYzOJ
         fbt7cSQ7ipBXtHdx79ufPvA2Rpjbsm67YLO0KOme19TNyDOCC3qvr7MvWNto3Lio/UhH
         rELinsD9fmyfXXjvXyW5wYO5VKJFzG64AnPXdR9gM2vFJQGeYezPve6ADxo6mTM19EDf
         iXR3LhxMc2/T664FpxBhu91nbf+QC3z7E9t4WK6oqyTuzLEKBBrb8xUL61zWgOiFN5co
         H5burYeP2hKe8553Bc3GBunPVq46LseahtmTOXXOQp5Gliwb6yBCad6bpPnWnY6z8MDh
         XNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MbFjCcAubd11uC4jn25Hggo8LJLFYUWUem/fHxABFTk=;
        b=lff5zTlL/aoRC9VSFoaSRCEWALTU5imonGHLeYgiYnovKErFtA4o0RHwx9ah7JgWD2
         ijbHTN2d16Xl3qa3xEi9BXJ80TUBumW3cSNJ1Xs/elTR4FWQbBNHOOx+D8zgEbXV1+wt
         LRdtAryPSkrxV0O0IhU/lNs4jtRdvUlwt6SyxtGD9d64knrZnDDqy/uWpxYzbUkwDydY
         a/MqkoxKAFQVofgrpu8yayjcqdnCxGUTpdB2VuwL56oZ4TfMfQZXpBBrbFUGOh6HwOqI
         6QXcbTzQ0I9bVYoRpIl96qOxHbQhOruV2ko5jVAJDAr8dTLMb6XpQ1spG3PJuedqbAML
         hHow==
X-Gm-Message-State: APjAAAV2ff85zXHH6MQdbBkTS8E2IyQODlvWSm+n1Pb8esmoVmF2KGdr
        Cv1cqeakGGewCh1J4/sf1N7H4vcf8XA=
X-Google-Smtp-Source: APXvYqxkEDOGkuoqfX+brJqg5uvyvczdQs5nnxdgLvS8d5e3/i1UmiBjK16f/wM5RXUhQq0sKHYIyA==
X-Received: by 2002:a17:90a:22a6:: with SMTP id s35mr604467pjc.3.1573009750094;
        Tue, 05 Nov 2019 19:09:10 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:09:09 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 48/50] sched: Print stack trace with KERN_INFO
Date:   Wed,  6 Nov 2019 03:05:39 +0000
Message-Id: <20191106030542.868541-49-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aligning with other messages printed in sched_show_task() - use
KERN_INFO to print the backtrace.

Cc: Ben Segall <bsegall@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 774ff0d8dfe9..eb50c70e73ea 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5932,7 +5932,7 @@ void sched_show_task(struct task_struct *p)
 		(unsigned long)task_thread_info(p)->flags);
 
 	print_worker_info(KERN_INFO, p);
-	show_stack(p, NULL);
+	show_stack_loglvl(p, NULL, KERN_INFO);
 	put_task_stack(p);
 }
 EXPORT_SYMBOL_GPL(sched_show_task);
-- 
2.23.0

