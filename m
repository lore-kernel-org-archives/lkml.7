Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A99FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704F924680
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780699;
	bh=5IK6K/5emsZlqCtcxohp7khTC0xD+HkYdcob0eXt/4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y/5qbZ3SSZ/oS5ukS7R3YBqbnJFXjppuADupHMoxTwbZTbCvW4dG1/6sVvq/cMt2u
	 HHj7RkB8/Cl3MwxkxSgklCMNt+sAIzVY/+4hZeDiP4jKCVRGqIpZqYOW6Rra5gahvE
	 wHb73Hq/juXvbGj1ePIavxjUpGeLLv7SBxNsBT6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfLSSiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:38:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbfLSSiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:38:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6192222C2;
        Thu, 19 Dec 2019 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780693;
        bh=5IK6K/5emsZlqCtcxohp7khTC0xD+HkYdcob0eXt/4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPDN67OCntBaZC84JsFfBKaucG6OJFGWAs8C/St2iN4vRNYWQRtOLVh4qXo8rb9WX
         U0WObGYYu/MGnlZdIC2v1IEKY8oLRR7iZUCchr5LDXBd9U4CR9xo2icuLsaxhG0i3w
         JVYHFYBNgC+Hj4+iLyJhMRX5zP6cHMX5gJ+DpDrY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <marco.felsch@preh.de>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho.andersen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Subject: [PATCH 4.4 079/162] fs/proc: Report eip/esp in /prod/PID/stat for coredumping
Date:   Thu, 19 Dec 2019 19:33:07 +0100
Message-Id: <20191219183212.607563852@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de>

commit fd7d56270b526ca3ed0c224362e3c64a0f86687a upstream.

Commit 0a1eb2d474ed ("fs/proc: Stop reporting eip and esp in
/proc/PID/stat") stopped reporting eip/esp because it is
racy and dangerous for executing tasks. The comment adds:

    As far as I know, there are no use programs that make any
    material use of these fields, so just get rid of them.

However, existing userspace core-dump-handler applications (for
example, minicoredumper) are using these fields since they
provide an excellent cross-platform interface to these valuable
pointers. So that commit introduced a user space visible
regression.

Partially revert the change and make the readout possible for
tasks with the proper permissions and only if the target task
has the PF_DUMPCORE flag set.

Fixes: 0a1eb2d474ed ("fs/proc: Stop reporting eip and esp in> /proc/PID/stat")
Reported-by: Marco Felsch <marco.felsch@preh.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: Tycho Andersen <tycho.andersen@canonical.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: stable@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux API <linux-api@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: http://lkml.kernel.org/r/87poatfwg6.fsf@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[ zhangyi: 68db0cf10678 does not merged, skip the task_stack.h for 4.4]
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/array.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -429,7 +429,15 @@ static int do_task_stat(struct seq_file
 		 * esp and eip are intentionally zeroed out.  There is no
 		 * non-racy way to read them without freezing the task.
 		 * Programs that need reliable values can use ptrace(2).
+		 *
+		 * The only exception is if the task is core dumping because
+		 * a program is not able to use ptrace(2) in that case. It is
+		 * safe because the task has stopped executing permanently.
 		 */
+		if (permitted && (task->flags & PF_DUMPCORE)) {
+			eip = KSTK_EIP(task);
+			esp = KSTK_ESP(task);
+		}
 	}
 
 	get_task_comm(tcomm, task);


