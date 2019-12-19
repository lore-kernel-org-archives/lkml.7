Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA79C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CFF222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782617;
	bh=CqvtxM5wQOaMFWkK5dFmK0FDjGmValcb6z/pJpqMHoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HKDO+YzQ6w93ISZV55l8IEene+Ym26ggMB0Q5FxiNpQ6e4hL65/xo0+V0VLQ6iVem
	 cg5tVzQymLItGC8cdy9WDjphLtiAI/Bg+FrqXlw7rUcllCcFJqPjByK3+n2sWIIuJ+
	 EdohkR/YUJVUSk45sukN/adF89kIfAVEaBGuL2n8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfLSTKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbfLSSjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:39:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7281D2467F;
        Thu, 19 Dec 2019 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780784;
        bh=CqvtxM5wQOaMFWkK5dFmK0FDjGmValcb6z/pJpqMHoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aRgheYh9TaazUcYMW+nV+JjLrJ7fNO9snKT+36l85gGZvf9m1E1I+cT6+JxienyyP
         6eSdqjBSUBYBUqEzvsLkKrDmeEFxPNzrflhtWvsuL1E79B0u32QZllQUwUiLGyL7Ms
         itZYmDEHRI7uQeyWbFN1or8utrheZ9ZaxHPzh9l0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jann@thejh.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tycho Andersen <tycho.andersen@canonical.com>,
        Ingo Molnar <mingo@kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Subject: [PATCH 4.4 078/162] fs/proc: Stop reporting eip and esp in /proc/PID/stat
Date:   Thu, 19 Dec 2019 19:33:06 +0100
Message-Id: <20191219183212.539842175@linuxfoundation.org>
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

From: Andy Lutomirski <luto@kernel.org>

commit 0a1eb2d474edfe75466be6b4677ad84e5e8ca3f5 upstream.

Reporting these fields on a non-current task is dangerous.  If the
task is in any state other than normal kernel code, they may contain
garbage or even kernel addresses on some architectures.  (x86_64
used to do this.  I bet lots of architectures still do.)  With
CONFIG_THREAD_INFO_IN_TASK=y, it can OOPS, too.

As far as I know, there are no use programs that make any material
use of these fields, so just get rid of them.

Reported-by: Jann Horn <jann@thejh.net>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux API <linux-api@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Tycho Andersen <tycho.andersen@canonical.com>
Link: http://lkml.kernel.org/r/a5fed4c3f4e33ed25d4bb03567e329bc5a712bcc.1475257877.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/array.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -425,10 +425,11 @@ static int do_task_stat(struct seq_file
 	mm = get_task_mm(task);
 	if (mm) {
 		vsize = task_vsize(mm);
-		if (permitted) {
-			eip = KSTK_EIP(task);
-			esp = KSTK_ESP(task);
-		}
+		/*
+		 * esp and eip are intentionally zeroed out.  There is no
+		 * non-racy way to read them without freezing the task.
+		 * Programs that need reliable values can use ptrace(2).
+		 */
 	}
 
 	get_task_comm(tcomm, task);


