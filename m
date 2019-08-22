Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229A1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C1621848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbfHVGve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:51:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfHVGvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:51:33 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B3955D66B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 06:51:33 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id k14so2722944wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 23:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SehunmZrLzZwSCNjetD7+l48gXfnJ0OoV09H8aMfBQ0=;
        b=MfFpig/WjLGEf3DIy8qViWYmG2VLZygnSSoD1v7/4RjxVf0G4wYuWlLr4x+/ZmKULE
         VGmd8gOgi9lk2adh2Pi3QnqaeqUjlpZPUEImkAlJOkrwqN5yEpE5W59DDc1OoIdcchgJ
         b8A8vENg5yFK85tCq84gv0NDPQwXNW5Uy3ZkWMCBCJ3jHkuCF4YlbTtikxJKSYAkFjmf
         kJmy04qw6A3cOorcgPDECAJ02ZSu0IrVP1kaesuqy2Kc2LjnC4EvsP9Qz2geeBuQFh+E
         /lW1pQA7ElzlZCOqgf/IAyZB/DhwctE1LfxhroxavjTmNmThvYtfe9JKdinH9OmMcmJ+
         8Lrw==
X-Gm-Message-State: APjAAAXJ55nYRqFTDhm+3vIgvcp9DaRpsi61c4pDK5paMZdze9JhcV8e
        2Nmvpnsjd1E/LLTa7u8yboSLJGjp6izqX5gOU2gq7o7LEm1otFpn3as2SWIYn2zHtpHgwIYiq0f
        3BdATD/6QUjPz+b1c8MIdFsQR
X-Received: by 2002:a7b:cb11:: with SMTP id u17mr4180649wmj.17.1566456691752;
        Wed, 21 Aug 2019 23:51:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyEf9FwXNfHtATnwaDhRIXXiYY4CT62XP8VqpM7xKDUrCJNC6Y16rIn5ri9PMSFgHmmbg9tug==
X-Received: by 2002:a7b:cb11:: with SMTP id u17mr4180621wmj.17.1566456691450;
        Wed, 21 Aug 2019 23:51:31 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id a23sm3553448wma.24.2019.08.21.23.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 23:51:30 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     tglx@linutronix.de, bigeasy@linutronix.de, rostedt@goodmis.org
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        williams@redhat.com, Juri Lelli <juri.lelli@redhat.com>
Subject: [RT PATCH] kernel/irq: make irq_set_affinity_notifier() work on old_notify consistently
Date:   Thu, 22 Aug 2019 08:51:17 +0200
Message-Id: <20190822065117.16467-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second half of irq_set_affinity_notifier() flushes an old notifier,
but (for RT) it is currently working on 'notify', which is the new one
(or can be NULL - in fact a NULL pointer dereference has been observed).

Fix this by making the second half of irq_set_affinity_notifier() use
old_notify consistently.

Fixes: d4200ab75cdd ("genirq: Handle missing work_struct in irq_set_affinity_notifier()")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
Hi,

This applies to v4.19.59-rt24 (and to all the other branches that have
the patch that introduced the issue). v5.2-rtx doesn't have this problem
(thanks to the workqueue rework).

Best,

Juri
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index b2736d7d863b..4586967a1b32 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -386,7 +386,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 
 	if (old_notify) {
 #ifdef CONFIG_PREEMPT_RT_BASE
-		kthread_cancel_work_sync(&notify->work);
+		kthread_cancel_work_sync(&old_notify->work);
 #else
 		cancel_work_sync(&old_notify->work);
 #endif
-- 
2.17.2

