Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB98C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1ACB222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caOSAp4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfKTAHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:07:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40231 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKTAHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 19:07:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id q15so13207508wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 16:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ik8rk03crFyahf/9pU+JDhTvTOC4x5NhvlmDbsWHqLk=;
        b=caOSAp4WSvmjNweZRfAqZzLt8e9VFF7PFHBtlFFsDN6yakR5Tzs00KQWgXk8RM7NTp
         f6vlHkYF1bV0nY5mD0ui3Rz/IP6tdTHlkO9eSqBWvNXOqo1pOiLli/S8sP66l39qJAGw
         QG956jjfcs+s4WIODhjl8FM+VXsa/3O1WRErCRDqYQ/zxJ+O4ecuo6nfkO2WuALY4CsH
         y07VRxTRlT5HbP3LQHh9TpKFelQwVUp/H6y2q6nbbxtOF/kyC+oz+cfrGm9X4u+dlxJx
         GhWK+9IhVdIG1QeZj9Tdhizm4Q987DhOSZgR/GE/OY7oLkUGMPVvBxAhlXSh80k83P6O
         SpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ik8rk03crFyahf/9pU+JDhTvTOC4x5NhvlmDbsWHqLk=;
        b=DkbW887NIx742gNlf3CG+MMU68G2WOIuYZ62UkosjT9CTUzEyaef4m50UGN5iNXq8W
         JJcCfx6NQmA/cey2prug9qNCH0iiPdvuXagLaB3xo8PeJzVGE8x7Gim1M2/41HWiC6nL
         BPdOjYSjHrKh7+CNFIkrYrluxBIBuJSXf+cx0lV70CUAl8bYR+cEx4qUr6eA5XtmwhLl
         P1CTGnCwd7wkfbg7D01xGUS8Ety68r3pJ3kc0VBMYB2CNZmHr1DL6QwZO5L62JN6XaWn
         bPrl0GPJ1KPLjlgkJpgCCjuqZ0bQAEydngGSTk58QHV2Y3O8ZWcX5Pn/0LVSdAw0mi7m
         tnWw==
X-Gm-Message-State: APjAAAXAUNKhl4L4XSIxToP0OVKM7UqENoScBpico3WSfqEUNSBlt8O6
        oO3UkrNq5eZyrFxL3IV2XGHYMRk9
X-Google-Smtp-Source: APXvYqyNt1KqkAtQSbRH3LXR3JsV9qJniFVH3itoyM+2VOSA4zOeJoRF/xHbkGPCwka9sIMk68AtPQ==
X-Received: by 2002:a5d:6746:: with SMTP id l6mr83214wrw.349.1574208452402;
        Tue, 19 Nov 2019 16:07:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:40e1:9900:5dce:1599:e3b5:7d61])
        by smtp.gmail.com with ESMTPSA id r2sm29424197wrp.64.2019.11.19.16.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:07:31 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH] fork: fix pidfd_poll()'s return type
Date:   Wed, 20 Nov 2019 01:07:22 +0100
Message-Id: <20191120000722.30605-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pidfd_poll() is defined as returning 'unsigned int' but the
.poll method is declared as returning '__poll_t', a bitwise type.

Fix this by using the proper return type and using the EPOLL
constants instead of the POLL ones, as required for __poll_t.

CC: Joel Fernandes (Google) <joel@joelfernandes.org>
CC: Christian Brauner <christian@brauner.io>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 kernel/fork.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 55af6931c6ec..13b38794efb5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1708,11 +1708,11 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 /*
  * Poll support for process exit notification.
  */
-static unsigned int pidfd_poll(struct file *file, struct poll_table_struct *pts)
+static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 {
 	struct task_struct *task;
 	struct pid *pid = file->private_data;
-	int poll_flags = 0;
+	__poll_t poll_flags = 0;
 
 	poll_wait(file, &pid->wait_pidfd, pts);
 
@@ -1724,7 +1724,7 @@ static unsigned int pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	 * group, then poll(2) should block, similar to the wait(2) family.
 	 */
 	if (!task || (task->exit_state && thread_group_empty(task)))
-		poll_flags = POLLIN | POLLRDNORM;
+		poll_flags = EPOLLIN | EPOLLRDNORM;
 	rcu_read_unlock();
 
 	return poll_flags;
-- 
2.24.0

