Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12068C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7942068F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MybPdpf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKURir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:38:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34352 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKURir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:38:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id h13so1897499plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 09:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0l5A9UoqjVI1sY5PPJyL17z33+kBWrkankas44MyTI=;
        b=MybPdpf6BAPp1aRDB1eeIjw2B/Dq0pyUNJ1csAvdv0Cba2+j5EY7K3OMBKv/jTMlgL
         T/tn+16bqw0epfRDgtWkYlVlo/JuqVTUZsSnT/73AOxejSWw3iiNzWL7JavsgNDhZ0zJ
         aW8T7onRojBC1uhhK4gxWj1TDatbOlhrGxy8j33dugQz6BUXqRoBNubAhVby3eRRGmNe
         /79gN+x4IeKenRaCjn/R+asKt0B2/YduvVXppspcoAnxpNToKKtzPvAdggQSmv4GyVQS
         IpApIsVenAU8tCvVAlRfxQwUK18kK59hjExBSP+WlHYBsO1tt5IR1SyHt5/7YE6gVAtm
         U1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0l5A9UoqjVI1sY5PPJyL17z33+kBWrkankas44MyTI=;
        b=L5s0OU9hiCUeQSMJbDoVY5tY0mJfeaMpOuTSYa3FKO6h2/6ZQ2t50YOEtqLkPsX7CS
         uqnHx760jikHx71LqLLKfEuD8naq8xyynpdgBWDDvPBoFyrqzSXdAgFTHbc+Jp573BER
         PAXCO0CN55XMJyzfOwMlWVhoSNf+Gp+pI7gMjF7AwnIhVcB/E49MXu7V9hH5OXLJRmyU
         y/guSTL8kz7361nzs/vlObG0wIbjIpu+/ITD8KoAzeQMvLfno6QHx5/TPJBns3lePyoV
         AQrkZgHVsmvu9Z5f/Ip9u3kr6jEohsmSAwRxRz/QWtgTWDbz6X9dQeuuWYHdvEG6KL0g
         7mcg==
X-Gm-Message-State: APjAAAVxD0mN4S6cO/+WpK35SP3rKP8g/lRGsPYcjAvf4yNr+0DzowaE
        LysS9jQC70FjyNxFIQG+ZHI=
X-Google-Smtp-Source: APXvYqxdvlf3bpokDoeWHYjxqwLvrJpxKLfXDVN8CmNraCM4hqsXq1QLwcAzKDvdgqU3wKauhTjD7g==
X-Received: by 2002:a17:90b:4393:: with SMTP id in19mr13261050pjb.132.1574357926843;
        Thu, 21 Nov 2019 09:38:46 -0800 (PST)
Received: from localhost.localdomain ([2408:8025:ad:7e20:1c97:67e5:7b87:2fd3])
        by smtp.gmail.com with ESMTPSA id d187sm3753526pgc.1.2019.11.21.09.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 09:38:46 -0800 (PST)
From:   chengkaitao <pilgrimtao@gmail.com>
To:     tglx@linutronix.de
Cc:     pilgrimtao@163.com, smuchun@gmail.com,
        linux-kernel@vger.kernel.org, Kaitao Cheng <pilgrimtao@gmail.com>
Subject: [PATCH] irq: cleanup some duplicate code
Date:   Thu, 21 Nov 2019 09:38:32 -0800
Message-Id: <20191121173832.2734-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaitao Cheng <pilgrimtao@gmail.com>

Cleanup extra if(test_and_clear_bit), and put the other one in front.

Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
---
 kernel/irq/manage.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1753486b440c..7266d0d30fa9 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -863,21 +863,15 @@ static int irq_wait_for_interrupt(struct irqaction *action)
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (kthread_should_stop()) {
-			/* may need to run one last time */
-			if (test_and_clear_bit(IRQTF_RUNTHREAD,
-					       &action->thread_flags)) {
-				__set_current_state(TASK_RUNNING);
-				return 0;
-			}
+		if (test_and_clear_bit(IRQTF_RUNTHREAD,
+					&action->thread_flags)) {
 			__set_current_state(TASK_RUNNING);
-			return -1;
+			return 0;
 		}
 
-		if (test_and_clear_bit(IRQTF_RUNTHREAD,
-				       &action->thread_flags)) {
+		if (kthread_should_stop()) {
 			__set_current_state(TASK_RUNNING);
-			return 0;
+			return -1;
 		}
 		schedule();
 	}
-- 
2.20.1

