Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B941C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1C32146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfLRMiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:38:55 -0500
Received: from smtpbgau1.qq.com ([54.206.16.166]:57286 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfLRMiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:38:54 -0500
X-QQ-mid: bizesmtp18t1576672707tkm6wuep
Received: from localhost.localdomain.info (unknown [103.37.140.45])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 18 Dec 2019 20:38:21 +0800 (CST)
X-QQ-SSF: 01100000006000D0TI10B00A0000000
X-QQ-FEAT: Uv7+hkXTRUPTnewJwjVVe9q0+dzPz+kAsJz0zP085EP3kykW/ZI9YlbIzv3RP
        +0kXzLCjHY1K/6SVrD3ReXiB9nbesUq/QRjlVmKcJl7KyvMWk9SQIQBRTsZ+lPd/f92wB5W
        dfNumnIt9kQAQce4P/wG7Tp/9CbAqynrYn76jOF9H6NP9Ddo6kp4xtmDL1zjYnvrPhPAlCr
        oV4xPeCJu0s5nysVgszTcS39owEtrQVvO3FYM6K0L2SpphfKsD/GiZCo366zBxG4HYRYDyh
        R5GG+L2fSr1lBC+nmS/5jcmnJdmJgbtjT6nj4RvY9CH5i+
X-QQ-GoodBg: 0
From:   Wang Long <w@laoqinren.net>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, Wang Long <w@laoqinren.net>
Subject: [PATCH] sched/psi: create /proc/pressure and /proc/pressure/{io|memory|cpu} only when psi enabled
Date:   Wed, 18 Dec 2019 20:38:18 +0800
Message-Id: <1576672698-32504-1-git-send-email-w@laoqinren.net>
X-Mailer: git-send-email 1.8.3.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:laoqinren.net:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when CONFIG_PSI_DEFAULT_DISABLED set to N or the command line set psi=0,
I think we should not create /proc/pressure and
/proc/pressure/{io|memory|cpu}.

In the future, user maybe determine whether the psi feature is enabled by
checking the existence of the /proc/pressure dir or
/proc/pressure/{io|memory|cpu} files.

Signed-off-by: Wang Long <w@laoqinren.net>
---
 kernel/sched/psi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 517e371..f12ade2 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1279,10 +1279,12 @@ static int psi_fop_release(struct inode *inode, struct file *file)
 
 static int __init psi_proc_init(void)
 {
-	proc_mkdir("pressure", NULL);
-	proc_create("pressure/io", 0, NULL, &psi_io_fops);
-	proc_create("pressure/memory", 0, NULL, &psi_memory_fops);
-	proc_create("pressure/cpu", 0, NULL, &psi_cpu_fops);
+	if (psi_enable) {
+		proc_mkdir("pressure", NULL);
+		proc_create("pressure/io", 0, NULL, &psi_io_fops);
+		proc_create("pressure/memory", 0, NULL, &psi_memory_fops);
+		proc_create("pressure/cpu", 0, NULL, &psi_cpu_fops);
+	}
 	return 0;
 }
 module_init(psi_proc_init);
-- 
1.8.3.1



