Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB75DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0A0206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKUObo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:31:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52763 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfKUObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:31:43 -0500
Received: from [193.96.224.244] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iXnUk-0000iU-Fh; Thu, 21 Nov 2019 14:31:42 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thread fixes
Date:   Thu, 21 Nov 2019 15:31:33 +0100
Message-Id: <20191121143133.14913-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This contains a simple fix for the pidfd poll method. In the original patchset
pidfd_poll() was made to return an unsigned int. However, the poll method is
defined to return a __poll_t. While the unsigned int is not a huge deal it's
just nicer to return a __poll_t.

I've decided to send it right before the 5.4 release mainly so that stable
doesn't need to backport it to both 5.4 and 5.3.

The following changes since commit af42d3466bdc8f39806b26f593604fdc54140bcb:

  Linux 5.4-rc8 (2019-11-17 14:47:30 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2019-11-21

for you to fetch changes up to 9e77716a75bc6cf54965e5ec069ba7c02b32251c:

  fork: fix pidfd_poll()'s return type (2019-11-20 11:48:50 +0100)

/* Testing */
All patches have seen exposure in linux-next and are based on v5.4-rc8.
All pidfd selftests passed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next.

Please consider pulling these changes from the signed for-linus-2019-11-21 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-2019-11-21

----------------------------------------------------------------
Luc Van Oostenryck (1):
      fork: fix pidfd_poll()'s return type

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
