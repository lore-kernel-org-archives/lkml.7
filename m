Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BEDC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D32217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YcT0bydu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbfKFDI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33621 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731100AbfKFDIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay6so3739921plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0nZYMsOi5mcRth8oOVQQZBR6zcPxsEPCmybPjjDUDBQ=;
        b=YcT0byduE/9KFd2MCNkG4yW3kh1PcJzeAFU0GWE5oVDfvDzJDyafRRqBK1srxH8Wju
         wzXk48QWXJIk0XhJPKeYH4PiSLdA6O+udWuaLt+rRwmUr12kA/1C4zTKnHKKkdmnzY0m
         fE2drf3Mhv9u209pIqj7go4+SbuwiE1LUEMvHPuMJHyP4u4ThjizTbKYVk6AlzJwpXLo
         OkmjuyU+7cw2SFwOHjTSL12JT9aM1HLqr/0NpOOYioeh2R0sWjnYV/azAeCBBnIcYwpi
         AyvmFV8Yedojjfz+xRh/9dMfRmg68o4vpEPzFsFvasL9hLoDMBIIeXySK7ntff76gQl2
         Hg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nZYMsOi5mcRth8oOVQQZBR6zcPxsEPCmybPjjDUDBQ=;
        b=PQdTF+CIcaIZFh028Rtt4fw7gsESNlxI979/4aM9JSyYR+abm8ZsEaVc749SdP1O7X
         oTfT5zOG2l5XbqzwvcdcruVvvKHsGAYBA6/koXmNYIjID42toxMw+7c4/VuksBZXOBBH
         9xauaYmSVuZhDCeN9m8ekl0Yo+VWwJXcaD2OSAyC+t6OdA+c0pRZcqSEWLorPXJSmrOI
         oWtdJQqUB21nGEiwjP8B7rGuy4bu8P7N9HTWjXwIxmkP6njBq+hT0GZLUZKaf0vR9v78
         +qB/rLFy4JZdXcHYH124wfkUBWcPhY4FKf20xfuYnl5Jrbd2weQRZYN5Cl2GATz8nTFz
         9SCg==
X-Gm-Message-State: APjAAAXs60iP7eYiqFKd1WyI8oh9elakI5w16SR5GQY+yGRjNoXyRr8f
        DyKZ26/bM2J9bnqM++zPWNS48OMclh0=
X-Google-Smtp-Source: APXvYqwKzVUbjez12V9LmSz50kP69UJh7Qv4UbK5y90D6KWEHaNDRr/hqyelGzSwMspfxfZeFUuPhA==
X-Received: by 2002:a17:902:9688:: with SMTP id n8mr180345plp.206.1573009734290;
        Tue, 05 Nov 2019 19:08:54 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:08:52 -0800 (PST)
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
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 44/50] sysrq: Use show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:35 +0000
Message-Id: <20191106030542.868541-45-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show the stack trace on a CPU with the same log level as "CPU%d" header.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/sysrq.c         | 2 +-
 include/linux/sched/debug.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 573b2055173c..fc5f84fa5347 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -220,7 +220,7 @@ static void showacpu(void *dummy)
 
 	raw_spin_lock_irqsave(&show_lock, flags);
 	pr_info("CPU%d:\n", smp_processor_id());
-	show_stack(NULL, NULL);
+	show_stack_loglvl(NULL, NULL, KERN_INFO);
 	raw_spin_unlock_irqrestore(&show_lock, flags);
 }
 
diff --git a/include/linux/sched/debug.h b/include/linux/sched/debug.h
index 95fb9e025247..373e4e3faf2a 100644
--- a/include/linux/sched/debug.h
+++ b/include/linux/sched/debug.h
@@ -31,6 +31,8 @@ extern void show_regs(struct pt_regs *);
  * trace (or NULL if the entire call-chain of the task should be shown).
  */
 extern void show_stack(struct task_struct *task, unsigned long *sp);
+extern void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+			      const char *loglvl);
 
 extern void sched_show_task(struct task_struct *p);
 
-- 
2.23.0

